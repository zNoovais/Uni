function resultado = decimal(num1)
    n = 0;
    x = num1;
    i = 0;
    
    while(x ~= 0)
        bit = mod(x,10);
        n = n + bit*(2^i);
        i = i + 1;
        if (bit == 1)
            x = (x-1)/10;
        else
            x = x/10;
        end
    end
    resultado = n;
end

