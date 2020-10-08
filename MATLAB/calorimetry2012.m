%%this script takes in a text file of calorimetr data and
%determines the specific heat of the sample by calculating the
%initial and final temperature

%read in text file
[time,waterTemp,sampleTemp1,sampleTemp2] = readCalData('smallerSampleB.txt');

% SAMPLE B mass: 
sampleMass = 114.400; %g
s_mass_uncertainty = .001; %g
% CALORIMETER mass: 
calMass = 318.3;
cal_mass_uncertainty = .05; %g
figure;
plot(time,sampleTemp1);