#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>

int contachar(char *s)
{
  int i;
  int r = 0;
  for(i = 0; s[i] != '\0'; i++)
  {
    if(isalpha(s[i]) != 0)
    {
      r++;
    }
  }
  return r;
}



float contaselected(char *s,char c)
{
  int i;
  int r = 0;
  for(i = 0; s[i] != '\0'; i++)
  {
    if(s[i] == c || s[i] == c - 32)
    {
      r++;
    }
  }
  return r;
}

float somatorio(char *text,char *alfa, float *tab, float total)
{
  int i;
  float somatorio = 0;
  float app;
  for(i = 0; i < 26; i++)
  {
    app = contaselected(text,alfa[i]);
    if (app != 0)
    {
    app = (app/total)*100;
    somatorio = somatorio + (tab[i] - app)*(tab[i] - app)/tab[i];
    }
    
  }
  return somatorio;
} 



void pular(char *texto) 
{
 for (int i = 0; texto[i] != '\0'; i++) 
 {
  if (isalpha(texto[i])) 
  {
    char letra_minuscula = tolower(texto[i]);
    char proxima_letra = (letra_minuscula - 'a' + 1) % 26 + 'a';
    if (isupper(texto[i])) 
     {
      texto[i] = toupper(proxima_letra);
     } 
    else 
    {
     texto[i] = proxima_letra;
     }
  }
 }
}

int main(void)
{

    char alfa[] ={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
    float tab[] = {8.4966,2.0720,4.5388,3.3844,11.1607,1.8121,2.4705,3.0034,7.5448,0.1965,1.1016,5.4893,3.0129,6.6544,7.5448,3.1671,0.1962,7.5809,5.7351,6.9509,3.6308,1.0074,1.2899,0.2902,1.7779,0.2722};
    int pulos[26];
    char text[10000];
    
    if (fgets(text,sizeof(text),stdin) == NULL) { return 1; }

      char *newline = strchr(text, '\n');   
      if (newline) *newline = '\0';   


    float total = strlen(text);

    for(int i = 0; i < 26; i++)
    {
      pulos[i] = somatorio(text,alfa,tab,total);
      pular(text);
    }

    float r = pulos[0];
    int i = 0;
    int acc;
    for(acc = 1; acc < 26; acc++)
    {
      if (pulos[acc] < r)
      {
        r = pulos[acc];
        i = acc;
      }
    }
    int k;
    for(k = i;k > 0; k--)
    pular(text);

    printf("%d %s\n",i,text);
  

}