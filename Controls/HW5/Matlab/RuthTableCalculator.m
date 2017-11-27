%{
    Takes in a polynomial p in which to build the ruth table
    For example s^2 + 5s + 6 => [1 5 6]
    Output: 
        r - ruth table taking limit of any epsilon to zero
        re - ruth table before epsilon limit
        signChanges - # signChanges in the first column if p is not
        symbolic

    Compatible for p with symbolic values i.e [2 4 5 K]. However, the 
    number of sign changes will not be computed in this case. 

    Compatible for cases with zero in first column or zero rows
%}
function [ r, re, signChanges ] = RuthTableCalculator( p )

    %% Determine whether p provided is all reals of symbolic
    calculateSignChanges = (length(symvar(p)) == 0); 
    
    numCols = ceil(length(p)/2);
    numRows = length(p);

    syms e; 
    r = sym(zeros(numRows, numCols));

    %% Create and simplify the first two rows
    for i = 1:numCols
        r(1,i) = p(2 * i - 1);
        if (2*i <= length(p))
            r(2,i) = p(2 * i);
        end
    end

    r(1,:) = divideRow(r, 1);
    r(2,:) = divideRow(r, 2);

    %% Fill in the ruth table for the rest of the rows
    for i = 3:numRows
        for j = 1:numCols
            rightColumnV1 = 0;
            rightColumnV2 = 0;
            if (j+1) <= numCols
                rightColumnV1 = r(i-2, j+1);
                rightColumnV2 = r(i-1, j+1);
            end
            leftColumnV1 = r(i-2, 1);
            leftColumnV2 = r(i-1, 1);
            det = leftColumnV1 * rightColumnV2 - rightColumnV1 * leftColumnV2;
            r(i,j) = -(det)/r(i-1,1);
        end
        %% Handle row of zeros by taking derivative of row above
        if r(i,:) == zeros(1, numCols)
            polynomialAbove = r(i-1,:);
            exponent = length(p) - (i - 1);
            for k=1:length(polynomialAbove)
                polynomialAbove(k) = polynomialAbove(k) * exponent;
                exponent=exponent-2;
            end
            r(i,:) = sym(polynomialAbove);
        end   

        %% Replace zeros in first column with epsilon
        if r(i,1) == 0 
           r(i,1) = e; 
        else 
           r(i,:) = divideRow(r, i);
        end
    end

    %% Save ruth table before limit
    re = r;

    %% Count the sign changes in the first column 
    firstCol = sym(zeros(numRows,1));
    for i = 1:numRows
        r(i,1) = limit(r(i,1), e, 0, 'right');
        %%What side you come from determined how you handle the zero case
        %%Come from right -> zero is negative and vice versa 
        firstCol(i) = r(i,1);
    end

    %% Count the sign changes
    if (calculateSignChanges) 
        signChanges = countSignChanges(firstCol);
    else
        signChanges = 'cannot calculate sign changes with syms';
    end
end

