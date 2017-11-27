sys = zpk([-2],[-1 -3 -4], 1)
rlocus(sys)
r = rlocus(sys, [1/.55])
r = rlocus(sys, [1/.4925])