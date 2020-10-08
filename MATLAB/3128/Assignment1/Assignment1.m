%% ASEN 3128 - Assignment 01 - Main
%  Simulation of the translational dynamics of an aircraft.
%
%   Author: Margaux McFarland
%   Collaborators: Madison Dube, Laney Franklin
%   Date: 9/8/19

clc
clear all
close all


wind = 0:1:20;
%loop through different wind values to get different distances
for i = wind %m/s
%part a
    %initial conditions
    initials = [0 0 0 20 20 i 0];
    m_init = 0.03; %mass, [kg]
    t_span = [0 6]; %seconds
    %ode45 call
    %state vec = [dxdt; dydt; drag]
    [t,state_vec] = ode45(@(t,state_vec) g_fun(t,state_vec,m_init),t_span,initials);

    x = state_vec(:, 1);
    y = state_vec(:, 2);
    z = state_vec(:, 3);
    dxdt = state_vec(:, 4);
    dydt = state_vec(:, 5);
    dzdt = state_vec(:, 6);
    drag = state_vec(:, 7);
figure(1)
hold on
plot3(x, z, y);
zlim([0 20]);
ylim([0 50]);
xlim([0 70]);
view(-41, 35);
xlabel("Position to the East (m)")
ylabel("Position to the North (m)")
zlabel("Height (m)")
title("Trajectory of the golf ball with varying winds")
grid on

value = find(y<0);
maxDist(i+1) = x(value(1));
end

%part b
%find the sensitivity of the landing location based on wind
figure(2)
scatter(wind, maxDist);
P = polyfit(wind, maxDist, 1);
slope = P(1)
best_fit = P(1)*wind+P(2);  % P(1) is the slope and P(2) is the intercept
hold on;
plot(wind,best_fit,'r-.')
xlabel("winds [m/s]");
ylabel("max distance [m]");
title("Distance of golf ball as wind increases");
legend("actaul distances", "best fit line");

%part c
%loop through different mass values to get different distances
mass = 0:1:6;
for i = mass 
    %initial conditions
    m_init = i*0.01; %mass in kg
    initials = [0 0 0 20 20 0 0]; %wind is zero
    t_span = [0 6]; %seconds
    %ode45 call
    %state vec = [dxdt; dydt; drag]
    [t,state_vec] = ode45(@(t,state_vec) g_fun(t,state_vec, m_init),t_span,initials);

    x2 = state_vec(:, 1);
    y2 = state_vec(:, 2);
    
figure(3)
hold on
plot(x2,y2);
ylim([0 25]);
xlim([0 70]);
xlabel("Position to the East (m)");
ylabel("Height (m)");
title("Trajectory of the golf ball with varying mass");
grid on
legend("m = 0g", "m = 1g", "m = 2g", "m = 3g", "m = 4g", "m = 5g", "m = 6g");
end

%% g_fun
%This is the function called with ode45
%
% <include>g_fun.m<\include>
%
function ddt = g_fun(t,state_vec, m_init)

%unpack state vector
x = state_vec(1, 1); %position in east direction 
y = state_vec(2, 1); %position in the upward direction
z = state_vec(3, 1); %position in the north direction
dxdt = state_vec(4, 1); %inertial velocity in east direction
dydt = state_vec(5, 1); %inertial velocity in east direction
dzdt = state_vec(6, 1); %wind velcoity in the north direction (body frame)
drag = state_vec(7, 1); %drag

% ddt(1,1) = inertial velocity in east direction
% ddt(1,2) = inertial velocity in the upward direction
% ddt(1,3) = inertial velocity in the north direction
% ddt(1,4) = inertial acceleration in the east direction
% ddt(1,5) = inertial acceleration in the upward direction
% ddt(1,6) = inertial acceleration in the north direction
% ddt(1,7) = change in drag over time

%givens
m = m_init;
d = 0.03; %diameter, [m]
cod = 0.6; %coefficient of drag

%magnitude of the airspeed (given inetial velocity and wind)
v = sqrt(dxdt^2 + dydt^2 + dzdt^2);  
v_e = sqrt(dxdt^2 + dydt^2); %inertial velocity

%constants
area = pi*(d/2)^2; %reference area of golf ball
rho = 1.225; %density of air [kg/m^3]
g = -9.8; %gravity, m/s^2

f_d = -(1/2)*rho*cod*area*v^2;

theta = atan(dydt/dxdt); %angle of climb (radians)
xi = atan(dzdt/v_e); %azimuth (radians)
net_force_x = f_d*cos(theta);
net_force_y = f_d*sin(theta) + m*g;
net_force_z = f_d*sin(xi);
ddxdt = net_force_x/m;
ddydt = net_force_y/m;
ddzdt = net_force_z/m;

ddt = [dxdt; dydt; dzdt; ddxdt; ddydt; ddzdt; f_d];
end 
