%% Mast Model (CASE 1: tipping side to side)
% model the normal force on a rover wheel as the rover tips with varying
% angles
%10/7/20
clc;
clear;
close all;
%% givens
m_top = linspace(0,5,6); %kg, mass on top of mast
m_mast = m_top; %mass of mast
m_body = 20; %kg, mass of rover body (17kg is mass of HERMES)
h_mast = 5;%linspace(10, 0, 5): %m, height of mast
w_body = 0.5; %m, width of body
l_body = 0.7; %m, length of body
h_body = 0.2; %m, height of body
g = 9.81; %kg-m/s2, gravity

figure(1)
%loop through different masses
for i = 1:6
    

%iterate through various angles created by obstacle
thetas = 0:1:90; % degrees

%% calculate the cgs
%for mast and top
z_mast = (h_body + (h_mast/2) + ((w_body/2)./sind(thetas))).*cosd(thetas);
z_top = (h_body + h_mast + ((w_body/2)./sind(thetas))).*cosd(thetas);
z_body = ((h_body/2) + (w_body./(2.*sind(thetas)))).*cosd(thetas);

y_mast = (z_mast - (h_body + (h_mast/2))./cosd(thetas))./tand(thetas);
y_top = (z_top - (h_body + h_mast)./cosd(thetas))./tand(thetas);
y_body = (z_body - (h_body./(2.*cosd(thetas))))./tand(thetas);


%for entire system
m_total = m_body + m_mast(i) + m_top(i); %total mass of entire system
z_cg = ((m_body*z_body) + (m_mast(i)*z_mast) + (m_top(i) * z_top))/m_total;
y_cg = ((m_body*y_body) + (m_mast(i)*y_mast) + (m_top(i) * y_top))/m_total;
%% Equations of Motion

%solve for normal force on right wheel
N_r = (y_cg.*(m_total*g))./((2.*y_cg.*cosd(thetas)) - (z_cg.*sind(thetas)));


%% Plot
plot(thetas, N_r)
title('Normal Force on Right Wheel vs Theta')
xlabel('Theta (degrees)')
ylabel('Normal Force (N)')

grid on
hold on
end
%mark angle where 7cm obstacle would be
xline(asind(0.07/w_body), '--r');
legend('Mass on Top = 0kg','Mass on Top = 1kg', 'Mass on Top = 2kg',...
    'Mass on Top = 3kg', 'Mass on Top = 4kg', 'Mass on Top = 5kg', 'Angle created by 7cm tall obstacle');


figure(2)
m_top = 5;
m_mast = 5;
h_mast = linspace(0, 5, 6); %m, height of mast
%loop through different heights
for i = 1:6
    

%iterate through various angles created by obstacle
thetas = 0:1:90; % degrees

%% calculate the cgs
%for mast and top
z_mast = (h_body + (h_mast(i)/2) + ((w_body/2)./sind(thetas))).*cosd(thetas);
z_top = (h_body + h_mast(i) + ((w_body/2)./sind(thetas))).*cosd(thetas);
z_body = ((h_body/2) + (w_body./(2.*sind(thetas)))).*cosd(thetas);

y_mast = (z_mast - (h_body + (h_mast(i)/2))./cosd(thetas))./tand(thetas);
y_top = (z_top - (h_body + h_mast(i))./cosd(thetas))./tand(thetas);
y_body = (z_body - (h_body./(2.*cosd(thetas))))./tand(thetas);


%for entire system
m_total = m_body + m_mast + m_top; %total mass of entire system
z_cg = ((m_body*z_body) + (m_mast*z_mast) + (m_top * z_top))/m_total;
y_cg = ((m_body*y_body) + (m_mast*y_mast) + (m_top * y_top))/m_total;
%% Equations of Motion

%solve for normal force on right wheel
N_r = (y_cg.*(m_total*g))./((2.*y_cg.*cosd(thetas)) - (z_cg.*sind(thetas)));


%% Plot
plot(thetas, N_r)
title('Normal Force on Right Wheel vs Theta')
xlabel('Theta (degrees)')
ylabel('Normal Force (N)')
grid on
hold on
end

%mark angle where 7cm obstacle would be
xline(asind(0.07/w_body), '--r');
legend('Height of Mast = 0m','Height of Mast = 1m', 'Height of Mast = 2m',...
    'Height of Mast = 3m', 'Height of Mast = 4m', 'Height of Mast = 5m', 'Angle created by 7cm tall obstacle');
