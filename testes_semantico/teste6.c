int add(int a, int b) {
    return a + b;
}

void main(void) {
    int x;
    x = add(5, 10);
    x = add(5, "10");  // Erro: argumento do tipo errado
}

