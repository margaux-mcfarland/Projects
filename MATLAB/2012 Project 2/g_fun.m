function dydt = g_fun(t,state_vec)
%this function returns the change in volume before the water is exhausted from the bottle,
%the mass flow rate of air after water is exhausted from the bottle, the
%change in x (velocity in the x-direction), the change in z (velocity in
%the z-direction), and acceleration in the x-direction and acceleration in
%the z direction

global F_thrust F_time 

%% constants for verification test case
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

%% constants for test case
% g = 9.81; %m/s/s
% C_d = 0.8; %discharge coefficient
% rho_air = 0.961; %kg/m^3
% rho_water = 1000; %kg/m^3
% vol_bottle = 0.002; %m^3
% P_amb = 12.1; %psi
% gamma = 1.4; %ratio of specific heats for air
% D_throat = 2.1; %cm
% D_bottle = 10.5; %cm
% R = 287; %J/kg*K
% M_bottle = 0.15; %kg
% C_D = 0.5; %drag coefficient
% P_gage = 62; %psi
% vol_water_init = 0.00042; %m^3
% T_air_init = 300; %K
% v_0 = 0.0; %m/s
% theta = 48; %degrees
% x0 = 0.0; %m
% y0 = 0.25; %m
% l_s = 0.5; %m %length of test stand

%convert units SI
P_amb = P_amb*6894.76; %Pa
D_throat = D_throat/100; %m
D_bottle = D_bottle/100; %m
P_gage = P_gage*6894.76; %Pa
theta = (2*pi)*theta/360; %radians

%areas
A_throat = pi*(D_throat/2)^2;
A_bottle = pi*(D_bottle/2)^2;

%intitials
vol_0 = vol_bottle-vol_water_init;
p_0 = P_amb+P_gage;
%initial mass of rocket
m_r_init = M_bottle+(rho_water*vol_water_init)+(p_0/(R*T_air_init))*vol_0;

% dydt(1,1) = change in volume of air
% dydt(1,2) = change in mass of rocket
% dydt(1,3) = horizontal velocity over time
% dydt(1,4) = vertical velcity over time
% dydt(1,5) = horizontal acceleration over time
% dydt(1,6) = vertical accleration over time
% dydt(1,7) = change in pressure over time 

%unpack state vector
v = state_vec(1,1);
m = state_vec(2,1);
x = state_vec(3,1);
y = state_vec(4,1);
dxdt = state_vec(5,1);
dydt = state_vec(6,1);
p = state_vec(7,1);


%  %find p(t) (air pressure at any given time in rocket)
%  p1 = p_0*((vol_0/v)^gamma);
%     %p(t) for second stage
%     p2 = P_end*(m/mass_air_init)^gamma;

if(v < vol_bottle)
    %% before water is exhausted
    V = sqrt(dxdt^2 + dydt^2);
    if(sqrt(x^2+y^2) <= l_s)
        %heading
        hx = cos(theta);
        hy = sin(theta);
    else
        %heading
        hx = dxdt/V;
        hy = dydt/V;
    end

    %change in mass of rocket
    d_m = -C_d*A_throat*sqrt(2*rho_water*(p-P_amb));

    %change in volume
    d_vol = C_d*A_throat*sqrt((2/rho_water)*(p_0*((vol_0/v)^gamma)-P_amb));
    
    %exhaust velocity
    V_e  = sqrt(2*(p-P_amb)./rho_water);
    
    %find F(t) thrust
    F = (2*C_d*A_throat)*(p-P_amb);
   
    D = 0.5*rho_air*(V^2)*C_D*A_bottle;
    F_net_x = (F-D)*hx;
    F_net_y = (F-D)*hy-(m*g);
    
    %change in pressure
    d_p = p_0*vol_0^(gamma)*(-gamma*v^(-gamma-1))*d_vol;
    
elseif(p >= P_amb)   
    %% after water is exhausted
    V = sqrt(dxdt^2 + dydt^2);
    if(sqrt(x^2+y^2) <= l_s)
        %heading
        hx = cos(theta);
        hy = sin(theta);
    else
        %heading
        hx = dxdt/V;
        hy = dydt/V;
    end
    
     %pressure after all water is exhausted
    P_end = p_0*(vol_0/vol_bottle)^gamma;
    %temperature of air in bottle after all the water is exhausted
    T_end = T_air_init*(vol_0/vol_bottle)^(gamma-1);
    mass_air_init = (p_0/(R*T_air_init))*vol_0;
    
    %volume stays constant
    d_vol = 0;
    
    rho = (m-M_bottle)/vol_bottle;
    %T(t)
    T = p/(rho*R);

    %define critical pressure
    P_cr = p*(2/(gamma+1))^(gamma/(gamma-1));

    if P_cr > P_amb
        %chocked
        M_exit = 1;
        P_exit = P_cr;
        T_exit = T*(2/(gamma+1));
        rho_exit = P_exit/(R*T_exit);
        V_e = sqrt((gamma*R)*T_exit);
    else
        %not chocked
        M_exit = sqrt(abs((2/(gamma-1))*((p/P_amb)^((gamma-1)/gamma)-1)));
        P_exit = P_amb;
        T_exit = T/(1+(((gamma-1)/2)*M_exit^2));
        rho_exit = P_amb/(R*T_exit);
        V_e = M_exit*sqrt((gamma*R)*T_exit);
    end
    
    %change in mass of rocket 
    d_m = -(C_d*rho_exit*A_throat)*V_e;
   
    %find F(t)
    F = (abs(d_m)*V_e) + ((P_exit-P_amb)*A_throat);
    D = 0.5*rho_air*(V^2)*C_D*A_bottle;
    F_net_x = (F-D)*hx;
    F_net_y = (F-D)*hy+(m*g);
    
    d_p = P_end*mass_air_init^(-gamma)*(gamma*(m-M_bottle)^(gamma-1))*d_m;
   
else
%% Ballistic Phase
     %velocity
    V = sqrt(dxdt^2+dydt^2);
    %heading
        hx = dxdt/V;
        hy = dydt/V;
    %volume stays constant
    d_vol = 0;
    %mass stays constant
    d_m = 0;
    %pressure stays constant
    d_p = 0;
    %drag
    D = 0.5*rho_air*(V^2)*C_D*A_bottle;
    F = 0;
    m = M_bottle;
    F_net_x = -D*hx;
    F_net_y = (-D*hy)-(M_bottle*g);
    
   
end

F_thrust =[F_thrust; real(F)];
F_time = [F_time; t];

%accelerations
dd_x = F_net_x/m;
dd_y = F_net_y/m;

dydt = [d_vol;d_m;dxdt;dydt;dd_x;dd_y;d_p];
end