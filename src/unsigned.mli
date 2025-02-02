(*
 * Copyright (c) 2013 Jeremy Yallop.
 *
 * This file is distributed under the terms of the MIT License.
 * See the file LICENSE for details.
 *)

(** Types and operations for unsigned integers. *)

module type Infix = sig
  type t

  val (+) : t -> t -> t
  (** Addition.  See {!add}. *)

  val (-) : t -> t -> t
  (** Subtraction.  See {!sub}.*)

  val ( * ) : t -> t -> t
  (** Multiplication.  See {!mul}.*)

  val (/) : t -> t -> t
  (** Division.  See {!div}.*)

  val (mod) : t -> t -> t
  (** Integer remainder.  See {!rem}. *)

  val (land) : t -> t -> t
  (** Bitwise logical and.  See {!logand}. *)

  val (lor) : t -> t -> t
  (** Bitwise logical or.  See {!logor}. *)

  val (lxor) : t -> t -> t
  (** Bitwise logical exclusive or.  See {!logxor}. *)

  val (lsl) : t -> int -> t
  (** [x lsl y] shifts [x] to the left by [y] bits.  See {!shift_left}. *)

  val (lsr) : t -> int -> t
  (** [x lsr y] shifts [x] to the right by [y] bits.  See {!shift_right}. *)
end
(** Infix names for the unsigned integer operations. *)


module type S = sig
  type t

  val add : t -> t -> t
  (** Addition. *)

  val sub : t -> t -> t
  (** Subtraction. *)

  val mul : t -> t -> t
  (** Multiplication. *)

  val div : t -> t -> t
  (** Division.  Raise {!Division_by_zero} if the second argument is zero. *)

  val rem : t -> t -> t
  (** Integer remainder.  Raise {!Division_by_zero} if the second argument is
      zero. *)

  val max_int : t
  (** The greatest representable integer. *)

  val logand : t -> t -> t
  (** Bitwise logical and. *)

  val logor : t -> t -> t
  (** Bitwise logical or. *)

  val logxor : t -> t -> t
  (** Bitwise logical exclusive or. *)

  val shift_left : t -> int -> t
  (** {!shift_left} [x] [y] shifts [x] to the left by [y] bits. *)

  val shift_right : t -> int -> t
  (** {!shift_right} [x] [y] shifts [x] to the right by [y] bits. *)

  val of_int : int -> t
  (** Convert the given int value to an unsigned integer. *)

  val to_int : t -> int
  (** Convert the given unsigned integer value to an int. *)

  val of_int64 : int64 -> t
  (** Convert the given int64 value to an unsigned integer. *)

  val to_int64 : t -> int64
  (** Convert the given unsigned integer value to an int64. *)

  val of_string : string -> t
  (** Convert the given string to an unsigned integer.  Raise {!Failure}
      ["int_of_string"] if the given string is not a valid representation of
      an unsigned integer. *)

  val to_string : t -> string
  (** Return the string representation of its argument. *)

  val zero : t
  (** The integer 0. *)

  val one : t
  (** The integer 1. *)

  val lognot : t -> t
  (** Bitwise logical negation. *)

  val succ : t -> t
  (** Successor. *)

  val pred : t -> t
  (** Predecessor. *)

  val compare : t -> t -> int
  (** The comparison function for unsigned integers, with the same
      specification as {!Pervasives.compare}. *)

  val equal : t -> t -> bool
  (** Tests for equality, with the same specification as {!Pervasives.(=)}. *)

  val max : t -> t -> t
  (** [max x y] is the greater of [x] and [y] *)

  val min : t -> t -> t
  (** [min x y] is the lesser of [x] and [y] *)

  val pp : Format.formatter -> t -> unit
  (** Output the result of {!to_string} on a formatter. *)

  module Infix : Infix with type t := t
end
(** Unsigned integer operations. *)

implicit module UChar : S with type t = private int
(** Unsigned char type and operations. *)

implicit module UInt8 : S with type t = private int
(** Unsigned 8-bit integer type and operations. *)

implicit module UInt16 : S with type t = private int
(** Unsigned 16-bit integer type and operations. *)

implicit module UInt32 : sig
  include S
  val of_int32 : int32 -> t
  val to_int32 : t -> int32
end
(** Unsigned 32-bit integer type and operations. *)

implicit module UInt64 : sig
  include S
  val of_int64 : int64 -> t
  val to_int64 : t -> int64

  val of_uint32 : UInt32.t -> t
  (** Convert the given 32-bit unsigned integer to a 64-bit unsigned
      integer. *)

  val to_uint32 : t -> UInt32.t
  (** Convert the given 64-bit unsigned integer to a 32-bit unsigned integer.
      The 64-bit unsigned integer is taken modulo 2{^32}, i.e. the top 32 bits
      are lost during the conversion.  *)
end
(** Unsigned 64-bit integer type and operations. *)

implicit module Size_t : S
(** The size_t unsigned integer type and operations. *)

implicit module UShort : S
(** The unsigned short integer type and operations. *)

implicit module UInt : S
(** The unsigned int type and operations. *)

implicit module ULong : S
(** The unsigned long integer type and operations. *)

implicit module ULLong : S
(** The unsigned long long integer type and operations. *)


type uchar = UChar.t
(** The unsigned char type. *)

type uint8 = UInt8.t
(** Unsigned 8-bit integer type. *)

type uint16 = UInt16.t
(** Unsigned 16-bit integer type. *)

type uint32 = UInt32.t
(** Unsigned 32-bit integer type. *)

type uint64 = UInt64.t
(** Unsigned 64-bit integer type. *)

type size_t = Size_t.t
(** The size_t unsigned integer type. *)

type ushort = UShort.t
(** The unsigned short unsigned integer type. *)

type uint = UInt.t
(** The unsigned int type. *)

type ulong = ULong.t
(** The unsigned long integer type. *)

type ullong = ULLong.t
(** The unsigned long long integer type. *)

val of_byte_size : int -> (module S)
(** [of_byte_size b] is a module of type S that implements an unsigned type
    with [b] bytes.

    Raise [Invalid_argument] if no suitable type is available. *)

implicit module ImpNum(S : S) : Imp.Num.Num
