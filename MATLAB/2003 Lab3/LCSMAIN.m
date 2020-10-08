%% ASEN 2003 Lab 3: Locomotive Crank Shaft
% created on 2/14/19

%this program analyzes a locomotive crank shaft by modeling the velocity of
%the collar at different voltages using kinematic relationships

%% read in files
[theta_exp_8V,w_exp_8V,v_exp_8V] = LCSDATA('Sec013_Group3_8.csv');
[theta_exp_9_5V,w_exp_9_5V,v_exp_9_5V] = LCSDATA('Sec013_Group3_9_5.csv');
[theta_exp_11V,w_exp_11V,v_exp_11V] = LCSDATA('Sec013_Group3_11.csv');

%% Plot of measured collar velocity over the measured angle at varying volts
figure
%8 volt plot
subplot(3,1,1);
plot(theta_exp_8V,v_exp_8V);
title('Measured Vertical Velocity vs Measured Angle at 8 Volts','FontSize',12);
xlabel('Measured Angle(degrees)');
axis([0 2500 -2500 2500]);
%9.5 volt plot

subplot(3,1,2);
plot(theta_exp_9_5V,v_exp_9_5V);
title('Measured Vertical Velocity vs Measured Angle at 9.5 Volts','FontSize',12);
xlabel('Measured Angle(degrees)');
ylabel('Measured Vertical Velocity (mm/s)','FontSize',14);
axis([0 2500 -2500 2500]);
%11 volt plot

subplot(3,1,3);
plot(theta_exp_11V,v_exp_11V);
title('Measured Vertical Velocity vs Measured Angle at 11 Volts','FontSize',12);
xlabel('Measured Angle(degrees)');
axis([0 2500 -2500 2500]);


%% Plot Model data

%measurements
r = 77; %mm
d = 153 ; %mm
l = 255; %mm

figure
%8 volt 
subplot(3,1,1);
v_model_8V = LCSMODEL(r,d,l,theta_exp_8V,w_exp_8V);
plot(theta_exp_8V,v_model_8V);
title('Modeled Vertical Velocity vs Measured Angle at 8 Volts');
xlabel('Measured Angle(degrees)');
ylabel('Modeled Vertical Velocity (mm/s)');
axis([0 2500 -2500 2500]);

%9.5 volt 
subplot(3,1,2);
v_model_9_5V = LCSMODEL(r,d,l,theta_exp_9_5V,w_exp_9_5V);
plot(theta_exp_9_5V,v_model_9_5V);
title('Modeled Vertical Velocity vs Measured Angle at 9.5 Volts');
xlabel('Measured Angle(degrees)');
ylabel('Modeled Vertical Velocity (mm/s)');
axis([0 2500 -5000 5000]);

%11 volt 
subplot(3,1,3);
v_model_11V = LCSMODEL(r,d,l,theta_exp_11V,w_exp_11V);
plot(theta_exp_11V,v_model_11V);
title('Modeled Vertical Velocity vs Measured Angle at 11 Volts');
xlabel('Measured Angle(degrees)');
ylabel('Modeled Vertical Velocity (mm/s)');
axis([0 2500 -5000 5000]);



