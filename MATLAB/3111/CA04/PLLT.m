function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)
%PLLT solves the fundamental equation of Prandtl Lifting Line Theory for
%finite wings with thick airfoilf
%   This function returns the coefficient of lift, coefficient of
%   drag, and span efficieny given the span, the cross-sectional lift
%   slope at the tip and root(per radian), the chord at the tip and root
%   (in ft), the zero-lift AoA at the tip and root (in degrees), geometric angle of 
%   attack at the tip and root(degrees), and N the number of off Fourier 
%   terms 
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/25/19

%givens
V_inf = 67.056; %m/s

%convert angles to radians
geo_t = deg2rad(geo_t);
geo_r = deg2rad(geo_r);
aero_t = deg2rad(aero_t);
aero_r = deg2rad(aero_r);

%get vecotr of all odd terms
n = linspace(1,N,N);
odd = 2*n-1;

for i = 1:N
    theta(i) = (n(i)*pi)/(2*N);
end

%get lift slopes/chords/geo/zero lift AoAs in vector form
a0 = a0_r+(a0_r-a0_t).*-cos(theta);
geo = geo_r+(geo_r-geo_t).*-cos(theta);
c = c_r+(c_r-c_t).*-cos(theta);
aero = aero_r+(aero_r-aero_t).*-cos(theta);

%B matrix
B = geo-aero;

%solve for the Fourier coefficients
for i = 1:N %loop through each theta
    for j = 1:length(odd) % loop through each odd term
        %A matrix
        A(i,j) = (((4*b)/(a0(i)*c(i)))*sin(theta(n(i)) *odd(j))...
            + (odd(j).* sin(theta(n(i)).*odd(j)))./sin(theta(n(i))));
    end
end
%matrix of Fourier coefficients
X = A\B';

S = (c_r + c_t)*(b/2); %planform area, m^2
AR = b^2/S; %aspect ratio

%coefficient of lift
c_L = X(1)*pi*AR;
%find span efficiency factor
for i = 1:length(X)
    delta(i) = n(i).*(X(i)/X(1))^2;
end
e = 1./(1+sum(delta));
%coefficient of drag
c_Di = c_L^2 /(pi*AR*e);

end