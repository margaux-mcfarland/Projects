function uncertainty = generalMethod3(ts, h0, dts, dh0)
%this function calculates the error propagated when calculating the
%coefficient of resitituion (Method 3)

syms Ts H0

%gravity
g = 9.81; %m/s^2

e(Ts, H0) = (Ts - sqrt(2*H0/g))/(Ts + sqrt(2*H0/g));

de_ts(Ts, H0) = diff(e, Ts);
de_h0(Ts, H0) = diff(e, H0);

de(Ts, H0) = sqrt((de_ts(Ts, H0)*dts)^2 + (de_h0(Ts, H0)*dh0)^2);

uncertainty = double(de(ts, h0));

end