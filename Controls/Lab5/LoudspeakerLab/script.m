% Lab 5
% Rohan Rajan, Ryan St.Pierre, Doyong Kim
% October 23, 2017
clear;
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
b = sqrt(ksuspension * mspeaker)/Qm

s = tf('s') ;
Hnum = qemf * s;
Hden = (m*Lsp)*s^3+(b*Lsp + m*Rsp)*s^2+(k*Lsp + b*Rsp + qemf^2)*s+k*Rsp;
H = Hnum/Hden

[HMag, HPhase, HOmega] = bode(H, EstAccOmega);
HMag   = squeeze(HMag);
HPhase = squeeze(HPhase);

%% Plot 
figure(1);clf;
semilogx(EstOmega, 20*log10(EstMag), 'k-')
hold on;
semilogx(HOmega, 20*log10(HMag), 'k--')
legend('Experimental','Analytical')
xlabel('\omega, rad/s')
ylabel('|H|, dB')
title('Experimental vs Analytical TF')

