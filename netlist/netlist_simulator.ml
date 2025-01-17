let print_only = ref false
let number_steps = ref (-1)
let base_ten = ref false
let per_sec = ref false
let curr_sec = ref false
let print_well = ref false
let tab_print = Array.make 7 0

open Printf
open Netlist_ast

(*--------------------------------Fonctions utilitaires----------------------*)

let int_of_array v =
  let x = ref 0 in
  let n = Array.length v in
  for i = 0 to n-1 do
    x := !x*2 + (Obj.magic v.(i));
  done;
  !x

let explode_string s = List.init (String.length s) (String.get s)

let istrue a =
  Array.for_all (fun x-> x) a

let andb a b = a && b
let orb a b = a || b
let nandb a b = not (a&&b)
let xorb a b =
    (a || b) && not (a && b)

let notb cons = match cons with
  | VBit b ->VBit(not b)
  | VBitArray a -> VBitArray (Array.map not a)

let getval env a = match a with
  | Aconst cons -> cons
  | Avar i -> Env.find i env
(*------------------------------Fonctions d'input----------------------------*)
exception MauvaiseEntree
let read_bit ident =
  let rec essai () =
    try
      Printf.printf "Valeur de %s :" ident ;
      match read_int () with
      | 0 -> false
      | 1 -> true
      | _ -> raise MauvaiseEntree
    with
    | MauvaiseEntree ->Printf.printf "Mauvaise entrée\n"; essai ()
    in
    essai ()




let read_array ident n =
  let rec essai () : bool array=
    try
      Printf.printf "Valeur de %s (Array de taille %d):" ident n ;
      let l = List.map (fun x -> match x with
            | '0' -> false
            | '1' -> true
            | _ -> raise MauvaiseEntree
          ) (explode_string (read_line ())) in
      if (List.length l) <> n then raise MauvaiseEntree;
      (Array.of_list l)
    with
    | MauvaiseEntree ->Printf.printf "Mauvaise entrée\n"; essai ()
    | _ -> Printf.printf "Problème de format\n"; essai ()
    in
    essai ()



let read_input (vars:Netlist_ast.ty Netlist_ast.Env.t) (inputs) (env) : Netlist_ast.value Netlist_ast.Env.t=
  List.fold_left (fun accenv i ->  Env.add i (match Env.find i vars with
      | TBit -> VBit (read_bit i)
      | TBitArray n -> VBitArray (read_array i n)
    ) accenv) env inputs


(*------------------------------Fonctions relatives aux opérations------------*)

let choose_binop (binop:binop) : (bool -> bool -> bool) = match binop with
  | Or -> orb
  | Xor -> xorb
  | And -> andb
  | Nand -> nandb




let dobinop n val1 val2 = match val1,val2 with
    | VBit b, VBit b2 -> VBit( (choose_binop n ) b b2 )
    | VBit b, VBitArray a | VBitArray a, VBit b ->
      VBitArray (Array.map (fun x -> choose_binop n b x) a )
    | VBitArray a1, VBitArray a2 -> VBitArray(
        Array.init (min (Array.length a1) (Array.length a2) )
            (fun j -> (choose_binop n) (a1.(j)) (a2.(j))))

let rec concat val1 val2 = match val1,val2 with
    | VBit b, VBit b2 ->  VBitArray [|b;b2|]
    | VBit b, VBitArray a -> concat (VBitArray([|b|])) val2
    | VBitArray a, VBit b -> concat val1 (VBitArray([|b|]))

    | VBitArray a1, VBitArray a2 ->
        let a = Array.make ((Array.length a1)+ (Array.length a2) ) false in
        for j = 0 to (Array.length a) -1 do
          if j < Array.length a1 then
            a.(j) <- a1.(j)
          else
            a.(j) <- a2.(j-Array.length a1)
        done;
        VBitArray a



let select i valu = match i,valu with
  | 0, VBit a -> VBit(a)
  | _, VBitArray a -> VBit(a.(i))
  | _ -> failwith "Mauvais argument"

let mux v1 a1 a2 env = match v1 with
  | VBit a -> if a then getval env a1 else getval env a2
  | VBitArray a -> if istrue a then getval env a1 else getval env a2

let slice i1 i2 arr =
  Array.init (i2 -i1 +1) (fun i -> Array.get arr (i+i1))


let call_op env op perm (rams:bool array array Netlist_ast.Env.t) roms=
  let (i,ex) = op in match ex with
  | Earg a -> (match a with
      | Aconst cons -> Env.add i cons env
      | Avar i2 -> Env.add i (Env.find i2 env) env)

  | Ereg i2 ->Env.add i (Env.find i2 perm) env

  | Enot a -> Env.add i (notb (getval env a)) env

  | Ebinop (n,a1,a2) -> Env.add i (match a1,a2 with
    | Avar i1, Avar i2 -> dobinop n (Env.find i1 env) (Env.find i2 env)
    | Avar i1, Aconst v | Aconst v, Avar i1 -> dobinop n (Env.find i1 env) v
    | Aconst v1, Aconst v2 -> dobinop n v1 v2
  ) env

  | Emux (a1,a2,a3) -> Env.add i (mux (getval env a1) a2 a3 env) env

  | Erom (_,_,a1) ->
    Env.add i (
      let a1val = getval env a1 in
      match a1val with
      | VBit _ -> failwith "Mauvaise utilisation de RAM"
      | VBitArray a -> VBitArray ( (Env.find i roms).(int_of_array a))
      ) env

  | Eram (_,_,a1,_,_,_) ->
    Env.add i (let a1val = getval env a1 in match a1val with
      | VBit _ -> failwith "Mauvaise utilisation de RAM"
      | VBitArray a -> VBitArray ((Env.find i rams).(int_of_array a))
      ) env

  | Econcat(a1,a2) -> Env.add i (match a1,a2 with
    | Avar i1, Avar i2 -> concat  (Env.find i1 env) (Env.find i2 env)
    | Avar i1, Aconst v ->concat  (Env.find i1 env) v
    | Aconst v, Avar i1 -> concat v (Env.find i1 env)
    | Aconst v1, Aconst v2 -> concat v1 v2
    ) env

  | Eslice (i1,i2,a) ->  Env.add i (let aval = getval env a in match aval with
    | VBit _ -> failwith "Impossible de slice un bit"
    | VBitArray b -> VBitArray (slice i1 i2 b)


                                   ) env
  | Eselect (i1,a) -> Env.add i (match a with
        | Avar inde -> select i1 (Env.find inde env)
        | Aconst valu -> select i1 valu) env

let int_to_month i =
  if i = 1 then "janvier"
  else if i = 2 then "février"
  else if i = 3 then "mars"
  else if i = 4 then "avril"
  else if i = 5 then "mai"
  else if i = 6 then "juin"
  else if i = 7 then "juillet"
  else if i = 8 then "août"
  else if i = 9 then "septembre"
  else if i = 10 then "octobre"
  else if i = 11 then "novembre"
  else "décembre"

let int_to_day i =
  if i = 1 then "lundi"
  else if i = 2 then "mardi"
  else if i = 3 then "mercredi"
  else if i = 4 then "jeudi"
  else if i = 5 then "vendredi"
  else if i = 6 then "samedi"
  else "dimanche"

let effectively_print n =
  let month = int_to_month tab_print.(5) in
  let sec = tab_print.(0) in
  let minute = tab_print.(1) in
  let hr = tab_print.(2) in
  let n_day = tab_print.(3) in
  let day_week = int_to_day tab_print.(4) in
  let year = tab_print.(6) in
  Printf.printf "Nous sommes le %s %d %s %d, il est %d:%d:%d\n %!" day_week n_day month year hr minute sec 

let pretty_print v ident = if !base_ten then begin
  if !print_well then begin(
    match v with
    | VBit b -> ()
    | VBitArray a -> if ident = "annee" then (
      tab_print.(6) <- ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a));
      effectively_print 0)
  else if ident = "mois" then
    tab_print.(5) <- ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a))
  else if ident = "semaine" then
    tab_print.(4) <- ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a))
  else if ident = "jour" then
    tab_print.(3) <- ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a))
  else if ident = "hr" then
    tab_print.(2) <- ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a))
  else if ident = "min" then
    tab_print.(1) <- ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a))
  else 
    tab_print.(0) <- ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a))) end else
  match v with
  | VBit b -> Printf.printf "=> %s = %d\n" ident (Obj.magic b)
  | VBitArray a -> Printf.printf "=> %s = " ident; 
      Printf.printf "%d\n" ((Array.fold_left (fun i b -> 2 * i + (Obj.magic b)) 0 a)) end
  else match v with
  | VBit b -> Printf.printf "=> %s = %d\n" ident (Obj.magic b)
  | VBitArray a -> Printf.printf "=> %s = " ident; Array.iter (fun x->
      Printf.printf "%d" (Obj.magic x)) a; Printf.printf "\n"

let rom_folder = "roms"

let prep_name_file s =
  String.concat "" [rom_folder; "/"; s; ".rom"]


exception BadLength
exception BadInput
let prepass acc i (op:exp) =
  let (rams, roms, li) = acc in
  match op with
  | Eram (addr_size, word_size,_,io,wa,data) -> (
    (Env.add i (Array.init (1 lsl addr_size) (
          fun i -> Array.init word_size (fun i-> false) )
       ) rams, roms, (i,word_size,io,wa,data)::li) )

  | Erom (addr_size, word_size, _) -> (
    let emptyarr =Array.init (1 lsl addr_size) (
          fun i -> Array.init word_size (fun i-> false)) in
    try
      let fich = open_in (prep_name_file i) in
      for i = 0 to (1 lsl addr_size) -1 do
        let line = input_line fich in
        if String.length line = word_size then begin
          emptyarr.(i) <- Array.of_list (List.map (fun x ->
            match x with
            | '0'-> false
            | '1' -> true
            | _ -> raise BadInput
          ) (explode_string line) ) end else raise BadLength
      done;
      (rams,Env.add i (emptyarr) roms,li)

    with
    | BadLength -> failwith "Mauvaise taille de fichier"
    | BadInput -> failwith "Mauvaise entrée"
    | e ->  (*Printf.printf "%s" (Printexc.to_string e);*)(rams,Env.add i (emptyarr) roms,li) )

  | _ -> (rams,roms,li)

let init v = match v with
| TBit -> VBit (false)
| TBitArray n-> VBitArray (Array.make n false)

let simulator program number_steps =
  let i = ref 0 in
  let e = ref (Env.map (fun v -> init v) program.p_vars) in
  let (rams,roms,li)  =  List.fold_left (fun acc (i,op) -> prepass acc i op)
      (Env.empty,Env.empty, []) program.p_eqs in
  

  while not (!i = number_steps) do
    (* Printf.printf "Etape n°%d\n %!" (!i+1); *)
    e := read_input program.p_vars program.p_inputs !e;
    e := List.fold_left (fun acc op ->
        call_op acc op !e rams roms) !e program.p_eqs;
    i := !i + 1;

    List.iter (fun (i,word_size,io,wa,data) ->
        let ioval =getval !e io in
        let iobool = (match ioval with
            | VBit a-> a
            | VBitArray a -> istrue a
          ) in
        let waval = getval !e wa in
        let warr = (match waval with
          | VBitArray a -> a
          | VBit _-> failwith "Mauvaise utilisation de RAM") in
        let dataval = getval !e data in
        let datarr = (match dataval with
            | VBit _ -> failwith "Mauvaise utilisation de RAM"
            | VBitArray a -> if (Array.length a) = word_size then a else
                failwith "Mauvais taille d'argument de RAM") in
        if iobool then (Env.find i rams).(int_of_array warr) <- datarr
      )  li;
    if !per_sec then try
      (match Env.find "sec" !e with
        |VBitArray a -> if a.(31) != !curr_sec then 
          (curr_sec := not !curr_sec;       List.iter (fun x-> pretty_print (Env.find x !e) x) program.p_outputs)
        | _ -> failwith "oups")
      with _ -> per_sec := false; List.iter (fun x-> pretty_print (Env.find x !e) x) program.p_outputs
    else List.iter (fun x-> pretty_print (Env.find x !e) x) program.p_outputs
  done


let compile filename =
  try
    let p = Netlist.read_file filename in
    begin try
        let p = Scheduler.schedule p in
        simulator p !number_steps
      with
        | Scheduler.Combinational_cycle ->
            Format.eprintf "The netlist has a combinatory cycle.@.";
    end;
  with
    | Netlist.Parse_error s -> Format.eprintf "An error accurred: %s@." s; exit 2

let main () =
  Arg.parse
    ["-n", Arg.Set_int number_steps, "Number of steps to simulate"; "-ten", Arg.Set base_ten, "Print the results in base 10"; "-sec", Arg.Set per_sec, "Only print every time a (clock) second passes"; "-clock", Arg.Set print_well, "Beautiful print for a clock"]
    compile
    ""
;;

main ()
