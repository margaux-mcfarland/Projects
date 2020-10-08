%%This function converts 2D wing data to 3D finte data
function [C_L, C_D, a] = convertTo3D(alpha, c_l, c_d, a_0, alpha_0)

%assume span efficiency of 0.9
e = 0.9;
%aspect ratio
AR = 16.5; 

%3D curve slope
a = a_0/(1+((57.3*a_0)/(pi*e*AR)));

%3D coefficient of lift
C_L = a * (alpha - alpha_0);

%3D coefficient of drag
C_D = c_d + ((C_L^2)/(pi*e*AR));


end