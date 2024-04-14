#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <time.h>

#define TAM 6

int main()
{
    setlocale(LC_ALL, "Portuguese");

    int megasena[TAM] = {0};

    srand(time(NULL));

    // Repetição dos números ---------------------------------------------------
    for (size_t i = 0; i < TAM; ++i)
    {
        megasena[i] = (rand() % 60 + 1);

        for(size_t j = 0; j < i; ++j)
        {
            if(megasena[i] == megasena[j])
            {
                --i;
                break;
            }
        }
    }
    // -------------------------------------------------------------------------

    // Ordenação dos números ---------------------------------------------------
    for (size_t i = 0; i < TAM; ++i)
    {
        for(size_t j = i + 1; j < TAM; ++j)
        {
            if(megasena[i] > megasena[j])
            {
                int tmp = megasena[i];
                megasena[i] = megasena[j];
                megasena[j] = tmp;
            }
        }
    }
    // -------------------------------------------------------------------------

    // Impressão dos numeros ---------------------------------------------------
    printf("Números sorteados:\n");
    for (size_t i = 0; i < TAM; ++i)
    {
        printf("%.2d ", megasena[i]);
    }
    puts("");
    // -------------------------------------------------------------------------
    return 0;
}
