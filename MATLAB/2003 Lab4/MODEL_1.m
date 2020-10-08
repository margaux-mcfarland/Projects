% MODEL_1 computes the angular velocity of a cylinder with an attatched
% trailing aparatus rolling down a ramp. 
%
% MODEL_1 assumes the trailing component translates but does not rotate, 
% and that the cylinder rolls without slipping.
%
% Inputs:
% > angular position of cylinder 
% > system geometric constraints
% 
% Outputs:
% > angular velocity of cylinder at each angular postion

function [w] = MODEL_1(theta, constants)

M = constants(1);
k = constants(2);
M_0 = constants(3);
g = constants(4);
R = constants(5);%gt_3sig_2a
beta = constants(6);

I = M*k^2;

num = (2*M_0*g*R*sin(beta)*(M + M_0)).*theta;

dem = ((M + M_0)*R^2) + I;

w = sqrt(num/dem);
end 