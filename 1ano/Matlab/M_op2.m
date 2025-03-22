function Mf = M_op2(M,i,alpha)
    M(i,:) = M(i,:)*alpha;
    Mf = M;
end