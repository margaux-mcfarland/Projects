%% ASEN 2003 Lab IV: Unbalanced Wheel
%
% Authors: Maria Callas, Chava Friedman, Baily Rice 
% Data Created: 02/28/18
% Last Edit:    
%
% This script reads in angular position and angular velocity experimental 
% data, and compares the experimental data with 4 discrete mathematical
% models for the wheel's angular velocity as a function of angular
% position.

clear all; 
clc; 
close all; 

%% define constant variables
M = 11.7;                  % cylinder mass [kg] 
M_0 = 0.7;                 % trailing support mass [kg]
M_ex = 3.4;                % extra mass mass [kg]
R = 0.235;                 % radius of cylinder [m]
R_ex = 0.019;              % radius of extra mass [m]
R_to_ex = 0.178;           % radius of cylinder to the extra component [m]
k = 0.203;                 % wheel radius of gyration [m] 
I = M*k^2;                 % cylinder moment of intertia [kg-m^2]
beta_deg = 5.5;            % slope of ramp [deg] 
beta = deg2rad(5.5);       % conversion of beta to radians [rad]
r = 0.178;                 % m 
r_extra = 0.019;           % m
g = 9.81;                  % acceleration due to gravity [m/s^2]
Mf = 0.6; 

% assiging vector to all constant variables
const = [M, k, M_0, g, R, beta, M_ex, R_to_ex, R_ex, I]; 

%% read in data for 0 < theta < 15 radians
filename = ["balanced_1.dms", "balanced_2.dms", "unbalanced_1.dms", ...
            "unbalanced_2.dms"]; 

% import .dms experimental data files from the VI
[data_b1,~,~] = importdata(filename(1));            % balanced 1
[data_b2,~,~] = importdata(filename(2));            % balanced 2
[data_ub1,~,~] = importdata(filename(3));           % unbalanced 1
[data_ub2,~,~] = importdata(filename(4));           % unbalanced 2

%% Balanced I
time_b1 = (data_b1.data(:, 1));               % time [s]
theta_b1 = (data_b1.data(:, 2));              % wheel position [rad]

% cut off all angular position values less than 15 radians
temp = find(theta_b1 <= 15);                  
theta_b1_trim = theta_b1(temp);  

theta_b1_index = length(theta_b1_trim);       % extract last desired index 
omega_b1 = (data_b1.data(:, 3));              % angular velocity [rad/s]

%% Balanced II
time_b2 = (data_b2.data(:, 1));               % time [s]
theta_b2 = (data_b2.data(:, 2));              % wheel position [rad]

% cut off all angular position values less than 15 radians
temp = find(theta_b2 <= 15); 
theta_b2_trim = theta_b2(temp); 

theta_b2_index = length(theta_b2_trim);       % extract last desired index 
omega_b2 = (data_b2.data(:, 3));              % angular velocity [rad/s]

%% Unbalanced I
time_ub1 = (data_ub1.data(:, 1));             % time [s]
theta_ub1 = (data_ub1.data(:, 2));            % wheel position [rad]

% cut off all angular position values less than 15 radians
temp = find(theta_ub1 <= 15); 
theta_ub1_trim = theta_ub1(temp); 

theta_ub1_index = length(theta_ub1_trim);     % extract last desired index  
omega_ub1 = (data_ub1.data(:, 3));            % angular velocity [rad/s]

%% Unbalanced II
time_ub2 = (data_ub2.data(:, 1));             % time [s]
theta_ub2 = (data_ub2.data(:, 2));            % wheel position [rad]

% cut off all angular position values less than 15 radians
temp = find(theta_ub2 <= 15); 
theta_ub2_trim = theta_ub2(temp); 

theta_ub2_index = length(theta_ub2_trim);     % extract last desired index 
omega_ub2 = (data_ub2.data(:, 3));            % angular velocity [rad/s]

%% run angular position experimental data through each model
% MODEL 1 
w_m1_b1 = MODEL_1(theta_b1, const);             % balanced trial 1
w_m1_b2 = MODEL_1(theta_b2, const);             % balanced trial 2

% MODEL 2 
w_m2_b1 = MODEL_2(theta_b1, const, Mf);         % balanced trial 1
w_m2_b2 = MODEL_2(theta_b2, const, Mf);         % balanced trial 2

% MODEL 3
w_m3_ub1 = MODEL_3(theta_ub1, const, Mf);       % unbalanced trial 1
w_m3_ub2 = MODEL_3(theta_ub2, const, Mf);       % unbalanced trial 2

% MODEL 4
w_m4_ub1 = MODEL_4(theta_ub1, const, Mf);       % unbalanced trial 1  
w_m4_ub2 = MODEL_4(theta_ub2, const, Mf);       % unbalanced trial 2

%% compute residual between model and experimental data

% model 1, balanced trial 1
for i = 1:length(w_m1_b1)
    residual_1a(i,1) = omega_b1(i,1) - w_m1_b1(i,1);
    res_avg_1a = mean(residual_1a);                  
    res_stdv_1a = std(residual_1a);
    
    % uncertainty of mean
    mean_unc_1a = res_stdv_1a/sqrt(length(w_m1_b1)); 
end

% model 1, balanced trial 2
for i = 1:length(w_m1_b2)
    residual_1b(i,1) = omega_b2(i,1) - w_m1_b2(i,1);
    res_avg_1b = mean(residual_1b);                  
    res_stdv_1b = std(residual_1b);
    
    % uncertainty of mean
    mean_unc_1b = res_stdv_1b/sqrt(length(w_m1_b2)); 
end

% model 2, balanced trial 1
for i = 1:length(w_m2_b1)
    residual_2a(i,1) = omega_b1(i,1) - w_m2_b1(i,1);
    res_avg_2a = mean(residual_2a);                  
    res_stdv_2a = std(residual_2a);
    
    % uncertainty of mean
    mean_unc_2a = res_stdv_2a/sqrt(length(w_m2_b1));
end

% model 2, balanced trial 2
for i = 1:length(w_m2_b2)
    residual_2b(i,1) = omega_b2(i,1) - w_m2_b2(i,1);
    res_avg_2b = mean(residual_2b);                  
    res_stdv_2b = std(residual_2b);
    
    % uncertainty of mean
    mean_unc_2b = res_stdv_2a/sqrt(length(w_m2_b2));
end

% model 3, unbalanced trial 1
for i = 1:length(w_m3_ub1)
    residual_3a(i,1) = omega_ub1(i,1) - w_m3_ub1(i,1);
    res_avg_3a = mean(residual_3a);                  
    res_stdv_3a = std(residual_3a);
    
    % uncertainty of mean
    mean_unc_3a = res_stdv_3a/sqrt(length(w_m3_ub1));
end

% model 3, unbalanced trial 2
for i = 1:length(w_m3_ub2)
    residual_3b(i,1) = omega_ub2(i,1) - w_m3_ub2(i,1);
    res_avg_3b = mean(residual_3b);                  
    res_stdv_3b = std(residual_3b);
    
    % uncertainty of mean
    mean_unc_3b = res_stdv_3b/sqrt(length(w_m3_ub2));
end

% model 4, unbalanced trial 1
for i = 1:length(w_m4_ub1)
    residual_4a(i,1) = omega_ub1(i,1) - w_m4_ub1(i,1);
    res_avg_4a = mean(residual_4a);                  
    res_stdv_4a = std(residual_4a);
    
    % uncertainty of mean
    mean_unc_4a = res_stdv_4a/sqrt(length(w_m4_ub1));
end

% model 4, unbalanced trial 2
for i = 1:length(w_m4_ub2)
    residual_4b(i,1) = omega_ub2(i,1) - w_m4_ub2(i,1);
    res_avg_4b = mean(residual_4b);                  
    res_stdv_4b = std(residual_4b);
    
    % uncertainty of mean
    mean_unc_4b = res_stdv_4b/sqrt(length(w_m4_ub2)); 
end

% compute uncertainty of mean residual for residual values > 3*stdv
for i = 1:length(residual_1a)
    n_3sig_1a = 0;
    if abs(residual_1a(i)) > 3*res_stdv_1a
    n_3sig_1a = n_3sig_1a + 1;
    end
end

for i = 1:length(residual_1b)
    n_3sig_1b = 0;
    if abs(residual_1b(i)) > 3*res_stdv_1b
    n_3sig_1b = n_3sig_1b + 1;
    end
end

for i = 1:length(residual_2a)
    n_3sig_2a = 0;
    if abs(residual_2a(i)) > 3*res_stdv_2a
    n_3sig_2a = n_3sig_2a + 1;
    end
end

for i = 1:length(residual_2b)
    n_3sig_2b = 0;
    if abs(residual_2b(i)) > 3*res_stdv_2b
    n_3sig_2b = n_3sig_2b + 1;
    end
end

for i = 1:length(residual_3a)
    n_3sig_3a = 0;
    if abs(residual_3a(i)) > 3*res_stdv_3a
    n_3sig_3a = n_3sig_3a + 1;
    end
end

for i = 1:length(residual_3b)
    n_3sig_3b = 0;
    if abs(residual_3b(i)) > 3*res_stdv_3b
    n_3sig_3b = n_3sig_3b + 1;
    end
end

for i = 1:length(residual_4a)
    n_3sig_4a = 0;
    if abs(residual_4a(i)) > 3*res_stdv_4a
    n_3sig_4a = n_3sig_4a + 1;
    end
end

for i = 1:length(residual_4b)
    n_3sig_4b = 0;
    if abs(residual_4b(i)) > 3*res_stdv_4b
    n_3sig_4b = n_3sig_4b + 1;
    end
end

%% PLOT!!!! #skobuffs #buffslove2plot

% Balanced Wheel: Model I
figure(1)
hold on;
grid minor;
title('Balanced Wheel Angular Velocity: Model I', 'Interpreter',...
       'latex','Fontsize',20)
plot(theta_b1_trim, w_m1_b1(1:theta_b1_index), 'LineStyle', 'none', ...
     'Marker', 'd', 'Color', 'k' ,  'LineWidth', 2);
plot(theta_b2_trim, w_m1_b2(1:theta_b2_index), 'LineStyle', ...
     'none', 'Marker', 'd', 'Color','r', 'LineWidth', 2);
plot(theta_b1_trim, omega_b1(1:theta_b1_index), 'Color', 'k', ...
     'LineWidth', 2);
plot(theta_b2_trim, omega_b2(1:theta_b2_index), 'Color', 'r', ...
     'LineWidth', 2);
legend('Model Trial 1', 'Model Trial 2', 'Experiment Trial 1', ...
       'Experiment Trial 2', 'Interpreter', 'latex','Fontsize',20)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',20)
ylabel('$\omega [rad/s]$','Interpreter','latex','Fontsize',20)
set(gca,'FontSize',20)

% Balanced Wheel: Model II
figure(2)
hold on;
grid minor;
title('Balanced Wheel Angular Velocity: Model II', 'Interpreter', ...
      'latex','Fontsize',20)
plot(theta_b1_trim, w_m2_b1(1:theta_b1_index), 'LineStyle', 'none', ...
     'Marker', 'd', 'Color', 'k' ,  'LineWidth', 2);
plot(theta_b2_trim, w_m2_b2(1:theta_b2_index), 'LineStyle', 'none', ...
     'Marker', 'd', 'Color', 'r' ,  'LineWidth', 2);
plot(theta_b1_trim, omega_b1(1:theta_b1_index), 'Color', 'k', ... 
     'LineWidth', 2);
plot(theta_b2_trim, omega_b2(1:theta_b2_index), 'Color', 'r', ...
     'LineWidth', 2);
legend('Model Trial 1', 'Model Trial 2', 'Experiment Trial 1', ...
       'Experiment Trial 2', 'Interpreter', 'latex','Fontsize',20)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',20)
ylabel('$\omega [rad/s]$','Interpreter','latex','Fontsize',20)
set(gca,'FontSize',20)

% Unbalanced Wheel: Model III
figure(3)
hold on;
grid minor;
title('Unbalanced Wheel Angular Velocity: Model III', 'Interpreter', ...
      'latex','Fontsize',20)
plot(theta_ub1_trim, w_m3_ub1(1:theta_ub1_index), 'LineStyle', ...
     'none', 'Marker', 'd', 'Color', 'k' ,  'LineWidth', 2);
plot(theta_ub2_trim, w_m3_ub2(1:theta_ub2_index), 'LineStyle', ...
     'none', 'Marker', 'd', 'Color', 'r' ,  'LineWidth', 2);
plot(theta_ub1_trim, omega_ub2(1:theta_ub1_index), 'Color', 'k', ...
     'LineWidth', 2);
plot(theta_ub2_trim, omega_ub2(1:theta_ub2_index), 'Color', 'r', ...
     'LineWidth', 2);
legend('Model Trial 1', 'Model Trial 2', 'Experiment Trial 1', ...
      'Experiment Trial 2', 'Interpreter', 'latex','Fontsize',20)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',20)
ylabel('$\omega [rad/s]$','Interpreter','latex','Fontsize',20)
set(gca,'FontSize',20)

% Unbalanced Wheel: Model IV
figure(4)
hold on;
grid minor;
title('Unbalanced Wheel Angular Velocity: Model IV', 'Interpreter',...
    'latex','Fontsize',20)
plot(theta_ub1_trim, w_m4_ub1(1:theta_ub1_index), 'LineStyle', ...
     'none', 'Marker', 'd', 'Color', 'k' ,  'LineWidth', 2);
plot(theta_ub2_trim, w_m4_ub2(1:theta_ub2_index), 'LineStyle', ...
     'none', 'Marker', 'd', 'Color', 'r' ,  'LineWidth', 2);
plot(theta_ub1_trim, omega_ub1(1:theta_ub1_index), 'Color', 'k', ...
     'LineWidth', 2);
plot(theta_ub2_trim, omega_ub2(1:theta_ub2_index), 'Color', 'r', ...
     'LineWidth', 2);
legend('Model Trial 1', 'Model Trial 2', 'Experiment Trial 1', ...
      'Experiment Trial 2', 'Interpreter', 'latex','Fontsize',20)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',20)
ylabel('$\omega [rad/s]$','Interpreter','latex','Fontsize',20)
set(gca,'FontSize',20)

% plot residuals
figure(5)
subplot(2,1,1)
hold on
grid minor
title('Model I',...
      'Interpreter', 'latex', 'Fontsize', 14)
plot(theta_b1, residual_1a, 'Color', 'b', 'LineWidth', 1)
plot(theta_b2, residual_1b, 'Color', 'r', 'LineWidth', 1)
legend('Trial 1', 'Trial 2',  ...
       'Interpreter', 'latex','Fontsize',10)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',10)
xlim([0 15])
ylabel('Residual [rad/s]','Interpreter','latex','Fontsize',10)
hold off

subplot(2,1,2)
hold on
grid minor
title('Model II', 'Interpreter', ...
        'latex', 'Fontsize', 14)
plot(theta_b1, residual_2a, 'Color', 'b', 'LineWidth', 1)
plot(theta_b2, residual_2b, 'Color', 'r', 'LineWidth', 1)
legend('Trial 1', 'Trial 2',  ...
       'Interpreter', 'latex','Fontsize',10)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',10)
xlim([0 15])
ylabel('Residual [rad/s]','Interpreter','latex','Fontsize',10)
sgtitle(['Residual Between Experimental Angular Velocity Data and Modeled' ...
        ' Values: Balanced Wheel'],'Interpreter', 'latex', 'Fontsize', 14)
hold off

figure(6)
subplot(2,1,1)
hold on
grid minor
title('Model III', 'Interpreter', ...
        'latex', 'Fontsize', 14)
plot(theta_ub1, residual_3a, 'Color', 'g', 'LineWidth', 1)
plot(theta_ub2, residual_3b, 'Color', 'm', 'LineWidth', 1)
legend('Trial 1', 'Trial 2',  ...
       'Interpreter', 'latex','Fontsize',10)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',10)
xlim([0 15])
ylabel('Residual [rad/s]','Interpreter','latex','Fontsize',10 ...
,      'Interpreter', 'latex', 'Fontsize', 10)
hold off

subplot(2,1,2)
hold on
grid minor
title('Model IV', 'Interpreter', ...
        'latex', 'Fontsize', 14)
plot(theta_ub1, residual_4a, 'Color', 'g', 'LineWidth', 1)
plot(theta_ub2, residual_4b, 'Color', 'm', 'LineWidth', 1)
legend('Trial 1', 'Trial 2',  ...
       'Interpreter', 'latex','Fontsize',10)
xlabel('$\theta [rad]$','Interpreter','latex','Fontsize',10)
ylabel('Residual [rad/s]','Interpreter','latex','Fontsize',10)
xlim([0 15])

sgtitle(['Residual Between Experimental Angular Velocity Data and Modeled' ...
        ' Values: Unbalanced Wheel'], 'Interpreter', 'latex', 'Fontsize', 16)
hold off

%% COMPUTE ANGULAR ACCELERATION
%Balanced wheel: Trials 1 & 2
% alpha_b1 = diff(omega_b1);
% alpha_b1 = [0; alpha_b1];
% alpha_b2 = diff(omega_b2);
% alpha_b2 = [0; alpha_b2];

%compute average change in omega over run (constant angular acceleration)
alpha_b1 = (omega_b1(theta_b1_index) - omega_b1(1))/time_b1(theta_b1_index);
alpha_b2 = (omega_b2(theta_b2_index) - omega_b2(1))/time_b2(theta_b2_index);


% function [w] = MODEL_1(theta, constants)
% 
% M = constants(1);
% k = constants(2);
% M_0 = constants(3);
% g = constants(4);
% R = constants(5);
% beta = constants(6);
% 
% I = M*k^2;
% 
% num = (2*M_0*g*R*sin(beta)*(M + M_0)).*theta;
% 
% dem = ((M + M_0)*R^2) + I;
% 
% w = sqrt(num/dem);
% end 


% function [w] = MODEL_2(theta, constants, Mf)
% 
% M = constants(1);
% k = constants(2);
% M_0 = constants(3);
% g = constants(4);
% R = constants(5);
% beta = constants(6);
% 
% I = M * k^2;
% 
% num = ((2*M_0*g*R*sin(beta)*(M + M_0)).*theta-(Mf.*theta));
% 
% dem = ((M + M_0)*R^2) + I;
% 
% w = sqrt(num/dem);
% end
% 
% function [w] = MODEL_3(theta, constants, Mf)
% Me=constants(7);
% k = constants(2);
% M=constants(1);
% M0=constants(3);
% g=constants(4);
% R=constants(5);
% beta=constants(6);
% R_te=constants(8);
% I = M * k^2;
% 
% 
% num = 2.*(((M+M0)*R*g.*theta.*sin(beta)) + (Me.*g.*R.*theta.*sin(beta)) - ...
%     (Mf.*theta) - (Me.*g.*R_te.*(cos(theta+beta)-cos(beta)))); 
% 
% den= ((M+M0).*R^2) + (Me.*(R^2+2.*R.*R_te.*cos(theta)+R_te^2)) + I;
% 
% w=sqrt(num./den);
% 
% end
% 
% function [w] = MODEL_4(theta, constants, Mf)
% Me=constants(7);
% k = constants(2);
% M=constants(1);
% M0=constants(3);
% g=constants(4);
% R=constants(5);
% beta=constants(6);
% R_te=constants(8);
% R_ex = constants(9);
% I = M * k^2;
% 
% 
% num = 2.*(((M+M0)*R*g.*theta.*sin(beta)) + (Me.*g.*R.*theta.*sin(beta)) - ...
%     (Mf.*theta) - (Me.*g.*R_te.*(cos(theta+beta)-cos(beta)))); 
% 
% den= ((M+M0).*R^2) + (Me.*(R^2+2.*R.*R_te.*cos(theta)+R_te^2)) + I + ... 
%     (1/4).*Me.*R_ex.^2;
% 
% w=sqrt(num./den);
% 
% end




