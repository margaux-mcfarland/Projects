function [t, dm_dt, V_exit, P_exit] = g_fun1(t, mass_air,P_end,mass_air_init,gamma,vol_bottle,P_amb,R,C_d,A_throat)
%this function returns the change in volume before the water is exhausted from the bottle,
%the mass flow rate of air after water is exhausted from the bottle, the
%change in x (velocity in the x-direction), the change in z (velocity in
%the z-direction), and acceleration in the x-direction and acceleration in
%the z direction
mass_air = real(mass_air)
%p(t)
p2 = P_end*(mass_air/mass_air_init)^gamma;
%T(t)
T = p2/((mass_air/vol_bottle)*R);

%define critical pressure
P_cr = p2*(2/(gamma+1))^(gamma*(gamma-1));
P_exit = 0;
V_exit = 0;
if P_cr > P_amb
    %chocked
    M_exit = 1;
    P_exit = P_cr;
    T_exit = T*(2/(gamma+1));
    rho_exit = P_exit/(R*T_exit);
    V_exit = sqrt((gamma*R)*T_exit);
else
    %not chocked
    M_exit = sqrt((2/(gamma-1))*((p2/P_amb)^((gamma-1)/gamma)-1));
    P_exit = P_amb;
    T_exit = T/(1+(((gamma-1)/2)*M_exit^2));
    rho_exit = P_amb/(R*T_exit);
    V_exit = M_exit*sqrt((gamma*R)*T_exit);
end

%mass flow rate of air
%decreasing mass so rate is negative
dm_dt = -(C_d*rho_exit*A_throat)*V_exit;


end