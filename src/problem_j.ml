(* Auto-generated from "problem.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type attendee = Problem_t.attendee = {
  x: float;
  y: float;
  tastes: float list
}

type problem = Problem_t.problem = {
  room_width: float;
  room_height: float;
  stage_width: float;
  stage_height: float;
  stage_bottom_left: float list;
  musicians: int list;
  attendees: attendee list
}

let write__float_list = (
  Atdgen_runtime.Oj_run.write_list (
    Yojson.Safe.write_std_float
  )
)
let string_of__float_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__float_list ob x;
  Buffer.contents ob
let read__float_list = (
  Atdgen_runtime.Oj_run.read_list (
    Atdgen_runtime.Oj_run.read_number
  )
)
let _float_list_of_string s =
  read__float_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_attendee : _ -> attendee -> _ = (
  fun ob (x : attendee) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"x\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.x;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"y\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.y;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"tastes\":";
    (
      write__float_list
    )
      ob x.tastes;
    Buffer.add_char ob '}';
)
let string_of_attendee ?(len = 1024) x =
  let ob = Buffer.create len in
  write_attendee ob x;
  Buffer.contents ob
let read_attendee = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_x = ref (None) in
    let field_y = ref (None) in
    let field_tastes = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 1 -> (
                match String.unsafe_get s pos with
                  | 'x' -> (
                      0
                    )
                  | 'y' -> (
                      1
                    )
                  | _ -> (
                      -1
                    )
              )
            | 6 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                  2
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_x := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_number
                ) p lb
              )
            );
          | 1 ->
            field_y := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_number
                ) p lb
              )
            );
          | 2 ->
            field_tastes := (
              Some (
                (
                  read__float_list
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 1 -> (
                  match String.unsafe_get s pos with
                    | 'x' -> (
                        0
                      )
                    | 'y' -> (
                        1
                      )
                    | _ -> (
                        -1
                      )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_x := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_number
                  ) p lb
                )
              );
            | 1 ->
              field_y := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_number
                  ) p lb
                )
              );
            | 2 ->
              field_tastes := (
                Some (
                  (
                    read__float_list
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            x = (match !field_x with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "x");
            y = (match !field_y with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "y");
            tastes = (match !field_tastes with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "tastes");
          }
         : attendee)
      )
)
let attendee_of_string s =
  read_attendee (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__int_list = (
  Atdgen_runtime.Oj_run.write_list (
    Yojson.Safe.write_int
  )
)
let string_of__int_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__int_list ob x;
  Buffer.contents ob
let read__int_list = (
  Atdgen_runtime.Oj_run.read_list (
    Atdgen_runtime.Oj_run.read_int
  )
)
let _int_list_of_string s =
  read__int_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__attendee_list = (
  Atdgen_runtime.Oj_run.write_list (
    write_attendee
  )
)
let string_of__attendee_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__attendee_list ob x;
  Buffer.contents ob
let read__attendee_list = (
  Atdgen_runtime.Oj_run.read_list (
    read_attendee
  )
)
let _attendee_list_of_string s =
  read__attendee_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_problem : _ -> problem -> _ = (
  fun ob (x : problem) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"room_width\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.room_width;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"room_height\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.room_height;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"stage_width\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.stage_width;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"stage_height\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.stage_height;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"stage_bottom_left\":";
    (
      write__float_list
    )
      ob x.stage_bottom_left;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"musicians\":";
    (
      write__int_list
    )
      ob x.musicians;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"attendees\":";
    (
      write__attendee_list
    )
      ob x.attendees;
    Buffer.add_char ob '}';
)
let string_of_problem ?(len = 1024) x =
  let ob = Buffer.create len in
  write_problem ob x;
  Buffer.contents ob
let read_problem = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_room_width = ref (None) in
    let field_room_height = ref (None) in
    let field_stage_width = ref (None) in
    let field_stage_height = ref (None) in
    let field_stage_bottom_left = ref (None) in
    let field_musicians = ref (None) in
    let field_attendees = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 9 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 's' then (
                        6
                      )
                      else (
                        -1
                      )
                    )
                  | 'm' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 's' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 10 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'w' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'h' then (
                  0
                )
                else (
                  -1
                )
              )
            | 11 -> (
                match String.unsafe_get s pos with
                  | 'r' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'h' && String.unsafe_get s (pos+10) = 't' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'w' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'h' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 12 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 't' then (
                  3
                )
                else (
                  -1
                )
              )
            | 17 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = '_' && String.unsafe_get s (pos+13) = 'l' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = 't' then (
                  4
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_room_width := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_number
                ) p lb
              )
            );
          | 1 ->
            field_room_height := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_number
                ) p lb
              )
            );
          | 2 ->
            field_stage_width := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_number
                ) p lb
              )
            );
          | 3 ->
            field_stage_height := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_number
                ) p lb
              )
            );
          | 4 ->
            field_stage_bottom_left := (
              Some (
                (
                  read__float_list
                ) p lb
              )
            );
          | 5 ->
            field_musicians := (
              Some (
                (
                  read__int_list
                ) p lb
              )
            );
          | 6 ->
            field_attendees := (
              Some (
                (
                  read__attendee_list
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 9 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 's' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | 'm' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 's' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 10 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'w' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'h' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  match String.unsafe_get s pos with
                    | 'r' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'h' && String.unsafe_get s (pos+10) = 't' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'w' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'h' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 't' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 17 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = '_' && String.unsafe_get s (pos+13) = 'l' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = 't' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_room_width := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_number
                  ) p lb
                )
              );
            | 1 ->
              field_room_height := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_number
                  ) p lb
                )
              );
            | 2 ->
              field_stage_width := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_number
                  ) p lb
                )
              );
            | 3 ->
              field_stage_height := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_number
                  ) p lb
                )
              );
            | 4 ->
              field_stage_bottom_left := (
                Some (
                  (
                    read__float_list
                  ) p lb
                )
              );
            | 5 ->
              field_musicians := (
                Some (
                  (
                    read__int_list
                  ) p lb
                )
              );
            | 6 ->
              field_attendees := (
                Some (
                  (
                    read__attendee_list
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            room_width = (match !field_room_width with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "room_width");
            room_height = (match !field_room_height with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "room_height");
            stage_width = (match !field_stage_width with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "stage_width");
            stage_height = (match !field_stage_height with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "stage_height");
            stage_bottom_left = (match !field_stage_bottom_left with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "stage_bottom_left");
            musicians = (match !field_musicians with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "musicians");
            attendees = (match !field_attendees with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "attendees");
          }
         : problem)
      )
)
let problem_of_string s =
  read_problem (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
