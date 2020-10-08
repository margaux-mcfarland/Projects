function Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N)
%Plot_Airfoil_Flow plot the flow over an airfoil
%   This function plots the streamlines, equipotential lines, and pressure 
%   contours for flow about a thin airfoil using approximation.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/10/19

%% Define Domain
xmin=-1;
xmax=3;
ymin=-2;
ymax=1.5;

% Define Number of Grid Points
nx=100; % steps in the x direction
ny=100; % steps in the y direction

% Create mesh over domain using number of grid points specified
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));

%% Streamlines

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

% Calculate psi for vortex (Eq. 3.114; pg. 310)
Psi_Gamma = 0;
% sum up each stream function (superposition)
for i = 1:length(x_c)
    Psi_Gamma = Psi_Gamma + Gamma(i)/(2*pi)*log(radius(x,y,xGamma(i),yGamma));
end
% Add all streamfunctions together
StreamFunction = Psi_U0 + Psi_Gamma; %Psi_U0
% Determine color levels for contours
levmin = StreamFunction(1,nx); % defines the color levels -> trial and error to find a good representation
levmax = StreamFunction(ny,nx/2);
levels = linspace(levmin,levmax,50)';

% Plot streamfunction at levels
figure
contourf(x,y,StreamFunction, 60);
hold on
plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
% Adjust axis and label figure
axis equal
axis([xmin xmax ymin ymax])
ylabel('y')
xlabel('x')
title("Streamlines: N = " + N + " vortices");

%% Equipotentials

%potential for uniform flow
Phi_U = (V_inf.*y.*sin(alpha) - V_inf.*x.*cos(alpha));

%potential for vortices
Phi_Gamma = 0;
% sum up each stream function (superposition)
for i = 1:length(x_c)
    theta = atan2(y,x-x_c(i));
    Phi_Gamma = Phi_Gamma + -Gamma(i)/(2*pi)*theta;
end

%add potential together
Equipotentials = Phi_U + Phi_Gamma;

% Plot equipotentials
figure
contourf(x,y,Equipotentials, 60);
colorbar
hold on
plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
% Adjust axis and label figure
axis equal
axis([xmin xmax ymin ymax])
ylabel('y')
xlabel('x')
title("Equipotentials: N = " + N + " vortices");


%% Pressure Contours

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

%pressure coefficient
cp = 1 - (V./V_inf).^2;
%dynamic pressure
q_inf = (1/2)*rho_inf*V_inf^2;
P = cp.*q_inf + p_inf;

% Plot pressure contours
figure
contourf(x,y,P, 60);
col = colorbar;
col.Label.String = 'Pressure (Pa)';
hold on
plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
% Adjust axis and label figure
axis equal
axis([xmin xmax ymin ymax])
ylabel('y')
xlabel('x')
title("Pressure Contours: N = " + N + " vortices");
fprintf("min pressure with %d vorticies: %f Pa\n",N,min(min(P)));
fprintf("max velocity with %d vorticies: %f m/s\n",N,max(max(V)));
fprintf('********************************************\n');
end