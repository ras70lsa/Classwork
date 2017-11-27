GH = zpk([],[-2 -3 -12], 1)

z = 0.826

close all 
K = 0:0.1:1000;

figure(1)
subplot(2,1,1)
rlocus(GH, K);
sgrid(z,0);

GHc = GH*(s+.1)/s
subplot(2,1,2)
rlocus(GHc, K)
sgrid(z,0)

figure(2) 
K = 27.9;
p = rlocus(GH, K)
sd = -real(p(2))
wd = imag(p(2))

Ts = 4/sd
Tp = pi/wd

tfin = Ts*3;
step(feedback(K*GH,1), tfin);
hold on;
axis([0 tfin 0 1]);

%% Make sure the second order approximation is okay

Rp2 = real(p(2)) * 5 
Rp1 = real(p(1))

approxOK =  abs(real(p(1))) > abs(real(p(2))) * 5 %% Approx is okay


s = tf('s')
css = K/(2*3*12+K)
A = (sd^2 + wd^2)*css
Tapprx = A/((s+sd)^2 + wd^2);
step(Tapprx);