function ddt = g_fun(t,state_vec, f1, f2, f3, f4)
%% ode function for part 3 (linearized)

%givens
m = 0.068; %kg
rad = 0.06; %m
Ix = 6.8e-5; %kgm^2
Iy = 9.2e-5; %kgm^2
Iz = 1.35e-4; %kgm^2
g_b = [0; 0; -9.81]; %m/s^2
k = 0.0024; %Nm/N

%unpack state vector - all state variables are equal to their deviations in
%steady hover
x_dev = state_vec(1, 1);
y_dev = state_vec(2, 1);
z_dev = state_vec(3, 1);
phi_dev = state_vec(4, 1);
theta_dev = state_vec(5, 1);
xi_dev = state_vec(6, 1);
u_dev = state_vec(7, 1);
v_dev = state_vec(8, 1);
w_dev = state_vec(9, 1);
p_dev = state_vec(10, 1);
q_dev = state_vec(11, 1);
r_dev = state_vec(12, 1);

%deviations
f1_dev = 0;
f2_dev = 0;
f3_dev = 0;
f4_dev = 0;

Lc_dev = (rad/sqrt(2))*(f1_dev + f2_dev + f3_dev + f4_dev);
Mc_dev = (rad/sqrt(2))*(-f1_dev + f2_dev + f3_dev - f4_dev);
Nc_dev = (rad/sqrt(2))*(f1_dev - f2_dev + f3_dev - f4_dev);
Zc_dev = (f1_dev + f2_dev + f3_dev + f4_dev);

% longitudinal
dq_dev = (1/Iy)*Mc_dev;
dtheta_dev = q_dev;
du_dev = g_b(3)*theta_dev;
% lateral
dp_dev = (1/Ix)*Lc_dev;
dphi_dev = p_dev;
dv_dev = -g_b(3)*phi_dev;
% azimuth
dr_dev = (1/Iz)*Nc_dev;
% vertical
dw_dev = (1/m)*Zc_dev;

Zc = Zc_dev + (f1 + f2 + f3 + f4)*(cos(theta_dev)*cos(phi_dev)); %N


ddt = [u_dev; v_dev; w_dev; p_dev; q_dev; r_dev; du_dev; dv_dev; dw_dev + Zc + m*g_b(3); dp_dev; dq_dev; dr_dev];

end