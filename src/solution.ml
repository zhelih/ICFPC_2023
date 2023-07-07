open Printf
open Problem_t

let path i = sprintf "../solution/%d" i
let parse i = Problem_j.solution_of_string @@ Std.input_file @@ path i

let make p l =
  assert (Array.length p.musicians = List.length l);
  { placements = List.map (fun (x,y) -> { x; y }) l; }
