%ASEN 3112 Lab 2 Main
%Author: Emily Riley
%Date: 3/20/20
%Description: This code loads in the experimental data and produces plots
%for the displacement vs loading, reaction forces vs loading, and internal
%forces vs loading. It then analyzes the uncertainty using linear
%regression. 

%% Housekeeping
clc; clear all; close all;
%% Conversions
lbtoN = 4.44822; 
intomm = 25.400013716;

%% Question 1: Experimental Results
inc_10 = load('ASEN3112-Sp20-Lab2Data-10lbincrements');
inc_5 = load('ASEN3112-Sp20-Lab2Data-5lbincrements');

%Use conversions on the data and normalize LVDT
inc_10(:,1:5) = inc_10(:,1:5)*lbtoN;
inc_5(:,1:5) = inc_5(:,1:5)*lbtoN;

inc_10(:,6) = (inc_10(:,6)-inc_10(1,6))*intomm;
inc_5(:,6) = (inc_5(:,6)-inc_5(1,6))*intomm;

inc_10(:,5) = (inc_10(:,5)-inc_10(1,5));
inc_5(:,5) = (inc_5(:,5) - inc_5(1,5));


%Displacement 
%5 lb increments
figure
plot(inc_5(1:105,1),inc_5(1:105,6),'b')
hold on
plot(inc_5(105:210,1),inc_5(105:210,6),'--b')
hold on
plot(inc_10(1:55,1),inc_10(1:55,6),'r')
hold on 
plot(inc_10(55:end,1),inc_10(55:end,6),'--r')
title('Displacement vs Loading for 5 and 10 lb Increments')
xlabel('Load (N)')
ylabel('Displacement (mm)')
legend('5 lb Loading','5 lb Unloading','10 lb Loading','10 lb Unloading','Location','NorthWest')

%Forces
%5 lb increments
figure
plot(inc_5(1:105,1),inc_5(1:105,2),'b')
hold on
plot(inc_5(1:105,1),inc_5(1:105,3),'r')
hold on
plot(inc_5(1:105,1),inc_5(1:105,4),'g')
hold on
%plot(inc_5(1:105,1),inc_5(1:105,5))
hold on
plot(inc_5(105:end,1),inc_5(105:end,2),'--b')
hold on
plot(inc_5(105:end,1),inc_5(105:end,3),'--r')
hold on
plot(inc_5(105:end,1),inc_5(105:end,4),'--g')
hold on
legend('F0','F1','F2','Location','NorthWest')
title('Reaction Forces vs Loading for 5 lb Increments')
xlabel('Load (N)')
ylabel('Reaction Force (N)')

%10 lb increments
figure
plot(inc_10(1:55,1),inc_10(1:55,2),'b')
hold on
plot(inc_10(1:55,1),inc_10(1:55,3),'r')
hold on
plot(inc_10(1:55,1),inc_10(1:55,4),'g')
hold on
plot(inc_10(55:end,1),inc_10(55:end,2),'--b')
hold on
plot(inc_10(55:end,1),inc_10(55:end,3),'--r')
hold on
plot(inc_10(55:end,1),inc_10(55:end,4),'--g')
hold on
legend('F0','F1','F2','Location','NorthWest')
title('Reaction Forces vs Loading for 10 lb Increments')
xlabel('Load (N)')
ylabel('Reaction Force (N)')


%Internal Forces
%Both increments
figure
plot(inc_5(1:105,1),inc_5(1:105,5),'b')
hold on
plot(inc_5(105:end,1),inc_5(105:end,5),'--b')
hold on
plot(inc_10(1:55,1),inc_10(1:55,5),'r')
hold on
plot(inc_10(55:end,1),inc_10(55:end,5),'--r')
legend('5 lb Loading','5 lb Unloading','10 lb Loading','10 lb Unloading','Location','NorthWest')
title('Internal Forces vs Loading for 5 and 10 lb Increments')
xlabel('Loading (N)')
ylabel('Internal Force (N)')


%% Linear Regression and Error Analysis
%Error for Displacements
%5 lb increments
[xd5,yd5,max_devd5,uncertaintyd5]= exp_error(inc_5(1:110,1),inc_5(1:110,6),5);

% 10 lb increments 
[xd10,yd10,max_devd10,uncertaintyd10]= exp_error(inc_10(1:60,1),inc_10(1:60,6),10);

%Error for Forces
% 5 lb increments
[xf0_5,yf0_5,max_devf0_5,uncertaintyf0_5] = exp_error(inc_5(1:110,1),inc_5(1:110,2),5);
[xf1_5,yf1_5,max_devf1_5,uncertaintyf1_5] = exp_error(inc_5(1:110,1),inc_5(1:110,3),5);
[xf2_5,yf2_5,max_devf2_5,uncertaintyf2_5] = exp_error(inc_5(1:110,1),inc_5(1:110,4),5);
[xfint_5,yfint_5,max_devfint_5,uncertaintyfint_5] = exp_error(inc_5(1:110,1),inc_5(1:110,5),5);
%10 lb increments
[xf0_10,yf0_10,max_devf0_10,uncertaintyf0_10] = exp_error(inc_10(1:60,1),inc_10(1:60,2),10);
[xf1_10,yf1_10,max_devf1_10,uncertaintyf1_10] = exp_error(inc_10(1:60,1),inc_10(1:60,3),10);
[xf2_10,yf2_10,max_devf2_10,uncertaintyf2_10] = exp_error(inc_10(1:60,1),inc_10(1:60,4),10);
[xfint_10,yfint_10,max_devfint_10,uncertaintyfint_10] = exp_error(inc_10(1:60,1),inc_10(1:60,5),10);

