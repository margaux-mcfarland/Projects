function u = calcTemp(N, bn, lam, x, alpha, t, T0, H, hold)
% this function calculates the temperature over time of the rod. It also
% plots the temperature over time
%summation
sum = 0;
for i = 1:N
    sum = sum + bn*sin(lam.*x)*exp(-lam^2*alpha.*t);
end

%add steady state and transient state
u = T0 + H*x + sum;

%plot
figure
plot(t, u);
grid on
xlabel("Time (s)");
ylabel("Temperature (deg C)");
str = sprintf("Temperature at a point on the rod vs time (up to %fs)",max(t));
title(str);

end