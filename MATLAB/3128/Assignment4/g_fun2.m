 function ddt = g_fun2(t,state_vec, f1, f2, f3, f4)
%% ode function for part 3 (non-linearized)

%givens
m = 0.068; %kg
rad = 0.06; %m
Ix = 6.8e-5; %kgm^2
Iy = 9.2e-5; %kgm^2
Iz = 1.35e-4; %kgm^2
g_b = [0; 0; -9.81]; %m/s^2
k = 0.0024; %Nm/N

%gains
K1 = 12*Ix; % controls roll rate
K2 = 20*Ix; % controls bank
K3 = 12*Iy; % controls pitch rate
K4 = 20*Iy; % controls elevation
K5 = 0.004; %Nm/(rad/s)

%unpack state vector
x = state_vec(1, 1);
y = state_vec(2, 1);
z = state_vec(3, 1);
phi = state_vec(4, 1);
theta = state_vec(5, 1);
xi = state_vec(6, 1);
u = state_vec(7, 1);
v = state_vec(8, 1);
w = state_vec(9, 1);
p = state_vec(10, 1);
q = state_vec(11, 1);
r = state_vec(12, 1);

%forces
Xc = (f1 + f2 + f3 + f4)*-sin(theta);
Yc = (f1 + f2 + f3 + f4)*sin(phi)*cos(theta);
Zc = (f1 + f2 + f3 + f4)*(cos(theta)*cos(phi)); %N
n = 1e-3; %N/(m/s)^2
Xa = -n*sqrt(u^2 + v^2 + w^2)*u;%N
Ya = -n*sqrt(u^2 + v^2 + w^2)*v;%N
Za = -n*sqrt(u^2 + v^2 + w^2)*w;%N
A_a = [Xa; Ya; Za]; %aerodynamic
A_c = [Xc; Yc; Zc]; %controls
f_b = m.*g_b + A_a + A_c; %net force in body frame cooridinates

%moments
Lc = -K1*p - (K2*phi); %Nm
Mc = -K3*q - (K4*theta);
Nc = -K5*r;
alpha = 2e-6; %Nm/(rad/s)^2
La = -alpha*sqrt(p^2 + q^2 + r^2)*p; %Nm
Ma = -alpha*sqrt(p^2 + q^2 + r^2)*q; %Nm
Na = -alpha*sqrt(p^2 + q^2 + r^2)*r; %Nm
G_ab = [La; Ma; Na]; %aerodynamic
G_cb = [Lc; Mc; Nc]; %controls
G_b = G_ab + G_cb; %net moment about cg in body frame coordinates


du = f_b(1)/m;
dv = f_b(2)/m;
dw = f_b(3)/m;
dp = (-((q*Iz*r) - (r*Iy*q)) + G_b(1))/Ix;
dq = (((p*Iz*r) - (r*Ix*p)) + G_b(2))/Iy;
dr = (-((p*Iy*q) - (q*Ix*p)) + G_b(3))/Iz;


ddt = [u; v; w; p; q; r; du; dv; dw; dp; dq; dr];
end