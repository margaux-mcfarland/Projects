function [c_s,error_c_s] = calcSpecificHeat(cal_mass,sample_mass,cal_c_s,T_0,T_1,T_2,sig_cal_mass,sig_sam_mass,sig_cal_c,sig_T_0,sig_T_1,sig_T_2)
%%this function takes in the mass of the sample, the mass of the
%%calorimeter, the specific heat of the calorimeter, the initial
%%temperature of the water, the intial temperature of the sample, and the
%%final temperature of the calorimeter. The specific heat of the sample is
%%then calculated and returned.
c_s = (cal_mass * cal_c_s * (T_2-T_0))/(sample_mass*(T_1-T_2));

%calculate error associated with specific heat using the general method
%partial derivatives of each term
d_cal_mass = (cal_c_s * (T_2-T_0))/(sample_mass*(T_1-T_2));
d_sample_mass = -(cal_mass * cal_c_s * (T_2-T_0))/(sample_mass^2*(T_1-T_2));
d_cal_c_s = (cal_mass * (T_2-T_0))/(sample_mass*(T_1-T_2));
d_T_0 = -(cal_mass * cal_c_s)/(sample_mass*(T_1-T_2));
d_T_1 = -(sample_mass*cal_mass * cal_c_s * (T_2-T_0))/(sample_mass*(T_2-T_1))^2;
d_T_2 = (cal_mass * cal_c_s)/(sample_mass*(T_1-T_2)) + (sample_mass*(cal_mass * cal_c_s * (T_2-T_0))/(sample_mass*(T_2-T_1))^2);

error_c_s = sqrt((d_cal_mass*sig_cal_mass)^2+(d_sample_mass*sig_sample_mass)^2+...
    (d_cal_c_s*sig_cal_c_s)^2+(d_T_0*sig_T_0)^2+(d_T_1*sig_T_1)^2+(d_T_2*sig_T_2)^2);

end