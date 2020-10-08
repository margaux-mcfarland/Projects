%% ASEN 3200-Lab A3: calculate the moment of inertia of the reaction wheel.

%% load in data

%added in results 
results1 = parseFile('Unit7_Base_5'); %5mNm
results2 = parseFile('Unit7_Base_6'); %6mNm
results3 = parseFile('Unit7_Base_7'); %7mNm
results4 = parseFile('Unit7_Base_8'); %8mNm
results5 = parseFile('Unit7_Base_9'); %9mNm
results6 = parseFile('Unit7_Base_10'); %10mNm
results7 = parseFile('Torque_10nM_Pt1'); %10mNm
results8 = parseFile('Torque_15nM_Pt1'); %15mNm
results9 = parseFile('Torque_20nM_Pt1'); %20mNm

%convert units
results1.Time = (1/1000).*results1.Time; %s
results1.Torque = (1/1000).*results1.Torque; %Nm
results1.AngVel = ((2*pi)/60).*results1.AngVel; %rad/s
results2.Time = (1/1000).*results2.Time; %s
results2.Torque = (1/1000).*results2.Torque; %Nm
results2.AngVel = ((2*pi)/60).*results2.AngVel; %rad/s
results3.Time = (1/1000).*results3.Time; %s
results3.Torque = (1/1000).*results3.Torque; %Nm
results3.AngVel = ((2*pi)/60).*results3.AngVel; %rad/s
results4.Time = (1/1000).*results4.Time; %s
results4.Torque = (1/1000).*results4.Torque; %Nm
results4.AngVel = ((2*pi)/60).*results4.AngVel; %rad/s
results5.Time = (1/1000).*results5.Time; %s
results5.Torque = (1/1000).*results5.Torque; %Nm
results5.AngVel = ((2*pi)/60).*results5.AngVel; %rad/s
results6.Time = (1/1000).*results6.Time; %s
results6.Torque = (1/1000).*results6.Torque; %Nm
results6.AngVel = ((2*pi)/60).*results6.AngVel; %rad/s
results7.Time = (1/1000).*results7.Time; %s
results7.Torque = (1/1000).*results7.Torque; %Nm
results7.AngVel = ((2*pi)/60).*results7.AngVel; %rad/s
results8.Time = (1/1000).*results8.Time; %s
results8.Torque = (1/1000).*results8.Torque; %Nm
results8.AngVel = ((2*pi)/60).*results9.AngVel; %rad/s
results9.Time = (1/1000).*results9.Time; %s
results9.Torque = (1/1000).*results9.Torque; %Nm
results9.AngVel = ((2*pi)/60).*results9.AngVel; %rad/s

%% get angular accelerations

%best fit curve for each
p1 = polyfit(results1.Time, results1.AngVel,1);
f1 = polyval(p1,results1.Time);
p2 = polyfit(results2.Time, results2.AngVel,1);
f2 = polyval(p2,results2.Time);
p3 = polyfit(results3.Time, results3.AngVel,1);
f3 = polyval(p3,results3.Time);
p4 = polyfit(results4.Time, results4.AngVel,1);
f4 = polyval(p4,results4.Time);
p5 = polyfit(results5.Time, results5.AngVel,1);
f5 = polyval(p5,results5.Time);
p6 = polyfit(results6.Time, results6.AngVel,1);
f6 = polyval(p6,results6.Time);
p7 = polyfit(results7.Time, results7.AngVel,1);
f7 = polyval(p7,results7.Time);
p8 = polyfit(results8.Time, results8.AngVel,1);
f8 = polyval(p8,results8.Time);
p9 = polyfit(results9.Time, results9.AngVel,1);
f9 = polyval(p9,results9.Time);

angAcc1 = (max(f1) - min(f1))/(max(results1.Time) - min(results1.Time)) %rad/s


%% compute
%torques applied for each trial
T1 = 5/1000; %Nm
T2 = 6/1000; %Nm
T3 = 7/1000; %Nm
T4 = 8/1000; %Nm
T5 = 9/1000; %Nm
T6 = 10/1000; %Nm
T7 = 10/1000; %Nm
T8 = 15/1000; %Nm
T9 = 20/1000; %Nm

%moment of inertia of wheel (equation when there is external torque
%applied, M not equal to 0) (divide each torque by angular acceleration)
Iw1 = T1/abs(p1(1)); %kgm^2
Iw2 = T2/abs(p2(1));
Iw3 = T3/abs(p3(1));
Iw4 = T4/abs(p4(1));
Iw5 = T5/abs(p5(1));
Iw6 = T6/abs(p6(1));
Iw7 = T7/abs(p7(1));
Iw8 = T8/abs(p8(1));
Iw9 = T9/abs(p9(1));

I_vec = [Iw1 Iw2 Iw3 Iw4 Iw5 Iw6 Iw7 Iw8 Iw9];
%find average value
Iw_avg = mean(I_vec)



