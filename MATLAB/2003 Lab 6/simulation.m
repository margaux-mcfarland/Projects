
%% user defined variables
%proportional gain applied to the hub angle measured
K1 = 10;
%proportional gain applied to the top sensor measurement
K2 = -35;
%Derivative gain applied to the hub angle rate
K3 = 0.1;
%derivative gain applied to the tip sensor rate
K4 = 0.1;

thetad = 1;

%% constants
Kg = 33.3; %dimensionless
Km = 0.0401; %V/(rad/s)
Rm = 19.2; %ohms
%rigid
J_hub = 0.0005; %Kg*m^2
J_load = 0.0015; %Kg*m^2
J = J_hub + J_load;
%flexible
L = 0.45; %m
Marm = 0.06; %kg
J_arm = (Marm*L^2)/3; %Kg*m^2
Mtip = 0.05; %kg
J_M = Mtip*L^2; %Kg*m^2
fc = 1.8;
J_L = J_arm + J_M;
K_arm = (2*pi*fc)^2*(J_L);


%% Closed Loop System - Rigid arm
% num = (K1*Kg*Km)/(J*Rm);
% den = [1 ((Kg^2*Km^2)/(J*Rm) + (K3*Kg*Km)/(J*Rm)) (K1*Kg*Km)/(J*Rm)]; 
% sysTF = tf(num,den);
% %%% Step Response
% [x,t] = step(sysTF); 
% x = thetad*x; 
% figure(1);
% clf;
% plot(t,x);
% xlabel('Time (s)');
% ylabel('Position');
% hold on

%% Closed Loop System - Flexible arm
%coefficients
p1 = -(Kg^2*Km^2)/(J_hub*Rm);
p2 = (Kg^2*Km^2*L)/(J_hub*Rm);
q1 = K_arm/(J_hub*L);
q2 = -(K_arm*(J_hub+J_L))/(J_L*J_hub);
r1 = (Kg*Km)/(J_hub * Rm);
r2 = -(Kg*Km*L)/(J_hub * Rm);

lam3 = -p1 + (K3*r1) + (K4*r2);
lam2 = -q2 + (K1*r1) + (K2*r2) + K4*(p2*r1 - r2*p1);
lam1 = (p1*q2) - (q1*p2) + K3*(q1*r2 - r1*q2) + K2*(p2*r1 - r2*p1);
lam0 = K1*(q1*r2 - r1*q2);

num1 = [K1*r1 0 K1*(q1*r2 - r1*q2)];
den1 = [1 lam3 lam2 lam1 0];
num2 = [K1*r2 0 K1*(q1*r2 - r1*q2)];
den2 = [1 lam3 lam2 lam1 0];

sysTF1 = tf(num1,den1);
figure(3)
step(sysTF1)

sysTF2 = tf(num2, den2);
figure(4)
step(sysTF2)

