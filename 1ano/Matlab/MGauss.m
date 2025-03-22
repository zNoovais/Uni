function CS = MGauss(M)
    [m,n] = size(M);
    M = atesc(M);
    b = M(:,n);
    CS  = mestaf(M,n);
end