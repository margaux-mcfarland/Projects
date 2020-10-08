% MODEL_3 computes the angular velocity of an unbalanced cylinder with 
% an attatched trailing aparatus rolling down a ramp. 
%
% MODEL_3 assumes the trailing component translates but does not rotate, 
% that the cylinder rolls  without slipping, that there is a constant 
% negative moment applied to the shaft of the wheel due to friction, and
% that the additional mass causing the cylinder to be unbalanced is a
% point particle. 
%
% Inputs:
% > angular position of cylinder 
% > system geometric constraints
% > coefficient of friction
% 
% Outputs:
% > angular velocity of cylinder at each angular postion

function [w] = MODEL_3(theta, constants, Mf)
Me=constants(7);
k = constants(2);
M=constants(1);
M0=constants(3);
g=constants(4);
R=constants(5);
beta=constants(6);
R_te=constants(8);
I = M * k^2;


num = 2.*(((M+M0)*R*g.*theta.*sin(beta)) + (Me.*g.*R.*theta.*sin(beta)) - ...
    (Mf.*theta) - (Me.*g.*R_te.*(cos(theta+beta)-cos(beta)))); 

den= ((M+M0).*R^2) + (Me.*(R^2+2.*R.*R_te.*cos(theta)+R_te^2)) + I;

w=sqrt(num./den);

end
