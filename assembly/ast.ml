type ident = string


type expr =
  | Ebinop of binop*int*int
  | Emovi of int*int
  | Emov of int*int
  |
  |
  |


type expr =
  | Label of label
  | Bexpr of bexpr
type program = expr list
