t = 0:.001:1;
x_t = 0.4 * sin(2.5 * t);
y_t = 0.4 * (cos(-2.5 * t) - 1);

plot(x_t, y_t);
xlim([0 1])
ylim([-1 0])

title('Controls: [1,-45 deg]');
xlabel('p_x');
ylabel('p_y');
grid on;