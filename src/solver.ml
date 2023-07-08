open Devkit
open Problem_t

module CC = Cache.Count

let offset = 15.

let nth_offset n = float_of_int n *. offset

let gen_snake (x,y) =
  let l = ref [x,y] in
  let margin = ref 1 in
  fun _c ->
    match !l with
    | [t] ->
      let m = nth_offset !margin in
      let sx = x -. m in
      let sy = y -. m in
      for i = 0 to !margin * 2 + 1 do let ix = sx +. nth_offset i in tuck l (ix,y-.m); tuck l (ix,y+.m) done;
      for i = 0 to !margin * 2 - 1 do let iy = sy +. nth_offset (i+1) in tuck l (x-.m,iy); tuck l (x+.m,iy) done;
      incr margin;
      t
    | t::ts -> l := ts; t
    | [] -> assert false

let gen_cross =
  let fx c =
    let x_sign = if c / 2 mod 2 == 1 then 1 else -1 in
    let x_lvl = if c mod 2 == 1 then 0 else (c-1)/4 + 1 in
    if c = 0 then 0 else x_sign*x_lvl
  in
  let fy c =
    let y_sign = if c / 2 mod 2 == 0 then 1 else -1 in
    let y_lvl = if c mod 2 = 0 then 0 else c/4 + 1 in
    y_sign*y_lvl
  in
  fun (x,y) c -> nth_offset (fx c) +. x, nth_offset (fy c) +. y

let solve interrupt p =
  let insts = List.sort_uniq compare @@ Array.to_list p.musicians in
  let h_centers = Hashtbl.create 1 in
  List.iter (fun inst ->
    let sol = Numeric.almost_optimal_musician inst p in
    Hashtbl.add h_centers inst sol
  ) insts;

  let counter = CC.create () in

  let res = DynArray.create () in

  let check_good x y =
    try
      let _ = DynArray.index_of (fun (a,b) -> (x -. a)** 2. +. (y -. b)**2. <= 100.) res in
      false
    with Not_found -> true
  in

  let snakes = Hashtbl.create 1 in
  h_centers |> Hashtbl.iter (fun inst xy -> Hashtbl.add snakes inst (gen_snake xy));

  p.musicians |> Array.iter begin fun inst ->
    let snake = Hashtbl.find snakes inst in
    if !interrupt then failwith "interrupted";

    let rec loop () =
      let c = CC.count counter inst in
      let (coord_x,coord_y) = snake c in

      assert (c < 20000);

(*       printfn "inst %d CC %d X %f Y %f" inst  c coord_x coord_y; *)

      CC.plus counter inst 1;

      if Numeric.inside coord_x coord_y p && check_good coord_x coord_y then
        DynArray.add res (coord_x, coord_y)
      else
        loop ()
    in
    loop ()
  end;
  DynArray.to_list res
