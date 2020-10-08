function [zero_l_AoA] = calcZeroLiftAoA(m,p,t,c)
%calcZeroLiftAoA calculates a zero lift angle of attack given airfoil
%geometry, using thin airfoil theory
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 11/7/19

sym theta;
%transform variable
x_chord = @(theta)(c/2)*(1-cos(theta));


zero_l_AoA_rad = -(1/pi)*integral(@(theta) func(theta).*(cos(theta) - 1), 0, pi);

    function dy_c = func(theta)
        %find slope of camber line
        if x_chord(theta) <= (p*c)  
            dy_c = ((m/p^2)*(2*p - (x_chord(theta)/c))) + m*(x_chord(theta)/p^2)*(2*p - (1/c));
        elseif x_chord(theta) <= c
            dy_c = -(2*m*x_chord(theta))/(c*(1-p)^2) + ((2*m*p)/(1-p)^2);
        end
    end

%convert to degrees
zero_l_AoA = rad2deg(zero_l_AoA_rad);

end