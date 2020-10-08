function [] = flexArmSimulation(K1,K2,K3,K4)


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
felx_link_stiff = (2*pi*fc)^2*(J_L);
K_arm = (2*pi*fc)^2*(J_L);

%% Flexible Arm Step Response
p1 = -(Kg^2*Km^2)/(J_hub*Rm);
p2 = (Kg^2*Km^2*L)/(J_hub*Rm);
q1 = K_arm/(J_hub*L);
q2 = -(K_arm*(J_hub+J_L))/(J_L*J_hub);
r1 = (Kg*Km)/(J_hub * Rm);
r2 = -(Kg*Km*L)/(J_hub * Rm);

lam3 = -p1 + (K3*r1) + (K4*r2);
lam2 = -q2 + (K1*r1) + (K2*r2) + (K4*(p2*r1 - r2*p1));
lam1 = p1*q2 - q1*p2 + K3*(q1*r2 - r1*q2) + K2*(p2*r1 - r2*p1);
lam0 = K1*(q1*r2 - r1*q2);

num1 = [K1*r1 0 K1*(q1*r2 - r1*q2)];
dem1 = [1 lam3 lam2 lam1 lam0];

sysTF1 = tf(num1,dem1);
figure(3)
xlim([0 5]);
step(sysTF1)
hold on
plot([0.5 0.5], [-20 20]);
info1 = stepinfo(sysTF1,'SettlingTimeThreshold',0.02)
% controlSystemDesigner(sysTF1)
num2 = [K1*r2 K1*(p2*r1 - r2*p1) 0];
dem2 = [1 lam3 lam2 lam1 lam0];

sysTF2 = tf(num2, dem2);
figure(4)
xlim([0 5]);
step(sysTF2)
hold on
plot([0.5 0.5], [-20 20]);
info2 = stepinfo(sysTF2)
end
% wn = 4; 
% z = 0.5;
% num = wn^2; 
% den = [1 2*z*wn wn^2]; 
% sys = tf(num,den); 
% t = [0:0.01:10]'; 
% figure(5) 
% xstep = step(sysTF1,t); 
% subplot(3,1,1),plot(t,xstep),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'),legend('Step response') 
% 
% ximp = impulse(sysTF1,t); 
% subplot(3,1,2),plot(t,ximp),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'),legend('Impulse response') 
% 
% u1=square(2*pi*0.2*t); 
% xgen = lsim(sysTF1,u1,t); 
% subplot(3,1,3),plot(t,u1,t,xgen),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'), legend('General response','u')
% 
% figure(6) 
% xstep = step(sysTF2,t); 
% subplot(3,1,1),plot(t,xstep),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'),legend('Step response') 
% 
% ximp1 = impulse(sysTF2,t); 
% subplot(3,1,2),plot(t,ximp1),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'),legend('Impulse response') 
% 
% u2=square(2*pi*0.2*t); 
% xgen1 = lsim(sysTF2,u2,t); 
% subplot(3,1,3),plot(t,u2,t,xgen1),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'), legend('General response','u')