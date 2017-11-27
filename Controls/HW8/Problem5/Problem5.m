clear;
G = zpk([],[0 -5 -11],1)

%% Find uncompensated overshoot
os = 0.3;
K=0:.1:300;
figure(1); clf;
z = -log(os) / (sqrt(pi^2 + log(os)^2))
rlocus(G,K);
sgrid(z,0);

K = 219

%% Find KV
syms s
Gs = s * (K)/(s*(s+5)*(s+11)); 
KV = limit(Gs,s,0)

%% Find poles

p = rlocus(G,K)

Tp = pi/imag(p(2))
Ts = 4/-real(p(2))

T = feedback(K * G, 1);
t = linspace(0, 3*Ts, 1e3);
figure(2); clf;
step(t,T);
hold on;
slope=1;
ramp=slope.*t ;
[y,t]=lsim(T,ramp,t);
plot(t,y, 'k')
legend('step', 'ramp');

figure(3); clf;
[y,t]=lsim(T,ramp,t);
hold on;
plot(t,y, 'k')
plot(t,t,'b');
legend('System response', 'Step Input');
xlabel('time')
ylabel('value');
title('Ramp input');
plot(t, ramp, 'b')

s = tf('s');
figure(4); clf;
sysLeadComp = (s+5)/(s+55.28) * G;
os = 0.15;
K = 0:1:8000;
z = -log(os) / (sqrt(pi^2 + log(os)^2))
rlocus(sysLeadComp,K);
sgrid(z,0);

K = 4.6e3;
p = rlocus(sysLeadComp,K)
TLC = feedback(K * sysLeadComp, 1);
figure(5);  clf;
step(t,TLC);
hold on;
step(t, T);
legend('Compensated','Uncompensated');

figure(6); clf;
[yLC,t]=lsim(TLC,ramp,t);
plot(t,yLC, 'k')
hold on;
plot(t,y,'b');
plot(t,t,'r');
legend('Compensated', 'Uncompenstated', 'Step input');
xlabel('time')
ylabel('value');
title('Ramp input');

%% Lag-lead 

sysLagLead = sysLeadComp * (s+0.158)/(s+0.01);
K = 4.6e3;
TLagLead = feedback(K*sysLagLead,1);
figure(7); clf;
step(t,T);
hold on;
step(t,TLC);
step(t,TLagLead);
legend('Uncompensated', 'Lead Compensated', 'Lag-lead Compensated');

figure(8); clf;
[yLagLead,t]=lsim(TLagLead,ramp,t);
plot(t,y,'b');
hold on;
plot(t,yLC, 'k')
plot(t,yLagLead, 'g')
plot(t,t,'r');
legend('Uncompensated', 'Lead Compensated', 'Lag-lead Compensated', 'Input Ramp');
xlabel('time')
ylabel('value');
title('Ramp input');
