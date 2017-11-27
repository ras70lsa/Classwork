%% Initialize workspace
clear; format short e;
figure(1); clf; figure(2); clf

%% Activate handles and globals
MakeNoiseHandles;

%% Set run time and number of points
Trun = 10;
Npts = floor(Trun / Ts)

%% Gather data using the dSpace card
% Change switch to make noise
mlib('Write', SWITCH, 'Data', 4)
% Prime ADC1 and ADC2 to take samples and fetch data
mlib('Set','TraceVars',[ADC1; ADC2],'NumSamples',Npts);
mlib('StartCapture')
while mlib('CaptureState')~=0
end
data=mlib('FetchData');
% Extract and recenter data
ch1=(data(1,:)-mean(data(1,:)))';
ch2=(data(2,:)-mean(data(2,:)))';
% Turn off noise
% Change switch to turn off noise
mlib('Write', SWITCH, 'Data', 1)

%% Generate TF estimate
[EstAccTF,EstAccF] = tfestimate(ch2,ch1,[],[],[],SR);
%% Remove 0 frequency due to division later...
EstAccTF = EstAccTF(2:end);
EstAccF  = EstAccF(2:end);
%% Split into component parts
EstAccMag   = abs(EstAccTF);
EstAccPhase = angle(EstAccTF);
EstAccOmega = EstAccF*2*pi;

%% Generate Plots
% Time Domain plot
time = 0:Ts:(Trun-Ts);
figure(1);
INC = floor(Npts/1000);
plot(time(1:INC:end),ch1(1:INC:end),...
     time(1:INC:end),ch2(1:INC:end));
xlabel('Time (s)')
ylabel('Measured Voltage (V)')
title('Time Domain Plot')
legend('Ch1','Ch2', 0)
% Transfer Function plot
figure(2)
semilogx(EstAccOmega, (20*log10(EstAccMag)))
xlabel('Angular Frequency (rad/s)')
ylabel('|H| (dB)')
title('Transfer Function Estimate')

%% Note about saving data
fprintf('\n If you wish to save your data \n')
fprintf('\n Use ''save FILENAME ch1 ch2 time EstAccTF EstAccF''\n');
