open Printf
open Devkit

let problem n = sprintf "../problem/%d" n
let problems = 45

let () =
  for i = 1 to problems do
    let j = Problem_j.problem_of_string @@ Std.input_file @@ problem i in
    printfn "%d %d" (List.length j.musicians) (List.length j.attendees)
  done
