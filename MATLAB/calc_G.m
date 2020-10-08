%this function calculates the G's experienced by the passenger
function G = calc_G(N, m)
%takes in the total normal force acting on the passanger and the mass
%outputs the "Gs" 

%gracity
g = 9.81; %m/s^2

G = N/(m*g);

end