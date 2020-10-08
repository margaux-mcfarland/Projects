function error = generalMethod(heights,time_stop,sig_height,sig_time)
%this function calculates the error propagated when calculating the
%coefficient of resitituion (Method 3)

%gravity
g = 9.81; %m/s^2

%partial derivative in terms of height
d_height = (-1/(g*sqrt(2*heights(1)/g)*(time_stop+sqrt(2*heights(1)/g))))...
    -((time_stop-sqrt(2*heights(1)/g))/(g*(time_stop+sqrt(2*heights(1)/g))^2*sqrt(2*heights(1)/g)));

%partial derivative in terms of time stop
d_time = (1/(time_stop+sqrt(2*heights(1)/g)))-...
    ((time_stop-sqrt(2*heights(1)/g))/(time_stop+sqrt(2*heights(1)))^2);

error = sqrt( (d_height*sig_height)^2+(d_time*sig_time)^2);



end