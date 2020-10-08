function [] = plotLift2(p, q, d, n, alpha, i2, j, k, L1, L2, L3, L_actual)
%This function plots lift and drag versus the number of panels used for
%trap rule. Takes in the free stream pressure, dynamic pressure, diameter, 
%angle of attack, the accurancy points, and total number of integration points.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 9/17/19

N = 1:n;
count = 1;
for i = N
    [L(count), D(count)] = airfoilLiftDrag(i);
    count = count + 1;
end
    %lift plot
    figure(3)
    plot(N, L);
    grid on
    xlabel("Number of integration points");
    ylabel("Lift (N)");
    title("Approximated Lift for n number of Integration Points");
    hold on
    %mark points on plot where accuracies acheived
    plot(i2, L1, 'r*');
    hold on;
    plot(j, L2, 'g*');
    hold on;
    plot(k, L3, 'b*');
    hold on
    %actual value
    yline(L_actual,'m--');
    xlim([0 700]); %so points are visible with legend
    legend("Approximated Lift", "5% relative error","1% relative error","0.1% relative error", "Actual Lift");
    
    %drag plot
    figure(4)
    plot(N, D);
    grid on
    xlabel("Number of integration points");
    ylabel("Drag (N)");
    title("Approximated Drag for n number of Integration Points");
   
    
end