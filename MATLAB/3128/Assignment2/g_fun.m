function ddt = g_fun(t,state_vec, f1, f2, f3, f4)
%% ode function for part 7 (no aerodynamic forces)

%unpack state vector
x = state_vec(1, 1);
y = state_vec(2, 1);
z = state_vec(3, 1);
xi = state_vec(4, 1);
theta = state_vec(5, 1);
phi = state_vec(6, 1);
u = state_vec(7, 1);
v = state_vec(8, 1);
w = state_vec(9, 1);
p = state_vec(10, 1);
q = state_vec(11, 1);
r = state_vec(12, 1);

%givens
m = 0.068; %kg
r = 0.06; %m
Ix = 6.8e-5; %kgm^2
Iy = 9.2e-5; %kgm^2
Iz = 1.35e-4; %kgm^2
g_b = [0; 0; -9.81]; %m/s^2
k = 0.0024; %Nm/N

%forces
Xc = 0;
Yc = 0;
Zc = f1 + f2 + f3 + f4; %N
A_c = [Xc; Yc; Zc]; %controls
f_b = m.*g_b + A_c; %net force in body frame cooridinates

%moments
Lc = (r/sqrt(2))*(f1 + f2 - f3 - f4); %Nm
Mc = (r/sqrt(2))*(-f1 + f2 + f3 - f4);
Nc = k*(f1 - f2 + f3 - f4);
G_cb = [Lc; Mc; Nc]; %controls
G_b = G_cb; %net moment about cg in body frame coordinates

du = f_b(1)/m;
dv = f_b(2)/m;
dw = f_b(3)/m;
dp = (-((q*Iz*r) - (r*Iy*q)) + G_b(1))/Ix;
dq = (((p*Iz*r) - (r*Ix*p)) + G_b(2))/Iy;
dr = (-((p*Iy*q) - (q*Ix*p)) + G_b(3))/Iz;


ddt = [u; v; w; p; q; r; du; dv; dw; dp; dq; dr];
end