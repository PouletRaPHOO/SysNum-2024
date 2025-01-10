
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | XOR
    | VAR
    | SLICE
    | SELECT
    | ROM
    | REG
    | RAM
    | OUTPUT
    | OR
    | NOT
    | NAND
    | NAME of (
# 27 "netlist_parser.mly"
       (string)
# 26 "netlist_parser.ml"
  )
    | MUX
    | INPUT
    | IN
    | EQUAL
    | EOF
    | CONST of (
# 26 "netlist_parser.mly"
       (string)
# 36 "netlist_parser.ml"
  )
    | CONCAT
    | COMMA
    | COLON
    | AND
  
end

include MenhirBasics

# 1 "netlist_parser.mly"
  
 open Netlist_ast

 let bool_of_string s = match s with
  | "t" | "1" -> true
  | "f" | "0" -> false
  | _ -> raise Parsing.Parse_error

 let bool_array_of_string s =
   let a = Array.make (String.length s) false in
   for i = 0 to String.length s - 1 do
     a.(i) <- bool_of_string (String.sub s i 1)
   done;
   a

 let value_of_const s =
   let n = String.length s in
   if n = 0 then
     raise Parsing.Parse_error
   else if n = 1 then
     VBit (bool_of_string s)
   else
     VBitArray (bool_array_of_string s)

# 72 "netlist_parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState01 : ('s, _menhir_box_program) _menhir_state
    (** State 01.
        Stack shape : .
        Start symbol: program. *)

  | MenhirState03 : (('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_state
    (** State 03.
        Stack shape : NAME.
        Start symbol: program. *)

  | MenhirState07 : (('s, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_state
    (** State 07.
        Stack shape : loption(separated_nonempty_list(COMMA,NAME)).
        Start symbol: program. *)

  | MenhirState09 : ((('s, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_state
    (** State 09.
        Stack shape : loption(separated_nonempty_list(COMMA,NAME)) loption(separated_nonempty_list(COMMA,NAME)).
        Start symbol: program. *)

  | MenhirState11 : (('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_state
    (** State 11.
        Stack shape : NAME.
        Start symbol: program. *)

  | MenhirState16 : (('s, _menhir_box_program) _menhir_cell1_var, _menhir_box_program) _menhir_state
    (** State 16.
        Stack shape : var.
        Start symbol: program. *)

  | MenhirState20 : (((('s, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_var__, _menhir_box_program) _menhir_state
    (** State 20.
        Stack shape : loption(separated_nonempty_list(COMMA,NAME)) loption(separated_nonempty_list(COMMA,NAME)) loption(separated_nonempty_list(COMMA,var)).
        Start symbol: program. *)

  | MenhirState22 : (('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_state
    (** State 22.
        Stack shape : NAME.
        Start symbol: program. *)

  | MenhirState23 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR, _menhir_box_program) _menhir_state
    (** State 23.
        Stack shape : NAME XOR.
        Start symbol: program. *)

  | MenhirState26 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 26.
        Stack shape : NAME XOR arg.
        Start symbol: program. *)

  | MenhirState28 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_state
    (** State 28.
        Stack shape : NAME SLICE.
        Start symbol: program. *)

  | MenhirState29 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 29.
        Stack shape : NAME SLICE int.
        Start symbol: program. *)

  | MenhirState30 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 30.
        Stack shape : NAME SLICE int int.
        Start symbol: program. *)

  | MenhirState32 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SELECT, _menhir_box_program) _menhir_state
    (** State 32.
        Stack shape : NAME SELECT.
        Start symbol: program. *)

  | MenhirState33 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SELECT, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 33.
        Stack shape : NAME SELECT int.
        Start symbol: program. *)

  | MenhirState35 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_state
    (** State 35.
        Stack shape : NAME ROM.
        Start symbol: program. *)

  | MenhirState36 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 36.
        Stack shape : NAME ROM int.
        Start symbol: program. *)

  | MenhirState37 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 37.
        Stack shape : NAME ROM int int.
        Start symbol: program. *)

  | MenhirState41 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_state
    (** State 41.
        Stack shape : NAME RAM.
        Start symbol: program. *)

  | MenhirState42 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 42.
        Stack shape : NAME RAM int.
        Start symbol: program. *)

  | MenhirState43 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 43.
        Stack shape : NAME RAM int int.
        Start symbol: program. *)

  | MenhirState44 : (((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 44.
        Stack shape : NAME RAM int int arg.
        Start symbol: program. *)

  | MenhirState45 : ((((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 45.
        Stack shape : NAME RAM int int arg arg.
        Start symbol: program. *)

  | MenhirState46 : (((((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 46.
        Stack shape : NAME RAM int int arg arg arg.
        Start symbol: program. *)

  | MenhirState48 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR, _menhir_box_program) _menhir_state
    (** State 48.
        Stack shape : NAME OR.
        Start symbol: program. *)

  | MenhirState49 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 49.
        Stack shape : NAME OR arg.
        Start symbol: program. *)

  | MenhirState51 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NOT, _menhir_box_program) _menhir_state
    (** State 51.
        Stack shape : NAME NOT.
        Start symbol: program. *)

  | MenhirState53 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND, _menhir_box_program) _menhir_state
    (** State 53.
        Stack shape : NAME NAND.
        Start symbol: program. *)

  | MenhirState54 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 54.
        Stack shape : NAME NAND arg.
        Start symbol: program. *)

  | MenhirState56 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_state
    (** State 56.
        Stack shape : NAME MUX.
        Start symbol: program. *)

  | MenhirState57 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 57.
        Stack shape : NAME MUX arg.
        Start symbol: program. *)

  | MenhirState58 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 58.
        Stack shape : NAME MUX arg arg.
        Start symbol: program. *)

  | MenhirState60 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT, _menhir_box_program) _menhir_state
    (** State 60.
        Stack shape : NAME CONCAT.
        Start symbol: program. *)

  | MenhirState61 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 61.
        Stack shape : NAME CONCAT arg.
        Start symbol: program. *)

  | MenhirState63 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND, _menhir_box_program) _menhir_state
    (** State 63.
        Stack shape : NAME AND.
        Start symbol: program. *)

  | MenhirState64 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 64.
        Stack shape : NAME AND arg.
        Start symbol: program. *)

  | MenhirState70 : (('s, _menhir_box_program) _menhir_cell1_equ, _menhir_box_program) _menhir_state
    (** State 70.
        Stack shape : equ.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_arg = 
  | MenhirCell1_arg of 's * ('s, 'r) _menhir_state * (Netlist_ast.arg)

and ('s, 'r) _menhir_cell1_equ = 
  | MenhirCell1_equ of 's * ('s, 'r) _menhir_state * (Netlist_ast.equation)

and ('s, 'r) _menhir_cell1_int = 
  | MenhirCell1_int of 's * ('s, 'r) _menhir_state * (int)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ of 's * ('s, 'r) _menhir_state * (Netlist_ast.ident list)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_var__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_var__ of 's * ('s, 'r) _menhir_state * ((Netlist_ast.Env.key * Netlist_ast.ty) list)

and ('s, 'r) _menhir_cell1_var = 
  | MenhirCell1_var of 's * ('s, 'r) _menhir_state * (Netlist_ast.Env.key * Netlist_ast.ty)

and ('s, 'r) _menhir_cell1_AND = 
  | MenhirCell1_AND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CONCAT = 
  | MenhirCell1_CONCAT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MUX = 
  | MenhirCell1_MUX of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NAME = 
  | MenhirCell1_NAME of 's * ('s, 'r) _menhir_state * (
# 27 "netlist_parser.mly"
       (string)
# 292 "netlist_parser.ml"
)

and ('s, 'r) _menhir_cell1_NAND = 
  | MenhirCell1_NAND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NOT = 
  | MenhirCell1_NOT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OR = 
  | MenhirCell1_OR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RAM = 
  | MenhirCell1_RAM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ROM = 
  | MenhirCell1_ROM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SELECT = 
  | MenhirCell1_SELECT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SLICE = 
  | MenhirCell1_SLICE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_XOR = 
  | MenhirCell1_XOR of 's * ('s, 'r) _menhir_state

and _menhir_box_program = 
  | MenhirBox_program of (Netlist_ast.program) [@@unboxed]

let _menhir_action_01 =
  fun n ->
    (
# 67 "netlist_parser.mly"
            ( Aconst (value_of_const n) )
# 327 "netlist_parser.ml"
     : (Netlist_ast.arg))

let _menhir_action_02 =
  fun id ->
    (
# 68 "netlist_parser.mly"
            ( Avar id )
# 335 "netlist_parser.ml"
     : (Netlist_ast.arg))

let _menhir_action_03 =
  fun e x ->
    (
# 44 "netlist_parser.mly"
                     ( (x, e) )
# 343 "netlist_parser.ml"
     : (Netlist_ast.equation))

let _menhir_action_04 =
  fun a ->
    (
# 47 "netlist_parser.mly"
          ( Earg a )
# 351 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_05 =
  fun x ->
    (
# 48 "netlist_parser.mly"
              ( Enot x )
# 359 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_06 =
  fun x ->
    (
# 49 "netlist_parser.mly"
               ( Ereg x )
# 367 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_07 =
  fun x y ->
    (
# 50 "netlist_parser.mly"
                    ( Ebinop(And, x, y) )
# 375 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_08 =
  fun x y ->
    (
# 51 "netlist_parser.mly"
                   ( Ebinop(Or, x, y) )
# 383 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_09 =
  fun x y ->
    (
# 52 "netlist_parser.mly"
                     ( Ebinop(Nand, x, y) )
# 391 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_10 =
  fun x y ->
    (
# 53 "netlist_parser.mly"
                    ( Ebinop(Xor, x, y) )
# 399 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_11 =
  fun x y z ->
    (
# 54 "netlist_parser.mly"
                          ( Emux(x, y, z) )
# 407 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_12 =
  fun addr ra word ->
    (
# 56 "netlist_parser.mly"
    ( Erom(addr, word, ra) )
# 415 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_13 =
  fun addr data ra wa we word ->
    (
# 58 "netlist_parser.mly"
    ( Eram(addr, word, ra, we, wa, data) )
# 423 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_14 =
  fun x y ->
    (
# 60 "netlist_parser.mly"
     ( Econcat(x, y) )
# 431 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_15 =
  fun idx x ->
    (
# 62 "netlist_parser.mly"
     ( Eselect (idx, x) )
# 439 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_16 =
  fun max min x ->
    (
# 64 "netlist_parser.mly"
     ( Eslice (min, max, x) )
# 447 "netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_17 =
  fun c ->
    (
# 76 "netlist_parser.mly"
            ( int_of_string c )
# 455 "netlist_parser.ml"
     : (int))

let _menhir_action_18 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 463 "netlist_parser.ml"
     : (Netlist_ast.equation list))

let _menhir_action_19 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 471 "netlist_parser.ml"
     : (Netlist_ast.equation list))

let _menhir_action_20 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 479 "netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_21 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 487 "netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_22 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 495 "netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_23 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 503 "netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_24 =
  fun eqs xs xs_inlined1 xs_inlined2 ->
    let vars =
      let xs = xs_inlined2 in
      
# 241 "<standard.mly>"
    ( xs )
# 513 "netlist_parser.ml"
      
    in
    let out =
      let xs = xs_inlined1 in
      
# 241 "<standard.mly>"
    ( xs )
# 521 "netlist_parser.ml"
      
    in
    let inp = 
# 241 "<standard.mly>"
    ( xs )
# 527 "netlist_parser.ml"
     in
    (
# 41 "netlist_parser.mly"
    ( { p_eqs = eqs; p_vars = Env.of_list vars; p_inputs = inp; p_outputs = out; } )
# 532 "netlist_parser.ml"
     : (Netlist_ast.program))

let _menhir_action_25 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 540 "netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_26 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 548 "netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_27 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 556 "netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_28 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 564 "netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_29 =
  fun () ->
    (
# 72 "netlist_parser.mly"
              ( TBit )
# 572 "netlist_parser.ml"
     : (Netlist_ast.ty))

let _menhir_action_30 =
  fun n ->
    (
# 73 "netlist_parser.mly"
                ( TBitArray n )
# 580 "netlist_parser.ml"
     : (Netlist_ast.ty))

let _menhir_action_31 =
  fun ty x ->
    (
# 70 "netlist_parser.mly"
                      ( (x, ty) )
# 588 "netlist_parser.ml"
     : (Netlist_ast.Env.key * Netlist_ast.ty))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AND ->
        "AND"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | CONCAT ->
        "CONCAT"
    | CONST _ ->
        "CONST"
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | IN ->
        "IN"
    | INPUT ->
        "INPUT"
    | MUX ->
        "MUX"
    | NAME _ ->
        "NAME"
    | NAND ->
        "NAND"
    | NOT ->
        "NOT"
    | OR ->
        "OR"
    | OUTPUT ->
        "OUTPUT"
    | RAM ->
        "RAM"
    | REG ->
        "REG"
    | ROM ->
        "ROM"
    | SELECT ->
        "SELECT"
    | SLICE ->
        "SLICE"
    | VAR ->
        "VAR"
    | XOR ->
        "XOR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_68 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_var__ -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_loption_separated_nonempty_list_COMMA_var__ (_menhir_stack, _, xs_inlined2) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _, xs_inlined1) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _, xs) = _menhir_stack in
      let eqs = _v in
      let _v = _menhir_action_24 eqs xs xs_inlined1 xs_inlined2 in
      MenhirBox_program _v
  
  let rec _menhir_run_71 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_equ -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_equ (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_19 x xs in
      _menhir_goto_list_equ_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_equ_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState70 ->
          _menhir_run_71 _menhir_stack _v
      | MenhirState20 ->
          _menhir_run_68 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_NAME (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState11 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CONST _v ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | COMMA | IN ->
          let _v = _menhir_action_29 () in
          _menhir_goto_ty_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_17 c in
      _menhir_goto_int _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_int : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState42 ->
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState41 ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState36 ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState35 ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState32 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState29 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState28 ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState11 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_43 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_int (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState43
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState43
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let id = _v in
      let _v = _menhir_action_02 id in
      _menhir_goto_arg _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_arg : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState22 ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState64 ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState63 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState61 ->
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState60 ->
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState58 ->
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState57 ->
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState56 ->
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState54 ->
          _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState53 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState51 ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState49 ->
          _menhir_run_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState48 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState46 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState45 ->
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState44 ->
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState43 ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState37 ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState33 ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState30 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState26 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState23 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_67 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a = _v in
      let _v = _menhir_action_04 a in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_exp : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NAME (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_03 e x in
      let _menhir_stack = MenhirCell1_equ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState70
      | EOF ->
          let _v_1 = _menhir_action_18 () in
          _menhir_run_71 _menhir_stack _v_1
      | _ ->
          _eRR ()
  
  and _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_NAME (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | XOR ->
              let _menhir_stack = MenhirCell1_XOR (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState23 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v ->
                  _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | SLICE ->
              let _menhir_stack = MenhirCell1_SLICE (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState28 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | SELECT ->
              let _menhir_stack = MenhirCell1_SELECT (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState32 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | ROM ->
              let _menhir_stack = MenhirCell1_ROM (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState35 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | REG ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_5 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let x = _v_5 in
                  let _v = _menhir_action_06 x in
                  _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | RAM ->
              let _menhir_stack = MenhirCell1_RAM (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState41 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | OR ->
              let _menhir_stack = MenhirCell1_OR (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState48 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v ->
                  _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | NOT ->
              let _menhir_stack = MenhirCell1_NOT (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState51 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v ->
                  _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | NAND ->
              let _menhir_stack = MenhirCell1_NAND (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState53 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v ->
                  _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | NAME _v_14 ->
              _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_14 MenhirState22
          | MUX ->
              let _menhir_stack = MenhirCell1_MUX (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState56 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v ->
                  _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | CONST _v_17 ->
              _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_17 MenhirState22
          | CONCAT ->
              let _menhir_stack = MenhirCell1_CONCAT (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState60 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v ->
                  _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | AND ->
              let _menhir_stack = MenhirCell1_AND (_menhir_stack, MenhirState22) in
              let _menhir_s = MenhirState63 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v ->
                  _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let n = _v in
      let _v = _menhir_action_01 n in
      _menhir_goto_arg _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_65 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_AND (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_07 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_64 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState64
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState64
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_CONCAT (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_14 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_61 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState61
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState61
      | _ ->
          _eRR ()
  
  and _menhir_run_59 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, y) = _menhir_stack in
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_MUX (_menhir_stack, _) = _menhir_stack in
      let z = _v in
      let _v = _menhir_action_11 x y z in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_58 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState58
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState58
      | _ ->
          _eRR ()
  
  and _menhir_run_57 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState57
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState57
      | _ ->
          _eRR ()
  
  and _menhir_run_55 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_NAND (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_09 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_54 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState54
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState54
      | _ ->
          _eRR ()
  
  and _menhir_run_52 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NOT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NOT (_menhir_stack, _) = _menhir_stack in
      let x = _v in
      let _v = _menhir_action_05 x in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_50 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_OR (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_08 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_49 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState49
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState49
      | _ ->
          _eRR ()
  
  and _menhir_run_47 : type  ttv_stack. (((((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, wa) = _menhir_stack in
      let MenhirCell1_arg (_menhir_stack, _, we) = _menhir_stack in
      let MenhirCell1_arg (_menhir_stack, _, ra) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, word) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, addr) = _menhir_stack in
      let MenhirCell1_RAM (_menhir_stack, _) = _menhir_stack in
      let data = _v in
      let _v = _menhir_action_13 addr data ra wa we word in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_46 : type  ttv_stack. (((((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState46
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState46
      | _ ->
          _eRR ()
  
  and _menhir_run_45 : type  ttv_stack. ((((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState45
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState45
      | _ ->
          _eRR ()
  
  and _menhir_run_44 : type  ttv_stack. (((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState44
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState44
      | _ ->
          _eRR ()
  
  and _menhir_run_38 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_int (_menhir_stack, _, word) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, addr) = _menhir_stack in
      let MenhirCell1_ROM (_menhir_stack, _) = _menhir_stack in
      let ra = _v in
      let _v = _menhir_action_12 addr ra word in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_34 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SELECT, _menhir_box_program) _menhir_cell1_int -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_int (_menhir_stack, _, idx) = _menhir_stack in
      let MenhirCell1_SELECT (_menhir_stack, _) = _menhir_stack in
      let x = _v in
      let _v = _menhir_action_15 idx x in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_31 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_int (_menhir_stack, _, max) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, min) = _menhir_stack in
      let MenhirCell1_SLICE (_menhir_stack, _) = _menhir_stack in
      let x = _v in
      let _v = _menhir_action_16 max min x in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_27 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_XOR (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_10 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_26 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState26
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState26
      | _ ->
          _eRR ()
  
  and _menhir_run_42 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_int (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState42
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_cell1_int as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_int (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState37
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState37
      | _ ->
          _eRR ()
  
  and _menhir_run_36 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_int (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState36
      | _ ->
          _eRR ()
  
  and _menhir_run_33 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SELECT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_int (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState33
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState33
      | _ ->
          _eRR ()
  
  and _menhir_run_30 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_cell1_int as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_int (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState30
      | CONST _v_1 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState30
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_int (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState29
      | _ ->
          _eRR ()
  
  and _menhir_run_13 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let n = _v in
      let _v = _menhir_action_30 n in
      _menhir_goto_ty_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_ty_exp : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NAME (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let ty = _v in
      let _v = _menhir_action_31 ty x in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_var (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState16 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | IN ->
          let x = _v in
          let _v = _menhir_action_27 x in
          _menhir_goto_separated_nonempty_list_COMMA_var_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_var_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState09 ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState16 ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_18 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_23 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_var__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_var__ : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_var__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState20
      | EOF ->
          let _v_1 = _menhir_action_18 () in
          _menhir_run_68 _menhir_stack _v_1
      | _ ->
          _eRR ()
  
  and _menhir_run_17 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_var -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_var (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_28 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_var_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  let _menhir_run_08 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          let _menhir_s = MenhirState09 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IN ->
              let _v = _menhir_action_22 () in
              _menhir_goto_loption_separated_nonempty_list_COMMA_var__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let rec _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_NAME (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState03 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | OUTPUT | VAR ->
          let x = _v in
          let _v = _menhir_action_25 x in
          _menhir_goto_separated_nonempty_list_COMMA_NAME_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_NAME_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState07 ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState01 ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState03 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let x = _v in
      let _v = _menhir_action_21 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_NAME__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_NAME__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState07 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState01 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | OUTPUT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v_0 ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState07
          | VAR ->
              let _v_1 = _menhir_action_20 () in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState07 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NAME (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_26 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_NAME_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INPUT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState01
          | OUTPUT ->
              let _v = _menhir_action_20 () in
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState01 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
