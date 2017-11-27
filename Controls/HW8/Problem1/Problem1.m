G = zpk([],[-1 -1 -10], 1)

figure(1)
rlocus(G);

%% Problem 1B - Find stability
K_test = 200:.1:270;
figure(2)
rlocus(G, K_test);

%% Problem 1C - Determine Gain and Poles of Damping of 0.6
K = 1:.1:270;
z = 0.6;
figure(1)
rlocus(G,K);
sgrid(z,0)

K_dampingP6 = 13.8;
p = rlocus(G,K_dampingP6)

%% Plot the step response
figure(3)
T = feedback(K_dampingP6 * G, 1);
sd = -real(p(2));
wd = imag(p(2));

Ts = 4/sd
Tp = pi/wd

t = linspace(0, 3*Ts, 1e3);
step(t,T);

%% Implement a PI controller 
s = tf('s');
K_pi = 200:0.1:300;
sysPI = G * (1/s) * (s+0.2);
figure(4) 
rlocus(sysPI, K_pi)

K_pi = 0:0.1:300;
rlocus(sysPI, K_pi)
sgrid(z,0)
K = 13.3; 
p = rlocus(sysPI, K)

%% Simulate the step response
Tpi = feedback(K * sysPI, 1)

sd = -real(p(2));
wd = imag(p(2));

Ts = 4/sd
Tp = pi/wd
figure(5); clf;
t = linspace(0, 3*Ts, 1e3);
step(t,Tpi);
hold on;
step(t, T);
legend('Compensated', 'Uncompensated');