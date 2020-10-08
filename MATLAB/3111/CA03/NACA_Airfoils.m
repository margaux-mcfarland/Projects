function [x,y] = NACA_Airfoils(m,p,t,c,N)
%NACA_Airfoils constructs panels for a given NACA airfoil
%   This function returns vectors of the x and y locations of the boundary
%   points. This function takes in the max camber m, the location of the
%   max camber p, the thickness t, the chord length c, and N the number of
%   panels employed.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/25/19

%x position along chord
x_chord = 0:(2*c)/N:c;

%calculate thickness distribution
y_t = (t/0.2).*c.*(0.2969.*(x_chord./c).^(1/2)-0.1260.*(x_chord./c)-0.3516.*(x_chord./c).^2+0.2843.*(x_chord./c).^3-0.1036.*(x_chord./c).^4);

%find formula for mean camber line
if x_chord <= (p*c)  
    y_c = m.*(x_chord./p^2).*(2*p - (x_chord./c));
elseif x_chord <= c
    y_c = m.*((c-x_chord)./(1-p)^2).*(1+(x_chord./c)-(2*p));
end

%find slope of camber line
if x_chord <= (p*c)  
    dy_c = ((m/p^2).*(2*p - (x_chord./c))) + m.*(x_chord./p^2).*(2*p - (1/c));
elseif x_chord <= c
    dy_c = -(2.*m.*x_chord)./(c*(1-p)^2) + ((2*m*p)/(1-p)^2);
end

%anlge between camber and chord
angle = atan(dy_c);

%upper surface
x_u = x_chord - y_t.*sin(angle);
y_u = y_c + y_t.*cos(angle);
%lower surface
x_l = x_chord + y_t.*sin(angle);
y_l = y_c - y_t.*cos(angle);

%trim the first element so as not to repeat when combining the upper and
%lower surface vectors
x_l = x_l(2:end);
y_l = y_l(2:end);

%add corrdinates, starting from trailing edge
x = [flip(x_l) x_u];
y = [flip(y_l) y_u];

end