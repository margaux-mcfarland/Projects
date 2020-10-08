% MODEL_2 computes the angular velocity of a cylinder with an attatched
% trailing aparatus rolling down a ramp. 
%
% MODEL_2 assumes the trailing component translates but does not rotate, 
% that the cylinder rolls  without slipping, and that there is a constant 
% negative moment applied to the shaft of the wheel due to friction.
%
% Inputs:
% > angular position of cylinder 
% > system geometric constraints
% > coefficient of friction
% 
% Outputs:
% > angular velocity of cylinder at each angular postion

function [w] = MODEL_2(theta, constants, Mf)

M = constants(1);
k = constants(2);
M_0 = constants(3);
g = constants(4);
R = constants(5);
beta = constants(6);

I = M * k^2;

num = ((2*M_0*g*R*sin(beta)*(M + M_0)).*theta-(Mf.*theta));

dem = ((M + M_0)*R^2) + I;

w = sqrt(num/dem);
end