open Printf
open Problem_t

let path i = sprintf "../solution/%d" i
let parse i = Problem_j.solution_of_string @@ Std.input_file @@ path i

let make p l =
  assert (Array.length p.musicians = List.length l);
  { placements = List.map (fun (x,y) -> { x; y }) l; }

let save i s = Std.output_file ~filename:(path i) ~text:(Problem_j.string_of_solution s)

let show_score f = sprintf "%#d" (int_of_float f)

let sqr x = x *. x

module FOP = struct
let (+) = (+.)
let ( * ) = ( *. )
let (/) = (/.)
let (-) = (-.)
end

let pt ({x;y}:placement) = (x,y)

(* point 1 (x1,y1)
   point 2 (x2,y2)
   circle center (x0,y0) radius r
*)
let is_blocked (x1,y1) (x2,y2) (x0,y0) =
  let r = 5. in
  let a = (x2 -. x1)*.(x2 -. x1) +. (y2 -. y1)*.(y2 -. y1) in
  let b = 2. *. ( (x2 -. x1)*.(x1 -. x0) +. (y2 -. y1)*.(y1 -. y0)) in
  let c = (x1 -. x0)*.(x1 -. x0) +. (y1 -. y0)*.(y1 -. y0) -. r*.r in

  let det = b*.b -. 4.*.a*.c in
  if det < 0. then false else begin
    let t1 = (-.b +. (Float.sqrt det)) /. (2.*.a) in
    let t2 = (-.b -. (Float.sqrt det)) /. (2.*.a) in
    ( (t1 >= 0.) && (t1 <= 1.) ) || ( (t2 >= 0.) && (t2 <= 1.) )
  end

let calc_score p coords =
  assert (Array.length coords = Array.length p.musicians);
  p.attendees
  |> List.map begin fun a ->
    coords |> Array.mapi (fun i m ->
      if coords |> Array.exists (fun mm -> mm <> m && is_blocked m (a.x,a.y) mm) then
        0.
      else
        let d2 = sqr (a.x -. fst m) +. sqr (a.y -. snd m) in
        Float.ceil (1_000_000. *. a.tastes.(p.musicians.(i)) /. d2))
    |> Array.fold_left (+.) 0.
  end
  |> List.fold_left (+.) 0.

let score p s =
  calc_score p (List.map pt s.placements |> Array.of_list)
