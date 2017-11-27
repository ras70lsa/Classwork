s = tf('s');
%% A 
Ga = ((s+2)*(s+6))/(s^2+8*s+25);
rlocus(Ga)

%% B 
Gb = (s^2 + 4)/(s^2 + 1);
rlocus(Gb)

%% C 
Gc = (s^2 + 1)/(s^2);
rlocus(Gc)

%% D
Gd = zpk([],[-1 -1 -1 -4], 1);
rlocus(Gd);