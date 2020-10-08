function e = method3(t_s,h_0)
%this function takes in the time it takes to stop a ball from boucning and
%calculates the coefficient of resitution 

%convert inital height to meters
%h_0 = h_0/100;
g = 9.81; %m/s^2

e = (t_s - sqrt((2*h_0)/g))/(t_s + sqrt((2*h_0)/g));

end