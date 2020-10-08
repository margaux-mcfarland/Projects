function ddt = g_fun(t,state_vec, m_init)

%unpack state vector
x = state_vec(1, 1); %position in east direction 
y = state_vec(2, 1); %position in the upward direction
z = state_vec(3, 1); %position in the north direction
dxdt = state_vec(4, 1); %inertial velocity in east direction
dydt = state_vec(5, 1); %inertial velocity in east direction
dzdt = state_vec(6, 1); %wind velcoity in the north direction (body frame)
drag = state_vec(7, 1); %drag

% ddt(1,1) = inertial velocity in east direction
% ddt(1,2) = inertial velocity in the upward direction
% ddt(1,3) = inertial velocity in the north direction
% ddt(1,4) = inertial acceleration in the east direction
% ddt(1,5) = inertial acceleration in the upward direction
% ddt(1,6) = inertial acceleration in the north direction
% ddt(1,7) = change in drag over time

%givens
m = m_init;
d = 0.03; %diameter, [m]
cod = 0.6; %coefficient of drag

%magnitude of the airspeed (given inetial velocity and wind)
v = sqrt(dxdt^2 + dydt^2 + dzdt^2);  
v_e = sqrt(dxdt^2 + dydt^2); %inertial velocity

%constants
area = pi*(d/2)^2; %reference area of golf ball
rho = 1.225; %density of air [kg/m^3]
g = -9.8; %gravity, m/s^2

f_d = -(1/2)*rho*cod*area*v^2;

theta = atan(dydt/dxdt); %angle of climb (radians)
xi = atan(dzdt/v_e); %azimuth (radians)
net_force_x = f_d*cos(theta);
net_force_y = f_d*sin(theta) + m*g;
net_force_z = f_d*sin(xi);
ddxdt = net_force_x/m;
ddydt = net_force_y/m;
ddzdt = net_force_z/m;

ddt = [dxdt; dydt; dzdt; ddxdt; ddydt; ddzdt; f_d];
end 
