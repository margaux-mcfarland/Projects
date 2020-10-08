function [L, D] = airfoilLiftDrag(N)
%airfoilLiftDrag This function takes in a number of integration points and
%then solves for lift and drag using Cp.mat to get the coefficient of
%pressure. Uses a NACA 0012 air foil.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 9/19/19

%given variables
c = 2; %chord length [m]
alpha = 9; %angle of attack [deg]
d = 1; %diameter [m]
v = 30; %freestream airspeed [m/s]
rho = 1.225; %air density
p = 101.3e3; %free stream pressure [Pa]
q = (1/2)*rho*v^2; %dynamic pressure

%percent location along chord (x/c)
x = 0:1/N:1;
%x = linspace(0,c, N);
load Cp
%cp value at each location (upper surface)
cp_up = fnval(Cp_upper, x);
%cp value at each location (lower surface)
cp_low = fnval(Cp_lower, x);

P_up = q.*cp_up + p; %solve for pressure
P_low = q.*cp_low + p; %solve for pressure

%get thickness (NACA 0012)
t = 12/100;
y_t = (t/0.2)*c.*(0.2969.*sqrt(x) - 0.1260.*x - 0.3516.*x.^2 + 0.2843.*x.^3 - 0.1038.*x.^4);

%normal force (coefficient)
cn = (1/c)*trapRule(c.*x,cp_low-cp_up, N-1);
%axial force (coefficient)
ca = (1/c)*trapRule(y_t, cp_up-cp_low, N-1);

%coefficients
cl = cn*cosd(alpha) - ca*sind(alpha);
cd = cn*sind(alpha) + ca*cosd(alpha);

L = cl*q;
D = cd*q;

end