function [v_mod] = LCSMODEL(r, d, l, theta, w)
%this function takes in a radius, distance from the vetical shaft and
%center, length of connecting bar, theta, and the angular acceleration of
%the wheel
%returns the model velocity of the collar (vertical speed)

B = real((pi/2)- acos(d./(l+((r.*sin(theta))./(cos((pi/2)-((pi/2)-theta)))))));

v_mod = r.*w.*(sin(theta)-cos(theta).*tan(B));


end