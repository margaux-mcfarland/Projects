function [e1, e2] = method1(h)
%this fuction calculates the coefficient of resituation
%using Method 1 which takes 3 heights of a bouncing ball

%there are two different ways to calculate e using the heights so this
%function returns two different coefficients which should be equal

%number of heights
n = 3;

%num of bounces
num = 2;
%initial height 
h_0 = h(1); %cm


e1 = sqrt(h(n)/h(n-1));
e2 = (h(n)/h_0)^(1/(2*num));

end