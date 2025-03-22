f = @(x) 0.51*x-sin(x);
f_dev = @(x) 0.51 - cos(x);
fi_fun = @(x) sin(x)/0.51;
a0 = 1;
b0 = 2;
x0 = 2;
kmax = 100;
CP = 5*10^-5;


[x_ast,x] = interativo(f,fi_fun,x0,eps,kmax);