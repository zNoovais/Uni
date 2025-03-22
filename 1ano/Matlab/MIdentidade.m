function Id = MIdentidade(n)
    for i=1:n 
        for j=1:n 
           if(i==j)
               Id(i,j) = 1;
           else
               Id(i,j) = 0;
           end
        end
    end
end