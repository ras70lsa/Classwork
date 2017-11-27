knn = [.1, .2, .3, .5, .7, .9]; 
sample = [176, 58, 60, 64, 70, 56];
EC = [350, 114, 118, 126, 138, 110];
path = [25, 10, 8, 4,4,4];

hold off;
plot(knn, sample);
hold on;
plot(knn, EC);
plot(knn, path);
legend('milestone samples', 'edges connected','milestones in path');
xlabel('connection threshold');
ylabel('#');
title('Connection threshold (r=0.2)');