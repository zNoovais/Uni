#include <stdio.h> 


float multInt1(int n, float m)
{
 float r = 0;

 for(int i = 0; i < n; i++)
 {
    r = m+r;
 }
 return r;
}

float multInt2(int n, float m)
{
    float r = 0;
    while(n > 0)
    {
       if(n % 2 != 0)
       {
        r = r+m;
       }

       n = n/2;
       m = m*2;
        
    }
    return r;
}

int mdc(int n, int m)
{
int r;
  while( m != 0)
  {
   r = n % m;
   n = m;
   m = r;
  }
 return n;
}

int mdc2(int n, int m)
{
  while(n != m)
  {
    if(n > m)
    {
      n = n-m;
    }
    else
    {
      m = m - n; 
    }
  } 
  return n;
}

int mdc3(int n, int m)
{
  while(n != m)
  {
    if(n > m)
    {
      n = n%m;
    }
    else
    {
      m = m % n; 
    }
  } 
  return n;
}

int fib1 (int n)
{
  if( n < 2)
  {
    return 1;
  }
  else
  {
    return (fib1(n-1)+fib1(n-2));
  }
}


int main(void)
{
 for(int i = 0; i < 10; i++)
 printf("%d\n",fib1(i));

 return 0;
}

