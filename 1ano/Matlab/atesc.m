function Mf = atesc(M) % m -> linhas; n -> colunas
    [m,n] = size(M);
    for i=1:m-1
        flag = 1;  
             for j=1:n 
        
                if(forall(M(i:m,j),0)==1)
                    %FAZ NADA 
                else
                    
           
                    flag = 0;
                    k = i-1+max_ind(abs(M(i:m,j)));
                    M = M_op1(M,k,i);
                for p=i+1:m
                    mult = M(p,j)/M(i,j);
                    M = M_op3(M,p,i,-mult);
                end
                end
                   if(flag == 0)
                       break;
                   end
             end
  
    end 
     Mf = M; 
    end
       

    