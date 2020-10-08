function [w0, Q] = calcSallenKey(R, C1, C2)
%takes in a resistor value and two capacitor values and returns the max
%gain, Q, and the frequency at the max gain, w0

w0 = 1/(R*sqrt(C1*C2));
Q = 0.5*sqrt(C1/C2);

end