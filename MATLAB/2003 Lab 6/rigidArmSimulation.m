function [] = rigidArmSimulation(K1,K3)

thetad = 1;

%% constants
Kg = 33.3; %dimensionless
Km = 0.0401; %V/(rad/s)
Rm = 19.2; %ohms

%rigid
J_hub = 0.0005; %Kg*m^2
J_load = 0.0015; %Kg*m^2
J = J_hub + J_load;

%% Rigid Arm Closed Loop System
num = (K1*Kg*Km)/(J*Rm);
den = [1 ((Kg^2*Km^2)/(J*Rm) + (K3*Kg*Km)/(J*Rm)) (K1*Kg*Km)/(J*Rm)]; 
sysTF = tf(num,den);
tau = (J*Rm)/(Kg^2*Km^2);
[u,t2] = gensig('square',tau);
%% Rigid Arm Step Response
[x,t1] = step(sysTF); 
x = thetad*x; 

figure(1)
xlim([0 5]);
t = [0:0.01:10]'; 
step(sysTF,t);
hold on
plot([0.15 0.15], [-20 20]);
info = stepinfo(sysTF,'SettlingTimeThreshold',0.02)

% controlSystemDesigner(sysTF)
% rlocus(sysTF,k)
% wn = 4; 
% z = 0.5;
% t = [0:0.01:10]'; 
% num = wn^2; 
% den = [1 2*z*wn wn^2]; 
% sys = tf(num,den); 
% figure(2) 
% xstep = step(sysTF,t); 
% subplot(3,1,1),plot(t,xstep),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'),legend('Step response') 
% 
% ximp = impulse(sysTF,t); 
% subplot(3,1,2),plot(t,ximp),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'),legend('Impulse response') 
% 
% u1=square(2*pi*0.2*t); 
% xgen = lsim(sysTF,u1,t); 
% subplot(3,1,3),plot(t,u1,t,xgen),grid on 
% xlabel('Time (sec)'),ylabel('x(t)'), legend('General response','u')
end
