f = @(x) x^3 -2*(x^2) + 3;
f_dev = @(x) 0.51 - cos(x);
a0 = -5;
b0 = 4;
kmax = 50;
CP = 5*10^-5;


[x_ast,x] = bisseta(f,a0,b0,eps,kmax);
