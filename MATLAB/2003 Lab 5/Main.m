clc; clear all; close all;

m = 54 * 2 / 1000; % [kg]
I = 0.0063; % [kg m^2]
R = 0.0762; % [m]
w0 = 130 * pi / 30; % [rad/s]

%% Tangential Case
syms w t

C = I/(m*R^2) + 1;
w = w0 * (C - (w0^2*t^2)) / (C + (w0^2*t^2));

time = double(solve(w==0,t));
time = time(2);

length_t = time * R * w0;

fprintf("Tangential time to despin is %f seconds at length of %f meters\n", time, length_t);

%% Radial Case

length_r = sqrt((I+m*R^2)/(m)) - R;
fprintf("Radial time to despin is %f seconds at length of %f meters\n", time, length_r);

%% Plot

figure
fplot(w, [0,time])