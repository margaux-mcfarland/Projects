function [theta_exp,w_exp,v_exp] = LCSDATA(filename)
%this function takes in a file name and parses the data 
%returns measured angle, angular rate, and vertical velocity of 6 full
%cycles

M = dlmread(filename,'\t',1,0);

%6 full cycles start at rows 19 t0 180

%find integer to subtract from wheel position
integer = M(19,2) - mod(M(19,2),360);
%return
theta_exp = M((19:180),2) - integer;
w_exp = (pi/180)*M((19:180),4); %convert to rad/s
v_exp =  M((19:180),5);

end