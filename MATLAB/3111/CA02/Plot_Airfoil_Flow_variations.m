function Plot_Airfoil_Flow_variations(c,alpha,V_inf,p_inf,rho_inf,N)
%Plot_Airfoil_Flow_variations plot the flow over an airfoil with changing
%values
%   This function plots the streamlines, equipotential lines, and pressure 
%   contours for flow about a thin airfoil using approximation. Takes in
%   vectors of varying chord length, angle of attack, and freesteam
%   velocities
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/10/19


%loop through each variation (5 different values for each)
%keep track of how many plots for placing in subplot
%there will be three plots (for each varying variable) each with 15 (5 stream
% functions, 5 equipotentials, and 5 pressure contours) plots inside
plot_num = 1;
%format plots to see everything
x0=10;
y0=10;
width=1500;
height=400;

% original givens
c_orig = 2; %m
alpha_orig = deg2rad(12); %radians
V_inf_orig = 68; % m/s

%% loop through changes in chord length
figure % all on same figure
set(gcf,'position',[x0,y0,width,height]);
for i = 1:length(c)
    % Define Domain
    xmin=-1;
    xmax=3 + c(i);
    ymin=-2 - c(i)/2;
    ymax=1.5 + c(i)/2;

    % Define Number of Grid Points
    nx=100; % steps in the x direction
    ny=100; % steps in the y direction

    % Create mesh over domain using number of grid points specified
    [x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));
    
    plot_num = i;
    %% Streamlines
    %sum up discretized strenghts
    dx = c(i)/N;
    x_c = dx/2:dx:c(i)-dx/2;
    %strength
    Gamma = 2.*alpha_orig.*V_inf_orig.*sqrt((1-(x_c./c(i)))./(x_c./c(i))).*dx;
    xGamma = x_c;  % location of vortex
    yGamma = 0;

    % Define a function which calculates the radius.
    % Center of circle = (x1,y1)
    radius= @(x,y,x1,y1) sqrt((x-x1).^2+(y-y1).^2);

    % Calculate psi for uniform stream (Eq. 3.55; pg. 310)
    Psi_U0 = (V_inf_orig.*y.*cos(alpha_orig) - V_inf_orig.*x.*sin(alpha_orig));

    % Calculate psi for vortex (Eq. 3.114; pg. 310)
    Psi_Gamma = 0;
    % sum up each stream function (superposition)
    for j = 1:length(x_c)
        Psi_Gamma = Psi_Gamma + Gamma(j)/(2*pi)*log(radius(x,y,xGamma(j),yGamma));
    end
    % Add all streamfunctions together
    StreamFunction = Psi_U0 + Psi_Gamma; %Psi_U0

    % Plot streamfunction at levels
    subplot(2,5,plot_num);
    plot_num = plot_num + 5; %plot equipotentials on row below
    contour(x,y,StreamFunction, 30);
    hold on
    plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
    % Adjust axis and label figure
    axis equal
    axis([xmin xmax ymin ymax])
    ylabel('y')
    xlabel('x')
    title("Streamlines with c = " + c(i) + " m");

    %% Equipotentials

    %potential for uniform flow
    Phi_U = (V_inf_orig.*y.*sin(alpha_orig) - V_inf_orig.*x.*cos(alpha_orig));

    %potential for vortices
    Phi_Gamma = 0;
    % sum up each stream function (superposition)
    for j = 1:length(x_c)
        theta = atan2(y,x-x_c(j));
        Phi_Gamma = Phi_Gamma + -Gamma(j)/(2*pi)*theta;
    end

    %add potential together
    Equipotentials = Phi_U + Phi_Gamma;

    % Plot equipotentials
    subplot(2,5,plot_num);
    contour(x,y,Equipotentials, 30);
    colorbar
    hold on
    plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
    % Adjust axis and label figure
    axis equal
    axis([xmin xmax ymin ymax])
    ylabel('y')
    xlabel('x')
    title("Equipotentials with c = " + c(i) + " m");
    
end

%% loop through changes in angle of attack
figure % all on same figure
set(gcf,'position',[x0,y0,width,height]);
for i = 1:length(alpha)
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
    
    plot_num = i;
    %sum up discretized strenghts
    dx = c_orig/N;
    x_c = dx/2:dx:c_orig-dx/2;
    %strength
    Gamma = 2.*alpha(i).*V_inf_orig.*sqrt((1-(x_c./c_orig))./(x_c./c_orig)).*dx;
    xGamma = x_c;  % location of vortex
    yGamma = 0;

    % Define a function which calculates the radius.
    % Center of circle = (x1,y1)
    radius= @(x,y,x1,y1) sqrt((x-x1).^2+(y-y1).^2);

    % Calculate psi for uniform stream (Eq. 3.55; pg. 310)
    Psi_U0 = (V_inf_orig.*y.*cos(alpha(i)) - V_inf_orig.*x.*sin(alpha(i)));

    % Calculate psi for vortex (Eq. 3.114; pg. 310)
    Psi_Gamma = 0;
    % sum up each stream function (superposition)
    for j = 1:length(x_c)
        Psi_Gamma = Psi_Gamma + Gamma(j)/(2*pi)*log(radius(x,y,xGamma(j),yGamma));
    end
    % Add all streamfunctions together
    StreamFunction = Psi_U0 + Psi_Gamma; %Psi_U0

    % Plot streamfunction at levels
    subplot(2,5,plot_num);
    plot_num = plot_num + 5; %plot equipotentials on row below
    contour(x,y,StreamFunction, 30);
    hold on
    plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
    % Adjust axis and label figure
    axis equal
    axis([xmin xmax ymin ymax])
    ylabel('y')
    xlabel('x')
    title("Streamlines with alpha = " + alpha(i) + " radians");

    %% Equipotentials

    %potential for uniform flow
    Phi_U = (V_inf_orig.*y.*sin(alpha(i)) - V_inf_orig.*x.*cos(alpha(i)));

    %potential for vortices
    Phi_Gamma = 0;
    % sum up each stream function (superposition)
    for j = 1:length(x_c)
        theta = atan2(y,x-x_c(j));
        Phi_Gamma = Phi_Gamma + -Gamma(j)/(2*pi)*theta;
    end

    %add potential together
    Equipotentials = Phi_U + Phi_Gamma;

    % Plot equipotentials
    subplot(2,5,plot_num);
    contour(x,y,Equipotentials, 30);
    colorbar
    hold on
    plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
    % Adjust axis and label figure
    axis equal
    axis([xmin xmax ymin ymax])
    ylabel('y')
    xlabel('x')
    title("Equipotentials with alpha = " + alpha(i) + " radians");
end

%% loop through changes in V_inf
figure % all on same figure
set(gcf,'position',[x0,y0,width,height]) 
for i = 1:length(V_inf)
   
    plot_num = i;
    %sum up discretized strenghts
    dx = c_orig/N;
    x_c = dx/2:dx:c_orig-dx/2;
    %strength
    Gamma = 2.*alpha_orig.*V_inf(i).*sqrt((1-(x_c./c_orig))./(x_c./c_orig)).*dx;
    xGamma = x_c;  % location of vortex
    yGamma = 0;

    % Define a function which calculates the radius.
    % Center of circle = (x1,y1)
    radius= @(x,y,x1,y1) sqrt((x-x1).^2+(y-y1).^2);

    % Calculate psi for uniform stream (Eq. 3.55; pg. 310)
    Psi_U0 = (V_inf(i).*y.*cos(alpha_orig) - V_inf(i).*x.*sin(alpha_orig));

    % Calculate psi for vortex (Eq. 3.114; pg. 310)
    Psi_Gamma = 0;
    % sum up each stream function (superposition)
    for j = 1:length(x_c)
        Psi_Gamma = Psi_Gamma + Gamma(j)/(2*pi)*log(radius(x,y,xGamma(j),yGamma));
    end
    % Add all streamfunctions together
    StreamFunction = Psi_U0 + Psi_Gamma; %Psi_U0

    % Plot streamfunction at levels
    subplot(2,5,plot_num);
    plot_num = plot_num + 5; %plot equipotentials on row below
    contour(x,y,StreamFunction, 30);
    hold on
    plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
    % Adjust axis and label figure
    axis equal
    axis([xmin xmax ymin ymax])
    ylabel('y')
    xlabel('x')
    title("Streamlines with Vinf = " + V_inf(i) + " m/s");

    %% Equipotentials

    %potential for uniform flow
    Phi_U = (V_inf(i).*y.*sin(alpha_orig) - V_inf(i).*x.*cos(alpha_orig));

    %potential for vortices
    Phi_Gamma = 0;
    % sum up each stream function (superposition)
    for j = 1:length(x_c)
        theta = atan2(y,x-x_c(j));
        Phi_Gamma = Phi_Gamma + -Gamma(j)/(2*pi)*theta;
    end

    %add potential together
    Equipotentials = Phi_U + Phi_Gamma;

    % Plot equipotentials
    subplot(2,5,plot_num);
    contour(x,y,Equipotentials, 30);
    colorbar
    hold on
    plot(xGamma,zeros(1,N),'LineWidth', 5, 'Color', 'k');
    % Adjust axis and label figure
    axis equal
    axis([xmin xmax ymin ymax])
    ylabel('y')
    xlabel('x')
    title("Equipotentials with Vinf = " + V_inf(i) + " m/s");
end