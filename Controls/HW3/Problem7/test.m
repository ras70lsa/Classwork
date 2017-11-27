sysa = tf([1 2],[1 3 36])
sysa2 = tf([2],[1 3 36])
impulse(sysa)
hold on;
impulse(sysa2)
hold off;

figure(2)
sysb = tf([1 10],[1 3 36])
sysb2 = tf([10],[1 3 36])
impulse(sysb)
hold on;
impulse(sysb2)
hold off;

figure(3)
sysc = tf([1 -10],[1 3 36])
sysc2 = tf([-10],[1 3 36])
impulse(sysc)
hold on;
impulse(sysc2)
hold off;
