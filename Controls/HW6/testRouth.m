function tab = testRouth(p)
fprintf('Routh table for poly: \t')
disp(p)
tab = routh(p);
disp(tab)
end

