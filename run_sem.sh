#!/bin/bash

# # Executa o analisador com o primeiro arquivo de entrada
# echo "Executando o analisador com entrada.c..."
# ./analisador < entrada.c
# echo
# echo
# echo "=========================================================================="
# echo
# echo

# # Executa o analisador com o segundo arquivo de entrada
# echo "Executando o analisador com entrada2.c..."
# ./analisador < entrada2.c
# echo
# echo
# echo "=========================================================================="
# echo
# echo

# Executa o caso de teste 1: Função simples com declaração de variáveis
echo "Executando o analisador com teste1.c - Função simples com declaração de variáveis..."
./analisador < testes_semantico/teste1.c
echo
echo
echo "=========================================================================="
echo
echo

# Executa o caso de teste 2: Função com retorno e atribuições
echo "Executando o analisador com teste2.c - Função com retorno e atribuições..."
./analisador < testes_semantico/teste2.c
echo
echo
echo "=========================================================================="
echo
echo

# Executa o caso de teste 3: Função com if e else
echo "Executando o analisador com teste3.c - Função com if e else..."
./analisador < testes_semantico/teste3.c
echo
echo
echo "=========================================================================="
echo
echo

# Executa o caso de teste 4: Erro semântico - variável não declarada
echo "Executando o analisador com teste4.c - Erro semântico: variável não declarada..."
./analisador < testes_semantico/teste4.c
echo
echo
echo "=========================================================================="
echo
echo

# Executa o caso de teste 5: Função recursiva
echo "Executando o analisador com teste5.c - Função recursiva..."
./analisador < testes_semantico/teste5.c
echo
echo
echo "=========================================================================="
echo
echo

# Executa o caso de teste 6: Erro semântico - função com tipos incompatíveis
echo "Executando o analisador com teste6.c - Erro semântico: função com tipos incompatíveis..."
./analisador < testes_semantico/teste6.c
echo
echo
echo "=========================================================================="
echo
echo

# Executa o caso de teste 7: Sucesso
echo "Executando o analisador com teste7.c - Sem erros..."
./analisador < testes_semantico/teste7.c
echo
echo
echo "=========================================================================="
echo
echo


# para executar:
# chmod +x run_sem.sh
# ./run_sem.sh
