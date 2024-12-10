exception Cycle
type mark = NotVisited | InProgress | Visited

type 'a graph =
    { mutable g_nodes : 'a node list }
and 'a node = {
  n_label : 'a;
  mutable n_mark : mark;
  mutable n_link_to : 'a node list;
  mutable n_linked_by : 'a node list;
}

let mk_graph () = { g_nodes = [] }

let add_node g x =
  let n = { n_label = x; n_mark = NotVisited; n_link_to = []; n_linked_by = [] } in
  g.g_nodes <- n :: g.g_nodes

let node_of_label g x =
  List.find (fun n -> n.n_label = x) g.g_nodes

let add_edge g id1 id2 =
  try
    let n1 = node_of_label g id1 in
    let n2 = node_of_label g id2 in
    n1.n_link_to   <- n2 :: n1.n_link_to;
    n2.n_linked_by <- n1 :: n2.n_linked_by
  with Not_found -> Format.eprintf "Tried to add an edge between non-existing nodes"; raise Not_found

let clear_marks g =
  List.iter (fun n -> n.n_mark <- NotVisited) g.g_nodes

let find_roots g =
  List.filter (fun n -> n.n_linked_by = []) g.g_nodes


let has_cycle g1 =
  List.iter (fun x-> x.n_mark<- NotVisited) g1.g_nodes;
  let rec dfs x = match x.n_mark with
      | NotVisited ->
        x.n_mark <- InProgress;
        List.iter (fun y -> dfs y) x.n_link_to;
        x.n_mark <- Visited;
      | Visited -> ()
      | InProgress -> raise Cycle
  in
  try
    List.iter (fun x -> dfs x) g1.g_nodes;
    false
  with
  | Cycle -> true



let topological g=
  let topo = ref [] in
      let rec dfs1 x = match x.n_mark with
      | NotVisited -> x.n_mark <- InProgress;
        List.iter (fun y -> dfs1 y) x.n_link_to;
        x.n_mark <- Visited;
        topo := x.n_label::!topo;
      | Visited -> ()
      | InProgress -> raise Cycle in
  try
    List.iter (fun x -> if x.n_mark = NotVisited then dfs1 x) g.g_nodes;
    List.iter (fun x-> x.n_mark<- NotVisited) g.g_nodes;
    !topo
  with
  | Cycle -> raise Cycle
