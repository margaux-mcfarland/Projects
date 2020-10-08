%% ASEN 2012 PROJECT 2
%The purpose of this program is to determine the trajectory of a bottle
%rocket with varying paratmeters such as launch angle, intial height, test
%stand length, volume of the bottle, initial volume of air, gage pressure,
%intial temperature, diameter of the bottle and diameter of the throat. 
%This program outputs the trajectory of the bottle in a plot of height vs distance. 
%Assumptions: no wind (all parameters act in 2-D plane), air inside the bottle
%expands isentropically.
%Authors: Margaux McFarland (107731341)
%           Braden Campbell (107523915)
%Date Created: 11/24/18
%Date Modified: 11/30/18

%% constants for verification test
g = 9.81; %m/s/s
C_d = 0.8; %discharge coefficient
rho_air = 0.961; %kg/m^3
rho_water = 1000; %kg/m^3
vol_bottle = 0.002; %m^3
P_amb = 12.1; %psi
gamma = 1.4; %ratio of specific heats for air
D_throat = 2.1; %cm
D_bottle = 10.5; %cm
R = 287; %J/kg*K
M_bottle = 0.15; %kg
C_D = 0.5; %drag coefficient
P_gage = 50; %psi
vol_water_init = 0.001; %m^3
T_air_init = 300; %K
v_0 = 0.0; %m/s
theta = 45; %degrees
x0 = 0.0; %m
y0 = 0.25; %m
l_s = 0.5; %m %length of test stand

%% constants for test case
% g = 9.81; %m/s/s
% C_d = 0.8; %discharge coefficient
% rho_air = 0.961; %kg/m^3
% rho_water = 1000; %kg/m^3
% vol_bottle = 0.002; %m^3
% P_amb = 12.1; %psi
% gamma = 1.4; %ratio of specific heats for air
% D_throat = 2.1; %cm
% D_bottle = 10.5; %cm
% R = 287; %J/kg*K
% M_bottle = 0.15; %kg
% C_D = 0.5; %drag coefficient
% P_gage = 62; %psi
% vol_water_init = 0.00042; %m^3
% T_air_init = 300; %K
% v_0 = 0.0; %m/s
% theta = 47; %degrees
% x0 = 0.0; %m
% y0 = 0.25; %m
% l_s = 0.5; %m %length of test stand

t_span = [0 6]; %seconds

%convert units SI
P_amb = P_amb*6894.76; %Pa
D_throat = D_throat/100; %m
D_bottle = D_bottle/100; %m
P_gage = P_gage*6894.76; %Pa

%areas
A_throat = pi*(D_throat/2)^2;
A_bottle = pi*(D_bottle/2)^2;

%initial conditions
vol_0 = vol_bottle-vol_water_init;
p_0 = P_amb+P_gage;
%m0 = (p_0/(R*T_air_init))*vol_0;
%initial mass of rocket
m0 = M_bottle+(rho_water*(vol_bottle-vol_0))+(p_0/(R*T_air_init))*vol_0;

%thrust 
global F_thrust F_time
F_thrust = 0;
F_time = 0;

initials = [vol_0,m0,x0,y0,0,0,p_0];
options = odeset('RelTol',1e-8);
[t,state_vec] = ode45(@(t,state_vec) g_fun(t,state_vec),t_span,initials,options);

vol = state_vec(:,1); % air volume over time
m = state_vec(:,2); %mass of air in bottle over time
x = state_vec(:,3); %horizontal position over time
y = state_vec(:,4); %vertical position over time

dxdt = state_vec(:,5); %horizontal velocity component over time
dydt = state_vec(:,6); %vertical velocity component over time
p = state_vec(:,7);


figure(1)
%plot thrust
plot(sort(F_time),F_thrust);
grid on
xlabel('Time (s)');
ylabel('Thrust (N)');
xlim([0 0.45]);
ylim([0 300]);

%trajectory
figure(2)
plot(x,y);
grid on;
title('Height vs Distance');
xlabel('Distance (m)');
ylabel('Height (m)');
xlim([0 80]);
ylim([0 40]);

%find max distance and max height
value = find(y<0);
maxDist = x(value(1))
maxHeight = max(y)


