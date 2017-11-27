function [ signChanges ] = countSignChanges( firstCol )

    signChanges = 0;
    positive = true;
    if (firstCol(1) < 0) 
        positive = false;
    end 

    for i=2:length(firstCol) 
        if (positive && firstCol(i) < 0) 
            positive = false;
            signChanges = signChanges + 1;
        end
        
        if (~positive && firstCol(i) >= 0) 
            positive = true;
            signChanges = signChanges + 1;
        end
        
    end 

end

