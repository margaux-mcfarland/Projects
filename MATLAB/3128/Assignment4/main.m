%% ASEN 3128 - Assignment 04 - Main
%  Simulation of a quad-copter, implementing feedback control
%
%   Author: Margaux McFarland
%   Date: 10/3/19

clc
clear all
close all

%% Part 2 - control law with linearized model

g_b = -9.81; %m/s^2
m = 0.068; %kg
%controls
f1 = (-g_b*m)/4;
f2 = (-g_b*m)/4;
f3 = (-g_b*m)/4;
f4 = (-g_b*m)/4;

%%%%%%%%%% deviation in roll rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0.1; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials2 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec2] = ode45(@(t,state_vec2) g_fun(t,state_vec2, f1, f2, f3, f4),t_span,initials2);


x2 = state_vec2(:, 1);
y2 = state_vec2(:, 2);
z2 = state_vec2(:, 3);
p = state_vec2(: ,10);

%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);

figure(1);
subplot(2, 2, 3);
plot3(x2, y2, z2);
hold on 
plot3(x2(index),y2(index),z2(index), 'r*');
title('Linearized Model: +0.1 rad/s roll rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%plot the roll rate
figure(2)
subplot(4, 1, 3);
plot(t,p);
hold on 
plot(t(index), p(index), 'r*');
title('Linearized Roll Rate over time +0.1 rad/s');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%%%%%%%%%% deviation in pitch rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0.1; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials2 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec2] = ode45(@(t,state_vec2) g_fun(t,state_vec2, f1, f2, f3, f4),t_span,initials2);

x2 = state_vec2(:, 1);
y2 = state_vec2(:, 2);
z2 = state_vec2(:, 3);

figure(1);
subplot(2, 2, 4);
plot3(x2, y2, z2);
%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);
hold on 
plot3(x2(index),y2(index),z2(index), 'r*')
title('Linearized Model: +0.1 rad/s pitch rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

q = state_vec2(:, 11);

%plot the pitch rate
figure(2)
subplot(4, 1, 4);
plot(t,q);
hold on 
plot(t(index), q(index), 'r*');
title('Linearized Pitch Rate over time +0.1 rad/s');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%%%%%%%%%% deviation in bank %%%%%%%%%%%%%%%
phi_dev = deg2rad(5); %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s


%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials2 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec2] = ode45(@(t,state_vec2) g_fun(t,state_vec2, f1, f2, f3, f4),t_span,initials2);


x2 = state_vec2(:, 1);
y2 = state_vec2(:, 2);
z2 = state_vec2(:, 3);

figure(1);
subplot(2, 2, 2);
plot3(x2, y2, z2);
%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);
hold on 
plot3(x2(index),y2(index),z2(index), 'r*')
title('Linearized Model: +5 deg bank');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

phi = state_vec2(:, 4);

%plot the bank
figure(2)
subplot(4, 1, 1);
plot(t,phi);
hold on 
plot(t(index), phi(index), 'r*');
title('Linearized Bank over time +5 degrees');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%%%%%%%%%% deviation in pitch %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = deg2rad(5); %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials2 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec2] = ode45(@(t,state_vec2) g_fun(t,state_vec2, f1, f2, f3, f4),t_span,initials2);

x2 = state_vec2(:, 1);
y2 = state_vec2(:, 2);
z2 = state_vec2(:, 3);

figure(1);
subplot(2, 2, 1);
plot3(x2, y2, z2);
%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);
hold on 
plot3(x2(index),y2(index),z2(index), 'r*')
title('Linearized Model: +5 deg pitch');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

theta = state_vec2(:, 5);

%plot the elevation
figure(2)
subplot(4, 1, 2);
plot(t,theta);
hold on 
plot(t(index), theta(index), 'r*');
title('Linearized Pitch over time +5 degrees');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%% Part 3 - control law with non-linearized model

%%%%%%%%%% deviation in roll rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0.1; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun2(t,state_vec, f1, f2, f3, f4),t_span,initials);


x = state_vec(:, 1);
y = state_vec(:, 2);
z = state_vec(:, 3);
p = state_vec(: ,10);

%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);

figure(3);
subplot(2, 2, 3);
plot3(x, y, z);
hold on 
plot3(x(index),y(index),z(index), 'r*');
title('Non-Linearized Model: +0.1 rad/s roll rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%plot the roll rate
figure(4)
subplot(4, 1, 3);
plot(t,p);
hold on 
plot(t(index), p(index), 'r*');
title('Non-linearized Roll Rate over time +0.1 rad/s');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%%%%%%%%%% deviation in pitch rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0.1; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun2(t,state_vec, f1, f2, f3, f4),t_span,initials);

x = state_vec(:, 1);
y = state_vec(:, 2);
z = state_vec(:, 3);

figure(3);
subplot(2, 2, 4);
plot3(x, y, z);
%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);
hold on 
plot3(x(index),y(index),z(index), 'r*')
title('Non-Linearized Model: +0.1 rad/s pitch rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

q = state_vec(:, 11);

%plot the pitch rate
figure(4)
subplot(4, 1, 4);
plot(t,q);
hold on 
plot(t(index), q(index), 'r*');
title('Non-linearized Pitch Rate over time +0.1 rad/s');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%%%%%%%%%% deviation in bank %%%%%%%%%%%%%%%
phi_dev = deg2rad(5); %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s


%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun2(t,state_vec, f1, f2, f3, f4),t_span,initials);


x = state_vec(:, 1);
y = state_vec(:, 2);
z = state_vec(:, 3);

figure(3);
subplot(2, 2, 2);
plot3(x, y, z);
%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);
hold on 
plot3(x(index),y(index),z(index), 'r*')
title('Non-Linearized Model: +5 deg bank');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

phi = state_vec(:, 4);

%plot the bank
figure(4)
subplot(4, 1, 1);
plot(t,phi);
hold on 
plot(t(index), phi(index), 'r*');
title('Non-linearized Bank over time +5 degrees');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%%%%%%%%%% deviation in pitch %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = deg2rad(5); %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun2(t,state_vec, f1, f2, f3, f4),t_span,initials);

x = state_vec(:, 1);
y = state_vec(:, 2);
z = state_vec(:, 3);

figure(3);
subplot(2, 2, 1);
plot3(x, y, z);
%find index at 0.5 seconds (time constant)
index = find(t >= 0.5, 1);
hold on 
plot3(x(index),y(index),z(index), 'r*')
title('Non-Linearized Model: +5 deg pitch');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

theta = state_vec(:, 5);

%plot the elevation
figure(4)
subplot(4, 1, 2);
plot(t,theta);
hold on 
plot(t(index), theta(index), 'r*');
title('Non-linearized Pitch over time +5 degrees');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%% Part 4 - Rolling Spider Quad Copter

%load data
load('RSdata_two_1530.mat');
times=rt_estimatedStates.time(:);
xdata=rt_estimatedStates.signals.values(:,1);
ydata=rt_estimatedStates.signals.values(:,2);
zdata=rt_estimatedStates.signals.values(:,3);
figure(5);
plot3(xdata, ydata, zdata);
title("Trajectory of Rolling Spider (w/ feedback control)");
xlabel("x (m)");
ylabel("y (m)");
zlabel("z (m)");
grid on

%get bank, pitch, roll rate, pitch rate at 2 seconds
index = find(times >= 2, 1);
phi_data = rt_estimatedStates.signals.values(:,6);
theta_data = rt_estimatedStates.signals.values(:,5);
p_data = rt_estimatedStates.signals.values(:,10);
q_data = rt_estimatedStates.signals.values(:,11);


%plot the bank
figure(6)
subplot(4, 1, 1);
plot(times,phi_data);
hold on 
plot(times(index), phi_data(index), 'r*');
title('Rolling Spider Bank over time +5 degrees');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%plot the elevation
figure(6)
subplot(4, 1, 2);
plot(times,theta_data);
hold on 
plot(times(index), theta_data(index), 'r*');
title('Rolling Spider Pitch over time +5 degrees');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%plot the roll rate
figure(6)
subplot(4, 1, 3);
plot(times,p_data);
hold on 
plot(times(index), p_data(index), 'r*');
title('Rolling Spider Roll Rate over time +0.1 rad/s');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%plot the pitch rate
figure(6)
subplot(4, 1, 4);
plot(times,q_data);
hold on 
plot(times(index), q_data(index), 'r*');
title('Rolling Spider Pitch Rate over time +0.1 rad/s');
xlabel('time (s)');
ylabel('roll rate (rad/s)');
grid on

%% other functions
%This is the function called with ode45
%
% <include>g_fun.m<\include>
%
function ddt = g_fun(t,state_vec, f1, f2, f3, f4)
%% ode function for part 1/2 (linearized, with control law)

%givens
m = 0.068; %kg
rad = 0.06; %m
Ix = 6.8e-5; %kgm^2
Iy = 9.2e-5; %kgm^2
Iz = 1.35e-4; %kgm^2
g_b = [0; 0; -9.81]; %m/s^2
k = 0.0024; %Nm/N

%gains
K1 = 12*Ix; % controls roll rate
K2 = 20*Ix; % controls bank
K3 = 12*Iy; % controls pitch rate
K4 = 20*Iy; % controls elevation
K5 = 0.004; %Nm/(rad/s) 

%unpack state vector - all state variables are equal to their deviations in
%steady hover
x_dev = state_vec(1, 1);
y_dev = state_vec(2, 1);
z_dev = state_vec(3, 1);
phi_dev = state_vec(4, 1);
theta_dev = state_vec(5, 1);
xi_dev = state_vec(6, 1);
u_dev = state_vec(7, 1);
v_dev = state_vec(8, 1);
w_dev = state_vec(9, 1);
p_dev = state_vec(10, 1);
q_dev = state_vec(11, 1);
r_dev = state_vec(12, 1);

%deviations
f1_dev = 0;
f2_dev = 0;
f3_dev = 0;
f4_dev = 0;

Lc_dev = -K1*p_dev - K2*phi_dev;
Mc_dev = -K3*q_dev - K4*theta_dev;
Nc_dev = -K5*r_dev;
Zc_dev = (f1_dev + f2_dev + f3_dev + f4_dev);

% longitudinal
dq_dev = (1/Iy)*Mc_dev;
dtheta_dev = q_dev;
du_dev = g_b(3)*theta_dev;
% lateral
dp_dev = (1/Ix)*Lc_dev;
dphi_dev = p_dev;
dv_dev = -g_b(3)*phi_dev;
% azimuth
dr_dev = (1/Iz)*Nc_dev;
% vertical
dw_dev = (1/m)*Zc_dev;

Zc = Zc_dev + (f1 + f2 + f3 + f4)*(cos(theta_dev)*cos(phi_dev)); %N


ddt = [u_dev; v_dev; w_dev; p_dev; q_dev; r_dev; du_dev; dv_dev; dw_dev + Zc + m*g_b(3); dp_dev; dq_dev; dr_dev];

end
%
% <include>g_fun2.m<\include>
%
function ddt = g_fun2(t,state_vec, f1, f2, f3, f4)
%% ode function for part 2 (non-linearized)

%givens
m = 0.068; %kg
rad = 0.06; %m
Ix = 6.8e-5; %kgm^2
Iy = 9.2e-5; %kgm^2
Iz = 1.35e-4; %kgm^2
g_b = [0; 0; -9.81]; %m/s^2
k = 0.0024; %Nm/N

%gains
K1 = 12*Ix; % controls roll rate
K2 = 20*Ix; % controls bank
K3 = 12*Iy; % controls pitch rate
K4 = 20*Iy; % controls elevation
K5 = 0.004; %Nm/(rad/s)

%unpack state vector
x = state_vec(1, 1);
y = state_vec(2, 1);
z = state_vec(3, 1);
phi = state_vec(4, 1);
theta = state_vec(5, 1);
xi = state_vec(6, 1);
u = state_vec(7, 1);
v = state_vec(8, 1);
w = state_vec(9, 1);
p = state_vec(10, 1);
q = state_vec(11, 1);
r = state_vec(12, 1);

%forces
Xc = (f1 + f2 + f3 + f4)*-sin(theta);
Yc = (f1 + f2 + f3 + f4)*sin(phi)*cos(theta);
Zc = (f1 + f2 + f3 + f4)*(cos(theta)*cos(phi)); %N
n = 1e-3; %N/(m/s)^2
Xa = -n*sqrt(u^2 + v^2 + w^2)*u;%N
Ya = -n*sqrt(u^2 + v^2 + w^2)*v;%N
Za = -n*sqrt(u^2 + v^2 + w^2)*w;%N
A_a = [Xa; Ya; Za]; %aerodynamic
A_c = [Xc; Yc; Zc]; %controls
f_b = m.*g_b + A_a + A_c; %net force in body frame cooridinates

%moments
Lc = -K1*p - (K2*phi); %Nm
Mc = -K3*q - (K4*theta);
Nc = -K5*r;
alpha = 2e-6; %Nm/(rad/s)^2
La = -alpha*sqrt(p^2 + q^2 + r^2)*p; %Nm
Ma = -alpha*sqrt(p^2 + q^2 + r^2)*q; %Nm
Na = -alpha*sqrt(p^2 + q^2 + r^2)*r; %Nm
G_ab = [La; Ma; Na]; %aerodynamic
G_cb = [Lc; Mc; Nc]; %controls
G_b = G_ab + G_cb; %net moment about cg in body frame coordinates


du = f_b(1)/m;
dv = f_b(2)/m;
dw = f_b(3)/m;
dp = (-((q*Iz*r) - (r*Iy*q)) + G_b(1))/Ix;
dq = (((p*Iz*r) - (r*Ix*p)) + G_b(2))/Iy;
dr = (-((p*Iy*q) - (q*Ix*p)) + G_b(3))/Iz;


ddt = [u; v; w; p; q; r; du; dv; dw; dp; dq; dr];
end
