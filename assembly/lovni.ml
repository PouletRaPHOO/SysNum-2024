
(* Fichier principal du compilateur Lövni *)

open Format
open Lexing
open Ast

(* Option de compilation, pour s'arrêter à l'issue du parser *)
let parse_only = ref false


(* Nom du fichier source *)
let ifile = ref ""

let set_file f s = f := s

(* Les options du compilateur que l'on affiche avec --help *)
let options =
  ["--parse-only", Arg.Set parse_only,
   "  Pour ne faire uniquement que la phase d'analyse syntaxique"
  ]

let usage = "usage: ./lovni.exe [option] file.lv"

(* localise une erreur en indiquant la ligne et la colonne *)
let localisation pos =
  let l = pos.pos_lnum in
  let c = pos.pos_cnum - pos.pos_bol + 1 in
  eprintf "File \"%s\", line %d, characters %d-%d:\n" !ifile l (c-1) c

let () =
  (* Parsing de la ligne de commande *)
  Arg.parse options (set_file ifile) usage;

  (* On vérifie que le nom du fichier source a bien été indiqué *)
  if !ifile="" then begin eprintf "Aucun fichier à compiler\n@?"; exit 1 end;

  (* Ce fichier doit avoir l'extension .kc *)
  if not (Filename.check_suffix !ifile ".lv") then begin
    eprintf "Le fichier d'entrée doit avoir l'extension .lv\n@?";
    Arg.usage options usage;
    exit 1
  end;

  (* Ouverture du fichier source en lecture *)
  let f = open_in !ifile in

  (* Création d'un tampon d'analyse lexicale *)
  let buf = Lexing.from_channel f in
  try (

    let p = Parser.prog Lexer.token buf in ();


    let rec premier_passage (compteur:int) (l:int) (n:int) e1 e2 (p:Ast.program)= match p with
    | [] -> e1,e2, []
    | t::q -> (match t with
        | Label i -> premier_passage compteur (l+1) (n+1) (Env.add i (l-n) e1) e2 q
        | Linefeed  -> premier_passage compteur (l+1) (n+1) e1 e2 q
        | Bexpr(Eload(re, i)) -> if Env.mem i e2
          then (let ei1,ei2,li = premier_passage compteur (l+1) n e1 e2 q in
                ei1,ei2,Bexpr(Eloadfin(re,Env.find i e2))::li
          ) else (
            let ei1,ei2,li = premier_passage (compteur+1) (l+1) n e1 (Env.add i compteur e2) q in
            ei1,ei2, (Bexpr(Eloadfin(re,compteur)))::li
          )
        | Bexpr(Estore(i, re)) -> if Env.mem i e2
          then (let ei1,ei2,li = premier_passage compteur (l+1) n e1 e2 q in
                ei1,ei2,Bexpr(Estorefin(Env.find i e2,re))::li
          ) else (
            let ei1,ei2,li = premier_passage (compteur+1) (l+1) n e1 (Env.add i compteur e2) q in
            ei1,ei2, (Bexpr(Estorefin(compteur,re)))::li
          )
        | _ as a -> let ei1,ei2, li = premier_passage compteur (l+1) n e1 e2 q in ei1,ei2,a::li
      )
    in
    let env_label,env_var, p2 = premier_passage 0 0 0 (Env.empty) (Env.empty) p in

    let oc = open_out (Filename.concat "roms" "actual_op") in

    let int_to_binary size va =
       let s = ref "" in
       let v = ref (abs va) in
       let q =  ref 1 lsl size in
       for i = 1 to size do
         let quotient = min (!v/!q, 1) in
         v:= !v mod !q;
         s := !s^quotient;
         q:= !q/2;
       done;
       !s
    in

    let find_binop_type b = match b with
      | Add | Sub | Mul -> "0001"
      | And | Or | Xor -> "0010"

   let find_binop_code b = match b with
     | Add | And-> "0001"
     | Sub | Or-> "0010"
     | Xor | Mul -> "0011"




    
    let rec passage2 p = match p with
      | [] -> ()
      | Bexpr(exp)::q -> Printf.fprint f oc "%s\n" (match exp with
          | Noop -> "00000000000000000000000000000000"
          | Ebinop(b,i1,i2) -> (find_binop_type b)^(find_binop_code b)^(int_to_binary 4 i1)^(int_to_binary 20 i2)



          | _ -> assert false


        ); passage2 q
      | _ -> assert false

    in
    close_out oc;

    close_in f;

    (* On s'arrête ici si on ne veut faire que le parsing *)
    exit 0;

  ) with
    | Lexer.Lexing_error c ->
	(* Erreur lexicale. On récupère sa position absolue et
	   on la convertit en numéro de ligne *)
	    localisation (Lexing.lexeme_start_p buf);
	    eprintf "Erreur lexicale: %s@." c;
	    exit 1

    | Parser.Error ->
	(* Erreur syntaxique. On récupère sa position absolue et on la
	   convertit en numéro de ligne *)
	localisation (Lexing.lexeme_start_p buf);
	eprintf "Erreur de parsing:@.";
  exit 1

