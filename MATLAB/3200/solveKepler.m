function E = solveKepler(e, t, n)
%solveKepler solves Kepler's equation
%   Iteratively finds the closest value for eccentric anomaly given 
%   eccentricity, mean motion, and the time past periapsis  
%
%   Date: 1/28/20

%following algorithm 3.1 on page 153 of textbook...

%mean anomaly
M = n*t;

%tolerance
tolerance = 1e-8;

%pick an initial guess for E
if M < pi
    E = M + e/2;
else
    E = M - e/2;
end

f = E - e*sin(E) - M;
f_prime = 1-e*cos(E);
%calculate ratio
ratio = f/f_prime;

%keep iterating until ratio is less than or equal to set tolerance
while abs(ratio) > tolerance
    E = E - ratio;
    f = E - e*sin(E) - M;
    f_prime = 1-e*cos(E);
    %calculate ratio
    ratio = f/f_prime;
end

end

