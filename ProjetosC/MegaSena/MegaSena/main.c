#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <time.h>

int main()
{
    setlocale(LC_ALL, "Portuguese");

    srand(time(NULL));

    int mega[6] = { 0 };
    int numeros_utilizados[10] = { 0 };

    for (int i = 0; i < 6; i++)
    {
        int num = 0;
        do
        {
            num = 1 + rand() % 10;
        } while (numeros_utilizados[num] == 1);

        mega[i] = num;
        numeros_utilizados[num] = 1;
    }

    // Impressão dos numeros ---------------------------------------------------
    printf("Números sorteados:\n");
    for (int i = 0; i < 6; i++)
    {
        printf("%.2d ", mega[i]);
    }
    printf("\n\n");
    // -------------------------------------------------------------------------

    system("pause");
    return 0;
}
