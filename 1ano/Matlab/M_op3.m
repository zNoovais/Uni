function Mf = M_op3(M,i,k,alpha) %altera a linha i com a linha k * alpha
    M(i,:) = M(i,:) + alpha*M(k,:);
    Mf = M;
end