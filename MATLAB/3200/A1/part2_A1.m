%% ASEN 3200-Lab A1 part 2: Reaction Wheel Measurements
%Import the data into MATLAB and plot the angular velocity as a function of time. 
%Find the average angular acceleration 
%by fitting a line to the data and compute an estimate of the moment of 
%inertia of the wheel in [kg m2]. Using the multiple trials compute the 
%mean and standard deviation of your estimate. 

%% load in Matlab data

%added in results 
results1 = parseFile('Unit7_RW_1'); %trial 1
results2 = parseFile('Unit7_RW_5'); %trial 2
results3 = parseFile('Unit7_RW_7'); %trial 3
results4 = parseFile('Unit7_RW_9'); %trial 4
results5 = parseFile('Unit7_RW_10'); %trial 5
results6 = parseFile('Unit7_RW_11'); %trial 6
results7 = parseFile('Unit7_RW_13'); %trial 7
results8 = parseFile('Unit7_RW_15'); %trial 8

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
results8.AngVel = ((2*pi)/60).*results8.AngVel; %rad/s

%% plot
figure(1)
sgtitle('Angular Velocity vs Time');

%trial 1
subplot(2,4,1)
plot(results1.Time, results1.AngVel);
title('Trial 1');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,1)
p = polyfit(results1.Time, results1.AngVel,1);
f = polyval(p,results1.Time);
plot(results1.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc1 = (max(f) - min(f))/(max(results1.Time) - min(results1.Time)) %rad/s


%trial 2
subplot(2,4,2)
plot(results2.Time, results2.AngVel);
title('Trial 2');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,2)
p = polyfit(results2.Time, results2.AngVel,1);
f = polyval(p,results2.Time);
plot(results2.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc2 = (max(f) - min(f))/(max(results2.Time) - min(results2.Time)) %rad/s

%trial 3
subplot(2,4,3)
plot(results3.Time, results3.AngVel);
title('Trial 3');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,3)
p = polyfit(results3.Time, results3.AngVel,1);
f = polyval(p,results3.Time);
plot(results3.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc3 = (max(f) - min(f))/(max(results3.Time) - min(results3.Time)) %rad/s

%trial 4
subplot(2,4,4)
plot(results4.Time, results4.AngVel);
title('Trial 4');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,4)
p = polyfit(results4.Time, results4.AngVel,1);
f = polyval(p,results4.Time);
plot(results4.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc4 = (max(f) - min(f))/(max(results4.Time) - min(results4.Time)) %rad/s

%trial 5
subplot(2,4,5)
plot(results5.Time, results5.AngVel);
title('Trial 5');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,5)
p = polyfit(results5.Time, results5.AngVel,1);
f = polyval(p,results5.Time);
plot(results5.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc5 = (max(f) - min(f))/(max(results5.Time) - min(results5.Time)) %rad/s

%trial 6
subplot(2,4,6)
plot(results6.Time, results6.AngVel);
title('Trial 6');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,6)
p = polyfit(results6.Time, results6.AngVel,1);
f = polyval(p,results6.Time);
plot(results6.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc6 = (max(f) - min(f))/(max(results6.Time) - min(results6.Time)) %rad/s

%trial 7
subplot(2,4,7)
plot(results7.Time, results7.AngVel);
title('Trial 7');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,7)
p = polyfit(results7.Time, results7.AngVel,1);
f = polyval(p,results7.Time);
plot(results7.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc7 = (max(f) - min(f))/(max(results7.Time) - min(results7.Time)) %rad/s

%trial 8
subplot(2,4,8)
plot(results8.Time, results8.AngVel);
title('Trial 8');
xlabel('Time (s)');
ylabel('Angular Vecocity (rad/s)');
grid on
hold on

%plot best fit curve for each
subplot(2,4,8)
p = polyfit(results8.Time, results8.AngVel,1);
f = polyval(p,results8.Time);
plot(results8.Time,f);
hold off

%find slope of that line (angular acceleration)
angAcc8 = (max(f) - min(f))/(max(results8.Time) - min(results8.Time)) %rad/s

%% compute
%torques applied for each trial
T1 = 1/1000; %Nm
T2 = 5/1000; %Nm
T3 = 7/1000; %Nm
T4 = 9/1000; %Nm
T5 = 10/1000; %Nm
T6 = 11/1000; %Nm
T7 = 13/1000; %Nm
T8 = 15/1000; %Nm

%moment of inertia of wheel (equation when there is external torque
%applied, M not equal to 0)
Iw1 = T1/angAcc1
Iw2 = T2/angAcc2
Iw3 = T3/angAcc3
Iw4 = T4/angAcc4
Iw5 = T5/angAcc5
Iw6 = T6/angAcc6
Iw7 = T7/angAcc7
Iw8 = T8/angAcc8

%mean and standard deviation
Iw = [Iw1 Iw2 Iw3 Iw4 Iw5 Iw6 Iw7 Iw8];
meanIw = mean(Iw)
std_dev = std(Iw)


