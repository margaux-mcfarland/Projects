clc
clear all
close all

%% Question 5

%calculate temperature across a rod
N = 10;

%givens
H = 7.92; %C/in
alpha = 48.2; %m^2/s
L = 5; %in
x = 4.875; %in
t = 0:0.1:1;
T0 = 7.64; %deg C

bn = -4*H*((-1).^N)./((2*N-1)*pi);
lam = ((2*N - 1)*pi)/(2*L);

u = calcTemp(N, bn, lam, x, alpha, t, T0, H);


%try for 1000s
t = 0:1:1000;
N = 1;
u = calcTemp(N, bn, lam, x, alpha, t, T0, H);

%% Question 6

% plot temperature at a single point on the rod
%same givens, different fourier term
lam = pi/(2*L);
u = calcTemp(N, bn, lam, x, alpha, t, T0, H);

%varying alphas
alpha = 1:50;
figure(4)
for i = 1:length(alpha)
    %summation
    sum = 0;
    for j = 1:N
        sum = sum + bn*sin(lam.*x)*exp(-lam^2*alpha(i).*t);
    end
    %add steady state and transient state
    u = T0 + H*x + sum;
    plot(t, u);
    hold on;
end
xlabel('time (s)');
ylabel('Temperature (deg C)');
title('Temperature vs time with varying thermal diffusivities');

%% functions called
%
% <include>calcTemp.m</include>
%

