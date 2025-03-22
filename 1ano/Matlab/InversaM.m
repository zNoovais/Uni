function MInv = InversaM(M)
   
   [m,n] = size(M);
   MInv = eye(m);
   M = [M eye(m)];
   M = atesc(M);
   for i = 1:m
       x = mestaf(M(1:m,1:n) ,M(:,i+m));
       MInv(:,i) = x;
   end

  
end
