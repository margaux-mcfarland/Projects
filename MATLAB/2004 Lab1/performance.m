function [v_R_range, v_R_endur] = performance(min_C_D,CLMinD,e_0,density)

%given
AR = 16.5;
W = 6.4*9.81; 
S = 0.63;
%for max range C_D = 2C_D0
C_D0 = min_C_D + (1/2)*CLMinD^2/(pi*AR*e_0);

C_L = sqrt(C_D0*pi*AR*e_0);
v_R_range = sqrt((2*W)/(density*S*C_L));


C_L_endur = sqrt(3*C_D0*pi*AR*e_0);
v_R_endur = sqrt((2*W)/(density*S*C_L_endur));

end