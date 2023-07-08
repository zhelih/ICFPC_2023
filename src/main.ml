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
  | "score"::suffix::nums ->
    let nums = List.map int nums in
    for i = 0 to Problem.total do
      if nums = [] || List.mem i nums then printfn "%d) %s" i Solution.(show_score @@ score (Problem.parse i) (Solution.parse suffix i))
    done
  | "draw"::suffix::i::[] ->
    let p = Problem.parse @@ int i in
    printfn "digraph problem_%s {" i;
    printfn "node [margin=0 fontcolor=black fontsize=32 style=filled pin=true]";
    printfn "stage [shape=box fillcolor=gray pos=\"%g,%g\" width=%g height=%g]"
      (Problem.stage_center_x p) (Problem.stage_center_y p) p.stage_width p.stage_height;
    begin match Solution.parse suffix @@ int i with
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
  | "solve"::suffix::i::[] ->
    let p = Problem.parse @@ int i in
    let interrupt = ref false in
    let sol = Solver.solve p in
    Signal.replace [Sys.sigterm;Sys.sigint] (fun _ -> interrupt := true);
    let coords = Local_search.run interrupt (int i) p sol in
    let s = Solution.make p coords in
    printfn "solution %s score %s" i Solution.(show_score @@ score p s);
    Solution.save suffix (int_of_string i) s
  | _ -> printfn "so what?"
