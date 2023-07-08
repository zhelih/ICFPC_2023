open Devkit

let step = 0.01

let rec_run p placements score0 =

  let new_score = ref score0 in
  let changed = ref false in

  (* perform 8 way local search *)
  let rec loop i =
    let x, y = placements.(i) in

    let try1 xx yy =
      if not !changed && Numeric.inside xx yy p then begin
        changed := true;
        placements.(i) <- (xx, yy);
        new_score := Solution.calc_score p placements;
        if !new_score <= score0 then changed := false
      end
    in
    try1 (x-.step) y;
    try1 (x+.step) y;
    try1 x (y-.step);
    try1 x (y+.step);
    try1 (x-.step) (y-.step);
    try1 (x-.step) (y+.step);
    try1 (x+.step) (y-.step);
    try1 (x+.step) (y+.step);

    if not !changed && i < Array.length placements - 1 then begin
      placements.(i) <- (x, y);
      loop (i+1)
    end
  in
  loop 0;
  !changed, !new_score

let run p placements =
  let placements = Array.of_list placements in
  let score0 = Solution.calc_score p placements in
  printfn "Starting local search step = %f, score = %s" step (Solution.show_score score0);
  let rec loop i sc0 =
    let c, nsc = rec_run p placements sc0 in
    if c then (
      if i mod 100 = 0 then printfn "Local Search : score = %s" (Solution.show_score nsc);
      if i < 20_000 then loop (i+1) nsc
    )
  in
  loop 0 score0;
  Array.to_list placements
