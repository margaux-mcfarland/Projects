function [uncertainty] = generalMethod1(hn, h0, n, dhn, dh0)
%generalMethod1 
%   Calculates the uncertainty of the calculation of the coefficient of restitution using the general method of error
%   propagation of Method 1
%
%   Created by Jordan Abell
%       6 February 2019
%
%   Input:
%       hn - [m] Height of nth bounce
%       h0 - [m] Initial height
%       n - Number of bounces
%       dhn - [m] Uncertainty of hn measurement
%       dh0 - [m] Uncertainty of h0 measurement
%
%   Output:
%       uncertainty - Uncertainty of the calculation of the coefficient of
%       restitution, e
syms Hn H0 N

e(Hn, H0, N) = (Hn/H0)^(1/(2*N));

de_hn(Hn, H0, N) = diff(e, Hn);
de_h0(Hn, H0, N) = diff(e, H0);

de(Hn, H0, N) = sqrt((de_hn(Hn, H0, N)*dhn)^2 + (de_h0(Hn, H0, N)*dh0)^2);

uncertainty = double(de(hn, h0, n));

end

