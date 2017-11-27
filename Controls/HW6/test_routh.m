%% Ryan St.Pierre (ras70)
%% Controls HW6
clear; clc

format shortG

delete('routh-test.txt')

diary routh-test.txt

syms K

%% Problem 2
p2 = [1 31 3]
tab = testRouth(p2);

%% Problem 3
p3 = [1 25 196 K+480 7*K]
tab = testRouth(p3);
Kmin1 = solve(tab(3,1)==0,K)

%% Problem 4
p4 = [1 1 100]
tab = testRouth(p4);

%% Problem 4
p5 = [1 59/45 0]
tab = testRouth(p5);

%% Problem 6
p6 = [1 8 19 32 10*K];
tab = testRouth(p6);
Kmin1 = solve(tab(4,1)==0,K)
Kmin2 = solve(tab(5,1)==0,K)

%% 6c 
p6c = [1 8 19 32 0]
r = roots(p6c)

%% Problem 7
p7 = [1 7 10]
tab = testRouth(p7);

%% Problem 8
p8 = [11 142 400]
tab = testRouth(p8);

%% Problem 8
p9 = [1 2 K K]
tab = testRouth(p9);

diary off