function sysChar(p)
% check input
if length(p) ~= 3
    fprintf('Usage: second-order polynomial coefficients\n');
    fprintf('Input has length %d\n', length(p));
    return
end

% print input
fprintf('Polynomial is %d*s^2 + %d*s + %d\n', p(1), p(2), p(3));

% Normalize the polynomial 
a = 1;
b = p(2)/p(1);
c = p(3)/p(1);
% calculate zeta and omega

omn = sqrt(c);
z = b/(2 * omn);
fprintf('%8s: %10.2e rad/s\n', 'om_n', omn);
fprintf('%8s: %10.4f\n', 'zeta', z);

oTr = 1.76 * z^3 - 0.417 * z^2 + 1.039 * z + 1;

% rise time
Tr = oTr / omn;
fprintf('%8s: %10.2e s\n', 'Tr', Tr);

% peak time
Tp = pi/(omn * sqrt(1 - z^2));
fprintf('%8s: %10.2e s\n', 'Tp', Tp);

% settling time
Ts = 4/(z * omn);
fprintf('%8s: %10.2e s\n', 'Ts', Ts);

% percent overshoot
pOS = exp(-((z * pi)/(sqrt(1 - z^2)))) * 100;
fprintf('%8s: %10.2f %%\n', '% OS', pOS);
end