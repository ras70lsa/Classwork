%% Initialize workspace
clear ; format short e
%% Load global variables
MotorConstants1841
%% Open the Simulink model
ModelName = 'ClosedLoopMotor';
open_system(ModelName);

%% Change values and save
set_param ([ ModelName '/DesSpeedFcn'] , 'Expression', '100*u')
set_param ([ ModelName '/KP'] , 'Gain', '10')
save_system ( ModelName )

%% Run simulation
sim(ModelName)


%% Plot
figure(1); clf;
plot(t, Omega, 'k--', t, OmegaDes, 'r');
title('Shaft Speed vs. Time for 1841 (K=10) - Ramp Input');
legend('Motor speed', 'Desired Speed');
xlabel('Time (s)');
ylabel('Angular Speed (rad/s)');
ylim([0, 110])

ess = ( OmegaDes ( end )- Omega ( end )) / OmegaDes ( end )