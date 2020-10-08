%ASEN 3200: Lab 1
%Date modified: 1/28/19

clear all
close all
clc

%%Givens for scenario 1
a = 242200.1854; %km, semi-major axis
e = 0.587; %eccentricity
i = 10; %degrees, inclination
v = 0; %degrees, true anomaly 

%% Question 4
b = a*sqrt(1-e^2); %km, semi-minor axis
%plot orbit path
%coordinates
x1 = 0;
y1 = 0;
x2 = 2*a;
y2 = 0;
%plot over one period 
mu = 398600; %km^3/s^2, gravitational parameter 
T = ((2*pi)/sqrt(mu))*a^(3/2);
t = 0:(2*pi)/T:2*pi;
X = a*cos(t);
Y = b*sin(t);
w = atan2(y2-y1,x2-x1);
x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
figure(1)
plot(x,y,'b-');
grid on
xlabel('X (km)');
ylabel('Y (km)');
title('Earth-cented Orbit (QUESTION 4)');
hold on
%mark Earth and satellite initial location, and eccentricity vector
rp = a*(1-e); %radius to perigee, km
ra = a*(1+e); %radius to apogee, km
plot(ra, 0, 'r*');
hold on
plot(2*a, 0, 'b*'); %initial position of satellite (zero degree true anamoly)
hold on
quiver(ra,0,rp/2,0,0,'LineWidth',2); %eccentricity vector points from earth to periapsis
legend('Orbit Path','Earth','Satellite','eccentricity vector');

%magnitude of eccentrencity vectors and angular momentem vectors over one
%period
figure(2)
period_vec = 0:1:T; %period vector
e_mag = e*ones(1,length(period_vec)); %eccentricity is constant througout orbit
h = sqrt(mu*a*(1-e^2))*ones(1,length(period_vec));%km^2/s, angular momentum (constant)

subplot(2,1,1);
plot(period_vec, e_mag);
grid on
title('Magnitude of Eccentricity Vector over Orbit Period');
xlabel('Orbit Period (s)');
ylabel('Eccentricity Vector Magnitude');
xlim([0 T]);
subplot(2,1,2);
plot(period_vec, h);
grid on
title('Magnitude of Angular Momentum over Orbit Period');
xlabel('Orbit Period (s)');
ylabel('Angular Momentum Magnitude (km^2/s)');
xlim([0 T]);
