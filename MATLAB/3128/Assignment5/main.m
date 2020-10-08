%% ASEN 3128 - Assignment 05 - Main
%  Simulation of a mambo quad-copter, implementing feedback control
%
%   Author: Margaux McFarland
%   Date: 10/8/19

clc
clear all
close all

%givens
g = 9.81; %m/s^2
Ix = 5.8e-5; %kgm^2
Iy = 7.2e-5; %kgm^2
Iz = 1.0e-4; %kgm^2

%% lateral
%gains
K1 = 22*Ix
K2 = 40*Ix
N = 300;
K3 = Ix.*linspace(825,840,N); %keep trying different ranges until real eigenvalues are found
for i = 1:N
    % A matrix
    A = [-K1/Ix, -K2/Ix, -(K3(i)*K2)/Ix; 1, 0, 0; 0, g, 0];
    eig_val(:, i) = eig(A); %eigenvalue matrix
end

eig_val_desired = eig_val(:,192) %most negative REAL eigenvalue - fastest response
K3_desired = K3(192) 

figure(1)
hold on
xline(-0.8, 'r');
hold on
xline(0, 'k--');
hold on
yline(0, 'k--');
hold on
%plot the eignenvalues that meet conditions
plot(eig_val_desired(1), 0, 'b*');
hold on
plot(eig_val_desired(2), 0, 'b*');
hold on
plot(eig_val_desired(3), 0, 'b*');
grid on
title("Lateral");
xlabel('Real Eigenvalues');
ylabel('Complex Eigenvalues');

%% longitudinal
K4 = 22*Ix;
K5 = 40*Ix;
K6 = Ix.*linspace(-840,-825,N);
for i = 1:N
    A = [-K4/Ix, -K5/Ix, -(K6(i)*K5)/Ix; 1, 0, 0; 0, -g, 0];
    eig_val2(:, i) = eig(A); % eigenvalue matrix
    
end
%desired values found by searching eigen value matrix
eig_val2_desired = eig_val2(:,129) %most negative REAL eigenvalue - fastest real response
K6_desired = K6(129)

figure(2)
xline(-0.8, 'r');
hold on
xline(0, 'k--');
hold on
yline(0, 'k--');
hold on
%plot the eignenvalues that meet conditions
plot(eig_val2_desired(1),0,'b*');
hold on
plot(eig_val2_desired(2), 0, 'b*');
hold on
plot(eig_val2_desired(3), 0, 'b*');
grid on
title('Longitudinal')
xlabel('Real Eigenvalues');
ylabel('Complex Eigenvalues');

%% Part 2 - open loop simulation

%%%%%%%lateral%%%%%%%%%%

g_b = 9.81; %m/s^2
m = 0.068; %kg
%controls
f1 = (g_b*m)/4;
f2 = (g_b*m)/4;
f3 = (g_b*m)/4;
f4 = (g_b*m)/4;

%response inputs 
u_r_dev = 0;
v_r_dev = 0.5; %m/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 0 0 0 0 0 0 0 0 0];
t_span = [0 10]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun(t,state_vec, f1, f2, f3, f4, u_r_dev, v_r_dev, 1),t_span,initials);

x = state_vec(:, 1);
y = state_vec(:, 2);
u = state_vec(:, 7);
v = state_vec(:, 8);

%response inputs - try again for 2 m/s
u_r_dev = 0;
v_r_dev = 2; %m/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 0 0 0 0 0 0 0 0 0];
t_span = [0 10]; %seconds
[t2, state_vec2] = ode45(@(t2,state_vec2) g_fun(t2,state_vec2, f1, f2, f3, f4, u_r_dev, v_r_dev, 1),t_span,initials);

x2 = state_vec2(:, 1);
y2 = state_vec2(:, 2);
u2 = state_vec2(:, 7);
v2 = state_vec2(:, 8);

%find index at 2 seconds
index = find(t >= 2, 1);

%plot the behavoir 
figure(3)
subplot(2,2,1);
plot(t, x);
xlabel('Time (s)');
ylabel('x position (m)');
title('X position over time');
grid on
hold on
subplot(2,2,2);
plot(t, y);
hold on
plot(t2, y2);
grid on
hold on
plot(t(index), y(index), 'r*');
hold on
plot(t(index), y2(index), 'b*');
xlabel('Time (s)');
ylabel('y position (m)');
title('Y position over time');
legend('input v = 0.5 m/s', 'input v = 2 m/s');
hold on
subplot(2,2,3);
plot(t, u);
xlabel('Time (s)');
ylabel('U, x-component of velocity (m/s)');
title('U over time');
grid on
hold on
subplot(2,2,4);
plot(t, v);
hold on
plot(t2, v2);
grid on
hold on
plot(t(index), v(index), 'r*');
hold on
plot(t(index), v2(index), 'b*');
xlabel('Time (s)');
ylabel('V, y-component of velocity (m/s)');
title('V over time');
legend('input v = 0.5 m/s', 'input v = 2 m/s');

%%%%%%%longitudinal%%%%%%%%%%

g_b = 9.81; %m/s^2
m = 0.068; %kg
%controls
f1 = (g_b*m)/4;
f2 = (g_b*m)/4;
f3 = (g_b*m)/4;
f4 = (g_b*m)/4;

%response inputs 
u_r_dev = 0.5;
v_r_dev = 0; %m/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 0 0 0 0 0 0 0 0 0];
t_span = [0 10]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun(t,state_vec, f1, f2, f3, f4, u_r_dev, v_r_dev, 1),t_span,initials);

x = state_vec(:, 1);
y = state_vec(:, 2);
u = state_vec(:, 7);
v = state_vec(:, 8);

%response inputs - try again for 2 m/s
u_r_dev = 2;
v_r_dev = 0; %m/s

%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 0 0 0 0 0 0 0 0 0];
t_span = [0 10]; %seconds
[t2, state_vec2] = ode45(@(t2,state_vec2) g_fun(t2,state_vec2, f1, f2, f3, f4, u_r_dev, v_r_dev, 1),t_span,initials);

x2 = state_vec2(:, 1);
y2 = state_vec2(:, 2);
u2 = state_vec2(:, 7);
v2 = state_vec2(:, 8);

%find index at 2 seconds
index = find(t >= 2, 1);

%plot the behavior 
figure(4)
subplot(2,2,1);
plot(t, x);
hold on
plot(t2, x2);
grid on
hold on
plot(t(index), x(index), 'r*');
hold on
plot(t(index), x2(index), 'b*');
xlabel('Time (s)');
ylabel('x position (m)');
title('X position over time');
legend('input u = 0.5 m/s', 'input u = 2 m/s');
hold on
subplot(2,2,2);
plot(t, y);
hold on
plot(t2, y2);
xlabel('Time (s)');
ylabel('y position (m)');
title('Y position over time');
grid on
hold on
subplot(2,2,3);
plot(t, u);
hold on
plot(t2, u2);
grid on
hold on
plot(t(index), u(index), 'r*');
hold on
plot(t(index), u2(index), 'b*');
xlabel('Time (s)');
ylabel('U, x-component of velocity (m/s)');
title('U over time');
legend('input u = 0.5 m/s','input u = 2 m/s');
hold on
subplot(2,2,4);
plot(t, v);
hold on
plot(t2, v2);
xlabel('Time (s)');
ylabel('V, y-component of velocity (m/s)');
title('V over time');
grid on

%% Part 3 - compare Mambo copter

load RSdata_one_1509.mat
%get x, y, u, and v at 2 seconds
times=rt_estimatedStates.time(:);
index = find(times >= 2, 1);
x_data = rt_estimatedStates.signals.values(:,1);
y_data = rt_estimatedStates.signals.values(:,2);
u_data = rt_estimatedStates.signals.values(:,7);
v_data = rt_estimatedStates.signals.values(:,8);

%simulation with both lateral and longitudinal velocoity inputs

%response inputs 
u_r_dev = 0.5;
v_r_dev = -0.5; %m/s
%state_vec = [x; y; z; phi; theta; xi; u; v; w; p; q; r];
initials = [0 0 0 0 0 0 0 0 0 0 0 0];
t_span = [0 10]; %seconds
[t, state_vec] = ode45(@(t,state_vec) g_fun(t,state_vec, f1, f2, f3, f4, u_r_dev, v_r_dev, 1),t_span,initials);

x = state_vec(:, 1);
y = state_vec(:, 2);
u = state_vec(:, 7);
v = state_vec(:, 8);

% plot mambo data
figure(5)
subplot(2,2,1);
plot(times, x_data);
hold on 
plot(t, x);
grid on
xlabel('Time (s)');
ylabel('X position (m)');
title('X position over time');
legend('Mambo response','Model Response');
hold on
subplot(2,2,2);
plot(times, y_data);
hold on 
plot(t, y);
xlabel('Time (s)');
ylabel('Y position (m)');
title('Y position over time');
legend('Mambo response','Model Response');
grid on
hold on
subplot(2,2,3);
plot(times, u_data);
hold on 
plot(t, u);
grid on
xlabel('Time (s)');
ylabel('U, x-component of velocity (m/s)');
title('U over time');
legend('Mambo response','Model Response');
hold on
subplot(2,2,4);
plot(times, v_data);
hold on 
plot(t, v);
xlabel('Time (s)');
ylabel('V, y-component of velocity (m/s)');
title('V over time');
legend('Mambo response','Model Response');
grid on

%% Functions Called
% The following functions were built and called as apart of this
% assignment.
%
% <include>g_fun.m</include>
%
%

