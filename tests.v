Require Import Arith List String.

From CertiCoq.Plugin Require Import CertiCoq.

Import ListNotations.

(* Test *)

Definition l := [1;2;3;4;2].

Definition list_sum l := fold_left plus l 0.

Definition test := list_sum l.

(* Definition test := (4 - 1) + 1. *)

(* Definition test := (4 - 1). *)
 
CertiCoq Compile test.
