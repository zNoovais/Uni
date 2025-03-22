f = @(x) x+log(x);
f_dev = @(x) 1 + 1/x;
x0 = 6;
kmax = 100;
CP = 5*10^(-3);
[x_ast,x] = newton(f,f_dev,x0,CP,kmax);