%% Step 1: Globalization
%givens
P = 200;
E = 3000;
A1 = 2;
A2 = 4;
A3 = 3;
L1 = 30;
L2 = 2*L1*sqrt(3)/3;
L3 = L1*2/3;
phi1 = 0;
phi2 = 30;
phi3 = 120;

%gobal K hat matrix
K_hat_1 = (E*A1 /L1).*[cosd(phi1)^2 sind(phi1)*cosd(phi1); sind(phi1)*cosd(phi1) sind(phi1)^2];
K_hat_2 = (E*A2 /L2).*[cosd(phi2)^2 sind(phi2)*cosd(phi2); sind(phi2)*cosd(phi2) sind(phi2)^2];
K_hat_3 = (E*A3 /L3).*[cosd(phi3)^2 sind(phi3)*cosd(phi3); sind(phi3)*cosd(phi3) sind(phi3)^2];

% global Kmat
K1 = [K_hat_1 -K_hat_1; -K_hat_1 K_hat_1]
K2 = [K_hat_2 -K_hat_2; -K_hat_2 K_hat_2]
K3 = [K_hat_3 -K_hat_3; -K_hat_3 K_hat_3]
%% Step 2: Merge
K = [K_hat_1 zeros(2,2) zeros(2,2) -K_hat_1;
    zeros(2,2) K_hat_2 zeros(2,2) -K_hat_2;
    zeros(2,2) zeros(2,2) K_hat_3 -K_hat_3;
    -K_hat_1 -K_hat_2 -K_hat_3 K_hat_1+K_hat_2+K_hat_3]
%% Step 3: Boundary Conditions
ux1 = 0;uy1 = 0;ux2 = 0;uy2 = 0;ux3 = 0;uy3 = 0;
f_reduced = [0;-P];
K_reduced = K_hat_1+K_hat_2+K_hat_3;
%% Step4: Displacement Solution
%solve for displacements
u4 = K_reduced\f_reduced
ux4 = u4(1);
uy4 = u4(2);
u = [ux1;uy1;ux2;uy2;ux3;uy3;ux4;uy4];
%% Step 5: Recovery of Reactions
f = K*u
%% Step 6: Recovery of Internal Forces
T1 = [cosd(phi1) sind(phi1) 0 0; -sind(phi1) cosd(phi1) 0 0;
    0 0 cosd(phi1) sind(phi1); 0 0 -sind(phi1) cosd(phi1)];
u_local_1 = T1*[ux1; uy1; ux4; uy4];
T2 = [cosd(phi2) sind(phi2) 0 0; -sind(phi2) cosd(phi2) 0 0;
    0 0 cosd(phi2) sind(phi2); 0 0 -sind(phi2) cosd(phi2)];
T3 = [cosd(phi3) sind(phi3) 0 0; -sind(phi3) cosd(phi3) 0 0;
    0 0 cosd(phi3) sind(phi3); 0 0 -sind(phi3) cosd(phi3)];
u_local_2 = T2*[ux2; uy2; ux4; uy4];
u_local_3 = T3*[ux3; uy3; ux4; uy4];
%displacements bar 1
d1 = u_local_1(3) - u_local_1(1);
F1 = (E*A1/L1)*d1
%bar 2
d2 = u_local_2(3) - u_local_2(1);
F2 = (E*A2/L2)*d2
%bar 3
d3 = u_local_3(3) - u_local_3(1);
F3 = (E*A3/L3)*d3


