#include <stdio.h>
#include <stdlib.h>
#include "funcao.h"
#include <locale.h>

int main()
{
    setlocale(LC_ALL, "Portuguese");

    int a;
    int b;

    printf("Digite o 1º número: ");
    scanf("%d", &a);

    printf("Digite o 2º número: ");
    scanf("%d", &b);

    printf("\nValor antes  da troca: [a %d] - [b %d]\n", a, b);


    swap(&a, &b);

    printf("Valor depois da troca: [a %d] - [b %d]\n", a, b);

    return 0;
}
