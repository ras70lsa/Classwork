clear; clc

format shortG

p1 = [1 2 3];
p2 = [1 2 1 2 3 1];
p3 = [1 2 4 9 4 9 3 0];
p4 = [1 0 2 0 1];

syms K;

a = [1 12 60+K 160-4*K 192+4*K];
disp(a)
tab = routh(a);
disp(tab)