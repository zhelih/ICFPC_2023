open Printf
open Problem_t

let total = 45
let path n = sprintf "../problem/%d" n
let parse i = Problem_j.problem_of_string @@ Std.input_file @@ path i
let stage_x p = match p.stage_bottom_left with [x;_] -> x | _ -> assert false
let stage_y p = match p.stage_bottom_left with [_;y] -> y | _ -> assert false
let stage_center_x p = stage_x p +. p.stage_width /. 2.
let stage_center_y p = stage_y p +. p.stage_height /. 2.
let has_neg p =
  let rec loop1 l =
    match l with
    | [] -> false
    | hd::_ when hd < 0. -> true
    | _::tl -> loop1 tl
  in
  let rec loop l =
    match l with
    | [] -> false
    | hd::tl -> if loop1 hd.tastes then true else loop tl
  in
  loop p.attendees
