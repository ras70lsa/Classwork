%% Initialize workspace
clear ; format short e
%% Load global variables
MotorConstants1624
%% Open the Simulink model
ModelName = 'OpenLoopMotor';
open_system(ModelName);

%% Change values and save
set_param ([ ModelName '/DesSpeedFcn'] , 'Expression', '100')
save_system ( ModelName )

%% Run simulation
sim(ModelName)


%% Plot
figure(1); clf
plot(t, Omega, 'k--', t, OmegaDes, 'r');
title('Shaft Speed vs. Time for 1642 (mrg)');
legend('Motor speed', 'Desired Speed');
xlabel('Time (s)');
ylabel('Angular Speed (rad/s)');