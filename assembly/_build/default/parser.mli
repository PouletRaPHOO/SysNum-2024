
(* The type of tokens. *)

type token = 
  | XOR
  | VAR of (string)
  | SUB
  | SRL
  | SLL
  | SEMICOLON
  | REG of (int)
  | OR
  | NOT
  | MUL
  | MOV
  | LINEFEED
  | LABEL of (string)
  | JNE
  | JMP
  | JGE
  | JE
  | EOF
  | CST of (int)
  | CMP
  | AND
  | ADD

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
