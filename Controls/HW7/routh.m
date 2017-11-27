function table = routh(p)
% check input
sz = size(p);
if sz(1) ~= 1
    error('polynomial must be 1 x n matrix');
end

table = makeTable(p);
if ~isnumeric(p)
    table = simplify(table);
end

end

function t = makeTable(p)

row = length(p);
col = ceil(row/2);
t = zeros(row, col);
if ~isnumeric(p)
    t = t*sym(0);
end

for i = 1:row
    for j = 1:col
        if i == 1
            % first row
            t(i,j) = p(2*j-1);
        elseif i == 2
            % second row
            if 2*j <= row
                t(i,j) = p(2*j);
            end
        else
            % other rows
            if j < col
                mat = [t(i-2,1) t(i-2,j+1); t(i-1,1) t(i-1,j+1)];
                t(i,j) = -det(mat)./t(i-1,1);
            end
        end
    end
    % check row for zeros
    if t(i,1) == 0
        allzero = true;
        for j = 2:col
            if t(i,j) ~= 0
                allzero = false;
            end
        end
        if ~allzero
            % zero in first column only
            t(i,1) = eps;
        else
            % row of all zeros
            ord = row-i+1;
            fprintf('row of zeros at order %d\n', ord-1);
            for j = 1:col
                t(i,j) = (ord-2*(j-1))*t(i-1,j);
            end
        end
    end
end

end