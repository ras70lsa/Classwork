% Ryan St Pierre (ras70)
% Lab 4
% Experiment 2.1, Nise 7e 
% Honor code statement: ras70
clear; format short e; format compact;
delete('diaryExperiment2_1');
echo on; diary diaryExperiment2_1
%% Prelab
%% Prelab-a
P1 = [1 7 2 9 10 12 15];
r1 = roots(P1)

%% Prelab-b
P2 = [1 9 8 9 12 15 20];
r2 = roots(P2)

%% Lab
%% Problem 1 

P3 = P1 + P2;
syms s; 
P3Display = poly2sym(P3,s)

P4 = P1 - P2;
P4Display = poly2sym(P4,s)

P5 = conv(P1, P2)
P5Display = poly2sym(P5,s)

%% Problem 2 
P6 = conv(conv(conv([1 7], [1 8]),conv([1 3],[1 5])), conv([1 9],[1,10]));
P6Display = poly2sym(P6,s)

%% Problem 3
% We can generate G1 two different ways - both using a maximum of two
% commands. Both ways are shown below

% Define s for future use if we want it
s = tf ('s');

% Way 1 - Using conv generate G1 in one line
G1 = tf(20 * conv(conv([1 2],[1 3]), conv([1 6],[1 8])),... 
conv([1,0],conv(conv([1 7],[1 9]), conv([1 10],[1 15]))))

% Way 2 - using 's' to generate G1 
G1prime = 20*((s+2)*(s+3)*(s+6)*(s+8))/(s*(s+7)*(s+9)*(s+10)*(s+15));
G1PrimeTF = tf(G1prime)
%% Problem 4 
% We can generate G2 two different ways - both using a maximum of two
% commands. Both ways are shown below

% Way 1 
G2 = zpk(roots([1 17 99 223 140]), roots([1 32 363 2092 5052 4320]), 1)

% Way 2 
G2prime = (s^4+17*s^3+99*s^2+223*s+140)/(s^5+32*s^4+363*s^3+2092*s^2+5052*s+4320);
G2PrimeTF = zpk(G2prime)

%% Problem 5 
% G3 
G3 = G1 + G2
G3TF = tf(G3)
G3zpk = zpk(G3)

% G4
G4 = G1 - G2
G4TF = tf(G4)
G4zpk = zpk(G4)

% G5 
G5 = G1 * G2
G5TF = tf(G5)
G5zpk = zpk(G5)

%% Problem 6 
% Problem 6a
G6_num = 5 * [1 2];
G6_den = conv([1 0],[1 8 15]);
[r6,p6,k6] = residue(G6_num,G6_den)

% Problem 6b
G7_num = G6_num;
G7_den = conv([1 0],[1 6 9]);
[r7,p7,k7] = residue(G7_num,G7_den)

% Problem 6c
G8_num = G6_num;
G8_den = conv([1 0],[1 6 34]);
[r8,p8,k8] = residue(G8_num,G8_den)

diary off; echo off;