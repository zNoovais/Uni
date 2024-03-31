#include <stdio.h>
#include <string.h>
#include <math.h>

int alleq(char s[] ,int e,char c) //função que verifica se tudo é 'c'
{
  int r = 1;
  int i;
  for(i = 0; i < e; i++)
  {
    if(s[i] != c) r = 0;
  }

  return r;
}

int main(void)
{
  int linhas;
  int i,j;
  if(scanf("%d",&linhas) != 1) { return 1; }

  
  for(j = 0; j < linhas; j++) //começo do loop de pergunta -> resposta
  {
    
    char bin[15];
    
    int e, m;
    if(scanf("%d%d%s",&e,&m,bin) != 3) { return 1; }

    if(1 <= e && e <=5 && m <= 7 && 1 <= m)
    {
     int excesso = pow(2,e-1)-1;
     int expp = 0;
     for(i = e+1; i >= 1; i--)
     {
        if( bin[i] == '1')  { expp = expp + pow(2,e-i); } // calculo of exponent
     }
    
    if(alleq(bin+1,e,'1') == 1)
    {
      if(alleq(bin+1+e,m,'0') == 1)
      {
        if(bin[0] == '0') printf("+Infinity\n"); else printf("-Infinity\n");
      }
      else printf("NaN\n");
    }

    else if(alleq(bin+1,e,'0') == 1)
    {
      if(alleq(bin+1+e,m,'0') == 1)
      {
        if(bin[0] == '0') printf("0\n"); else printf("-0\n");
      }
      else
      {
      int r = -1;
      double man = 0;
      
      for(i = 0; i < m; i++)
      {
        if(bin[1+e+i] == '1') man = man + pow(2,r);
        r--;
      }
      printf("%lg\n", pow(-1,bin[0])*man*pow(2,1-excesso));
      }
    }

    else
    {
      
      int r = -1;
      double man = 0;
      
      for(i = 0; i < m; i++)
      {
        if(bin[1+e+i] == '1') man = man + pow(2,r);
        r--;
      }
      if(bin[0] == '1')
      {
      printf("%lg\n", -1*(1+man)*pow(2,expp-excesso));
      }
      else
      {
       printf("%lg\n", 1*(1+man)*pow(2,expp-excesso));
      }

    }
    }
    
  }
 return 0;
}
  
