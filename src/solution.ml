open Printf
open Devkit
open Problem_t

let verbose = false

let path suffix i = sprintf "../solution.%s/%d" suffix i
let parse suffix i = Problem_j.solution_of_string @@ Std.input_file @@ path suffix i

let make p l =
  assert (Array.length p.musicians = List.length l);
  { placements = List.map (fun (x,y) -> { x; y }) l; }

let save suffix i s =
  begin try Sys.mkdir (Filename.dirname @@ path suffix i) 0o755 with _ -> () end;
  Std.output_file ~filename:(path suffix i) ~text:(Problem_j.string_of_solution s)

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

let h_blocked_cache = Hashtbl.create 1

let is_blocked_cached (x1,y1) (x2,y2) (x0,y0) =
  let key = (Int64.bits_of_float x1, Int64.bits_of_float y1, Int64.bits_of_float x2, Int64.bits_of_float y2, Int64.bits_of_float x0, Int64.bits_of_float y0) in
  match Hashtbl.find_opt h_blocked_cache key with
  | None -> let v = is_blocked (x1,y1) (x2,y2) (x0,y0) in Hashtbl.add h_blocked_cache key v; v
  | Some v -> v

let calc_score p coords =
  assert (Array.length coords = Array.length p.musicians);
  p.attendees
  |> List.fold_left begin fun acc a ->
    coords |> CCArray.foldi begin fun acc i m ->
      if coords |> Array.exists (fun mm -> mm != m && is_blocked m (a.x,a.y) mm) then
        acc
      else begin
        let d2 = sqr (a.x -. fst m) +. sqr (a.y -. snd m) in
        let pr = Float.ceil (1_000_000. *. a.tastes.(p.musicians.(i)) /. d2) in
        if verbose then printfn "%f\t(%f,%f)\t%d" pr a.x a.y i;
        acc +. pr
      end
    end
    acc
  end 0.

let calc_score_blocked_stats p coords =
  assert (Array.length coords = Array.length p.musicians);
  let val_block_on = ref 0. in
  let val_block_off = ref 0. in
  let val_block_pos = ref 0. in
  let val_block_neg = ref 0. in
  let res = p.attendees
  |> List.fold_left begin fun acc a ->
    coords |> CCArray.foldi begin fun acc i m ->
      let am_i_blocked = coords |> Array.exists (fun mm -> mm != m && is_blocked m (a.x,a.y) mm) in
      let d2 = sqr (a.x -. fst m) +. sqr (a.y -. snd m) in
      let pr = Float.ceil (1_000_000. *. a.tastes.(p.musicians.(i)) /. d2) in
      val_block_off := !val_block_off +. pr;
      if am_i_blocked then begin
        if pr > 0. then val_block_pos := !val_block_pos +. pr else val_block_neg := !val_block_neg +. pr;
      end else val_block_on := !val_block_on +. pr;
      if am_i_blocked then acc else acc +. pr
    end
    acc
  end 0. in
  printfn "SMART BLOCKER SOLUTION SCORE";
  printfn "BLOCK OFF\tBLOCK ON\tBLOCK +\tBLOCK -";
  printfn "%s\t%s\t%s\t%s" (show_score !val_block_off) (show_score !val_block_on) (show_score !val_block_pos) (show_score !val_block_neg);
  res

let score p s =
  calc_score_blocked_stats p (List.map pt s.placements |> Array.of_list)
