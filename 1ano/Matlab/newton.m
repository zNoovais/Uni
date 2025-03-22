function [x_ast,x] = newton(f,f_dev,x0,CP,kmax)
    x_ast = 'nao convergiu';
    x(1) = x0;
    for k=1:kmax
        x(k+1)=x(k)-f(x(k))/(f_dev(x(k)));
        if abs((x(k+1)-x(k))) < CP && abs(f(x(k))) < 5*10^(-6)
             x_ast=x(k+1);
             break;
        end 
        
    end
end