% Lab 5
% Rohan Rajan, Ryan St.Pierre, Doyong Kim
% October 23, 2017
clear;
s = tf('s') 
load('Lab5Data.mat');

sensativityConstantG = 101.2; %% mV/g
sc = sensativityConstantG * (1/100) / 9.8; %% V/m/s^2

%% Adjust EstAccTF by the sensativity constant
EstTFsensAdj = EstAccTF ./ sc;

%% Calculate magnitude, phase, and omega
EstAccMag = abs(EstAccTF);
EstAccPhase = angle(EstAccTF);
EstAccOmega = EstAccF*2*pi;

%% Integrate to velocity
integrationFactor = EstAccOmega .* 1i;
EstTFVel = EstTFsensAdj./integrationFactor;

%% Plot 

EstMag   = abs(EstTFVel);
EstPhase = angle(EstTFVel);
EstOmega = EstAccOmega;

%% Constants 
gTokg = (1/1000);
mspeaker = 10 * gTokg; 
macc = 2 * gTokg;
mair = 0.574 * gTokg;
m = mspeaker + macc + mair;

qemf = 6.6; %% Bl 
Lsp = 0.8e-3; %% mH to H 
Rsp = 6.1; 

ksuspension = 917;
kair = 2698; 
k = kair + ksuspension;

Qm = 1.78;
b = sqrt(ksuspension * mspeaker)/Qm;

%% Guess and check constants
bacc = 0.05;
kacc = 70000;
msair = mspeaker + mair;

%% Define theoretical TF
Hnum = qemf*s*(bacc*s+kacc);
Hden5 = Lsp*macc*msair;
Hden4 = ((b+bacc)*Lsp+msair*Rsp)*macc+msair*Lsp*bacc;
Hden3 = ((k+kacc)*Lsp+(b+bacc)*Rsp+qemf^2)*macc+(kacc*msair+b*bacc)* ...
            Lsp+msair*Rsp*bacc;
Hden2 = Rsp*(k+kacc)*macc+(k*bacc+kacc*b)*Lsp+(kacc*msair+b*bacc)*Rsp+ ...
            qemf^2*bacc;
Hden1 = k*Lsp*kacc+(k*bacc+kacc*b)*Rsp+qemf^2*kacc;
Hden0 = k*kacc*Rsp;
HdenTotal = Hden5 * s^5 + Hden4 * s^4 + Hden3 * s^3 + Hden2 * s^2 + ...
            Hden1 * s + Hden0;

H = Hnum/HdenTotal;

[HMag, HPhase, HOmega] = bode(H, EstAccOmega);
HMag   = squeeze(HMag);
HPhase = squeeze(HPhase);

%% Plot 
hold off;
figure(1);clf;
semilogx(EstOmega, 20*log10(EstMag), 'k-')
hold on;
semilogx(HOmega, 20*log10(HMag), 'k--')
legend('Experimental','Analytical')
xlabel('\omega, rad/s')
ylabel('|H|, dB')
title('Experimental vs Analytical TF')
