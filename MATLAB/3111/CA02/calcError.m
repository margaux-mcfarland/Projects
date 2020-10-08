function [error_V, error_P] = calcError(c,alpha,V_inf,p_inf,rho_inf,N)
%calcError calculates the error of Pressure and Velocity with a given N
%   This function takes in a number of vortices (N vector) and calculates the max velocity
%   and max pressure of the flow and compares it to the actual value which
%   is estimated using a large number of voritices. The function then
%   returns that error 
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/10/19

%% get estimates values
% Define Domain
xmin=-1;
xmax=3;
ymin=-2;
ymax=1.5;

% Define Number of Grid Points
nx=100; % steps in the x direction
ny=100; % steps in the y direction

% Create mesh over domain using number of grid points specified
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));

%sum up discretized strenghts
dx = c/N;
x_c = dx/2:dx:c-dx/2;

%strength
Gamma = 2.*alpha.*V_inf.*sqrt((1-(x_c./c))./(x_c./c)).*dx;
xGamma = x_c;  % location of vortex
yGamma = 0;

% Define a function which calculates the radius.
% Center of circle = (x1,y1)
radius= @(x,y,x1,y1) sqrt((x-x1).^2+(y-y1).^2);

% Calculate psi for uniform stream (Eq. 3.55; pg. 310)
Psi_U0 = (V_inf.*y.*cos(alpha) - V_inf.*x.*sin(alpha));

%get components of velocity - uniform
u_U = V_inf*cos(alpha);
v_U = V_inf*sin(alpha);

%get components of velocity - vortex
V_r_Gamma = 0;
V_theta_Gamma_x = 0;
V_theta_Gamma_y = 0;
for i = 1:length(x_c)
    theta = atan2(y,x-x_c(i));
    V_theta_Gamma_x =  V_theta_Gamma_x + (Gamma(i)./(2.*pi.*radius(x,y,xGamma(i),yGamma)).*sin(theta));
    V_theta_Gamma_y =  V_theta_Gamma_y + (-Gamma(i)./(2.*pi.*radius(x,y,xGamma(i),yGamma)).*cos(theta));
end

%add components and get magnitude
V = sqrt((u_U + V_r_Gamma+ V_theta_Gamma_x).^2 + (v_U + V_theta_Gamma_y).^2);

%get V max
V_max = max(max(V));

%pressure coefficient
cp = 1 - (V./V_inf).^2;
%dynamic pressure
q_inf = (1/2)*rho_inf*V_inf^2;
P = cp.*q_inf + p_inf;

%get max P

P_max = max(max(P));

%% get actual values
N_high = 1000;
%sum up discretized strenghts
dx = c/N_high;
x_c = dx/2:dx:c-dx/2;

%strength
Gamma = 2.*alpha.*V_inf.*sqrt((1-(x_c./c))./(x_c./c)).*dx;
xGamma = x_c;  % location of vortex
yGamma = 0;

% Define a function which calculates the radius.
% Center of circle = (x1,y1)
radius= @(x,y,x1,y1) sqrt((x-x1).^2+(y-y1).^2);

% Calculate psi for uniform stream (Eq. 3.55; pg. 310)
Psi_U0 = (V_inf.*y.*cos(alpha) - V_inf.*x.*sin(alpha));

%get components of velocity - uniform
u_U = V_inf*cos(alpha);
v_U = V_inf*sin(alpha);

%get components of velocity - vortex
V_r_Gamma = 0;
V_theta_Gamma_x = 0;
V_theta_Gamma_y = 0;
for i = 1:length(x_c)
    theta = atan2(y,x-x_c(i));
    V_theta_Gamma_x =  V_theta_Gamma_x + (Gamma(i)./(2.*pi.*radius(x,y,xGamma(i),yGamma)).*sin(theta));
    V_theta_Gamma_y =  V_theta_Gamma_y + (-Gamma(i)./(2.*pi.*radius(x,y,xGamma(i),yGamma)).*cos(theta));
end

%add components and get magnitude
V = sqrt((u_U + V_r_Gamma+ V_theta_Gamma_x).^2 + (v_U + V_theta_Gamma_y).^2);

%get V max
V_max_actual = max(max(V));

%pressure coefficient
cp = 1 - (V./V_inf).^2;
%dynamic pressure
q_inf = (1/2)*rho_inf*V_inf^2;
P = cp.*q_inf + p_inf;

%get max P

P_max_actual = max(max(P));

%% calculate error

error_V = abs(V_max - V_max_actual)/V_max_actual;
error_P = abs(P_max - P_max_actual)/P_max_actual;


end