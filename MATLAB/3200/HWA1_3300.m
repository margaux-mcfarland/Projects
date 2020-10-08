%angles
theta1 = 45;
theta2 = 45;
theta3 = 45;

%totations
R1 = [1 0 0; 0 cosd(theta1) sind(theta1);0 -sind(theta1) cosd(theta1)];
R2 = [cosd(theta2) 0 -sind(theta2);0 1 0;sind(theta2) 0 cosd(theta2)];
R3 = [cosd(theta3) sind(theta3) 0; -sind(theta3) cosd(theta3) 0;0 0 1];

%DCMs
Q1 = R3*R2*R1;
Q2 = R1*R2*R3;
Q3 = R3*R1*R3;

%eigenvales/vectors
[V1,D1] = eig(Q1)
[V2,D2] = eig(Q2)
[V3,D3] = eig(Q3)

%axis of rotations
u1 = V1(:,1)
u2 = V2(:,1)
u3 = V3(:,1)

%angles of rotation
phi1 = acosd(real(D1(2,2)))
phi2 = acosd(real(D2(2,2)))
phi3 = acosd(real(D3(2,2)))

