open Printf
open Problem_t

let total = 45
let path n = sprintf "../problem/%d" n
let parse i = Problem_j.problem_of_string @@ Std.input_file @@ path i
let stage_x p = match p.stage_bottom_left with [x;_] -> x | _ -> assert false
let stage_y p = match p.stage_bottom_left with [_;y] -> y | _ -> assert false
let stage_center_x p = stage_x p +. p.stage_width /. 2.
let stage_center_y p = stage_y p +. p.stage_height /. 2.

let instruments p =
  let maxi = Array.fold_left max 0 p.musicians in
  let a = Array.make maxi 0 in
  p.musicians |> Array.iter (fun i -> a.(i) <- a.(i) + 1);
  a

(*
let score p positions =
  assert (List.length positions = List.length p.musicians);
  p.attendees
  |> List.map begin fun a ->
    a.tastes
  end
  |> List.fold_left (+.) 0.
*)
