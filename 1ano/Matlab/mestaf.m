function CS = mestaf(M,b) % m -> linhas; n -> colunas % b - > termos indenpendentes %matriz em escada nao esquecer!!!
    [m,n] = size(M);
    i = m;
    j = n;
    ind = n;
    CS = zeros(m,1);
    CS(j) = b(m)/M(m,n);
    while(i ~= 1)
        ind = ind-1;
        i = i-1;
        j = j-1;
        k = n;
        while(k ~= j)
            b(i) = b(i) -M(i,k)*CS(k);
            k = k-1;
        end
        CS(ind) = b(i)/M(i,j);
    end

end
