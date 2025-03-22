function resultado = facbinary(x,n) % n: mantissa | x: num para binario
    r = 0.0;
    escala = 0.1;
    while(n ~= 0 && x ~= 0)
        digit = floor(x*10);
        digit = digit-1;
        r = r + 1*escala;
        escala = escala*0.1;
        if(digit == 1)
            x = (x*10)-1;
        else
            x = x*10;
        end
        n = n-1;
    end
    resultado = r;
end

           




    