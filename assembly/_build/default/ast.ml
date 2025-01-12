type ident = string

module Env = struct
  include Map.Make(struct
    type t = ident
    let compare = compare
  end)
end



type binop = Add | Sub | Mul | And | Or | Xor

type unop = Sll | Srl | Not

type jump = Jmp | Jge | Jne | Je

type bexpr =
  | Enoop
  | Ebinop of binop*int*int
  | Eunop of unop*int
  | Emovi of int*int
  | Emov of int*int
  | Ecmp of int*int
  | Ejump of jump*ident
  | Eload of int*ident
  | Estore of ident*int
  | Eloadfin of int*int
  | Estorefin of int*int
  | Estorereg of int*int
  | Eloadreg of int*int



type expr =
  | Label of ident
  | Bexpr of bexpr
  | Linefeed

type program = expr list
