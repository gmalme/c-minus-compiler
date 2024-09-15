%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stddef.h>

// Estrutura da Tabela de Símbolos
typedef struct simbolo {
    char *nome;
    char *tipo;
    int usado;
    int linha;
    struct simbolo *proximo;
} Simbolo;

Simbolo *tabela = NULL;

// Funções para manipulação da Tabela de Símbolos
void insere(char *nome, char *tipo, int linha);
Simbolo* busca(char *nome);
void verificaUso();
void erroSemantico(char *mensagem, char *nome, int linha);
void warningSemantico(char *mensagem, char *nome, int linha);
void imprimirTabelaDeSimbolos();

int linha_atual = 1;

%}

%union {
    char *cadeia;
    int inteiro; // Para números inteiros
}

%token <cadeia> ID
%token <cadeia> NUM_INTEIRO NUM_FLUTUANTE
%token <inteiro> NUM
%token INTEIRO FLUTUANTE VOID INICIO FIM ATRIB IGUAL DIF MENOR MAIOR
%token MAIS MENOS MULTIPLICA DIVIDE PONTOEVIRGULA VIRGULA
%token ABREPAREN FECHAPAREN ABRECOLCHETE FECHACOLCHETE
%token ABRECHAVES FECHACHAVES

%type <cadeia> tipo var simple-expression numero

%%

programa:
    declaracoes bloco
    ;

declaracoes:
    | declaracoes declaracao
    ;

declaracao:
    tipo lista_ids ';'
    ;

tipo:
    INTEIRO { $$ = strdup("int"); }
    | FLUTUANTE { $$ = strdup("float"); }
    | VOID { $$ = strdup("void"); }
    ;

lista_ids:
    ID { insere($1, $<cadeia>1, linha_atual); }
    | lista_ids ',' ID { insere($3, $<cadeia>1, linha_atual); }
    ;

bloco:
    INICIO comandos FIM
    ;

comandos:
    | comandos comando
    ;

comando:
    atribuicao ';'
    ;

atribuicao:
    var ATRIB simple-expression { Simbolo *s = busca($1); if (s == NULL) erroSemantico("Variável não declarada", $1, linha_atual); else s->usado = 1; }
    ;

simple-expression:
    var
    | numero
    | var IGUAL var
    | var DIF var
    | var MENOR var
    | var MAIOR var
    ;

var:
    ID
    ;

numero:
    NUM_INTEIRO { $$ = strdup($1); }
    | NUM_FLUTUANTE { $$ = strdup($1); }
    ;

%%

void insere(char *nome, char *tipo, int linha) {
    if (busca(nome) != NULL) {
        erroSemantico("Variável já declarada", nome, linha);
        return;
    }
    Simbolo *novo = (Simbolo *)malloc(sizeof(Simbolo));
    novo->nome = strdup(nome);
    novo->tipo = tipo;
    novo->usado = 0;
    novo->linha = linha;
    novo->proximo = tabela;
    tabela = novo;
}

Simbolo* busca(char *nome) {
    Simbolo *atual = tabela;
    while (atual != NULL) {
        if (strcmp(atual->nome, nome) == 0) {
            return atual;
        }
        atual = atual->proximo;
    }
    return NULL;
}

void verificaUso() {
    Simbolo *atual = tabela;
    int teveErro = 0;

    while (atual != NULL) {
        if (atual->usado == 0) {
            teveErro = 1;
            warningSemantico("Variável declarada e não usada", atual->nome, atual->linha);
        }
        atual = atual->proximo;
    }

    if (teveErro == 0) {
        printf("Nenhum erro foi identificado");
    }
}

void erroSemantico(char *mensagem, char *nome, int linha) {
    printf("Erro semântico na linha %d: %s - %s\n", linha, mensagem, nome);
}

void warningSemantico(char *mensagem, char *nome, int linha) {
    printf("Warning semântico na linha %d: %s - %s\n", linha, mensagem, nome);
}

void imprimirTabelaDeSimbolos() {
    Simbolo *atual = tabela;
    printf("\nTabela de Símbolos:\n");
    printf("Nome\t\tTipo\t\tUsado\t\tLinha\n");
    printf("---------------------------------------------------\n");
    while (atual != NULL) {
        printf("%s\t\t%s\t\t%s\t\t%d\n", atual->nome, atual->tipo, atual->usado ? "Sim" : "Não", atual->linha);
        atual = atual->proximo;
    }
}

int main() {
    yyparse();
    verificaUso();
    imprimirTabelaDeSimbolos();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s na linha %d\n", s, linha_atual);
}

