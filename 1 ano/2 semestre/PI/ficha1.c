#include <stdio.h>

void drawsq(int n) //codigo para fazer quadrados
{
 for(int h = 0; h < n; h++)
 { for(int i = 0; i < n;i++)
   {
    putchar('#');
   }
   putchar('\n');
 }
}



void drawch(int n) // desenha um tab  de xadrez
{
 for(int i = 0; i < n; i++)
 {
  if (i%2 == 0)
  {
    for(int j = 0; j < n; j++)
    {
      if(j%2 == 0)
      {
        putchar('#');
      } 
      else
      {
        putchar('_');
      }
    }
  }
  else
  {
    for(int j = 0; j < n; j++)
    {
      if(j%2 == 0)
      {
        putchar('_');
      } 
      else
      {
        putchar('#');
      }
    }
  }
  putchar('\n');
 }
}

void draw(int n) //desenha o n de quadrados que eu queira
{
  for(n;(n > 0);n--)
  { 
    putchar('#');    
  }
  putchar('\n');
}

void jump(int n) //faz espaços
{
 for(int i = 0; i < n; i++)
 {
  putchar(' ');
 }

}

void drawtr1(int n) // desenha um triangulo1
{
  
 for(int i = 0; i < n-1; i++)
 {
  draw(1+i);
 }


 draw(n); // linha do meio

 for(int i = n-1; i > 0; i--)
 {
  draw(i);
 }
 
}

void drawtr2(int n)
{
  int c = 1;
 
 for(int i = n ;i > 0;i--)
 {

  jump(i-1);

  draw(c);

  c = c + 2;
 
 }
}

int main(void)
{
 drawtr1(25); //qwqw
 return 0;
}