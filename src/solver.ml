open Devkit
open Problem_t

module CC = Cache.Count

let solve p =
  let insts = List.sort_uniq compare @@ Array.to_list p.musicians in
  let h_centers = Hashtbl.create 1 in
  List.iter (fun inst ->
    let sol = Numeric.almost_optimal_musician inst p in
    Hashtbl.add h_centers inst sol
  ) insts;

  let counter = CC.create () in

  let fx c =
    let x_sign = if c / 2 mod 2 == 1 then 1 else -1 in
    let x_lvl = if c mod 2 == 1 then 0 else (c-1)/4 + 1 in
    if c == 0 then 0 else x_sign*x_lvl
  in
  let fy c =
    let y_sign = if c / 2 mod 2 == 0 then 1 else -1 in
    let y_lvl = if c mod 2 == 0 then 0 else c/4 + 1 in
    y_sign*y_lvl
  in

  let offset = 15 in

  let res = DynArray.create () in

  let check_good x y =
    try
      let _ = DynArray.index_of (fun (a,b) -> (x -. a)** 2. +. (y -. b)**2. <= 100.) res in
      false
    with Not_found -> true
  in

  List.iter (fun inst ->
    let (center_x, center_y) = Hashtbl.find h_centers inst in

    let rec loop () =
      let c = CC.count counter inst in
      let coord_x = float (offset * (fx c)) +. center_x in
      let coord_y = float (offset * (fy c)) +. center_y in

      assert (c < 10000);

      printfn "inst %d CC %d X %f Y %f" inst  c coord_x coord_y;

      CC.plus counter inst 1;

      if Numeric.inside coord_x coord_y p && check_good coord_x coord_y then begin
        DynArray.add res (coord_x, coord_y)
      end else begin
        loop ()
      end
    in loop ()
  ) (Array.to_list p.musicians);
  DynArray.to_list res
