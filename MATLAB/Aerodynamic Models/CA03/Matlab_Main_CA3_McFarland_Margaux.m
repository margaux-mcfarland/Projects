%% ASEN 3111 - Computational Assignment 03 - Main
%  Flow Over Thick Airfoils
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 11/7/19

clc;
clear;
close all;


%% Problem 1

%test that vortex panel method works with Kuthe/Chow data/values
xb = [1, 0.933, 0.750, 0.500, 0.250, 0.067, 0, 0.067, 0.250, 0.500, 0.750, 0.933, 1];
yb = [0, -0.005, -0.017, -0.033, -0.042, -0.033, 0, 0.045, 0.076, 0.072, 0.044, 0.013,0];
c_l = Vortex_Panel(xb,yb,100,8,1);

%% Problem 2
%NACA 0012
m = 0;
p = 0;
t = 12/100;
c = 1; %m %?
V_inf = 25; %set to 100 m/s 

%choose actual value as value found high high N (300)
N = 300;
[x, y] = NACA_Airfoils(m,p,t,c,N);
[c_l_actual, cp_actual, X, Y] = Vortex_Panel(x,y,V_inf,0,0);

%calculate error as panels increase
N = 2:150;
for i = 1:length(N)
    [x, y] = NACA_Airfoils(m,p,t,c,N(i));
    [c_l, cp, X, Y] = Vortex_Panel(x,y,V_inf,0,0);
    error(i) = abs((mean(cp_actual) - mean(cp))/mean(cp_actual))*100;
end 

%plot percent error of average cp vs number of panels 
figure(2)
plot(N, error);
title('Error vs Number of Panels');
yline(5, '--r');
xlabel('Number of Panels, N');
ylabel('Percent Error in average cp, %');
legend('error', '5% error');
grid on

%find number of panels when error is <= 5%
min_N = N(find(error <= 5,1));
fprintf("Using %d Panels...\n",min_N);

%verify NACA airfoil generator works 
[x, y] = NACA_Airfoils(m,p,t,c,min_N);
figure(3)
plot(x, y);
ylim([-0.2 0.2])
xlabel('x/c');
ylabel('y/c');
title('NACA 0012 Airfoil');

%loop through various alphas to find cl and cp
alphas = [-5, 0, 5, 10];
for i = 1:length(alphas);
    [c_l(i), CP, X, Y] = Vortex_Panel(x,y,V_inf,alphas(i),0);
    figure(4)
    %plot cp vs x/c for each alpha on one plot
     c = max(X) - min(X);
    x = X(1:length(X)-1); %upper surface
    x_c = x./c;
    %invert the CP order for plot
    CP = CP(1:length(CP)-1); %upper surface
    plot(x,CP);
    set(gca, 'YDir','reverse')
    grid on
    title('Coefficient of Pressure vs percent chord');
    xlabel('Percent chord, x/c');
    ylabel('Cp');
    hold on
    %legend('Upper surface', 'Lower surface');
    cp_mean(i) = mean(CP);
end
legend('-5 degrees', '0 degrees', '5 degrees', '10 degrees');

%plot cl vs alpha and cp vs alpha at various alphas
figure(5)
sgtitle('NACA 0012');
subplot(1, 2, 1);
plot(alphas, c_l);
xlabel('Angle of Attack, degrees');
ylabel('Average Cl');
title('Cl vs alpha');
grid on
subplot(1, 2, 2);
plot(alphas, cp_mean);
set(gca, 'YDir','reverse')
xlabel('Angle of Attack, degrees');
ylabel('Average cp');
grid on
title('Cp vs alpha');

%% Problem 3
%vector of NACA names
NACA_names = ['0012'; '2412'; '4412'; '2424'];

%loop through each airfoil
for i = 1:length(NACA_names)
    %get airfoil properties from name
    m = str2num(NACA_names(i,1))/100;
    p = str2num(NACA_names(i,2))/10;
    t = str2num(NACA_names(i,3:4))/100;
    
    %get cooridinates of airfoil shape
    [x, y] = NACA_Airfoils(m,p,t,c,min_N);
     
    %get cl from vortex panel method at various alphas
    %loop through alphas
    alphas = -5:0.5:20;
    for j = 1:length(alphas)
        [c_l(j), cp, X, Y] = Vortex_Panel(x,y,V_inf,alphas(j),0);
    end
    %plot cl vs alpha
    figure(5+i)
    plot(alphas, c_l);
    xlabel('Angle of Attack, degrees');
    ylabel('Average Cl');
    title_str = "Cl vs Alpha for NACA " + NACA_names(i,:);
    title(title_str);
    grid on
    
    %estimate lift slope
    lift_slope = (c_l(end) - c_l(1)) / alphas(end) - alphas(1);
    fprintf("----NACA %s----\n", NACA_names(i,:));
    fprintf("estimated lift slope = %s rad^-1\n", lift_slope);

    %estimate zero-lift angle of attack
    zero_index = find(c_l >= 0, 1); %index where cl is zero
    zero_l_AoA = alphas(zero_index); %angle of attack
    xline(zero_l_AoA,'--k'); %add line on plot where lift = 0
    fprintf("estimated zero lift AoA = %s degrees\n", zero_l_AoA);
    
    %compare with thin airfoil theory
    %lift slope should be 2*pi
    lift_slope_thin = 2*pi;
    zeroAoA_thin = calcZeroLiftAoA(m,p,t,c);
    %print and plot results
    cl_thin = lift_slope_thin.*(deg2rad(alphas)-deg2rad(zeroAoA_thin));
    hold on 
    plot(alphas, cl_thin);
    xline(zeroAoA_thin,'--g'); %add line on plot where lift = 0
    legend('Vortex Panel Method', 'Zero-lift line for Vortex Panel','Thin Airfoil Theory','Zero-lift line for thin airfoil');
    fprintf("\t thin airfoil theory lift slope = %s rad^-1\n", lift_slope_thin);
    fprintf("\t thin airfoil theory zero lift AoA = %s degrees\n", zeroAoA_thin);
    maxCL = max(c_l)
    maxCL_thin = max(cl_thin)
end


%% Functions Called
% The following functions were built and called as apart of this
% assignment.
%
% <include>NACA_Airfoils.m</include>
%
%
% <include>Vortex_Panel.m</include>
%
%
% <include>calcZeroLiftAoA.m</include>
%