(* Auto-generated from "problem.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type placement = { x: float; y: float }

type solution = { placements: placement list }

type attendee = {
  x: float;
  y: float;
  tastes: float Atdgen_runtime.Util.ocaml_array
}

type problem = {
  room_width: float;
  room_height: float;
  stage_width: float;
  stage_height: float;
  stage_bottom_left: float list;
  musicians: int Atdgen_runtime.Util.ocaml_array;
  attendees: attendee list
}
