%% ASEN 3111 - Experimental Lab 01 - Main
%  Flow Over Thin Airfoils
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/23/19

clc
clear all
close all

%% load in pre-sorted mat file
load Data_EXP_McFarland_Margaux
    
%% Problem 1

%find and compare up stream and down stream flows of same configuration and
%repetition number

%sum of velocity deficits for each case
sum_u = zeros(10000, 28);
% sum of ydistances (to find average)
sum_y = zeros(10000, 28);
% sum of densities (to find average)
sum_rho = zeros(10000, 28);
%sum of downstream velocities (to find average)
sum_v2 = zeros(10000, 28);
%sum of freestream velocities (to find average)
sum_v1 = zeros(10000, 28);
%number of velocity degecits found for each case
count_u = zeros(10000, 28);

%loop through each configuration
for i = 1:length(all_configurations)
    config = all_configurations{i};
    for j = 1:length(config) - 1
        myconfig = config(j);
        if myconfig.matched == 0
        rep_str = myconfig.nameData(5); %the repetition string
        V = myconfig.nameData(3); %airspeed
        direction = myconfig.nameData(2); %upstream/downstream
        for k = j+1:length(config)
            nextconfig = config(k); %keep track of the next configuration
            %check to see if we have already found a match for a configuration
            if nextconfig.matched == 0
                %next configurations values
                %find the same repetitions/same airspeed
                rep_str_next = nextconfig.nameData(5); %the repetition string
                V_next = nextconfig.nameData(3); %airspeed
                direction_next = nextconfig.nameData(2); %upstream/downstream
                %compare to first configuration until we find a match
                if V_next == V
                    if rep_str_next == rep_str
                       %now check if directions are different
                       if direction_next ~= direction 
                           %calculate velocity from dynamic pressure
                           V_current = (2.*myconfig.aux_q./myconfig.atmD).^(1/2); 
                           V_next = (2.*nextconfig.aux_q./nextconfig.atmD).^(1/2);
                           if direction_next == 'up'
                               %calculate velocity deficity, u
                               u = V_next - V_current;
                               V2 = V_current;
                               V1 = V_next;
                               %mark the two configurations as matched
                               myconfig.matched = 1;
                               nextconfig.matched = 1;
                               break %exit loop searching for match
                           else %the next configuration is behind the current
                               u = V_current - V_next;
                               V2 = V_next;
                               V1 = V_current;
                               %mark the two configurations as matched
                               myconfig.matched = 1;
                               nextconfig.matched = 1;
                               break %exit loop searching for match
                           end
                       end
                    end
                end
            end
        end
        %sum up each repetitons velocity deficits for each configuration
        %and then plot
        if myconfig.matched %only plot if u exists
        if myconfig.nameData(1) == 'cylinder'
            if myconfig.nameData(3) == 'V15'
                switch myconfig.nameData(4)
                    case 'x60'
                        sum_u(:,1) = sum_u(:,1) + u;
                        sum_y(:, 1) = sum_y(:,1) + myconfig.yDist;
                        sum_rho(:, 1) = sum_rho(:,1) + myconfig.atmD;
                        sum_v2(:,1) = sum_v2(:,1) + V2;
                        sum_v1(:,1) = sum_v1(:,1) + V1;
                        count_u(:,1) = count_u(:,1) + 1;
                    case 'x90'
                        sum_u(:,2) = sum_u(:,2) + u;
                        sum_y(:, 2) = sum_y(:,2) + myconfig.yDist;
                        sum_rho(:, 2) = sum_rho(:,2) + myconfig.atmD;
                        sum_v2(:,2) = sum_v2(:,2) + V2;
                        sum_v1(:,2) = sum_v1(:,2) + V1;
                        count_u(:,2) = count_u(:,2) + 1;
                    case 'x120'
                        sum_u(:,3) = sum_u(:,3) + u;
                        sum_y(:, 3) = sum_y(:,3) + myconfig.yDist;
                        sum_rho(:, 3) = sum_rho(:,3) + myconfig.atmD;
                        sum_v2(:,3) = sum_v2(:,3) + V2;
                        sum_v1(:,3) = sum_v1(:,3) + V1;
                        count_u(:,3) = count_u(:,3) + 1;
                    case 'x150'
                        sum_u(:,4) = sum_u(:,4) + u;
                        sum_y(:, 4) = sum_y(:,4) + myconfig.yDist;
                        sum_rho(:,4) = sum_rho(:,4) + myconfig.atmD;
                        sum_v2(:,4) = sum_v2(:,4) + V2;
                        sum_v1(:,4) = sum_v1(:,4) + V1;
                        count_u(:,4) = count_u(:,4) + 1;
                    case 'x180'
                        sum_u(:,5) = sum_u(:,5) + u;
                        sum_y(:, 5) = sum_y(:,5) + myconfig.yDist;
                        sum_rho(:, 5) = sum_rho(:,5) + myconfig.atmD;
                        sum_v2(:,5) = sum_v2(:,5) + V2;
                        sum_v1(:,5) = sum_v1(:,5) + V1;
                        count_u(:,5) = count_u(:,5) + 1;
                    case 'x210'
                        sum_u(:,6) = sum_u(:,6) + u;
                        sum_y(:, 6) = sum_y(:,6) + myconfig.yDist;
                        sum_rho(:, 6) = sum_rho(:,6) + myconfig.atmD;
                        sum_v2(:,6) = sum_v2(:,6) + V2;
                        sum_v1(:,6) = sum_v1(:,6) + V1;
                        count_u(:,6) = count_u(:,6) + 1;
                    case 'x240'
                        sum_u(:,7) = sum_u(:,7) + u;
                        sum_y(:, 7) = sum_y(:,7) + myconfig.yDist;
                        sum_rho(:, 7) = sum_rho(:,7) + myconfig.atmD;
                        sum_v2(:,7) = sum_v2(:,7) + V2;
                        sum_v1(:,7) = sum_v1(:,7) + V1;
                        count_u(:,7) = count_u(:,7) + 1;
                end
            else %25 m/2 velocity
                switch myconfig.nameData(4)
                    case 'x60'
                        sum_u(:,8) = sum_u(:,8) + u;
                        sum_y(:, 8) = sum_y(:,8) + myconfig.yDist;
                        sum_rho(:, 8) = sum_rho(:,8) + myconfig.atmD;
                        sum_v2(:,8) = sum_v2(:,8) + V2;
                        sum_v1(:,8) = sum_v1(:,8) + V1;
                        count_u(:,8) = count_u(:,8) + 1;
                    case 'x90'
                        sum_u(:,9) = sum_u(:,9) + u;
                        sum_y(:, 9) = sum_y(:,9) + myconfig.yDist;
                        sum_rho(:, 9) = sum_rho(:,9) + myconfig.atmD;
                        sum_v2(:,9) = sum_v2(:,9) + V2;
                        sum_v1(:,9) = sum_v1(:,9) + V1;
                        count_u(:,9) = count_u(:,9) + 1;
                    case 'x120'
                        sum_u(:,10) = sum_u(:,10) + u;
                        sum_y(:, 10) = sum_y(:,10) + myconfig.yDist;
                        sum_rho(:, 10) = sum_rho(:,10) + myconfig.atmD;
                        sum_v2(:,10) = sum_v2(:,10) + V2;
                        sum_v1(:,10) = sum_v1(:,10) + V1;
                        count_u(:,10) = count_u(:,10) + 1;
                    case 'x150'
                        sum_u(:,11) = sum_u(:,11) + u;
                        sum_y(:, 11) = sum_y(:,11) + myconfig.yDist;
                        sum_rho(:, 11) = sum_rho(:,11) + myconfig.atmD;
                        sum_v2(:,11) = sum_v2(:,11) + V2;
                        sum_v1(:,11) = sum_v1(:,11) + V1;
                        count_u(:,11) = count_u(:,11) + 1;
                    case 'x180'
                        sum_u(:,12) = sum_u(:,12) + u;
                        sum_y(:, 12) = sum_y(:,12) + myconfig.yDist;
                        sum_rho(:, 12) = sum_rho(:,12) + myconfig.atmD;
                        sum_v2(:,12) = sum_v2(:,12) + V2;
                        sum_v1(:,12) = sum_v1(:,12) + V1;
                        count_u(:,12) = count_u(:,12) + 1;
                    case 'x210'
                        sum_u(:,13) = sum_u(:,13) + u;
                        sum_y(:, 13) = sum_y(:,13) + myconfig.yDist;
                        sum_rho(:, 13) = sum_rho(:,13) + myconfig.atmD;
                        sum_v2(:,13) = sum_v2(:,13) + V2;
                        sum_v1(:,13) = sum_v1(:,13) + V1;
                        count_u(:,13) = count_u(:,13) + 1;
                    case 'x240'
                        sum_u(:,14) = sum_u(:,14) + u;
                        sum_y(:, 14) = sum_y(:,14) + myconfig.yDist;
                        sum_rho(:, 14) = sum_rho(:,14) + myconfig.atmD;
                        sum_v2(:,14) = sum_v2(:,14) + V2;
                        sum_v1(:,14) = sum_v1(:,14) + V1;
                        count_u(:,14) = count_u(:,14) + 1;
                end
            end
        else %airfoil
            if myconfig.nameData(3) == 'V15'
                switch myconfig.nameData(4)
                    case 'x13'
                        sum_u(:,15) = sum_u(:,15) + u;
                        sum_y(:, 15) = sum_y(:,15) + myconfig.yDist;
                        sum_rho(:, 15) = sum_rho(:,15) + myconfig.atmD;
                        sum_v2(:,15) = sum_v2(:,15) + V2;
                        sum_v1(:,15) = sum_v1(:,15) + V1;
                        count_u(:,15) = count_u(:,15) + 1;
                    case 'x18'
                        sum_u(:,16) = sum_u(:,16) + u;
                        sum_y(:, 16) = sum_y(:,16) + myconfig.yDist;
                        sum_rho(:, 16) = sum_rho(:,16) + myconfig.atmD;
                        sum_v2(:,16) = sum_v2(:,16) + V2;
                        sum_v1(:,16) = sum_v1(:,16) + V1;
                        count_u(:,16) = count_u(:,16) + 1;
                    case 'x23'
                        sum_u(:,17) = sum_u(:,17) + u;
                        sum_y(:, 17) = sum_y(:,17) + myconfig.yDist;
                        sum_rho(:, 17) = sum_rho(:,17) + myconfig.atmD;
                        sum_v2(:,17) = sum_v2(:,17) + V2;
                        sum_v1(:,17) = sum_v1(:,17) + V1;
                        count_u(:,17) = count_u(:,17) + 1;
                    case 'x28'
                        sum_u(:,18) = sum_u(:,18) + u;
                        sum_y(:, 18) = sum_y(:,18) + myconfig.yDist;
                        sum_rho(:, 18) = sum_rho(:,18) + myconfig.atmD;
                        sum_v2(:,18) = sum_v2(:,18) + V2;
                        sum_v1(:,18) = sum_v1(:,18) + V1;
                        count_u(:,18) = count_u(:,18) + 1;
                    case 'x33'
                        sum_u(:,19) = sum_u(:,19) + u;
                        sum_y(:, 19) = sum_y(:,19) + myconfig.yDist;
                        sum_rho(:, 19) = sum_rho(:,19) + myconfig.atmD;
                        sum_v2(:,19) = sum_v2(:,19) + V2;
                        sum_v1(:,19) = sum_v1(:,19) + V1;
                        count_u(:,19) = count_u(:,19) + 1;
                    case 'x38'
                        sum_u(:,20) = sum_u(:,20) + u;
                        sum_y(:, 20) = sum_y(:,20) + myconfig.yDist;
                        sum_rho(:, 20) = sum_rho(:,20) + myconfig.atmD;
                        sum_v2(:,20) = sum_v2(:,20) + V2;
                        sum_v1(:,20) = sum_v1(:,20) + V1;
                        count_u(:,20) = count_u(:,20) + 1;
                    case 'x43'
                        sum_u(:,21) = sum_u(:,21) + u;
                        sum_y(:, 21) = sum_y(:,21) + myconfig.yDist;
                        sum_rho(:, 21) = sum_rho(:,21) + myconfig.atmD;
                        sum_v2(:,21) = sum_v2(:,21) + V2;
                        sum_v1(:,21) = sum_v1(:,21) + V1;
                        count_u(:,21) = count_u(:,21) + 1;
                end
            else %25 m/2 velocity
                switch myconfig.nameData(4)
                    case 'x13'
                        sum_u(:,22) = sum_u(:,22) + u;
                        sum_y(:, 22) = sum_y(:,22) + myconfig.yDist;
                        sum_rho(:, 22) = sum_rho(:,22) + myconfig.atmD;
                        sum_v2(:,22) = sum_v2(:,22) + V2;
                        sum_v1(:,22) = sum_v1(:,22) + V1;
                        count_u(:,22) = count_u(:,22) + 1;
                    case 'x18'
                        sum_u(:,23) = sum_u(:,23) + u;
                        sum_y(:, 23) = sum_y(:,23) + myconfig.yDist;
                        sum_rho(:, 23) = sum_rho(:,23) + myconfig.atmD;
                        sum_v2(:,23) = sum_v2(:,23) + V2;
                        sum_v1(:,23) = sum_v1(:,23) + V1;
                        count_u(:,23) = count_u(:,23) + 1;
                    case 'x23'
                        sum_u(:,24) = sum_u(:,24) + u;
                        sum_y(:, 24) = sum_y(:,24) + myconfig.yDist;
                        sum_rho(:, 24) = sum_rho(:,24) + myconfig.atmD;
                        sum_v2(:,24) = sum_v2(:,24) + V2;
                        sum_v1(:,24) = sum_v1(:,24) + V1;
                        count_u(:,24) = count_u(:,24) + 1;
                    case 'x28'
                        sum_u(:,25) = sum_u(:,25) + u;
                        sum_y(:, 25) = sum_y(:,25) + myconfig.yDist;
                        sum_rho(:, 25) = sum_rho(:,25) + myconfig.atmD;
                        sum_v2(:,25) = sum_v2(:,25) + V2;
                        sum_v1(:,25) = sum_v1(:,25) + V1;
                        count_u(:,25) = count_u(:,25) + 1;
                    case 'x33'
                        sum_u(:,26) = sum_u(:,26) + u;
                        sum_y(:, 26) = sum_y(:,26) + myconfig.yDist;
                        sum_rho(:, 26) = sum_rho(:,26) + myconfig.atmD;
                        sum_v2(:,26) = sum_v2(:,26) + V2;
                        sum_v1(:,26) = sum_v1(:,26) + V1;
                        count_u(:,26) = count_u(:,26) + 1;
                    case 'x38'
                        sum_u(:,27) = sum_u(:,27) + u;
                        sum_y(:, 27) = sum_y(:,27) + myconfig.yDist;
                        sum_rho(:, 27) = sum_rho(:,27) + myconfig.atmD;
                        sum_v2(:,27) = sum_v2(:,27) + V2;
                        sum_v1(:,27) = sum_v1(:,27) + V1;
                        count_u(:,27) = count_u(:,27) + 1;
                    case 'x43'
                        sum_u(:,28) = sum_u(:,28) + u;
                        sum_y(:, 28) = sum_y(:,28) + myconfig.yDist;
                        sum_rho(:, 28) = sum_rho(:,28) + myconfig.atmD;
                        sum_v2(:,28) = sum_v2(:,28) + V2;
                        sum_v1(:,28) = sum_v1(:,28) + V1;
                        count_u(:,28) = count_u(:,28) + 1;
                end
            end 
            end
            
        end
        end
    end
end

% calculate average velocity deficit and plot the average
u_avg = sum_u./count_u;
yDist_avg = sum_y./count_u;
%other averages (for problem 4)
rho_avg = sum_rho./count_u;
v2_avg = sum_v2./count_u;
v1_avg = sum_v1./count_u;
for i = 1:28 % loop through each average and plot
    [f_num, sub_num,title_str, sgtitle_str] = getFigNum(i);
    figure(f_num);
    sgtitle(sgtitle_str);
    subplot(2, 4, sub_num);
    plot(yDist_avg(:,i), u_avg(:,i));
    grid on
    title(title_str);
    xlabel('Vertical Distance (mm)');
    ylabel('Velocity deficit (m/s)');
    
    %find max u for each downstream position
    u_max(i) = max(u_avg(:,i));
    
    %find index of the max velocity deficit to find the y distances at that
    %point
    y_neg_index = find(u_avg(:,i) >= 0.5*u_max(i), 1); %find value closest to 0.5*u
    y_pos_index = find(u_avg(:,i) >= 0.5*u_max(i), 1,'last'); 
    
    %find half wake width for each downstream position
    delta(i) = (1/2)*(yDist_avg(y_pos_index,i) - yDist_avg(y_neg_index,i));
    
end

%all the downstream positions
xpos_cyl = [60 90 120 150 180 210 240];
xpos_air = [13 18 23 28 33 38 43];

%plot half wake width vs horizontal distance
%cylinder plot of half wake width
figure(5)
sgtitle('Cylinder');
subplot(1,2,1)
plot(xpos_cyl, delta(1:7));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('Wake half-width (mm)');
title('Wake half-width vs x at 15 m/s'); 
subplot(1,2,2);
plot(xpos_cyl, delta(8:14));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('Wake half-width (mm)');
title('Wake half-width vs x at 25 m/s'); 
%airfoil plot 
figure(6)
sgtitle('Airfoil');
subplot(1,2,1)
plot(xpos_air, delta(15:21));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('Wake half-width (mm)');
title('Wake half-width vs x at 15 m/s'); 
subplot(1,2,2);
plot(xpos_air, delta(22:28));
xlabel('Horizontal distance,x (mm)');
ylabel('Wake half-width (mm)');
title('Wake half-width vs x at 25 m/s'); 
grid on

%% Problem 2
%plot max velocity deficit vs horizontal distance
%cylinder plot of max velocity deficit
figure(7)
sgtitle('Cylinder');
subplot(1,2,1)
plot(xpos_cyl, u_max(1:7));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('Max velocity deficit, u (m/s)');
title('u max vs x at 15 m/s'); 
subplot(1,2,2);
plot(xpos_cyl, u_max(8:14));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('Max velocity deficit,u (m/s)');
title('u max vs x at 25 m/s');
%airfoil plot of max deficit
figure(8)
sgtitle('Airfoil');
subplot(1,2,1)
plot(xpos_air, u_max(15:21));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('Max velocity deficit,u (m/s)');
title('u max vs x at 15 m/s');
subplot(1,2,2);
plot(xpos_air, u_max(22:28));
xlabel('Horizontal distance,x (mm)');
ylabel('Max velocity deficit,u (m/s)');
title('u max vs x at 25 m/s');
grid on

%% Problem 3

%get non-dimensional velocity deficit
u_non_dim = u_avg./u_max;
%get non-dinmensional vertical location
y_non_dim = yDist_avg./delta;

for i = 1:28 % loop through each configuration and plot
    [f_num, sub_num,title_str, sgtitle_str] = getFigNum(i);
    figure(f_num + 8); %there have already been 8 figures
    sgtitle(sgtitle_str);
    subplot(2, 4, sub_num);
    plot(y_non_dim(:,i), u_non_dim(:,i));
    grid on
    title(title_str);
    xlabel('Non-dimensional y (mm)');
    ylabel('Non-dimensional u (m/s)');

end

%% Problem 4

%loop through drag vector and display value in command window
sum_d_cyl1 = 0;sum_d_cyl2 = 0;
cyl_count1 = 0;cyl_count2 = 0;
sum_d_air1 = 0;sum_d_air2 = 0;
air_count1 = 0;air_count2 = 0;
%given chord lengths
c_air = 0.0889; %m
c_cyl = 0.0127; %m
for i = 1:28
    [f_num, sub_num,title_str, sgtitle_str] = getFigNum(i);
    
    %find index of the lowest and highest y distance and compute values at
    %that location for the integral
    [maxR, maxC] = find(yDist_avg == max(yDist_avg(:,i)), 1);
    [minR, minC] = find(yDist_avg == min(yDist_avg(:,i)), 1);
    
    %compute drag from eq 2.83 - also convert y distances to m
    D(i) = (v2_avg(maxR,i).*u_avg(maxR,i)*(max(yDist_avg(:,i))/1000))...
        -(v2_avg(minR,i).*u_avg(minR,i)*(min(yDist_avg(:,i))/1000));
    %calculate the coefficient (pg 144)
    if f_num == 1 || f_num == 2 %cylinder
        cd_cyl = (2.*D)./(c_cyl.*v1_avg(1,i).^2);
    else %airfoil
        cd_air = (2.*D)./(c_air.*v1_avg(1,i).^2);
    end
    %find averages for cylinder/airfoil
    if f_num == 1 %cyl at 15 m/s
        sum_d_cyl1 = sum_d_cyl1 + cd_cyl(i);
        cyl_count1 = cyl_count1 + 1;
    elseif f_num == 2 %cyl at 25 m/s
        sum_d_cyl2 = sum_d_cyl2 + cd_cyl(i);
        cyl_count2 = cyl_count2 + 1;
    elseif f_num == 3 %airfoil at 15 m/s
        sum_d_air1 = sum_d_air1 + cd_air(i);
        air_count1 = air_count1 + 1;
    else %airfoil at 25 m/s
        sum_d_air2 = sum_d_air2 + cd_air(i);
        air_count2 = air_count2 + 1;
    end
end
% plot each experiments cd
figure(13)
sgtitle('Cd of Cylinder');
subplot(1,2,1)
plot(xpos_cyl, cd_cyl(1:7));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('cd');
title('cd vs x at 15 m/s'); 
subplot(1,2,2);
plot(xpos_cyl, cd_cyl(8:14));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('cd)');
title('cd vs x at 25 m/s');
%airfoil plot of max deficit
figure(14)
sgtitle('Cd of Airfoil');
subplot(1,2,1)
plot(xpos_air, cd_air(15:21));
grid on
xlabel('Horizontal distance,x (mm)');
ylabel('cd');
title('cd vs x at 15 m/s');
subplot(1,2,2);
plot(xpos_air, cd_air(22:28));
xlabel('Horizontal distance,x (mm)');
ylabel('cd');
title('cd vs x at 25 m/s');
grid on

%display the average cd for each case in command window
fprintf("Cylinder at 15 m/s average cd = %f\n",sum_d_cyl1/cyl_count1);
fprintf("Cylinder at 25 m/s average cd = %f\n",sum_d_cyl2/cyl_count2);
fprintf("Airfoil at 15 m/s average cd = %f\n",sum_d_air1/air_count1);
fprintf("Airfoil at 25 m/s average cd = %f\n",sum_d_air2/air_count2);