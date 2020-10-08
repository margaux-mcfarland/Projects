%% Thermal Model for ARGOS PDR

clc;
clear all;
close all;

%% givens

sigma = 5.67e-8; %W/m2K4, Stefan-Boltzmann's constant
As = 50; %m2, surface area of fire (100m long, 1m average height)
A_rover = 0.5*0.3; %m2, front side surface area of rover
Ts1 = 1073; %K, surface temp of fire
emiss = 0.393; %emissivity of fire
h_conv = 2; %W/m2K, convection coefficient, in between free and forced convection
T_surr = 1072.995:0.001:1073; %K, surrounding temp
k_air = 0.026; %W/mK thermal conductivity 
alpha = 0.2:0.2:1;
%iterate through different distances to fire

x = 1:1:500; %m

figure(1)
for i = 1:1:5

%% heat transfer equations
q_conv = h_conv*As*(Ts1-288.15);
q_rad = emiss*sigma*As*(Ts1^4 - 288.15^4);
%inverse square law
q_rover = q_rad./(x.^2);
T_rover = ((288.15)^4 + (alpha(i)*q_rover)./(emiss*sigma*A_rover)).^(1/4);
q_total = q_conv + q_rad;

%Ts2 = T_surr(i) - (q_total.*x)./(k_air*As);

%% plot
plot(x, T_rover);
grid on
title('Temperature Rover Experiences vs Distance from Fire (Radiation Only)');
xlabel('Distance from Fire (m)');
ylabel('Temperature Surrounding Rover (K)');
hold on
end
%add a line for temperature most commercial products can withstand
yline(343.15, '--r'); %70 deg C
yline(433.15, '--b'); % melting pt for acrylic, 160 degC (HERMES)
yline(933.15, '--g'); % melting pt of aluminum, 660 degC(DRIFT)
legend('Absorptivity = 0.2','Absorptivity = 0.4','Absorptivity = 0.6','Absorptivity = 0.8','Absorptivity = 1',...
    'Commercial Temperature Limit', 'Melting Point of Acrylic (HERMES Body)', 'Melting Point of Aluminum (DRIFT body)')


%% some sources
% Flame Radiation Review - emmisivity
% https://onlinelibrary.wiley.com/doi/pdf/10.1002/9781118903117.app1

%Utah Wildfire Facts - temp of fire
%https://nhmu.utah.edu/sites/default/files/attachments/Wildfire%20FAQs.pdf

%inverse square law
%http://cfbt-us.com/wordpress/?tag=heat-transfer#:~:text=It%20is%20the%20ratio%20of,body%20at%20the%20same%20temperature.&text=Electromagnetic%20radiation%20spreads%20out%20as,as%20illustrated%20in%20Figure%205).

% use later for determining larger surface area of a fire
%https://link.springer.com/referenceworkentry/10.1007%2F978-3-319-51727-8_54-1

