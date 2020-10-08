function [c_l,c_p, X, Y] = Vortex_Panel(x,y,V_inf,alpha,print)
%NVortex_Panel approximate coefficient of lift using the Vortex Panel
%Method
%   This function returns the sectional coefficient of lift given a set of
%   (x,y) coordinates of an airfoil, free-stream airspeed, and the angle of
%   attack. Also returns the cp
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/25/19
N =  length(x) - 1;
%number of points
MP1 = N + 1;
%convert AoA to radians
alpha = deg2rad(alpha);

%cooridnates of the control points and panel length S are computed
for i = 1:N
    IP1 = i + 1;
    X(i) = 0.5*(x(i) + x(IP1));
    Y(i) = 0.5*(y(i) + y(IP1));
    S(i) = sqrt((x(IP1) - x(i))^2 + (y(IP1) - y(i))^2);
    theta(i) = atan2((y(IP1) - y(i)), (x(IP1) - x(i)));
    sine(i) = sin(theta(i));
    cosine(i) = cos(theta(i));
    %right hand side of equation
    RHS(i) = sin(theta(i) - alpha);
end

for i = 1:N
    for j = 1:N
        if i == j
            CN1(i,j) = -1;
            CN2(i,j) = 1;
            CT1(i,j) = 0.5*pi;
            CT2(i,j) = 0.5*pi;
        else
            %constants
            A = -(X(i) - x(j))*cosine(j) - (Y(i) - y(j))*sine(j);
            B = (X(i) - x(j))^2 + (Y(i) - y(j))^2;
            C = sin(theta(i) - theta(j));
            D = cos(theta(i) - theta(j));
            E = (X(i) - x(j))*sine(j) - (Y(i) - y(j))*cosine(j);
            F = log(1 + S(j)*(S(j)+2.*A)/B);
            G = atan2(E*S(j), B+A*S(j));
            P = (X(i)-x(j))*sin(theta(i)-2.*theta(j)) + (Y(i) - y(j))*cos(theta(i) -2.*theta(j));
            Q = (X(i) - x(j))*cos(theta(i)-2.*theta(j)) - (Y(i) - y(j))*sin(theta(i)-2.*theta(j));
            CN2(i,j) = D + 0.5*Q*F/S(j) - (A*C+D*E)*G/S(j);
            CN1(i,j) = 0.5*D*F + C*G - CN2(i,j);
            CT2(i,j) = C + 0.5*P*F/S(j) + (A*D-C*E)*G/S(j);
            CT1(i,j) = 0.5*C*F - D*G - CT2(i,j);
        end
    end
end
%compute influence coefficients
for i = 1:N
    AN(i,1) = CN1(i,1);
    AN(i,MP1) = CN2(i,N);
    AT(i,1) = CT1(i,1);
    AT(i,MP1) = CT2(i,N);
    for j = 2:N
        AN(i, j) = CN1(i,j) + CN2(i,j-1);
        AT(i, j) = CT1(i,j) + CT2(i,j-1);
    end
end
AN(MP1, 1) = 1;
AN(MP1, MP1) = 1;
for j = 2:N
    AN(MP1,j) = 0;
end
RHS(MP1) = 0;

%solver for dimensionless strengths gama using Cramer's rule. Then compute
%and print the dimensionless velocity and pressure coefficient at control
%points
GAMA = AN\RHS';
if print %only print to show Kuthe and Chow example works
    fprintf("i  X(i)  Y(i)  theta(i)  S(i)  GAMA(i)  V(i)  CP(i)\n");
    fprintf("--  ----  ----  --------  ----  -------  ----  -----\n");
end
for i = 1:N
    V(i) = cos(theta(i)-alpha);
    for j = 1:MP1
        V(i) = V(i) + AT(i,j)*GAMA(j);
        CP(i) = 1.0 - V(i)^2;
    end
    if print %only print to show Kuthe and Chow example works
        fprintf("%d  %f  %f  %f  %f  %f  %f  %f\n", i, X(i), Y(i), theta(i), S(i), GAMA(i), V(i), CP(i));
    end
end

c_p = CP;
%plot c_p only if the first problem 
if print
    c = max(X) - min(X);
    x_up = X(1:length(X)/2); %upper surface
    x_c_up = x_up./c;
    x_low = X(length(X)/2:length(X)); %lower surface
    x_c_low = x_low./c;
    %invert the CP order for plot
    CP_up = CP(1:length(CP)/2); %upper surface
    CP_low = CP(length(CP)/2:length(CP)); %lower surface
    figure(1)
    plot(x_up,CP_up);
    set(gca, 'YDir','reverse')
    hold on
    plot(x_low, CP_low);
    set(gca, 'YDir','reverse')
    grid on
    title('Coefficient of Pressure vs percent chord');
    xlabel('Percent chord, x/c');
    ylabel('Cp');
    grid on
    legend('Upper surface', 'Lower surface');
end
%calcualte  cl

%kutta-joukowski (L = rho*V_inf*GAMA), but non-dimensionalize
c_l = 2*sum(GAMA)/V_inf; %c is 1

end