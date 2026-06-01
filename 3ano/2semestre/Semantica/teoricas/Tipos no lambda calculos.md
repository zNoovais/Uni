
$(\lambda x:Int.yx)5$ ------> é tipificável?

nos temos isto: c|x|$\lambda x.e$| a b é o nosso escopo de coisas


$y:INT\to A\vdash(\lambda x:INT.y\;x)\;5:A$


![[Pasted image 20260421094718.png|697]]

*regras:* var, app e abs

## Propiedades dos tipos

 - **Unicidade**
Se $\Gamma\vdash a:\sigma,\Gamma\vdash a:\tau\implies\sigma=\tau$

- **Substituição**
Se $\Gamma,x:\tau\vdash a:\sigma,\Gamma\vdash b:\tau,\implies\Gamma\vdash a[b/x]:\sigma$
- **Enfraquecimento**
- **Fortalecimento**
- 