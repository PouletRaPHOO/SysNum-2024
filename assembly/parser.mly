
/* Analyseur syntaxique pour mini-Turtle */

%{
  open Ast

%}

/* Déclaration des tokens */
%token <int> CST
%token <string> VAR
%token <string> LABEL
%token <int> REG
%token SEMICOLON
%token ADD SUB MUL AND NOT OR XOR SLL SRL
%token MOV
%token CMP
%token JMP JNE JGE
%token LOAD STORE
%token EOF
%token LINEFEED


/* Priorités et associativités des tokens */


/* Point d'entrée de la grammaire */
%start prog

/* Type des valeurs renvoyées par l'analyseur syntaxique */
%type <Ast.program> prog

%%

/* Règles de grammaire */

prog:main = expr* EOF {main}

expr:
      | d=exp SEMICOLON {Bexpr(d)}
      | LINEFEED {Linefeed}
      | l = LABEL {Label l}

exp:
    | b=binop i1 = REG i2 = REG {Ebinop(b,i1,i2)}
    | u=unop i1= REG {Eunop(u,i1)}
    | MOV i1 = REG i2 = REG {Emov(i1,i2)}
    | MOV i1 = REG i2= CST {Emovi (i1,i2)}
    | MOV i1 = REG i=VAR {Eload{i1,i}}
    | MOV i1 = VAR i2 = REG {Estore(i1,i2)}
    | j=jump i = VAR {Ejump(j,i)}
    | CMP i1 = REG i2 = REG {Ecmp(i1,i2)}

%inline jump =
    | JMP {Jmp}
    | JE {Je}
    | JNE {Jne}
    | JGE {Jge}

%inline binop =
      | ADD {Add}
      | SUB {Sub}
      | MUL {Mul}

%inline unop =
        | SLL {Sll}
        | SRL  {Srl}
        | NOT {Not}
