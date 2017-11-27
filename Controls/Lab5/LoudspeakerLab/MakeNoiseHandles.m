%% Select the board
mlib('SelectBoard', 'ds1104');

%% Define global variables for measurement and output channels
global ADC1 ADC2 DAC1 SWITCH
global Ts SR

%% Create handles to relevant blocks
ADC1   = mlib('GetTrcVar', 'Model Root/ADC1/In1');
ADC2   = mlib('GetTrcVar', 'Model Root/ADC2/In1');
DAC1   = mlib('GetTrcVar', 'Model Root/DAC1/In1');
SWITCH = mlib('GetTrcVar', 'Model Root/SwitchPos/Value');