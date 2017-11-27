clf;
sys = tf([1 2.1],[1 3 7 10])
step(sys)
hold on;
k = 12
sys2 = tf([1],[1 1 5])
step(sys2)

clf;
sys = tf([1],[1 1 5])
step(sys)
hold on;
K = 1
sys2 = tf([K -K],[1 1 5])
step(sys2)

