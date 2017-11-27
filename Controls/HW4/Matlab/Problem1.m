% Ryan St Pierre (ras70)
% HW #4
% Problem 1 
% Honor code statement: ras70
clear; format short e; format compact;
delete('diaryProblem1D');
echo on; diary diaryProblem1D

%% Define numerator and denominators of blocks
G1num = [0 0 1];
G1den = [1 0 0];
G2num = [0 50];
G2den = [1 1];
G3num = [1 0];
G3den = [0 1];
G4num = [2];
G4den = [1];

H1num = [0 2];
H1den = [1 0];

%% Define blocks
G1 = tf(G1num, G1den);
G2 = tf(G2num, G2den);
G3 = tf(G3num, G3den);
G4 = tf(G4num, G4den);
H1 = tf(H1num, H1den);

%% Find GF, the simplified TF 
G5 = parallel(G3, -G4);
G6 = feedback(G2, H1, -1);
G7 = G1 * G5 * G6;
GF = feedback(G7, 1, -1);
s=tf('s');
GF = minreal(GF)

diary off; echo off;
