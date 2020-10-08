%% Prelab 7
clear all; close all; clc;
%% 1c
Vmin = 0; Vmax = 3.3;
b1 = 4; b2 = 8; b3 = 12;
V = [0 .25 .5 .75 1 1.25 1.5 1.75 2 2.25 2.5 2.75 3 3.25];
[binNum1] = Voltage2Bin(Vmin,Vmax,b1,V);
[binNum2] = Voltage2Bin(Vmin,Vmax,b2,V);
[binNum3] = Voltage2Bin(Vmin,Vmax,b3,V);
figure(1)
plot(V,binNum1,'*',V,binNum2,'*',V,binNum3,'*','LineWidth',4)
legend('4 Bits','8 Bits','12 Bits')
xlabel('Voltage (V)')
ylabel('Bin Number')

%% 1d
Vmax = 3.3+1.65;
Vmin = 1.65;
V = linspace(Vmin,Vmax,50);
Vidx = 1:length(V);
b1d = 12;
figure(2)
[binNum1d] = Voltage2Bin(Vmin,Vmax,b1d,V);
plot(Vidx,binNum1d,'*','LineWidth',2)
xlabel('Array Number')
ylabel('Bin Number')
