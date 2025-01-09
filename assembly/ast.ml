type binop =
  | Equal | Inf | Infeq | Sup | Supeq | Add | Sub | Mult | Div | Mod | Incr
  | And | Or

type ident = string

type typ =
    | Unit
    | Fle of typ list * result
    | ParamL of typ
    | ParamM of typ

and result = {
  effects : ident list;
  res : typ;
}

type param = ident*typ

type exp =
  | Etrue
  | Efalse
  | Eunit
  | Eint of int
  | Estring of string
  | Eident of ident
  | Eapp of exp*(exp list)
  | Elist of exp list
  | Eblock of block
  | Ebinop of binop*exp*exp
  | Eass of ident*exp
  | Eif of exp*exp*exp
  | Elambda of funbody
  | Eret of exp

and stmt =
  | Sex of exp
  | Val of ident*exp
  | Var of ident*exp
and block = stmt list




and funbody = {
  params : param list;
  result : result option;
  body : exp
}

type decl = {
  name : string;
  body : funbody;}

type program = decl list
