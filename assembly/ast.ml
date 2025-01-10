type ident = string

type binop = Add | Sub | Mul

type unop = Sll | Srl | Not

type jump = Jmp | Jge | Jne | Je

type Bexpr =
  | Noop
  | Ebinop of binop*int*int
  | Eunop of unop*int
  | Emovi of int*int
  | Emov of int*int
  | Ecmp of int*int
  | Ejump of jump*ident
  | Eload of int*ident
  | Estore of ident*int



type expr =
  | Label of ident
  | Bexpr of bexpr
  | Linefeed

type program = expr list
