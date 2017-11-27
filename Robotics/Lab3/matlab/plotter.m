% CT = [0.1, 0.2, .3, .5, .7, .9]; 
% time = [0.2685, 0.1997, 0.0911, 0.1120, 0.1328, 0.1137];
% 
% plot(CT, time);
% xlabel('Connection Threshold');
% ylabel('Time (s)');
% title('Time vs Connection Threshold');

PT = [0.01, 0.05, 0.1, .4, .9]; 
sample = [1114, 181, 147, 117, 221];
EC = [2226, 360, 292, 232, 440];
path = [174, 35, 19, 12,17];

hold off; 
plot(PT, sample);
hold on;
plot(PT, EC);
plot(PT, path);
legend('milestone samples', 'edges connected','milestones in path');
xlabel('Perturbation  Threshold');
ylabel('#');
title('Perturbation Threshold');