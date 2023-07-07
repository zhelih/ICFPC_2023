  open Printf
open Problem_t

let path i = sprintf "../solution/%d" i
let parse i = Problem_j.solution_of_string @@ Std.input_file @@ path i

let make p l =
  assert (Array.length p.musicians = List.length l);
  { placements = List.map (fun (x,y) -> { x; y }) l; }

let save i s = Std.output_file ~filename:(path i) ~text:(Problem_j.string_of_solution s)

let sqr x = x *. x

module FOP = struct
let (+) = (+.)
let ( * ) = ( *. )
let (/) = (/.)
let (-) = (-.)
end

(* https://mathworld.wolfram.com/Circle-LineIntersection.html *)
(*let is_blocked ~by a b =
  let open FOP in
  let ax = fst a - fst by in
  let ay = snd a - snd by in
  let bx = fst b - fst by in
  let by = snd b - snd by in
  if Float.(sign_bit ax = sign_bit bx && sign_bit ay = sign_bit by) then false
  else
    let incidence =
      let r2 = 25. in
      let dx = bx - ax in
      let dy = by - ay in
      let dr2 = sqr dx + sqr dy in
      let dnt = ax * by - bx * ay in
      r2 * dr2 - sqr dnt
    in
    incidence >= 0.*)

(* point 1 (x1,y1)
   point 2 (x2,y2)
   circle center (x0,y0) radius r
*)
let is_blocked (x1,y1) (x2,y2) (x0,y0,r) =
  let a = (x2 -. x1)*.(x2 -. x1) +. (y2 -. y1)*.(y2 -. y1) in
  let b = 2. *. ( (x2 -. x1)*.(x1 -. x0) +. (y2 -. y1)*.(y1 -. y0)) in
  let c = (x1 -. x0)*.(x1 -. x0) +. (y1 -. y0)*.(y1 -. y0) -. r*.r in

  let det = b*.b -. 4.*.a*.c in
  if det < 0. then false else begin
    let t1 = (-.b +. (Float.sqrt det)) /. (2.*.a) in
    let t2 = (-.b -. (Float.sqrt det)) /. (2.*.a) in
    ( (t1 >= 0.) && (t1 <= 1.) ) || ( (t2 >= 0.) && (t2 <= 1.) )
  end

let score p s =
  assert (List.length s.placements = Array.length p.musicians);
  p.attendees
  |> List.map begin fun a ->
    s.placements |> List.mapi (fun i (m:placement) ->
      let d2 = sqr (a.x -. m.x) +. sqr (a.y -. m.y) in
      1_000_000. *. a.tastes.(p.musicians.(i)) /. d2)
    |> List.fold_left (+.) 0.
  end
    |> List.fold_left (+.) 0.
