%% ASEN 3128 - Assignment 03 - Main
%  Simulation of a quad-copter, including linearization model
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 9/26/19

clc
clear all
close all

%% Part 2 - non-linearized version
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
initials = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun2(t,state_vec, f1, f2, f3, f4),t_span,initials);

x = state_vec(:, 1);
y = state_vec(:, 2);
z = state_vec(:, 3);

figure(1);
subplot(3, 2, 4);
plot3(x, y, z, 'r*');
title('Non-linearized Model: +0.1 rad/s roll rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
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

figure(1);
subplot(3, 2, 5);
plot3(x, y, z, 'r*');
title('Non-linearized Model: +0.1 rad/s pitch rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%%%%%%%%%% deviation in yaw rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0.1; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun2(t,state_vec, f1, f2, f3, f4),t_span,initials);

x = state_vec(:, 1);
y = state_vec(:, 2);
z = state_vec(:, 3);

figure(1);
subplot(3, 2, 6);
plot3(x, y, z, 'r*');
title('Non-linearized Model: +0.1 rad/s yaw rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
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

figure(1);
subplot(3, 2, 1);
plot3(x, y, z, 'r*');
title('Non-linearized Model: +5 deg bank');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
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

figure(1);
subplot(3, 2, 2);
plot3(x, y, z, 'r*');
title('Non-linearized Model: +5 deg pitch');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%%%%%%%%%% deviation in azimuth %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = deg2rad(5); %azimuth, radians
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

figure(1);
subplot(3, 2, 3);
plot3(x, y, z, 'r*');
title('Non-linearized Model: +5 deg azimuth');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on
%% Part 3 - linearized version

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

figure(2);
subplot(3, 2, 4);
plot3(x2, y2, z2, 'r*');
title('Linearized Model: +0.1 rad/s roll rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
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

figure(2);
subplot(3, 2, 5);
plot3(x2, y2, z2, 'r*');
title('Linearized Model: +0.1 rad/s pitch rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%%%%%%%%%% deviation in yaw rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0.1; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials2 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec2] = ode45(@(t,state_vec2) g_fun(t,state_vec2, f1, f2, f3, f4),t_span,initials2);

x2 = state_vec2(:, 1);
y2 = state_vec2(:, 2);
z2 = state_vec2(:, 3);

figure(2);
subplot(3, 2, 6);
plot3(x2, y2, z2, 'r*');
title('Linearized Model: +0.1 rad/s yaw rate');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
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

figure(2);
subplot(3, 2, 1);
plot3(x2, y2, z2, 'r*');
title('Linearized Model: +5 deg bank');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
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

figure(2);
subplot(3, 2, 2);
plot3(x2, y2, z2, 'r*');
title('Linearized Model: +5 deg pitch');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%%%%%%%%%% deviation in azimuth %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = deg2rad(5); %azimuth, radians
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

figure(2);
subplot(3, 2, 3);
plot3(x2, y2, z2, 'r*');
title('Linearized Model: +5 deg azimuth');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%% Part 4 - control law 

%gain
k = 0.004;

%%%%%%%%%% deviation in pitch rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0.1; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials3 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec3] = ode45(@(t,state_vec3) g_fun3(t,state_vec3, f1, f2, f3, f4,k),t_span,initials3);

x3 = state_vec3(:, 1);
y3 = state_vec3(:, 2);
z3 = state_vec3(:, 3);

figure(3);
subplot(3, 1, 1);
plot3(x3, y3, z3, 'r*');
title('Linearized Model of the Trajectory of the Quadcopter (deviation by +0.1 rad/s roll rate)');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%%%%%%%%%% deviation in pitch rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0.1; %pitch rate, rad/s
r_dev = 0; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials3 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec3] = ode45(@(t,state_vec3) g_fun3(t,state_vec3, f1, f2, f3, f4, k),t_span,initials3);

x3 = state_vec3(:, 1);
y3 = state_vec3(:, 2);
z3 = state_vec3(:, 3);

figure(3);
subplot(3, 1, 2);
plot3(x3, y3, z3, 'r*');
title('Linearized Model of the Trajectory of the Quadcopter (deviation by +0.1 rad/s pitch rate)');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on

%%%%%%%%%% deviation in yaw rate %%%%%%%%%%%%%%%
phi_dev = 0; %bank, radians
theta_dev = 0; %pitch, radians
xi_dev = 0; %azimuth, radians
p_dev = 0; %roll rate, rad/s
q_dev = 0; %pitch rate, rad/s
r_dev = 0.1; %yaw rate, rad/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials3 = [0 0 0 phi_dev theta_dev xi_dev 0 0 0 p_dev q_dev r_dev];
t_span = [0 5]; %seconds
[t, state_vec3] = ode45(@(t,state_vec3) g_fun3(t,state_vec3, f1, f2, f3, f4, k),t_span,initials2);

x3 = state_vec3(:, 1);
y3 = state_vec3(:, 2);
z3 = state_vec3(:, 3);

figure(3);
subplot(3, 1, 3);
plot3(x3, y3, z3, 'r*');
title('Linearized Model of the Trajectory of the Quadcopter (deviation by +0.1 rad/s yaw rate)');
xlabel('North (m)');
ylabel('East (m)');
zlabel('Down (m)');
grid on
%% Part 5 - control law on spider

%load data
load('RSdata_White_Assignemnt_Gains.mat');
times=rt_estim.time(:);
xdata=rt_estim.signals.values(:,1);
ydata=rt_estim.signals.values(:,2);
zdata=rt_estim.signals.values(:,3);
figure(4);
subplot(2, 1, 1);
plot3(xdata, ydata, zdata);
title("Trajectory of PARROT spider (w/ feedback control)");
xlabel("x (m)");
ylabel("y (m)");
zlabel("z (m)");
grid on

%plots from hardware demo (assignment 2, no feedback control)
load RSdata_White_1433.mat
times=rt_estim.time(:);
xdata=rt_estim.signals.values(:,1);
ydata=rt_estim.signals.values(:,2);
zdata=rt_estim.signals.values(:,3);
subplot(2, 1, 2);
plot3(xdata, ydata, zdata);
title("Trajectory of PARROT spider (no feedback control)");
xlabel("x (m)");
ylabel("y (m)");
zlabel("z (m)");
grid on

%% other functions
%This is the function called with ode45
%
% <include>g_fun2.m<\include>
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
Lc = (rad/sqrt(2))*(f1 + f2 - f3 - f4); %Nm
Mc = (rad/sqrt(2))*(-f1 + f2 + f3 - f4);
Nc = k*(f1 - f2 + f3 - f4);
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
% <include>g_fun.m<\include>
function ddt = g_fun(t,state_vec, f1, f2, f3, f4)
%% ode function for part 3 (linearized)

%givens
m = 0.068; %kg
rad = 0.06; %m
Ix = 6.8e-5; %kgm^2
Iy = 9.2e-5; %kgm^2
Iz = 1.35e-4; %kgm^2
g_b = [0; 0; -9.81]; %m/s^2
k = 0.0024; %Nm/N

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

Lc_dev = (rad/sqrt(2))*(f1_dev + f2_dev + f3_dev + f4_dev);
Mc_dev = (rad/sqrt(2))*(-f1_dev + f2_dev + f3_dev - f4_dev);
Nc_dev = (rad/sqrt(2))*(f1_dev - f2_dev + f3_dev - f4_dev);
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
% <include>g_fun3.m<\include>
function ddt = g_fun3(t,state_vec, f1, f2, f3, f4, gain)
%% ode function for part 4 (non-linearized w/ control law)

%givens
m = 0.068; %kg
rad = 0.06; %m
Ix = 6.8e-5; %kgm^2
Iy = 9.2e-5; %kgm^2
Iz = 1.35e-4; %kgm^2
g_b = [0; 0; -9.81]; %m/s^2
k = 0.0024; %Nm/N


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
Lc = -gain*sqrt(p^2 + q^2 + r^2)*p; %Nm
Mc = -gain*sqrt(p^2 + q^2 + r^2)*q;
Nc = -gain*sqrt(p^2 + q^2 + r^2)*r;
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
