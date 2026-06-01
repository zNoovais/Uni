$$
e \equiv(xy)(\lambda z.\lambda x.xz)
$$


FV (e) = x,y    *variáveis livre (free)*
BV (e) = z,x *variáveis ligadas (bounded)*


redução $\beta$ : $(\lambda x.a)b$ -> $a[b/x]$ !!! muito importante substituição (ver exercicios sobre: [[3ano/2semestre/Semantica/fichas|fichas]])

### Forma Canonica

As expressões lambda são formas canónicas: na abstração de $\lambda x.e.$ 
isto é usado na *lazy evaluation* que nós vamos calcular sempre só ate a forma canónica

```haskell
> um (fun x) = 1 
```

