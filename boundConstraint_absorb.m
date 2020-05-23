function vn = boundConstraint_absorb(vi, low, up);

[NP, D] = size(vi);  % the population size and the problem's dimension


vn = vi;
    
    
for i = 1:NP    
    for j = 1:D 
        if vi(i,j) > up(j) 
            vn(i,j) = up(j);
        elseif  vi(i,j) < low(j)
            vn(i,j) = low(j);
        else
            vn(i,j) = vi(i,j);
        end  
    end
end  