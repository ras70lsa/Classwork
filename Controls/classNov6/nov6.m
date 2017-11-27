GH = zpk([2 4],[-1 -3], 1);
rlocus(GH);
%% OS < 5% -> z > 0.69
z = 0.69;
sgrid(z,0);
[K,p] = rlocfind(GH)