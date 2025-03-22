function r = forall(array,num)
    r = 1;
    n = length(array);
    for i=1:n
        if array(i) ~= num
            r = 0;
        end
    end 
end