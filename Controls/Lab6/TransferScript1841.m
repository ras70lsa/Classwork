%% Initialize workspace
clear; format short e;
%% Load motor constants variables
MotorConstants1841

s = tf('s');

Gpos = (Kt)/(s* ((Jm*s + Dm) * (La*s + Ra) + Kt * Kb ))

figure(1); clf;
tModel = linspace (0 , 0.270 , 1000);
eModel = (6).*( tModel >=0);
OmegaModel = lsim (s * Gpos , eModel , tModel );
plot ( tModel , OmegaModel , 'k - ');
ylabel (' Angular Velocity ( rad /s) ');
title (' 6 Volt Step Response of Velocity for Faulhaber 1841 '); 

w_max = max(OmegaModel); %% 183.28 (At 1V)
0.632 * w_max %% 115.83 (At 1V) 

%% Pulse Train Response 
figure (2); clf
NP = 1000; AMP = 6; T = 0.4; DC = 0.75;
tModel = linspace (0 , 1.2 , NP );
eModel = AMP *( mod ( tModel , T) <( DC *T ));
OmegaModel = lsim (s * Gpos , eModel , tModel );
subplot (2 ,1 ,1)
plot ( tModel , OmegaModel , 'k - ')
axis ([0.0 1.2 0.0 1.1* max(OmegaModel)])
xlabel (' Time (s ) '); ylabel (' Angular Velocity ( rad /s) ')
title (' Pulse Train Response of Velocity for Faulhaber 1841 ')
subplot (2 ,1 ,2)
plot ( tModel , eModel , 'k - ')
axis ([0.0 1.2 -1.0 7.0])
xlabel (' Time (s ) '); 
ylabel (' Input Voltage (V) ');