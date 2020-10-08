%ASEN 3200: Lab 1
%Date modified: 1/28/19

%% Question 11

%givens for scenario 2
t_p = 13.5*60; %second, time past periapsis
T = 6.3 * 3600; %seconds, orbit period
n = (2*pi)/T; %rad/s, mean motion
E = solveKepler(e, t_p, n);
