%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE CHALLENGE 3 - Monte Carlo Basics
%
% This script uses a Monte Carlo Simulation to examine how a rod set up
% as a cantilever beam with a point load acting at its end deflects as
% some of the inputs vary ramdomly. We then look at a histogram of
% deflection along with the statistics (max, min, mean, std)
% We can look at the variations individually to determine which varable
% affects deflection more or we can vary all together if we are only
% interested in how deflection behaves.
% 
% We will assume that beam has a circular cross-section and the deflection
% of the beam is within the elastic region.
%
% Please ZIP and upload your team's script(s) and figures to Canvas to 
% complete the challenge.
% 
% STUDENT TEAMMATES
% 1. Margaux McFarland
% 2. Mia Abouhamad
% 3. Andrew Swackhamer
% 4.
%
% CHALLENGE AUTHORS
% Jelliffe Jackson, Allison Anderson, Torin Clark, John Jackson 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Housekeeping
clear all
close all
clc

%% Given - Define the length L, the diameter D, the force F and Youngs Modulus E
L = 0.1; %m
D = 0.01; %m
F = 1000; %N
E = 200e9; %Pa

% Set number of Monte Carlo simulations
Number = 10000;

% Set up the random varying parameters
% Simulate the uncertainty in the force applied, given its uncertainty. The
% device applying the force states its precision is +/25 N (standard
% deviation of a normally distribution)
SD_Force = 25;  %N, standard deviation of the force applied
% randn produces random numbers that are normally distributed with mean=0, SD=1
Force = F + SD_Force*rand(1,Number);
% Force(1:Number) = F;

%% (1) Diameter is measured to be 0.01 m (10mm), but our calipers only measure
% to nearest 1mm, so uncertainty in that measurement might be +/- 0.5mm (or
% 0.0005m)

% What is deltaD?
deltaD = 0.0005; % m, +/- 0.5 mm of uncertainty

% How do you use rand() to produce a uniform sampling of diameter using deltaD?
diameter = D + deltaD*(randn(1,Number)-0.5);   
R = diameter./2;
%% (2) Moment of Inertia of Cylinder

% Cylinder 2nd inertia is pi*R^4/4 - write this expression below:
I = pi*R.^4/4;

% McMaster Carr cuts material perfectly, nothing to do here.
Length(1:Number) = L;   
% We pulled this from a material property datasheet, nothing to do here.
YoungsMod(1:Number) = E;

%% (3) Calculate the deflection
% deflection = PL^3/(3EI) -- remember the trick to multiply and divide arrays
% element-wise:
deflection = F.*L.^3./(3.*E.*I);

%% Plot a histogram with the mean
fig = figure();
hist(deflection, 30);
xlabel('deflection (m)'); ylabel(['Frequency of ', num2str(Number), ' sims'])
hold on;
plot(mean(deflection)*[1 1], [0 Number/8], 'g'); ylim([0, Number/8])
savefig(fig, 'monte-carlo')
saveas(fig, 'monte-carlo.png')

%% (Extra) Change the STD of the force and check to see how it affects the
% results. Save to a new graph.

fig = figure();
hist(deflection, 30);
xlabel('deflection (m)'); ylabel(['Frequency of ', num2str(Number), ' sims'])
hold on;
plot(mean(deflection)*[1 1], [0 Number/8], 'g'); ylim([0, Number/8])
savefig(fig, 'monte-carlo2')
saveas(fig, 'monte-carlo2.png')

%% (Extra) What happens when if you sample the diameter using a normal
% distribution rather than a uniform distribution?
diameter = D + deltaD*(randn(1,Number)-0.5);   
