function [x,y] = NACA_Airfoils(m,p,t,c,N)
%   Generate x and y coordinates for given airfoil
% 
% Input:
%
%     1- m: max camber
%     2- p: location of max camber
%     3- t: thickness
%     4- c: chord length
%     5- N: Panels used.
%
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%
% Output:
%       1- vector containing the x-location of the boundary points
%       2- vector containing the y-location of the boundary points

%thickness equation for NACA 4 digit airfoil series
yt = @(x_in) ((t/0.2)*c)*( 0.2969*sqrt(x_in/c) - 0.1260*(x_in/c) - 0.3516*(x_in/c)^2 + (0.2843*(x_in/c)^3) - (0.1036*(x_in/c)^4) );



r = c/2;

%cover whole airfoil

th = linspace(0,pi,N+1);
x_value3 = r + r.*cos(th);
x_value2 = x_value3;
x_value2(end) = [];

x_value = [x_value3 flip(x_value2)]';


for  i = 1:length(x_value)/2
    

        %from anderson calculation of x and y
        if x_value(i)/c <= p*c
            yc = m*x_value(i)/p^2*(2*p-x_value(i)/c);
            dy_dc = 2*m/p^2*(p-x_value(i)/c);
            zeta = atan(dy_dc);
        else
            yc = m*(c-x_value(i))/(1-p)^2*(1+x_value(i)/c-2*p);
            dy_dc = 2*m/(1-p)^2*(p-x_value(i)/c);
             zeta = atan( dy_dc);

        end
    
    
    %estimations of upper and lower surfaces
    
    YU(i) = yc + yt(x_value(i))*cos(zeta);
    YL(i) = yc - yt(x_value(i))*cos(zeta);

end

x = [x_value];
YU = flip(YU);
YL(end+1) = 0;
%concatenate arrays together
y = [YL  YU];
end