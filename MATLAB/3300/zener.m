%plot the measurements from lab 5

Vin = 1:1:10;
Vz = [0.986 1.99 2.99 3.99 4.95 5.42 5.49 5.5 5.54 5.55];
figure
plot(Vin, Vz)
title('Input Voltage vs measured Zener Voltage');
xlabel('Input Voltage (V)');
ylabel('Zener Voltage (V)');
grid on
hold on
yline(5.6,'--r');
legend('Measurements','V_z')