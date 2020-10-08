%% ASEN 3111 - CFD Lab - Main
%  Turbulent Flow over a NACA 0012 airfoil
%
%   Author: Margaux McFarland
%   Collaborators: Brendan Palmer
%   Date: 12/10/19

clc
clear all
close all

%load in mat file (made in premain)
load Data_CFD_McFarland_Margaux.mat

%loop through the mat file struct
for i = 1:length(results)
  %take the last value in of the force coefficient because that is where
  %values converged 
  %first 12 are cd with positive AoA
  if i < 13
      CD(i + 2) = results(i).forceCoeff(end);
  elseif i == 13 %next two files are cd with negative AoA 
      CD(i - 12) = results(i).forceCoeff(end);
  elseif i == 14
      CD(i - 13) = results(i).forceCoeff(end);
  elseif i < 27 %last 12 cl with positive AoA
      CL(i - 12) = results(i).forceCoeff(end);
  elseif i == 27 %next two files are cl with negative AoA 
      CL(i - 25) = results(i).forceCoeff(end);
  elseif i == 28
      CL(i - 27) = results(i).forceCoeff(end);
  end
end

%angle of attack vector
AoA = -4:2:20;
%add 15 degrees
AoA = [AoA(1:10) 15 AoA(11:end)];
%plots
figure(1)
plot(CL,CD,'s');
title('c_{D} vs AoA for NACA 0012');
xlabel('Coefficient of Lift');
ylabel('Coefficient of Drag');
grid on
figure(2)
plot(AoA,CL, '-o');
title('c_{L} vs AoA for NACA 0012');
xlabel('Angle of Attack, degrees');
ylabel('Coefficient of Lift');
hold on
grid on

%estimate stall angle
stall_angle = 15; %degrees
%find lift slope - only take linear portion (ignore stall)
lift_slope = (CL(find(AoA == 10, 1)) - CL(1))/(10 - AoA(1));
%find zero lift AoA, find when cl is closest to zero
zero_lift_AoA = AoA(find(abs(CL) == min(abs(CL)),1));
%find max cl
max_cl = max(CL);

%thin airfoil theory
AoA = -4:2:20;
lift_slope_thin = deg2rad(2*pi); 
zeroAoA_thin = 0; %symmetric airfoil
cl_thin = lift_slope_thin.*(AoA-deg2rad(zeroAoA_thin));
plot(AoA, cl_thin);
hold on 

%vortex panel method
%load in comp 3 assignment data on NACA 0012
load Cl_different_AOA_0012.mat
plot(AoA,Cl_different_AOA_0012);
legend('CFD','Thin Airfoil Theory','Vortex-Panel Method');


