function [x_ast,x] = bisseta(f,a0,b0, CP, kmax)
a = a0;
b = b0;
x_ast = 'nao convergiu';
      for k=1:kmax
        x(k) = (a+b)/2;
        if(f(x(k)) == 0 || abs(f(x(k))) < CP ) % criterio de paragem (alterar com o exercicio)
            x_ast = x(k);
            break;
        
        else
            if f(a)*f(x(k)) < 0
                b = x(k);
            else
                a = x(k);
            end
         end
      end

      
     
end