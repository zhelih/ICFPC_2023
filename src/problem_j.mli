(* Auto-generated from "problem.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type placement = Problem_t.placement = { x: float; y: float }

type solution = Problem_t.solution = { placements: placement list }

type attendee = Problem_t.attendee = {
  x: float;
  y: float;
  tastes: float Atdgen_runtime.Util.ocaml_array
}

type problem = Problem_t.problem = {
  room_width: float;
  room_height: float;
  stage_width: float;
  stage_height: float;
  stage_bottom_left: float list;
  musicians: int Atdgen_runtime.Util.ocaml_array;
  attendees: attendee list
}

val write_placement :
  Buffer.t -> placement -> unit
  (** Output a JSON value of type {!type:placement}. *)

val string_of_placement :
  ?len:int -> placement -> string
  (** Serialize a value of type {!type:placement}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_placement :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> placement
  (** Input JSON data of type {!type:placement}. *)

val placement_of_string :
  string -> placement
  (** Deserialize JSON data of type {!type:placement}. *)

val write_solution :
  Buffer.t -> solution -> unit
  (** Output a JSON value of type {!type:solution}. *)

val string_of_solution :
  ?len:int -> solution -> string
  (** Serialize a value of type {!type:solution}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_solution :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> solution
  (** Input JSON data of type {!type:solution}. *)

val solution_of_string :
  string -> solution
  (** Deserialize JSON data of type {!type:solution}. *)

val write_attendee :
  Buffer.t -> attendee -> unit
  (** Output a JSON value of type {!type:attendee}. *)

val string_of_attendee :
  ?len:int -> attendee -> string
  (** Serialize a value of type {!type:attendee}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_attendee :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> attendee
  (** Input JSON data of type {!type:attendee}. *)

val attendee_of_string :
  string -> attendee
  (** Deserialize JSON data of type {!type:attendee}. *)

val write_problem :
  Buffer.t -> problem -> unit
  (** Output a JSON value of type {!type:problem}. *)

val string_of_problem :
  ?len:int -> problem -> string
  (** Serialize a value of type {!type:problem}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_problem :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> problem
  (** Input JSON data of type {!type:problem}. *)

val problem_of_string :
  string -> problem
  (** Deserialize JSON data of type {!type:problem}. *)

