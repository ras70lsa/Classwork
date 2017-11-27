clear;
G = zpk([-6],[-2 -3 -5], 1)

K = 0:.1:200;
figure(1); clf;
rlocus(G, K);
z = 0.707
sgrid(z,0);

K = 4.6;
p = rlocus(G, K)

T = feedback(K * G, 1);
sd = -real(p(2));
wd = imag(p(2));
Ts = 4/sd 


figure(2); clf;
t = linspace(0, 3*Ts, 1e3);
step(t,T);

%% PD controller 

figure(3) 
s = tf('s');
zero = 7.2;
K = 0:.1:100;
pdSys = G * (s + zero);
rlocus(pdSys, K);
sgrid(z,0)
K = 4.7;
p = rlocus(pdSys,K)

Tpd = feedback(K*pdSys, 1);
sdNew = -real(p(1));
TsNew = 4/sdNew
t = linspace(0, 3*TsNew, 1e3);
figure(4); clf;
step(t, Tpd);
hold on;
step(t, T);
legend('PD Compensated', 'Uncompensated');
