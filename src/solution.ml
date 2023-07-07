open Printf
open Problem_t

let path i = sprintf "../solution/%d" i
let parse i = Problem_j.solution_of_string @@ Std.input_file @@ path i

let make p l =
  assert (Array.length p.musicians = List.length l);
  { placements = List.map (fun (x,y) -> { x; y }) l; }

let save i s = Std.output_file ~filename:(path i) ~text:(Problem_j.string_of_solution s)

let sqr x = x *. x

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
