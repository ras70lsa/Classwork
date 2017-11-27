kOsc = 224/9;
p = [1 9 20 12 kOsc];
syms s
expression = s^4 + 9*s^3 + 20*s^2 + 12*s + kOsc;
factor(expression)
roots(p)