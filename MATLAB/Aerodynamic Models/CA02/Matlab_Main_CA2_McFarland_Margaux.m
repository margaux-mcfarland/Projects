%% ASEN 3111 - Computational Assignment 02 - Main
%  Flow Over Thin Airfoils
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/10/19
   
clc
clear all
close all

%givens
c = 2; %m
alpha = deg2rad(12); %radians
V_inf = 68; % m/s
p_inf = 101.3e3; %Pa
rho_inf = 1.225; %kg/m^3
N = 20;

%plot airfoil flow - with lowish number of vortices
Plot_Airfoil_Flow(c, alpha, V_inf, p_inf, rho_inf, N);

%vary number of N vorticies
%try very high number to approximate the actual results
N_high = 1000;
Plot_Airfoil_Flow(c, alpha, V_inf, p_inf, rho_inf, N_high);

%% make error plots
%vector of varying number of vortices
vort_vec = 0:10:300;
for i = 1:length(vort_vec)
    [error_V(i),error_P(i)] = calcError(c, alpha, V_inf, p_inf, rho_inf, vort_vec(i));
end

%find 5% percent error on plots
index_V = find(error_V <= 0.05,1);
index_P = find(error_P <= 0.05, 1);

fprintf('The number of vortices requires to get <=5 percent error in Velocity: %f\n', vort_vec(index_V));
fprintf('The number of vortices requires to get <=5 percent error in Pressure: %f\n', vort_vec(index_P));
fprintf('********************************************\n');

figure
plot(vort_vec, error_V);
hold on
yline(0.05, 'r--');
xlabel('Number of Vortices');
ylabel('Error');
title('Error in Velocity vs Number of vorticies');
legend('error curve','5 percent error line');
figure
plot(vort_vec, error_P);
hold on
yline(0.05, 'r--');
xlabel('Number of Vortices');
ylabel('Error');
title('Error in Pressure vs Number of vorticies');
legend('error curve','5 percent error line');

%% study changes in 1) chord length 2) angle of attack 3) freestream flow speed

%vectors of varying values
chords = linspace(1,10,5);
alphas = linspace(0, pi/2, 5);
speeds = linspace(1,100,5);
N = 50; % determined to be accurate enough from above

%plot these variations
Plot_Airfoil_Flow_variations(chords, alphas, speeds, p_inf, rho_inf, N);

%% Functions Called
% The following functions were built and called as apart of this
% assignment.
%
% <include>Plot_Airfoil_Flow.m</include>
%
%
% <include>calcError.m</include>
%
%
% <include>Plot_Airfoil_Flow_variations.m</include>
%