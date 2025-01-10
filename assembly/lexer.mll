

(* Analyseur lexical pour Lovni *)

{
    open Lexing
    open Parser

    exception Lexing_error of string


    let kwd_tbl =
    ["ADD", ADD;
     "MOV", MOV;
     "SUB", MINUS;
     "MUL", MUL;
     "AND", AND;
     "OR", OR;
     "NOT", NOT;
     "XOR", SLL;
     "SRL", SRL;
     "CMP", CMP;
     "JMP", JMP;
     "JNE", JNE;
     "JGE", JGE;
     "LOAD", LOAD;
     "STORE",STORE
    ]

    let id_or_kwd =
        let h = Hashtbl.create 9 in
        List.iter (fun (s,t) -> Hashtbl.add h s t) kwd_tbl;
        fun s ->
             try Hashtbl.find h s with _ -> VAR s

    let decode_reg r : int= match r with
      | "$r"^a -> int_of_string a
      | _ -> failwith "pas normal"
    let decode_label r : int= match r with
      | a^":" -> a
      | _ -> failwith "pas normal"

}


let lower = ['a' - 'z']
let upper = ['A' - 'Z']
let digit =  ['0'-'9']
let register = '&''r' digit+
let entier = '$' '-'? digit+
let instr = upper+
let label = lower+':'
let var = lower+

let space = ' ' | '\t'


rule token = parse
    | "//" [^ '\n']* '\n' {new_line lexbuf;token lexbuf}
    | "(*" {comment lexbuf}
    | '\n' {new_line lexbuf; LINEFEED }
    | '\t' {token lexbuf}
    | ';' {SEMICOLON}
    | label as l {LABEL (decode_label l)}
    | var as v {VAR v}
    | register as r {REG (decode_reg r)}
    | upper as i  {id_or_kwd i}
    | eof  { EOF }
    | _ { assert false }



and comment = parse
    | "*)" {token lexbuf}
    | '\n' {new_line lexbuf; comment lexbuf }
    | _ {comment lexbuf}
    | eof {raise (Lexing_error ("Commentaire non terminé"))}

{

}
