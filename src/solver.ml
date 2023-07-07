open Devkit
open Problem_t

let solve p =
  let insts = List.sort_uniq compare p.musicians in
  let _inst_centers = List.map (fun inst ->
    Numeric.almost_optimal_musician inst p
  ) insts in

  (* count how many musicians per inst *)
  printfn "done"
