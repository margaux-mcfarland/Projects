function e = method2(t)
%this function calculates the coefficient of restitution using a vector of
%time values which represent the the times of two adjacent bounces

n = 2;

e = t(n)/t(n-1);

end