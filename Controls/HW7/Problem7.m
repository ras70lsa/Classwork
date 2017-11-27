s = tf('s');
%% A 
GHa = ((s-2)^2)/((s^2+4*s+12)*(s+4)^2);
r= rlocus(GHa, [29.17691453624])

%% B
GHb = ((s^2 + 2*s+5)*(s-2))/((s+3)*(s+5));
rlocus(GHb)