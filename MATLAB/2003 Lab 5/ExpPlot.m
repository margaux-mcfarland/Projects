close all; clear; clc;

%% Read in
DespinData = dlmread('test1', '	', 1, 0);
FrictionData = dlmread('norelease', '	', 1, 0);

%% Plot with despinners
%Model
%variable definitions
I = 0.0063; %kg*m^2
R = 0.0792; %m
m = 0.054; %kg
omega0 = 130; %rpm
omega0 = omega0*2*pi/60; %rad/s
C = I/(2*m*R^2)+1;

%angular velocity over some interval
t = linspace(0, 10, 1000);
omega = omega0*(C-omega0^2*t.^2)./(C+omega0^2*t.^2);
omega = omega*30/pi;

%valid ang. vel. values
omega = omega(omega >= 0);
t = t(omega >= 0);

%Experiment
%Data trim and clean up
DespinData = DespinData(1:130,:);
DespinData = DespinData((DespinData(:,1)<800) & (DespinData(:,1) > 340),:);
DespinData(:,1) = DespinData(:,1) - DespinData(1,1);
DespinData(:,1)= DespinData(:,1)/1000;

%plot of tangential model and experimental data
hold on;
plot(DespinData(:,1), DespinData(:,2),t, omega);
xlabel("Time (s)");
ylabel("Angular Velocity (rpm)");
title("Despin Deployment");
legend("Experiment", "Model");
hold off;
saveas(gcf, "ExpandModelDespin.png");


%% Despin Purely due to friction
%remove points where time value resets
for i = 1:length(FrictionData(:,1))-1
   if (FrictionData(i+1,1) < FrictionData(i,1))
      FrictionData(i+1:end,1) = FrictionData(i+1:end,1)+FrictionData(i,1)-FrictionData(i+1,1) + (FrictionData(i+2,1)-FrictionData(i+1,1)); 
   end
end

%plot of despin purely due to friction
figure;
FrictionData(:,1) = FrictionData(:,1)/1000;
plot(FrictionData(:,1), FrictionData(:,2));
xlabel("Time (s)");
ylabel("Angular Velocity (rpm)");
title("Despinning With Only Friction");
saveas(gcf, "Friction.png");

%% Tension for Tangential Release Model
T = 8*m*R*omega0^3*t*C./(C + omega0^2*t.^2).^2;

%plot tension vs time
figure
plot(t,T);
xlabel("Time (s)");
ylabel("Tension (N)");
title("Tangential Release Tension");
%saveas(gcf, "Tension.png");




