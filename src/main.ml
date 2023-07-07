open Devkit
open Problem_t

let () =
  match Nix.args with
  | "stats"::nums ->
    printfn "ID\tAtt\tMus\tNeg\tZero";
    let nums = List.map int_of_string nums in
    for i = 0 to Problem.total do
      if nums = [] || List.mem i nums then
      begin
        let p = Problem.parse i in
        let bad_taste = p.attendees |> List.exists (fun a -> a.tastes |> List.exists (fun t -> Float.abs t < Float.epsilon)) in
        printfn "%d\t%d\t%d\t%b\t%b" i (List.length p.attendees) (List.length p.musicians) (Problem.has_neg p) bad_taste
      end
    done
  | "draw"::i::[] ->
    let p = Problem.parse @@ int_of_string i in
    printfn "digraph problem_%s {" i;
    printfn "node [margin=0 fontcolor=black fontsize=32 width=5 shape=circle style=filled fillcolor=blue]";
    printfn "stage [shape=box fillcolor=gray pin=true pos=\"%g,%g\" width=%g height=%g]"
      (Problem.stage_center_x p) (Problem.stage_center_y p) p.stage_width p.stage_height;
    p.attendees |> List.iteri begin fun i a ->
      printfn "%d [pin=true pos=\"%g,%g\"]" i a.x a.y;
    end;
    printfn "}"
  | "solve"::i::[] ->
    Solver.solve @@ Problem.parse @@ int_of_string i
  | _ -> printfn "so what?"
