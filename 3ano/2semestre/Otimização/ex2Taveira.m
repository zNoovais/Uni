clc;
clear
syms w1 w2;
F = 0.1*w1^6-1.5*w1^4+5*w1^2+0.1*w2^4+3*w2^2-9*w2+0.5*w1*w2;
wk = [-1.25; 1.25];
sk = [4; 0.75];
eta0 = 1.2;
gradF = gradient(F,[w1, w2]);
Fk = subs(F,[w1;w2],wk);
gradFk = subs(gradF, [w1;w2],wk);
rho = 0.7;
c = 0.0001;
eta = eta0;
subs(F,[w1;w2],wk+eta*sk)
while(subs(F,[w1;w2],wk+eta*sk) >= Fk+c*eta*gradFk'*sk)
    eta = eta*rho;
end;