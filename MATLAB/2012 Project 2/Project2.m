%% This program determines the trajectory of a bottle rocket
%Authors: Margaux McFarland (107731341)
%           Braden Campbell
%Date: 11/30/18

clc
clear 
close all

%constants
g = 9.81; %m/s/s
C_d = 0.8; %discharge coefficient
rho_air = 0.961; %kg/m^3
rho_water = 1000; %kg/m^3
vol_bottle = 0.002; %m^3
P_amb = 12.1; %psi
gamma = 1.4; %ratio of specific heats for air
D_throat = 2.1; %cm
D_bottle = 10.5; %cm
R = 287; %J/kg*K
M_bottle = 0.15; %kg
C_D = 0.5; %drag coefficient
P_gage = 50; %psi
vol_water_init = 0.001; %m^3
T_air_init = 300; %K
v_0 = 0.0; %m/s
theta = 45; %degrees
x0 = 0.0; %m
y0 = 0.25; %m
l_s = 0.5; %m %length of test stand
t_span = [0 5]; %seconds

%convert units SI
P_amb = P_amb*6894.76; %Pa
D_throat = D_throat/100; %m
D_bottle = D_bottle/100; %m
P_gage = P_gage*6894.76; %Pa

%areas
A_throat = pi*(D_throat/2)^2;
A_bottle = pi*(D_bottle/2)^2;


%% before the water is exhausted
%find volume of air given rate of change of volume
%initial conditions 
vol_0 = vol_bottle-vol_water_init;
p_0 = P_amb+P_gage;
[t,vol_air] = ode45(@(t,vol_air) C_d*A_throat*sqrt((2/rho_water)*(p_0*((vol_0/vol_air)^gamma)-P_amb)),t_span,vol_0);
vol_air = real(vol_air);

%find p(t) (air pressure at any given time in rocket)
p1 = p_0.*((vol_0./vol_air).^gamma);

%exhaust velocity
V_e  = sqrt(2*(p1-P_amb)./rho_water);

%find F(t) thrust
F1 = (2*C_d*A_throat).*(p1-P_amb);

%initial mass of rocket
M_r_intit = M_bottle+(rho_water*vol_water_init)+(p_0/(R*T_air_init))*vol_0;

%% after water is exhausted

%pressure after all water is exhausted
P_end = p_0*(vol_0/vol_bottle)^gamma;
%temperature of air in bottle after all the water is exhausted
T_end = T_air_init*(vol_0/vol_bottle)^(gamma-1);

%get mass flow rate of air at this point
%mass_flow_air = (C_d*rho_air*A_throat).*V_e;
mass_air_init = (p_0/(R*T_air_init))*vol_0;

[t,mass_air, V_exit, P_exit] = ode45(@(t,mass_air) g_fun1(t,mass_air,P_end,mass_air_init,gamma,vol_bottle,P_amb,R,C_d,A_throat), t_span, mass_air_init);

mass_air = real(mass_air);

F = (g_fun1(mass_air,P_end,mass_air_init,gamma,vol_bottle,P_amb,R,C_d,A_throat)*V_exit + ((P_exit-P_amb)*A_throat));
