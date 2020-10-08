%%this script takes in a text file of calorimetr data and
%determines the specific heat of the sample by calculating the
%initial and final temperature

%read in text file
[time,waterTemp,sampleTemp1,sampleTemp2] = readCalData('Sample_B.txt');

% SAMPLE B mass: 
sample_mass = 114.400; %g
s_mass_uncertainty = .001; %g
% CALORIMETER mass: 
cal_mass = 318.3; %g
cal_mass_uncertainty = .05; %g

%plot
figure(1);
scatter(time,sampleTemp1,'*');
grid on;
figure(2);
scatter(time,sampleTemp2);
grid on;


%at t=300 sec, sample is removed
%water temp at 300 sec is intial temp of sample
T_1 = waterTemp(300);



