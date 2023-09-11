let () = print_endline "Implicit module resolution test"

let () =
  let square {S : Unsigned.S} x = S.Infix.(x * x) in
  let open Unsigned in
  assert (square (UInt8.of_int 5) = (UInt8.of_int 25));
  assert (square (UInt16.of_int 5) = (UInt16.of_int 25));
  assert (square (UInt32.of_int 5) = (UInt32.of_int 25));
  assert (square (UInt64.of_int 5) = (UInt64.of_int 25));
  assert (square (UChar.of_int 5) = (UChar.of_int 25));
  assert (square (UShort.of_int 5) = (UShort.of_int 25));
  assert (square (UInt.of_int 5) = (UInt.of_int 25));
  assert (square (ULong.of_int 5) = (ULong.of_int 25));
  assert (square (ULLong.of_int 5) = (ULLong.of_int 25));
  assert (square (Size_t.of_int 5) = (Size_t.of_int 25))

let () =
  let square {S : Signed.S} x = S.Infix.(x * x) in
  let open Signed in
  assert (square (Int32.of_int 5) = (Int32.of_int 25));
  assert (square (Int64.of_int 5) = (Int64.of_int 25));
  assert (square (SInt.of_int 5) = (SInt.of_int 25));
  assert (square (Long.of_int 5) = (Long.of_int 25));
  assert (square (LLong.of_int 5) = (LLong.of_int 25))

let () =
  (* ensure signed types resolve as instances of unsigned's signature *)
  let square {S : Unsigned.S} x = S.Infix.(x * x) in
  let open Signed in
  assert (square (Int32.of_int 5) = (Int32.of_int 25));
  assert (square (Int64.of_int 5) = (Int64.of_int 25));
  assert (square (SInt.of_int 5) = (SInt.of_int 25));
  assert (square (Long.of_int 5) = (Long.of_int 25));
  assert (square (LLong.of_int 5) = (LLong.of_int 25))
