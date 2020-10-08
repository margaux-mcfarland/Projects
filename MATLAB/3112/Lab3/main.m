%% ASEN 3112 Lab 3 - main
% this script reads in the experimental data for Lab 3 and plots/analyzes
% the data

clc
clear all
close all

%% load in data
expData = parseFile('5mincenter_renamed.csv');

%givens
f_sweep = linspace(2,50, length(expData.time)); %Hz
d_1 = 11; %in, distance from 0 (center) to 1 (tail)
d_2 = 10.5; %in, distance from 0 (center) to 2 (nose)
d_3 = 8.5; %in, distance from 0 (center) to 3 (wingtip)

%% normailize results
%displacements
disp0 = expData.disp0./expData.disp0;
disp1 = expData.disp1./expData.disp0;
disp2 = expData.disp2./expData.disp0;
disp3 = expData.disp3./expData.disp0;
disp4 = expData.laser_disp./expData.disp0;
%accelerations
acc0 = expData.acc0./expData.acc0;
acc1 = expData.acc1./expData.acc0;
acc2 = expData.acc2./expData.acc0;
acc3 = expData.acc3./expData.acc0;


%% plot response: displacement vs frequency
figure(1)
sgtitle('Displacement vs Excitation Frequency');
subplot(3,2,1)
plot(f_sweep, disp0);
xlabel('Frequency (Hz)');
ylabel('Displacement (mm)');
title('Channel 0: Center');
subplot(3,2,2)
plot(f_sweep, disp1);
xlabel('Frequency (Hz)');
ylabel('Displacement (mm)');
title('Channel 1: Tail');
subplot(3,2,3)
plot(f_sweep, disp2);
xlabel('Frequency (Hz)');
ylabel('Displacement (mm)');
title('Channel 2: Nose');
subplot(3,2,4)
plot(f_sweep, disp3);
xlabel('Frequency (Hz)');
ylabel('Displacement (mm)');
title('Channel 3: Wing Tip');
subplot(3,2,5)
plot(f_sweep, disp4);
xlabel('Frequency (Hz)');
ylabel('Displacement (mm)');
title('Vibrometer: Tail displacement');

%% plot response: acceleration vs frequency
figure(2)
sgtitle('Acceleration vs Excitation Frequency');
subplot(2,2,1)
plot(f_sweep, acc0);
xlabel('Frequency (Hz)');
ylabel('Acceleration (mm/s^2)');
title('Channel 0: Center');
subplot(2,2,2)
plot(f_sweep, acc1);
xlabel('Frequency (Hz)');
ylabel('Acceleration (mm/s^2)');
title('Channel 1: Tail');
subplot(2,2,3)
plot(f_sweep, acc2);
xlabel('Frequency (Hz)');
ylabel('Acceleration (mm/s&2)');
title('Channel 2: Nose');
subplot(2,2,4)
plot(f_sweep, disp3);
xlabel('Frequency (Hz)');
ylabel('Acceleration (mm/s^2)');
title('Channel 3: Wing Tip');

%% fine resonant frequency

%find frequency at peak amplitude
index_max0 = find(disp0 == max(disp0), 1);
index_max1 = find(disp1 == max(disp1));
index_max2 = find(disp2 == max(disp2));
index_max3 = find(disp3 == min(disp3));
index_max4 = find(disp4 == min(disp4));

res_freq1 = f_sweep(index_max1)*(2*pi) %rad/s
res_freq2 = f_sweep(index_max2)*(2*pi) %rad/s
res_freq3 = f_sweep(index_max3)*(2*pi) %rad/s
res_freq4 = f_sweep(index_max4)*(2*pi) %rad/s




