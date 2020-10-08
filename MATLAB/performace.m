function [v_R_range, v_R_endur] = performance(max_C_D,e_0,density)
%for max range C_D = 2C_D0
C_D0 = max_C_D/2;
%C_D0 = k*C_L^2;

%given
AR= = 16.5;
W = 6.4; %kg
S = 0.63;

C_L = C_D0*pi*AR*e_0;
v_R_range = sqrt((2*W)/(density*S*C_L));


C_L = 3*C_D0*pi*AR*e_0;
v_R_endur = sqrt((2*W)/(density*S*C_L));

end