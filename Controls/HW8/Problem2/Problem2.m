clear;
G = zpk([],[-2 -3 -7], 1)

K = 0:.1:200;
figure(1); clf;
rlocus(G, K);

%% Find gains and pole w 10% OS

os = .1;
z = -log(os) / (sqrt(pi^2 + log(os)^2))
sgrid(z,0)
K = 41
p = rlocus(G,K)

T = feedback(K * G, 1);
sd = -real(p(2));
wd = imag(p(2));

% Second order approx does not hold but helps develop a good plotting range
Ts = 4/sd 

figure(2)
t = linspace(0, 3*Ts, 1e3);
step(t,T);

%% Lag compensator 

s = tf('s');
LagSys = G * (s+0.041)/(s+0.01);
K = 0:.1:200;
figure(3); clf;
rlocus(LagSys, K);
sgrid(z,0)
K = 41.1;
p = rlocus(LagSys, K)

%% Plot step response
TLag = feedback(K * LagSys,1) 
figure(4); clf;
step(t,TLag);
hold on;
step(t, T);
legend('Compensated', 'Uncompensated');