
function [Rocket,TOF] = Isp_Model(Vol_water, theta, coeff_drag,wind)


if Vol_water == 0
    Rocket = [0 0 0];
    return;
end

theta = radtodeg(theta);

%constants / baseline conditions
g = 9.81; %m/s^2
m_prop = Vol_water * 1000; %kg
m_bottle = 0.123; %kg
m_init = m_bottle + m_prop;%kg
m_final = m_init - m_prop; %assume all water leaves bottle

[thrust,t_span] = getThrust('LA8am_test1');
I_sp = calcIsp(thrust, t_span, g,m_prop);

%calculate delta V
delta_V = I_sp*g*log(m_init/m_final);

%assuming delta_V is the inital velcoity and the mass of the rocket stays
%constant and equals the final mass


t_span = [0 5];
initials = [0;0;0;delta_V*cosd(theta);0;delta_V*sind(theta)];

%stop ode45 when hits the ground (z = 0)
opts=odeset('Events',@stopping_point);
[t, Rocket] = ode45(@(t,Rocket) getTrajectory(t,Rocket,m_final,coeff_drag,theta,wind),t_span,initials,opts);

%unpack state vector
x = Rocket(:,1);
y = Rocket(:,2);
z = Rocket(:,3);

V_x = Rocket(:,4);
V_y = Rocket(:,5);
V_z = Rocket(:,6);


%plot trajectory
% figure(3)
% plot3(x,y,z);
% 
% xlim([0 70]);
% ylim([-10 10]);
% zlim([0 20]);
% xlabel('Downrange (m)');
% ylabel('Crossrange (m)');
% zlabel('Height (m)');
% title('Flight Path of Water Bottle Rocket (Isp Model) (Wind: 1 mph from N)');
% grid on
% figure(4)
% plot(x,z);
% xlim([0 70]);
% ylim([0 20]);
% xlabel('Downrange (m)');
% ylabel('Height (m)');
% title('Flight Path of Water Bottle Rocket (Isp Model) (Wind: 1 mph from N)');
% grid on

maxDist = x(end);
zenith = max(z);
TOF = t(end);

end
