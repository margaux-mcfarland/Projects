function F = trapRule(x, f, N)
%trapRule This function uses the composite trapezoidal rule
%   Composite trap rule approximates the area under a curve by creating a 
%   trapezoid at integration points along the curve. Returns the
%   approximated area F under the curve represented by the vector f.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 9/17/19

%area 
F = 0;

for k = 1:N %loop through integration panels
    %sum each trapezoid area
    F = F + (x(k+1) - x(k))*((f(k+1) + f(k))/2); 
end

end