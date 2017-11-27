clear;
GTypezero = zpk([],[-4 -6 -10],1);

s = tf('s');
G = (1/s) * GTypezero;

zero = 3;
sysTransient = G * (s+zero);

K = 0:.1:350;
figure(1); clf;
rlocus(sysTransient,K);
z = 0.5;
sgrid(z, 0);

K = 228;

p = rlocus(sysTransient, K)
Ts = 4/-real(p(2))

T = feedback(K * sysTransient, 1);
t = linspace(0, 3*Ts, 1e3);
figure(2); clf;
step(t,T)

sysComp = (s+0.01)/s * sysTransient;
p = rlocus(sysComp, K) 
Tcomp = feedback(K * sysTransient, 1);
t = linspace(0, 3*Ts, 1e3);
figure(2); clf;
step(t, Tcomp);
hold on;
T = feedback(K * G, 1);
step(t, T);
legend('Uncompensated', 'Compensated');

figure(3); clf;
slope=1;
ramp=slope.*t ;
[y,t]=lsim(T,ramp,t);
[yComp,t]=lsim(Tcomp,ramp,t);
plot(t,y);
hold on;
plot(t,yComp);
legend('Uncompensated', 'Compensated');
title('Ramp response')
xlabel('Time')
ylabel('Value')
