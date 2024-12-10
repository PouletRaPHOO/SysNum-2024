open Graph

type graph' = int list array

let g1 = [| [1]; [1]; [1] |]
let g2 = [| []; [2]; [3]; [4]; [0; 1]; |]
let g3 = [| [1]; [2]; [3]; [] |]
let g4 = [| [3]; [0; 2; 4]; [3]; []; [6]; [1; 4; 7]; [3; 8]; [6; 9]; []; [8] |]

let tests : (graph' * bool) list = [g1, true; g2, true; g3, false; g4, false]

let graph_of_graph' g' =
  let g = mk_graph () in
  Array.iteri (fun i _ ->
    add_node g i
  ) g';
  Array.iteri (fun src dests ->
    List.iter (fun dest ->
      add_edge g src dest
    ) dests
  ) g';
  g

(* Assumption on g: its node labels are distinct integers between 0 and n-1 *)
(* Graphs made with graph_of_graph' have this property *)
let check_topo_on g =
  let topo_order = topological g in
  (* Check that topo_order is a function node index -> node index *)
  if not (
    List.length topo_order = List.length g.g_nodes &&
    List.for_all (fun x -> 0 <= x && x < List.length g.g_nodes) topo_order
  ) then (
    false
  ) else (
    (* Build inverse permutation *)
    let inverse_topo_order = Array.make (List.length g.g_nodes) None in
    List.iteri (fun i node ->
      inverse_topo_order.(node) <- Some i
    ) topo_order;
    (* Check the topological order for every edge *)
    List.for_all (fun source ->
      List.for_all (fun destination ->
        match inverse_topo_order.(source.n_label), inverse_topo_order.(destination.n_label) with
        | Some source_topo_pos, Some destination_topo_pos ->
          source_topo_pos < destination_topo_pos
        | _, _ -> false
      ) source.n_link_to
    ) g.g_nodes
  )

let test i (g', b) =
  let g = graph_of_graph' g' in
  Format.printf "Test %d:\n- has_cycle: %s\n- topological_sort: %s\n"
    i
    (if has_cycle g = b then "OK" else "FAIL")
    (try if check_topo_on g then "OK" else "FAIL"
    with Cycle -> if b then "OK" else "FAIL (no cycle here)"
    | e -> Format.eprintf "The detection of a cycle should raise the Cycle exception; otherwise, fix this one\n"; raise e)

let () = List.iteri test tests

