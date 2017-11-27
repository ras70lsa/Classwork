clear;
G = zpk([],[-5, -5, -5],1);

os = .15;
z = -log(os) / (sqrt(pi^2 + log(os)^2));

K = 0:.1:200;
figure(1); clf;
rlocus(G, K);
sgrid(z,0);

K = 116;
p = rlocus(G, K)

Ts = 4/-real(p(2))
%% Plot simulated response
T = feedback(K * G, 1) 
t = linspace(0, 3*Ts, 1e3);
figure(2); clf;
step(t,T)

%% Lead compensator 
s = tf('s');
pc = 4.9;
sysLC = G * (s+1)/(s+pc);
figure(3); clf;
K = 1:.1:200;
rlocus(sysLC,K);
sgrid(z,0);

K = 182;

p = rlocus(sysLC,K)

TLC = feedback(K*sysLC, 1);
figure(4); clf;
step(t, TLC)