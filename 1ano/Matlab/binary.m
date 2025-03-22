function resultado = binary(x)
    n = 0;
    escala = 1;

    while(x ~= 0)
        bit = mod(x,2);
        n = n + bit*escala;
        escala = escala*10;
        if (bit == 0)
            x = x/2;
        else 
            x = (x-1)/2;
        end
    end
   resultado = n;
end
           
    
