%% Homework 4 - problem 5.3
% solv for exit mach, exit velocity, specific thrust, thrust-air ratio,
% thrust specific fuel consumption for varying T4s

%% givens
ty = 1.8; %temp ratio
a0 = 295.28; %m/s, speed of sound
tc1 = 1.93; % pressure ratio 1
tc2 = 2.35; % pressure ratio 2
gamma = 1.4; %ratio of specific heats
M0 = 2; %freestram Mach
cp = 1.004; %specific heat
hPR = 42800; %chemical energy of fuel
gc = 1; %gravity constant
T0 = 217; %K

%combustor temperatures
T4 = [2400, 2200, 2000, 1800]; %K

%% solve

t_lam = T4./T0;
t_t1 = 1 - (ty./t_lam).*(tc1 -1);
t_t2 = 1 - (ty./t_lam).*(tc2 -1);

M91 = sqrt((2/(gamma-1)).*(t_lam./(ty*tc1)).*((ty.*tc1.*t_t1)-1))
M92 = sqrt((2/(gamma-1)).*(t_lam./(ty*tc2)).*((ty.*tc2.*t_t2)-1))

V91 = a0.*sqrt((2/(gamma-1)).*(t_lam./(ty*tc1)).*((ty.*tc1.*t_t1)-1))
V92 = a0.*sqrt((2/(gamma-1)).*(t_lam./(ty*tc2)).*((ty.*tc2.*t_t2)-1))

F_m1 = (a0/gc).*((V91./a0) - M0)
F_m2 = (a0/gc).*((V92./a0) - M0)

f1 = (cp*T0/hPR).*(t_lam - (ty.*tc1))
f2 = (cp*T0/hPR).*(t_lam - (ty.*tc2))

S1 = f1./F_m1
S2 = f2./F_m2


