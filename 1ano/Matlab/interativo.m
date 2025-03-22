function [x_ast,x] = interativo(f,fi_fun,x0,CP, kmax)
    x_ast = 'nao convergiu';
    x(1) = x0;
    for k = 1:kmax-1
        x(k+1) = fi_fun(x(k));
        if(f(k+1) == 0 || abs(x(k+1)-x(k)) <= CP)
            x_ast = x(k+1);
            break;
        end    
    end
end