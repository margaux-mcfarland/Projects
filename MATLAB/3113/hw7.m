%% Problem 18-19
% Givens
k = 21; %[W/m·K]
rho = 8000; %[kg/m^3]
c_p = 570; %[J/kg·K]
h = 150; %[W/m^2·K]
L_c = 2e-2/2; %[m]
L = 3; %[m]
T_inf = 950; %[C]
T_i = 18; %[C]
Bi = h*L_c/k; %Biot number
b = h/(rho*c_p*L_c);
count = 1;
for V = [5:60]
    t = L/V;
    T_plate(count) = exp(-b*t)*(T_i-T_inf) + T_inf;
    count = count + 1;
end
V = [5:60];
plot(T_plate,V,'linewidth',2)
xlabel('Velocity [m/s]')
ylabel('T_{Plate} [\circC]')
title('Temperature vs velocity')
grid on