(* Auto-generated from "problem.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type attendee = { x: float; y: float; tastes: float list }

type problem = {
  room_width: float;
  room_height: float;
  stage_width: float;
  stage_height: float;
  stage_bottom_left: float list;
  musicians: int list;
  attendees: attendee list
}
