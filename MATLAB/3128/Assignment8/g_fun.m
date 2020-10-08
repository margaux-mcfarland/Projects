function ddt = g_fun(t,state_vec, A, B, K1, K2)
%% ode function for linearized longitudinal dynamics for B747-100, w/ controls

%unpack state vector 

theta_dev = state_vec(5, 1); %elevation deviation, rad
u_dev = state_vec(7, 1); %x velocity deviation, m/s
w_dev = state_vec(9, 1); %z velocity deviation, m/s
q_dev = state_vec(11, 1);% roll rate devitaion, rad/s

e_dev = -K2*theta_dev - (K1*q_dev); %elevator control deviation

%combine states into y matrix
y = [u_dev;w_dev;q_dev;theta_dev];
U = e_dev;

ydot = A*y + B*U;

%givens
u0 = 157.886; %m/s, x-component is the same as airspeed in stability frame
theta0 = 0; %radians, trim elevation


dx_dev = u_dev*cos(theta0) + w_dev*sin(theta0) - u0*theta_dev*sin(theta0);
dz_dev = u_dev*cos(theta0) + w_dev*cos(theta0) - u0*theta_dev*cos(theta0);

ddt = [dx_dev; 0; dz_dev; 0; q_dev; 0; ydot(1); 0; ydot(2); ydot(4); ydot(3); 0];

end