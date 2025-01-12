

(* Analyseur lexical pour Lovni *)

{
    open Lexing
    open Parser

    exception Lexing_error of string


    let kwd_tbl =
    ["ADD", ADD;
     "MOV", MOV;
     "SUB", SUB;
     "MUL", MUL;
     "AND", AND;
     "OR", OR;
     "NOT", NOT;
     "XOR", XOR;
     "SLL", SLL;
     "SRL", SRL;
     "CMP", CMP;
     "JMP", JMP;
     "JNE", JNE;
     "JGE", JGE;
     "NOOP", NOOP;
     "STO", STO;
     "LOAD", LOAD
    ]

    let id_or_kwd =
        let h = Hashtbl.create 9 in
        List.iter (fun (s,t) -> Hashtbl.add h s t) kwd_tbl;
        fun s ->
             try Hashtbl.find h s with _ -> raise (Lexing_error ("Opération non reconnue"))


    (* Code récupéré depuis Stack Overflow https://stackoverflow.com/questions/9863036/ocaml-function-parameter-pattern-matching-for-strings *)

    let string_of_char c = String.make 1 c
    (* Converts a string to a list of chars *)
    let explode str =
        let rec explode_inner cur_index chars =
            if cur_index < String.length str then
                let new_char = str.[cur_index] in
                explode_inner (cur_index + 1) (chars @ [new_char])
            else chars in
        explode_inner 0 []

    (* Converts a list of chars to a string *)
    let rec implode chars =
        match chars with
            [] -> ""
            | h::t ->  string_of_char h ^ (implode t)

    let decode_int r : int= match explode r with
      | '$'::a -> int_of_string (implode a)
      | _ -> failwith "pas normal"

    let decode_reg r : int= match explode r with
      | '%'::'r'::a -> int_of_string (implode a)
      | _ -> failwith "pas normal"

    let rec decode_label = function
        | [] ->  failwith "pas normal"
        | [':'] -> []
        | a::t-> a::(decode_label t)

}


let lower = ['a' - 'z']
let upper = ['A' - 'Z']
let digit =  ['0'-'9']
let register = '%''r' digit+
let entier = '$' '-'? digit+
let instr = upper+
let label = lower+digit*':'
let var = lower+

let space = ' ' | '\t'


rule token = parse
    | "//" [^ '\n']* '\n' {new_line lexbuf;token lexbuf}
    | "(*" {comment lexbuf}
    | '\n' {new_line lexbuf; LINEFEED }
    | space {token lexbuf}
    | ';' {SEMICOLON}
    | label as l {LABEL (implode (decode_label (explode l)))}
    | var as v {VAR v}
    | register as r {REG (decode_reg r)}
    | instr as i  {id_or_kwd i}
    | entier as e {CST (decode_int e)}
    | eof  { EOF }
    | _ { raise (Lexing_error ("opérande non reconnue"))  }



and comment = parse
    | "*)" {token lexbuf}
    | '\n' {new_line lexbuf; comment lexbuf }
    | _ {comment lexbuf}
    | eof {raise (Lexing_error ("Commentaire non terminé"))}

{

}
