open Printf
open Devkit

let problem n = sprintf "../problem/%d" n

let () =
  let j = Problem_j.problem_of_string @@ Std.input_file @@ problem 1 in
  printfn "%d" (List.length j.musicians)
