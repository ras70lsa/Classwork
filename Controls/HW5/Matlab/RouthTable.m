%{
    Ryan St.Pierre
    Controls HW5 
    October 19
%}

%% Work done for all of HW5
echo on             
% remove old file if there
delete('HW5DiaryRas70.txt')    
% start diary named WithEcho.txt
diary HW5DiaryRas70.txt
clear; 

syms K

%%Problem 1
p = [1 5 6+K K];
[r1, re1, sc1] = RuthTableCalculator(p);
r1

%% Problem 3
p = [1 142 6031 79002+ K];
[r3, re3, sc3] = RuthTableCalculator(p);
r3

%% Problem 3b - select a value of K to yield oscillations
kOsc = 777400;
p = [1 142 6031 79002 + kOsc];
[r3, re3, sc3] = RuthTableCalculator(p);
r3

%% Problem 4
p = [1 7 15 13 4+K];
[r4, re4, sc4] = RuthTableCalculator(p);
r4 

%% Problem 4b - select a value of K to yield oscillations
kOsc = -4;
p = [1 7 15 13 4+kOsc];
[r4, re4, sc4] = RuthTableCalculator(p);
r4 %% does not work - not marginal stability

kOsc = 1000/49;
p = [1 7 15 13 4+kOsc];
[r4, re4, sc4] = RuthTableCalculator(p);
r4 %% marginal stability 

%% Problem 5
p = [1 9 20 12 K];
[r5, re5, sc5] = RuthTableCalculator(p);
r5 

%% Problem 5b - select a value of K to yield oscillations
kOsc = 224/9;
p = [1 9 20 12 kOsc];
[r5, re5, sc5] = RuthTableCalculator(p);
r5

%% Problem 5b - select a value of K to yield oscillations
kOsc = 224/9;
p = [1 9 20 12 kOsc];
[r5, re5, sc5] = RuthTableCalculator(p);
r5


%% Problem 5c - find roots
syms s
expression = s^4 + 9*s^3 + 20*s^2 + 12*s + kOsc;
factoredExpression = factor(expression)
roots5c = roots(p)

%% Problem 7
p = [1 5.45+K 11.91+11*K 43.65+K];
[r7, re7, s7] = RuthTableCalculator(p);
r7 

kCritical = -0.31547;
e = 0.00001;
kUnstable = kCritical - e;
p = [1 5.45+kUnstable 11.91+11*kUnstable 43.65+kUnstable];
[r, re, sc7] = RuthTableCalculator(p);
sc7 %% 2 sign changes - unstable

kStable = kCritical + e;
p = [1 5.45+kStable 11.91+11*kStable 43.65+kStable];
[r, re, sc7] = RuthTableCalculator(p);
sc7  %% 0 sign changes - stable

diary off

