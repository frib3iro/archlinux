#include <stdio.h>

void swap(int *, int *);

int main()
{
    int a = 3;
    int b = 7;

    printf("valor de a: %d\n", a);
    printf("valor de b: %d\n", b);

    swap(&a, &b);
    puts("");

    printf("valor de a: %d\n", a);
    printf("valor de b: %d\n", b);

    return 0;
}

void swap(int *a, int *b)
{
    *a = *a + *b;
    *b = *a - *b;
    *a = *a - *b;
}
