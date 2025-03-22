#include <stdio.h>

void swapM(int *x, int *y) // troca dois inteiros
{
    int r;
    r = *x;
    *x = *y;
    *y = r;
}

void swap (int v[], int i, int j)
{
    int r;
    r = v[i];
    v[i] = v[j];
    v[j] = r;
}

int soma (int v[], int n)
{
    int s = 0;
    int i;
    for(i = 0; i < n; i++)
    {
        s = v[i] + s;
    }

    return s;
}

void inverteArray (int v[], int n)
{
    for(int i = 0; i < n/2; i++)
    {
        swap(v,i,n-1-i);
    }
}

int maximum (int v[], int n, int *m)
{
    if(n <= 0) { return 1; }

    int i,maior = v[0];
    for(i = 1; i < n; i++)
    {
        if(v[i] > maior) { maior = v[i]; }
    }

    *m = maior;
    return 0;
}

void quadrados (int q[], int n)
{
    q[0] = 0;
    for(int i = 0; i < n-1; i++)
    {
        q[i+1] = i*i + (2*i + 1);
    }
}

int main(void) 
{

int q[10];

q[9] = 69;

quadrados(q,9);

for(int i = 0; i < 10; i++)
printf("%d\n",q[i]);
 


}