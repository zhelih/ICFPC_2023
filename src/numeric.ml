open Problem_t
(*type attendee = { x: float; y: float; tastes: float list }

type problem = {
  room_width: float;
  room_height: float;
  stage_width: float;
  stage_height: float;
  stage_bottom_left: float list;
  musicians: int list;
  attendees: attendee list
}
*)
(* compute almost-optimal x and y for musician and all attendees, corner is likely *)
let almost_optimal_musician inst p =
  let atts = List.map (fun att -> att.x, att.y, (List.nth att.tastes inst)) p.attendees in (* FIXME better *)
  let sum_ti = List.fold_left (fun prev (_,_,t) -> prev +. (1. /. t)) 0. atts in
  let sum_ai_ti = List.fold_left (fun prev (a,_,t) -> prev +. (a /. t)) 0. atts in
  let sum_bi_ti = List.fold_left (fun prev (_,b,t) -> prev +. (b /. t)) 0. atts in

  let x_star = sum_ti /. sum_ai_ti in
  let y_star = sum_ti /. sum_bi_ti in

  (* place inside of the stage +- 10 *)
  let stage_x_min = 10. +. (List.nth p.stage_bottom_left 0) in
  let stage_x_max = -10. +. (List.nth p.stage_bottom_left 0) +. p.stage_width in

  let stage_y_min = 10. +. (List.nth p.stage_bottom_left 1) in
  let stage_y_max = -10. +. (List.nth p.stage_bottom_left 1) +. p.stage_height in

  let x_sol = min ((max x_star stage_x_min)) (stage_x_max) in
  let y_sol = min ((max y_star stage_y_min)) (stage_y_max) in

  x_sol, y_sol
