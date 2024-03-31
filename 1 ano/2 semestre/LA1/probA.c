#include <stdio.h>
#include <locale.h>
#include <wchar.h>

int main(void)
{
  int dia, mes;
  setlocale(LC_CTYPE, "C.UTF-8");
  if(scanf("%d%d", &dia, &mes) == 2) {
        wchar_t a = 0x2652;
        wchar_t b = 0x2653;
        wchar_t c = 0x2648;
        wchar_t d = 0x2649;
        wchar_t e = 0x264a;
        wchar_t f = 0x264b;
        wchar_t g = 0x264c;    //TODOS OS SIGNOS
        wchar_t h = 0x264d;
        wchar_t i = 0x264e;
        wchar_t j = 0x264f;  
        wchar_t k = 0x2650;
        wchar_t l = 0x2651;

        if (mes == 1)
        {
            if(dia < 20) { wprintf(L"%lc\n", l); } else { wprintf(L"%lc\n", a); }
        }
        if (mes == 2)
        {
            if(dia < 19) { wprintf(L"%lc\n", a); } else { wprintf(L"%lc\n", b); }
        }
        if (mes == 3)
        {
            if(dia < 21) { wprintf(L"%lc\n", b); } else { wprintf(L"%lc\n", c); }
        }
        if (mes == 4)
        {
            if(dia < 21) { wprintf(L"%lc\n", c); } else { wprintf(L"%lc\n", d); }
        }
        if (mes == 5)
        {
            if(dia < 21) { wprintf(L"%lc\n", d); } else { wprintf(L"%lc\n", e); }
        }
        if (mes == 6)
        {
            if(dia < 21) { wprintf(L"%lc\n", e); } else { wprintf(L"%lc\n", f); }
        }
        if (mes == 7)
        {
            if(dia < 23) { wprintf(L"%lc\n", f); } else { wprintf(L"%lc\n", g); }
        }
        if (mes == 8)
        {
            if(dia < 23) { wprintf(L"%lc\n", g); } else { wprintf(L"%lc\n", h); }
        }
        if (mes == 9)
        {
            if(dia < 23) { wprintf(L"%lc\n", h); } else { wprintf(L"%lc\n", i); }
        }
        if (mes == 10)
        {
            if(dia < 23) { wprintf(L"%lc\n", i); } else { wprintf(L"%lc\n", j); }
        }
        if (mes == 11)
        {
            if(dia < 22) { wprintf(L"%lc\n", j); } else { wprintf(L"%lc\n", k); }
        }
        if (mes == 12)
        {
            if(dia < 22) { wprintf(L"%lc\n", k); } else { wprintf(L"%lc\n", l); }
        }
    
    }

    return 0;
}