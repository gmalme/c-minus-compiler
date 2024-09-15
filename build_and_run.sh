#!/bin/bash

# Executa Bison para gerar o arquivo parser.tab.c e parser.tab.h
bison -d parser.y

# Executa Flex para gerar o arquivo lex.yy.c
flex lexer.l

# Compila os arquivos gerados e cria o executável analisador
gcc -o analisador parser.tab.c lex.yy.c -lfl

# Executa o analisador com o primeiro arquivo de entrada
echo "Executando o analisador com entrada.c..."
./analisador < entrada.c
echo "\n\n==========================================================================\n\n"

# Executa o analisador com o segundo arquivo de entrada
echo "Executando o analisador com entrada2.c..."
./analisador < entrada2.c
echo "\n\n==========================================================================\n\n"



# para executar:
# chmod +x build_and_run.sh
# ./build_and_run.sh

