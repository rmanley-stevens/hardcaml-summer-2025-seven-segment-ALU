open Core
open! Hardcaml
open! Hardcaml_example

(*let generate rtl =
  Command.basic
    ~summary:
      ("Generate "
       ^
       match rtl with
       | Rtl.Language.Verilog -> "Verilog"
       | Vhdl -> "VHDL")
    [%map_open.Command
      let () = return () in
      fun () ->
        let module Circuit = Circuit.With_interface (Counter.I) (Counter.O) in
        let circuit = Circuit.create_exn ~name:"counter" Counter.create in
        Rtl.print rtl circuit]
;;

let simulate =
  Command.basic
    ~summary:"Run simulation"
    [%map_open.Command
      let () = return () in
      fun () ->
        Hardcaml_waveterm_interactive.run
          (Hardcaml_example_test.Test_counter.test_counter ())]
;;
*)

let nexys17_100t =
  Command.basic
    ~summary:"Generate top level code for Nexys A7 board"
    [%map_open.Command
      let () = return () in
      fun () -> Hardcaml_hobby_boards.Nexys_a7_100t.generate_top (Counter.board ())]
;;

let () =
  Command_unix.run
    (Command.group
       ~summary:"simulate or generate rtl for counter design."
       [
       "nexys-a7", nexys17_100t
       ])
;;
