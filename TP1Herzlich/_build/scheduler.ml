open Netlist_ast
open Graph
open Hashtbl

exception Combinational_cycle

let rec extract_args li = match li with
  | [] -> []
  | x::q -> (match x with
    | Avar(i) -> i::(extract_args q)
    | Aconst(_) -> extract_args q
  )

let read_exp eq = let x,exp = eq in
  match exp with
    | Earg (a) (* a: argument *) -> extract_args [a]
    | Ereg (i)-> []
    | Enot (a) (* NOT a *)-> extract_args [a]
    | Ebinop (_,a1,a2) (* OP a1 a2 : boolean operator *)-> extract_args [a1;a2]
    | Emux (a1,a2,a3) (* MUX a1 a2 : multiplexer *)->  extract_args [a1;a2;a3]
    | Erom (_,_,a) (*read_addr*)-> extract_args [a]
    | Eram (_,_,a1,_,_,_)-> extract_args [a1]
    | Econcat (a1,a2)(* CONCAT a1 a2 : concatenation of arrays *)-> extract_args [a1;a2]
    | Eslice (_,_,a) -> extract_args [a]
    | Eselect (_,a) -> extract_args [a]

let build_graph p =
  let h = Hashtbl.create (List.length p.p_inputs) in
  let h2 = Hashtbl.create (List.length p.p_inputs) in
  let g = mk_graph () in

  List.iter (fun y -> Hashtbl.add h y 0) p.p_inputs;


  List.iter (fun (i,exp) ->
    let ali = read_exp (i,exp) in
    if not (Hashtbl.mem h2 i) then begin
        Hashtbl.add h2 i 0;
        add_node g i;
    end;

    List.iter (fun ind ->
        if not (Hashtbl.mem h ind) then (
            if not (Hashtbl.mem h2 ind) then begin
              Hashtbl.add h2 ind 0;
              add_node g ind;
            end;
            add_edge g ind i;
        )
      ) ali;
    ) p.p_eqs;
  g

let schedule p =
  let topo = try topological (build_graph p) with
    | Cycle -> raise Combinational_cycle
  in
  let neq = ref [] in
  List.iter ( fun i -> List.iter (fun (ind,exp) -> if ind =i
                    then neq := (ind,exp)::!neq
      ) p.p_eqs;
    ) topo;
  neq := List.rev !neq;
  let newp = {p_eqs = !neq;
              p_inputs = p.p_inputs;
              p_outputs = p.p_outputs;
              p_vars = p.p_vars;
             } in
  newp
