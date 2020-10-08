function [uncertainty] = generalMethod2(tn, tn1, dtn, dtn1)
%generalMethod1 
%   Calculates the uncertainty of the calculation of the coefficient of restitution using the general method of error
%   propagation of Method 2
%
%   Created by Jordan Abell
%       6 February 2019
%
%   Input:
%       tn - [s] Time of nth bounce
%       tn1 - [s] Time of (n-1) bounce
%       dtn - [s] Uncertainty of tn measurement
%       dtn1 - [s] Uncertainty of tn1 measurement
%
%   Output:
%       uncertainty - Uncertainty of the calculation of the coefficient of
%       restitution, e
syms Tn Tn1

e(Tn, Tn1) = (Tn/Tn1);

de_tn(Tn, Tn1) = diff(e, Tn);
de_tn1(Tn, Tn1) = diff(e, Tn1);

de(Tn, Tn1) = sqrt((de_tn(Tn, Tn1)*dtn)^2 + (de_tn1(Tn, Tn1)*dtn1)^2);

uncertainty = double(de(tn, tn1));
end

