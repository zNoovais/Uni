function Mf = M_op1(Mi,i,i_lin)
    R = Mi(i,:);
    Mi(i,:) = Mi(i_lin,:);
    Mi(i_lin,:) = R;
    Mf = Mi;
end

