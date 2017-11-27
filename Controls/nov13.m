GH = zpk([-8],[-3 -6 -10], 1)

os = .2;
z = -log(.2) / (sqrt(pi^2 + log(.2)^2))

close all 
K = 1:0.005:125;

figure(1)
rlocus(GH, K);

sgrid(z,0);

K = 122;
p = rlocus(GH, K) 
% Zero at -8 cancels pole at -8 to make seocnd order approx
sd = -real(p(1));
wd = imag(p(1));

Ts = 4/sd
Tp = pi/wd

figure(2) 
t = linspace(0, 3*Ts, 1e3);
T = feedback(K*GH,1);
step(t,T);

%% improve transient response

s = tf('s')
sysPd = GH * (s+55.9)
figure(1) 
Kvec = 0:.1:20;
rlocus(sysPd, Kvec);
sgrid(z,0);

K = 5.3;
p = rlocus(sysPd, K) 
% Zero at -8 cancels pole at -8 to make seocnd order approx
sd = -real(p(1));
wd = imag(p(1))

Ts = 4/sd
Tp = pi/wd % Peak time we designed for 

figure(2) 
hold on;
t = linspace(0, 3*Ts, 1e3);
Tpd = feedback(K*sysPd,1);
step(t,Tpd);

%% improve steady-state error 

sysPID = sysPd*(1/s) * (s+0.5);
figure(1)
Kvec = 0:.1:20;
rlocus(sysPID, Kvec)
sgrid(z,0)

K = 4.6
p = rlocus(sysPID, K) ;
% Zero at -8 cancels pole at -8 to make seocnd order approx
sd = -real(p(1));
wd = imag(p(1));

Ts = 4/sd
Tp = pi/wd

figure(2) 
TPID = feedback(K *sysPID, 1);
step(t,TPID)