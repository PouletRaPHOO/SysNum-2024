
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


/* Priorités et associativités des tokens */


/* Point d'entrée de la grammaire */
%start prog

/* Type des valeurs renvoyées par l'analyseur syntaxique */
%type <Ast.program> prog

%%

/* Règles de grammaire */

prog:main = decla* EOF {main}

decla: d=expr SEMICOLON {{name = "aaa"; body = {params = []; result = None; body =d}}}

expr:
    | i = IDENT {Eident i }
    | e1 = expr PLUS e2=expr {Ebinop (Add, e1, e2)}
    | i = CST {Eint i}
