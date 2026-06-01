a2
oq é um neuronio? 

temos inputs (x1,....,xn) cada um com o seu peso (w1,..,wn)
$$
\sum w_{n}x_{n} + bias
$$
passa para uma funçao de ativação z e gera um output y 

![[Pasted image 20260410094629.png|561]]



![[Pasted image 20260410094918.png]]


![[Pasted image 20260410095732.png]]
Pra calcular os vetores posso fazer em paralelo.. ciclos fors demoram mt 

$$
z^{(2)} = xW^{(1)} + b^{(1)}
$$
$$
a^{(2)} = f(z^{(2)})
$$

**EXEMPLO!**
![[Pasted image 20260410100637.png]]
$$
z = b + w_{1}x_{1}+w_{2}x_{2} = 30+20*0+20*0 = -30 
$$

$$
g(-30) = 0
$$


ligar neuronios é basicamente uma composição de funções ... é 

![[Pasted image 20260410102802.png]]


ta mas pra treinarmos isso temos que calcular gradientes mas como fazemos isso que é muito foda...

### Backpropagation
![[Pasted image 20260410103256.png]]
Já sabes isto é um processo iterativo... definido em epocas 

![[Pasted image 20260410103608.png]]









