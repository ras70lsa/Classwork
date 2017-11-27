s = tf('s')
n = 1.075;
w0 = 1e-10;
G = n/(s^2 - w0^2)
t = linspace(0,5,1e3);
figure(1);
clf;
T = feedback(G, 1) 
step(t,T)