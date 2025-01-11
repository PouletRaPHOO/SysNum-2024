
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | XOR
    | VAR of (
# 11 "parser.mly"
       (string)
# 16 "parser.ml"
  )
    | SUB
    | SRL
    | SLL
    | SEMICOLON
    | REG of (
# 13 "parser.mly"
       (int)
# 25 "parser.ml"
  )
    | OR
    | NOT
    | MUL
    | MOV
    | LINEFEED
    | LABEL of (
# 12 "parser.mly"
       (string)
# 35 "parser.ml"
  )
    | JNE
    | JMP
    | JGE
    | JE
    | EOF
    | CST of (
# 10 "parser.mly"
       (int)
# 45 "parser.ml"
  )
    | CMP
    | AND
    | ADD
  
end

include MenhirBasics

# 4 "parser.mly"
  
  open Ast


# 60 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_prog) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState48 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 48.
        Stack shape : expr.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.program) [@@unboxed]

let _menhir_action_01 =
  fun i1 i2 ->
    let b = 
# 60 "parser.mly"
            (Add)
# 85 "parser.ml"
     in
    (
# 44 "parser.mly"
                                (Ebinop(b,i1,i2))
# 90 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_02 =
  fun i1 i2 ->
    let b = 
# 61 "parser.mly"
            (Sub)
# 98 "parser.ml"
     in
    (
# 44 "parser.mly"
                                (Ebinop(b,i1,i2))
# 103 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_03 =
  fun i1 i2 ->
    let b = 
# 62 "parser.mly"
            (Mul)
# 111 "parser.ml"
     in
    (
# 44 "parser.mly"
                                (Ebinop(b,i1,i2))
# 116 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_04 =
  fun i1 i2 ->
    let b = 
# 63 "parser.mly"
            (Xor)
# 124 "parser.ml"
     in
    (
# 44 "parser.mly"
                                (Ebinop(b,i1,i2))
# 129 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_05 =
  fun i1 i2 ->
    let b = 
# 64 "parser.mly"
            (And)
# 137 "parser.ml"
     in
    (
# 44 "parser.mly"
                                (Ebinop(b,i1,i2))
# 142 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_06 =
  fun i1 i2 ->
    let b = 
# 65 "parser.mly"
           (Or)
# 150 "parser.ml"
     in
    (
# 44 "parser.mly"
                                (Ebinop(b,i1,i2))
# 155 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_07 =
  fun i1 ->
    let u = 
# 68 "parser.mly"
              (Sll)
# 163 "parser.ml"
     in
    (
# 45 "parser.mly"
                     (Eunop(u,i1))
# 168 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_08 =
  fun i1 ->
    let u = 
# 69 "parser.mly"
               (Srl)
# 176 "parser.ml"
     in
    (
# 45 "parser.mly"
                     (Eunop(u,i1))
# 181 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_09 =
  fun i1 ->
    let u = 
# 70 "parser.mly"
              (Not)
# 189 "parser.ml"
     in
    (
# 45 "parser.mly"
                     (Eunop(u,i1))
# 194 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_10 =
  fun i1 i2 ->
    (
# 46 "parser.mly"
                            (Emov(i1,i2))
# 202 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_11 =
  fun i1 i2 ->
    (
# 47 "parser.mly"
                           (Emovi (i1,i2))
# 210 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_12 =
  fun i i1 ->
    (
# 48 "parser.mly"
                         (Eload(i1,i))
# 218 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_13 =
  fun i1 i2 ->
    (
# 49 "parser.mly"
                            (Estore(i1,i2))
# 226 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_14 =
  fun i ->
    let j = 
# 54 "parser.mly"
          (Jmp)
# 234 "parser.ml"
     in
    (
# 50 "parser.mly"
                     (Ejump(j,i))
# 239 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_15 =
  fun i ->
    let j = 
# 55 "parser.mly"
         (Je)
# 247 "parser.ml"
     in
    (
# 50 "parser.mly"
                     (Ejump(j,i))
# 252 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_16 =
  fun i ->
    let j = 
# 56 "parser.mly"
          (Jne)
# 260 "parser.ml"
     in
    (
# 50 "parser.mly"
                     (Ejump(j,i))
# 265 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_17 =
  fun i ->
    let j = 
# 57 "parser.mly"
          (Jge)
# 273 "parser.ml"
     in
    (
# 50 "parser.mly"
                     (Ejump(j,i))
# 278 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_18 =
  fun i1 i2 ->
    (
# 51 "parser.mly"
                            (Ecmp(i1,i2))
# 286 "parser.ml"
     : (Ast.bexpr))

let _menhir_action_19 =
  fun d ->
    (
# 39 "parser.mly"
                        (Bexpr(d))
# 294 "parser.ml"
     : (Ast.expr))

let _menhir_action_20 =
  fun () ->
    (
# 40 "parser.mly"
                 (Linefeed)
# 302 "parser.ml"
     : (Ast.expr))

let _menhir_action_21 =
  fun l ->
    (
# 41 "parser.mly"
                  (Label l)
# 310 "parser.ml"
     : (Ast.expr))

let _menhir_action_22 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 318 "parser.ml"
     : (Ast.program))

let _menhir_action_23 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 326 "parser.ml"
     : (Ast.program))

let _menhir_action_24 =
  fun main ->
    (
# 36 "parser.mly"
                      (main)
# 334 "parser.ml"
     : (Ast.program))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ADD ->
        "ADD"
    | AND ->
        "AND"
    | CMP ->
        "CMP"
    | CST _ ->
        "CST"
    | EOF ->
        "EOF"
    | JE ->
        "JE"
    | JGE ->
        "JGE"
    | JMP ->
        "JMP"
    | JNE ->
        "JNE"
    | LABEL _ ->
        "LABEL"
    | LINEFEED ->
        "LINEFEED"
    | MOV ->
        "MOV"
    | MUL ->
        "MUL"
    | NOT ->
        "NOT"
    | OR ->
        "OR"
    | REG _ ->
        "REG"
    | SEMICOLON ->
        "SEMICOLON"
    | SLL ->
        "SLL"
    | SRL ->
        "SRL"
    | SUB ->
        "SUB"
    | VAR _ ->
        "VAR"
    | XOR ->
        "XOR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_46 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let main = _v in
      let _v = _menhir_action_24 main in
      MenhirBox_prog _v
  
  let rec _menhir_run_49 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_23 x xs in
      _menhir_goto_list_expr_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_expr_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState48 ->
          _menhir_run_49 _menhir_stack _v
      | MenhirState00 ->
          _menhir_run_46 _menhir_stack _v
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_04 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_exp : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let d = _v in
          let _v = _menhir_action_19 d in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | XOR ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | SRL ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | SLL ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | OR ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | NOT ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | MUL ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | MOV ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | LINEFEED ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | LABEL _v_0 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState48
      | JNE ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | JMP ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | JGE ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | JE ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | CMP ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | AND ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | ADD ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | EOF ->
          let _v_1 = _menhir_action_22 () in
          _menhir_run_49 _menhir_stack _v_1
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_02 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i1 = _v in
          let _v = _menhir_action_08 i1 in
          _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i1 = _v in
          let _v = _menhir_action_07 i1 in
          _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_06 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i1 = _v in
          let _v = _menhir_action_09 i1 in
          _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_16 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_03 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_19 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_13 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VAR _v_1 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i) = (_v, _v_1) in
              let _v = _menhir_action_12 i i1 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | REG _v_2 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_2) in
              let _v = _menhir_action_10 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | CST _v_3 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_3) in
              let _v = _menhir_action_11 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_26 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_20 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_27 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let l = _v in
      let _v = _menhir_action_21 l in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_28 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_16 i in
          _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_30 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_14 i in
          _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_32 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_17 i in
          _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_34 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_15 i in
          _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_36 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_18 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_05 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_42 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | REG _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i1, i2) = (_v, _v_0) in
              let _v = _menhir_action_01 i1 i2 in
              _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | XOR ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | SRL ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | SLL ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | OR ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | NOT ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | MUL ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | MOV ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | LINEFEED ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | LABEL _v ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | JNE ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | JMP ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | JGE ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | JE ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | CMP ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | AND ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | ADD ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | EOF ->
          let _v = _menhir_action_22 () in
          _menhir_run_46 _menhir_stack _v
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
