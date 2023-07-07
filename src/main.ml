open Devkit
open Problem_t

let int = int_of_string

let () =
  match Nix.args with
  | "stats"::nums ->
    printfn "ID\tAtt\tMus\tTastes\tNeg\tZero";
    let nums = List.map int nums in
    for i = 0 to Problem.total do
      if nums = [] || List.mem i nums then
      begin
        let p = Problem.parse i in
        let is = Problem.instruments p in
        let has_zero = p.attendees |> List.exists (fun a -> a.tastes |> Array.exists (fun t -> Float.abs t < Float.epsilon)) in
        let has_neg = p.attendees |> List.exists (fun a -> a.tastes |> Array.exists (fun t -> t < 0.)) in
        printfn "%d\t%d\t%d\t%d\t%b\t%b" i (List.length p.attendees) (Array.length p.musicians) (Array.length is) has_neg has_zero
      end
    done
  | "score"::nums ->
    let nums = List.map int nums in
    for i = 0 to Problem.total do
      if nums = [] || List.mem i nums then
      begin
        printfn "%d) %10.0f" i (Solution.score (Problem.parse i) (Solution.parse i))
      end
    done
  | "draw"::i::[] ->
    let p = Problem.parse @@ int i in
    printfn "digraph problem_%s {" i;
    printfn "node [margin=0 fontcolor=black fontsize=32 style=filled pin=true]";
    printfn "stage [shape=box fillcolor=gray pos=\"%g,%g\" width=%g height=%g]"
      (Problem.stage_center_x p) (Problem.stage_center_y p) p.stage_width p.stage_height;
    begin match Solution.parse @@ int i with
    | exception Sys_error _ -> () (* no solution *)
    | s ->
      printfn "node [shape=circle fillcolor=red width=10]";
      s.placements |> List.iteri begin fun i (p:placement) ->
        printfn "m%d [pin=true pos=\"%g,%g\"]" i p.x p.y
      end
    end;
    printfn "node [shape=circle fillcolor=blue width=10]";
    p.attendees |> List.iteri begin fun i a ->
      printfn "a%d [pin=true pos=\"%g,%g\"]" i a.x a.y;
    end;
    printfn "}"
  | "solve"::i::[] ->
    let p = Problem.parse @@ int i in
    let coords = Solver.solve p in
    Solution.save (int_of_string i) @@ Solution.make p coords
  | _ -> printfn "so what?"
