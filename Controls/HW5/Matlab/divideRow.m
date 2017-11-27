function [ simplifiedRow ] = divideRow( table, index )
    div =  gcd(sym(table(index,:)));
    if length(symvar(div)) ~= 0 
        simplifiedRow = table(index, :);
        return
    end
    if (abs(div) < 1) 
        div = 1;
    end
    if (div<0)
        div = div * -1;
    end
    simplifiedRow = table(index, :) /div;
end

