%% Initialize workspace
clear; format short e;

%% Sets global parameters
global Ts SR

% Defines sampling rate and - more importantly - sample time
SR = 10000;
Ts = 1/SR;

%% Opens and builds Simulink Model on dSpace
ModelName = 'MakeNoise'
open_system(ModelName)
rtwbuild(ModelName)