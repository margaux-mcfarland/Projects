function F = simpRule(f, a,  b, N, theta)
%simpRule This function uses Simpson's Rule 
%   Simpson's Rule approximates the area under a curve by a parabola
%   connecting the curve at the endpoints and the midpoints. This function 
%   takes in the function (f) being approximated,the upper(b),lower bounds 
%   (a), the number of panels (N), and returns the area.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 9/13/19


h = (b-a)/(2*N); %height of each panel
%area being approximated
F = 0;
for i = 1:N
    %indicied of points along cylinder 
    k1 = 2*i - 1;
    k2 = 2*i;
    k3 = 2*i + 1;
    %sum each force
    F = F + f(k1) + 4*f(k2) + f(k3);
end
    
    F = F * (h/3);
end 