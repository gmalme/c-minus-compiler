%{
#include "parser.tab.h"
%}

%%

"int"           { return INTEIRO; }
"float"         { return FLUTUANTE; }
"void"          { return VOID; }
"="             { return IGUAL; }
"!="            { return DIF; }
"<"             { return MENOR; }
">"             { return MAIOR; }
":="            { return ATRIB; }
"inicio"        { return INICIO; }
"fim"           { return FIM; }


"+"             { return MAIS; }
"-"             { return MENOS; }
"*"             { return MULTIPLICA; }
"/"             { return DIVIDE; }
";"             { return PONTOEVIRGULA; }
","             { return VIRGULA; }
"("             { return ABREPAREN; }
")"             { return FECHAPAREN; }
"["             { return ABRECOLCHETE; }
"]"             { return FECHACOLCHETE; }
"{"             { return ABRECHAVES; }
"}"             { return FECHACHAVES; }

[0-9]+          { yylval.inteiro = atoi(yytext); return NUM; } // Correção no retorno do número

[ \t\n]+        ; // Ignora espaços, tabulações e quebras de linha
.               { printf("Caractere desconhecido: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
