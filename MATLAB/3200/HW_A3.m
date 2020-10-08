%% Problem 4
%givens
phi = 60;
theta = -30;
psi = 120;

%3-1-3
Q1 = [-sind(phi)*cosd(theta)*sind(psi)+(cosd(phi)*cosd(psi)) cosd(phi)*cosd(theta)*sind(psi) + (sind(phi)*cosd(psi)) sind(theta)*sind(psi)];
Q2 = [-sind(phi)*cosd(theta)*cosd(psi)-(cosd(phi)*sind(psi)) cosd(phi)*cosd(theta)*cosd(psi) - (sind(phi)*sind(psi)) sind(theta)*cosd(psi)];
Q3 = [sind(phi)*sind(theta) -cosd(phi)*sind(theta) cosd(theta)];

Q_1 = [Q1; Q2; Q3];

[U1,Phi1] = eig(Q_1)

%3-2-1
Q1 = [cosd(phi)*cosd(theta) sind(phi)*cosd(theta) -sind(theta)];
Q2 = [cosd(phi)*sind(theta)*sind(psi)-(sind(phi)*cosd(psi)) sind(phi)*sind(theta)*sind(psi) + (cosd(phi)*cosd(psi)) cosd(theta)*sind(psi)];
Q3 = [cosd(phi)*sind(theta)*cosd(psi)+(sind(phi)*sind(psi)) sind(phi)*sind(theta)*cosd(psi) - (cosd(phi)*sind(psi)) cosd(theta)*cosd(psi)];


Q_2 = [Q1; Q2; Q3];

[U2,Phi2] = eig(Q_2)

%% Problem 5
%givens
wx = 1.25;
wy = 0.5;
wz = 0.25;
%3-1-3
phi_dot = (1/sind(theta))*(sind(psi)*wx + (cosd(psi)*wy));
theta_dot = cosd(psi)*wx - (sind(psi)*wy);
psi_dot = (-1/tand(theta))*(sind(psi)*wx + (cosd(psi)*wy)) + wy;
%3-2-1
phi_dot_2 = (1/cosd(theta))*(sind(psi)*wy + (cosd(psi)*wz))
theta_dot_2 = cosd(psi)*wy - (sind(psi)*wz)
psi_dot_2 = wx + (tand(theta))*(sind(psi)*wy + (cosd(psi)*wz))
