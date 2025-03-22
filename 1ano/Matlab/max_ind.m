function ind = max_ind(array)
    n = length(array);
    maior = max(array);
    for i=1:n
        if maior == array(i)
            ind = i;
        end
    end
end
