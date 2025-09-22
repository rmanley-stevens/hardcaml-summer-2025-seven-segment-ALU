(*open Core
open Hardcaml
open Hardcaml_waveterm
open Hardcaml_example

let test_counter () =
  let module Sim = Cyclesim.With_interface (Counter.I) (Counter.O) in
  let sim = Sim.create Counter.create in
  let waves, sim = Waveform.create sim in
  let inputs = Cyclesim.inputs sim in
  (*Add*)
  inputs.num1 := Bits.of_string "0000100";
  inputs.num2 := Bits.of_string "0000101";
  inputs.op := Bits.of_string "00";
  Cyclesim.cycle ~n:2 sim;
  (*Sub*)
  inputs.num1 := Bits.of_string "0000100";
  inputs.num2 := Bits.of_string "0000101";
  inputs.op := Bits.of_string "01";
  Cyclesim.cycle ~n:3 sim;
  (*And*)
  inputs.num1 := Bits.of_string "0110011";
  inputs.num2 := Bits.of_string "1100100";
  inputs.op := Bits.of_string "10";
  Cyclesim.cycle ~n:4 sim;
  (*Or*)
  inputs.num1 := Bits.of_string "0110011";
  inputs.num2 := Bits.of_string "1100100";
  inputs.op := Bits.of_string "11";
  Cyclesim.cycle ~n:5 sim;
  Cyclesim.cycle sim;
  waves
;;

let%expect_test "test counter" =
  Waveform.print (test_counter ());
  [%expect
    {|
    ┌Signals────────┐┌Waves──────────────────────────────────────────────┐
    │               ││────────────────────────────────────────┬──────────│
    │num1           ││ 04                                     │33        │
    │               ││────────────────────────────────────────┴──────────│
    │               ││────────────────────────────────────────┬──────────│
    │num2           ││ 05                                     │64        │
    │               ││────────────────────────────────────────┴──────────│
    │               ││────────────────┬───────────────────────┬──────────│
    │op             ││ 0              │1                      │2         │
    │               ││────────────────┴───────────────────────┴──────────│
    │               ││────────────────┬───────────────────────┬──────────│
    │y              ││ 09             │7F                     │20        │
    │               ││────────────────┴───────────────────────┴──────────│
    └───────────────┘└───────────────────────────────────────────────────┘
    |}]
;;
*)