clear; close; clc

FilenameMaster = filenameGenerator();
BLFilename = FilenameMaster(9:30);

VVFilename = 'VelocityVoltage_S014_G13.csv';

%Velocity Voltage
%we usde the pitot tube with the transducer, venturi tube with manometer

%pressure transducer
VVData = parseFile(VVFilename);
[VVspeed, VVMethod] = calcAirSpeed(VVData.AtmP,VVData.AtmT,VVData.PDiff1,1);

%manometer
h = ([0 (0.7+0.3) (1.4+1) (0.35+0.07) (2.3+1.9)]')*0.0254;%m
h = sort(h);
ManoData = struct('V', [0.5 2.5 4.5 6.5 8.5]','AtmP', VVData.AtmP(600:500:3000), 'AtmT', VVData.AtmT(600:500:3000),  'Pdiff', []);
sgrav = 0.826; %dimensionless, ratio of density of fluid to water
sgrav = sgrav*9.8*1000; %kg/m^3*m/s^2 = N/m^3
ManoData.Pdiff = h*sgrav; %N/m^2
[ManoSpeed, ManoMethod] = calcAirSpeed(ManoData.AtmP, ManoData.AtmT, ManoData.Pdiff,2);

figure(1);
subplot(1,2,1)
plot(VVData.V, VVspeed,'*');
%line.LineWidth = 5;
xlabel('Voltage (V)')
ylabel('Velocity (m/s)')
title(VVMethod)
%saveas(gcf,VVMethod,'png');
subplot(1,2,2)
plot(ManoData.V, ManoSpeed,'*');
%line.LineWidth = 5;
xlabel('Voltage (V)')
ylabel('Velocity (m/s)')
title(ManoMethod)
%saveas(gcf,'BothVPlots','png');


Vandv = polyfit(VVData.V,VVspeed,1);
fprintf("\nv = %.3fV + %.3f\n",Vandv)

%plot velocity voltage with error bars
figure(2)
% error of velocity calculated using pressure transducer
errorMethod1 = zeros(length(ManoSpeed),1); 
% error of velocity calculated using water manometer
errorMethod2 = zeros(length(VVspeed),1);

for i = 1:length(ManoSpeed) % error associated with manometer
     %error for manometer = ± 0.05 inches = 0.00127 m
    
    errorMethod1(i) = generalMethod(ManoData.Pdiff(i),0.1*248.84, ManoData.AtmP(i),...
        3.45*10^3, ManoData.AtmT(i), 0.25, 1,VVData.V(i));
end

for i = 1:length(VVspeed) %error associated with venturi tube
    % get error associated with each velocity point
    %error for atmospheric pressure = ±1.5%
    %error for atmoshperic temperature = ±¼C + 273.15 = 273.40 K
    %error for differential pressure transducer = ±0.1%
    errorMethod2(i) = generalMethod(VVData.PDiff1(i),0.01*6894.76, VVData.AtmP(i),...
        3.45*10^3, VVData.AtmT(i), 0.25, 2, VVData.V(i));
    
end
%take average of velocities and error bars
sum1 = 0; sum1_2 = 0; sum1_error = 0; sum1_error_2 = 0; count1 = 0; count1_2 = 0;
sum2 = 0; sum2_2 = 0; sum2_error = 0; sum2_error_2 = 0; count2 = 0; count2_2 = 0;
sum3 = 0; sum3_2 = 0; sum3_error = 0; sum3_error_2 = 0; count3 = 0; count3_2 = 0;
sum4 = 0; sum4_2 = 0; sum4_error = 0; sum4_error_2 = 0; count4 = 0; count4_2 = 0;
sum5 = 0; sum5_2 = 0; sum5_error = 0; sum5_error_2 = 0; count5 = 0; count5_2 = 0;

%loop through transducer data
for i = 1:length(VVData.V)
    if VVData.V(i) == 0.5
        sum1_2 = sum1_2 + VVspeed(i);
        sum1_error_2 = sum1_error_2 + errorMethod2(i);
        count1_2 = count1_2 + 1;
    elseif VVData.V(i) == 2.5
        sum2_2 = sum2_2 + VVspeed(i);
        sum2_error_2 = sum2_error_2 + errorMethod2(i);
        count2_2 = count2_2 + 1;
    elseif VVData.V(i) == 4.5
        sum3_2 = sum3_2 + VVspeed(i);
        sum3_error_2 = sum3_error_2 + errorMethod2(i);
        count3_2 = count3_2 + 1;
    elseif VVData.V(i) == 6.5
        sum4_2 = sum4_2 + VVspeed(i);
        sum4_error_2 = sum4_error_2 + errorMethod2(i);
        count4_2 = count4_2 + 1;
    elseif VVData.V(i) == 8.5
        sum5_2 = sum5_2 + VVspeed(i);
        sum5_error_2 = sum5_error_2 + errorMethod2(i);
        count5_2 = count5_2 + 1;
    end
end

averageVelocity2 = [sum1_2/count1_2 sum2_2/count2_2 sum3_2/count3_2 sum4_2/count4_2 sum5_2/count5_2];

averageError2 = [sum1_error_2/count1_2 sum2_error_2/count2_2 sum3_error_2/count3_2 sum4_error_2/count4_2 sum5_error_2/count5_2];

figure(2)
%venturi tube subplot
subplot(1,2,2)
errorbar([0.5 2.5 3.5 6.5 8.5] ,ManoSpeed,errorMethod1,'*');
title('U-tube Manometer');

xlabel('Voltage (V)');
ylabel('Average Velocity (m/s)');

%pitot-static probe subplot
subplot(1,2,1);
errorbar([0.5 2.5 3.5 6.5 8.5] ,averageVelocity2,averageError2,'*');
title('Pressure Transducer');

xlabel('Voltage (V)');
ylabel('Average Velocity (m/s)');

%plot comparing the pitot-static uncertainties and the venturi tube
%uncertainties
figure(3);
plot([0.5 2.5 3.5 6.5 8.5], errorMethod1);
hold on;
plot([0.5 2.5 3.5 6.5 8.5], averageError2);
legend('Uncertainty associacted with the Manometer','Uncertainty associated with the pressure transducer','Location','northwest');
title('Uncertainties of Air speed for each method');
xlabel('Voltage (V)');
ylabel('Uncertainty (m/s)');

%Boundary Layer

ports = [1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11];
delta = zeros(length(BLFilename),1);
for i = 1:length(BLFilename)
FName = BLFilename(i);
BLData = parseFile(FName);
BLSpeed = calcAirSpeed(BLData.AtmP,BLData.AtmT,BLData.PDiff2,2);
a = BoundaryLayer(BLData,BLSpeed);
    delta(i) = a;
end
figure(4);
plot(ports,delta)
xlabel('Port'); ylabel('Boundary Layer Height (cm)');

