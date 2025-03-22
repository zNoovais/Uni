function Tab = NewtonP(x,y)
    n = length(x);
    i = 1;
    while(i ~= n)
        Tab(i,1) = (y(i)-y(i+1))/(x(i)-x(i+1));
        i = i+1;
    end
  
    j = 2;
    while(j ~= n)
        i = 1;
        while(i ~= n-j+1)
            Tab(i,j) = (Tab(i,j-1)-Tab(i+1,j-1))/(x(i) - x(i+j));
            i = i+1;
        end
        j = j+1;
    end
    


    
    
    

end