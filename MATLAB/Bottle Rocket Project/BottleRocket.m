% ASEN 2004 Bottle Rocket Simulation (Lab 3)
% Purpose: Simulates water based rocket launching 
% Inputs: >inputs
% Outputs: >plots and shit, idk
% Assumptions: 
% ODE45 numerical integration + Monte Carlo simulation
% Authors: Delaney Jones (ID: 106081404) + ASEN 2004 LabSec13 Group 2
%Modified from ASEN 2012 Project 2 Code for ASEN 2004 Lab 3
% Date Created: Nov 27, 2018
% Date Modified: Mar 18, 2019

%housekeeping
clear; close all; clc;


%%
%Control Variables

ModelType = 2;
%Determines which method to use for ode45
%0 - Thermodynamic
%1 - Thrust Interp
%2 - Isp

TestVar = 3;
%Determines which variable to test
%0 - gauge Pres
%1 - Water Vol
%2 - Launch Angle
%3 - Drag Coeff
%4 - Wind 
%9 - All

VarType = 1;
%determines if/how parameters are varied
%0 - no variation
%1 - Sensitivity analysis (linear variation)
%2 - Monte Carlo is used (random variation

Record = 0;
%Determines if data is saved to external file
%0 - no recording, 1 - data is saved

%Dists of the actual raketa
%Launch1 : 45.6 m
DriftAng1 = 7; %deg
Launch1X = 45.6*cosd(7);
Launch1Y = 45.6*sind(7);
%Launch2 : 52.8 m


%Gauge Pressure (Pa)
%vary from 0 to PMax
%PMax = PFail/FoS; 
Psi2Pa = 6894.757; %conversion factor psi -> Pa
PMax = 40*Psi2Pa; %psi converted to Pa
PMin = 30*Psi2Pa;
PVar = 1*Psi2Pa;
PDesired = 40*Psi2Pa; %Pa, 40 max

%Water Volume (m^3)
%vary from 0 to 0.001
VolMin = 0.00001;
VolMax = 0.001;
VolVar = 0.0001;
VolDesired = .001; %m^3, 0.000971 in TA Baseline 

%Launch Angle (rad)
%vary from 20 deg to 60 deg
LaunchAngleMin = pi/10;
LaunchAngleMax = pi/2.5;
LaunchAngleVar = 1*pi/180; %variation of 1 degree
LAngleDesired = pi/4; %rads

%Coefficient of Drag (Dimensionless)
%vary from 0.3 to 0.5
CD = CoeffofDrag(0);
CoeffDragMax = max(CD); 
CoeffDragMin = min(CD);
CoeffDragVar = .01;
CDDesired = mean(CD); %dimensionless

%Wind vector (mph)
Wind = [0;0; 0]/2.237; %wind velocity in vector form blowing to (N, W, z), mph conv to m/s

%Wind Variation (m/s)
MaxWind = [3;3;0];
MinWind = [-3;-3;0;];
WindVar = [3;3;0];


launchdir = 198; %deg from N
Windconv = [cosd(launchdir) -sind(launchdir) 0; sind(launchdir) cosd(launchdir) 0; 0 0 1]; 
Wind = Windconv*Wind; %wind velocity aligned with dir vec 
% wind = [-10; 5; 0]; %m/s, overriding to [downrange, crossrange, up/down]


%Testing Parameters
N = 1;
TestParam = "No Parameter Tested";
if (VarType > 0)
    N = 1000; %Number of tests to run
    Results = zeros(N,1); %Param Val
    XResults = Results;
    YResults = Results;
    ZResults = Results;
    PGauge = ones(N,1)*PDesired;

    VolWaterInit = ones(N,1)*VolDesired;

    LaunchAngle = ones(N,1)*LAngleDesired;

    CoeffDrag = ones(N,1)*CDDesired;
    Wind = ones(3,N).*Wind;
    switch (TestVar)
        case 0
            TestParam = "Internal Pressure (psi)";
            if (VarType == 1) %lin var
                PGauge = linspace(PMin, PMax, N);
            elseif (VarType ==2) %montecarlo
                PGauge = rand(N,1)*(2*PVar)+PDesired-PVar;
            end
            Results = PGauge;
        case 1
            TestParam = "Water Volume (L)";
            if (VarType == 1) %lin var
                VolWaterInit = linspace(VolMin, VolMax, N);
            elseif (VarType ==2) %montecarlo
                VolWaterInit = rand(N,1)*(2*VolVar)+VolDesired-VolVar;
            end
            Results = VolWaterInit;
        case 2
            TestParam = "Launch Angle (deg)";
            if (VarType == 1) %lin var
                LaunchAngle = linspace(LaunchAngleMin, LaunchAngleMax, N);
            elseif (VarType ==2) %montecarlo
                LaunchAngle = rand(N,1)*(2*LaunchAngleVar) + LAngleDesired-LaunchAngleVar;
            end
            Results = LaunchAngle;
        case 3
            TestParam = "Coefficient of Drag";
            if (VarType == 1) %lin var
                CoeffDrag = linspace(CoeffDragMin, CoeffDragMax, N);
            elseif (VarType ==2) %montecarlo
                CoeffDrag = rand(N,1)*(2*CoeffDragVar) + CDDesired- CoeffDragVar;
            end
            Results = CoeffDrag;
        case 4 %Wind variation
            TestParam = "Wind";
            if (VarType == 1) %lin var
                ErrorString = 'Linear variation of wind is not supported. Please choose another variable or variation method.';
                error(ErrorString);                
            elseif (VarType == 2) %Monte Carlo
                Wind = [(rand(2,N)*2 - 1).*WindVar(1:2) + Wind(1:2)*ones(2,N); zeros(1,N)];
            end
            Results = Wind;
        case 9 %Vary everything (thing, thing, thing ...)
            TestParam = "All Parameters";
            Results = zeros(N,4); %[param1, param2,...,paramN]
               
            Results(:,1) = LaunchAngle;
            if (VarType == 1) %lin var
                PGauge = linspace(PMin, PMax, N);
                VolWaterInit = linspace(VolMin, VolMax, N);
                LaunchAngle = linspace(LaunchAngleMin, LaunchAngleMax, N);
                CoeffDrag = linspace(CoeffDragMin, CoeffDragMax, N);
            elseif (VarType ==2) %montecarlo
                PGauge = rand(N,1)*(2*PVar)+PDesired-PVar;
                VolWaterInit = rand(N,1)*(2*VolVar)+VolDesired-VolVar;
                LaunchAngle = rand(N,1)*(2*LaunchAngleVar) + LAngleDesired-LaunchAngleVar;
                CoeffDrag = rand(N,1)*(2*CoeffDragVar) + CDDesired- CoeffDragVar;
                Wind = [(rand(2,N)*2 - 1).*WindVar(1:2) + Wind(1:2)*ones(2,N); zeros(1,N)];
            end
            Results(:,1) = PGauge;
            Results(:,2) = VolWaterInit;
            Results(:,3) = LaunchAngle;
            Results(:,4) = CoeffDrag;
        otherwise
            TestParam = "Error";
    end
else
    PGauge = PDesired;
    VolWaterInit = VolDesired;
    LaunchAngle = LAngleDesired;
    CoeffDrag = CDDesired;
end
%% Variable Testing
%Variable Testing 

% Monte Carlo simulation setup
winindex = 1; %trial with current best performance
maxvalue = 0; %maximized parameter best performance
MaxDist = 90; %Max plotting range

if (VarType > 0)

    fprintf("Simulating: [%-20s] 0.00%% \n", ''); %progress bar
    progstr = '';
    for index = 1:N
        switch ModelType
            case 0
                [Rocket, ~, ~, ~] = ThermoBottleRocketAnalysis(PGauge(index), VolWaterInit(index), LaunchAngle(index), CoeffDrag(index), Wind(:,index));

            case 1
                [Rocket, ~, ~, ~] = ThrustInterpBottleRocketAnalysis(PGauge(index), VolWaterInit(index), LaunchAngle(index), CoeffDrag(index), Wind(:,index));
            case 2
                %Put the function call for the Isp model here
                [Rocket, RocketTime] = Isp_Model(VolWaterInit(index), LaunchAngle(index), CoeffDrag(index), Wind(:,index));
        end
        
        ZResults(index) = max(Rocket(:,3));
        XResults(index) = Rocket(end,1);
        YResults(index) = Rocket(end,2);
        

        if (sqrt(XResults(index)^2 + YResults(index)^2) > maxvalue)
            winindex = index;
            maxvalue = sqrt(XResults(index)^2 + YResults(index)^2);
        end

        %progress bar animation
        if (sum(index/N*100 == 0:.01:100)>0)
            clc;
            percent = index/N*100;
            if (sum(index/N*20 == 1:1:20)>0 && index/N > .01)
                progstr = '#';
                for j = 2:index/N*20
                    progstr = cat(2,progstr,'#');
                end
            end
            fprintf("Simulating: [%-20s] %.2f%% \n", progstr, percent);
        end
    end
else %No variation 
    switch ModelType
        case 0
            [Rocket,RocketTime, Thrust, ThrustTime] = ThermoBottleRocketAnalysis(PGauge, VolWaterInit, LaunchAngle, CoeffDrag, Wind);
        case 1
            [Rocket,RocketTime, Thrust, ThrustTime] = ThrustInterpRocketAnalysis(PGauge, VolWaterInit, LaunchAngle, CoeffDrag, Wind);
        case 2
            %Put the function call for the Isp model here
            [Rocket, RocketTime] = Isp_Model(VolWaterInit, LaunchAngle, CoeffDrag, Wind);
    end
end

%% Variable Analysis
%Sensitivity Analysis 
if (VarType ==1)
figure;
hold on;
%Data plotting
switch TestVar
%Reconversion to Units that make sense to real people
    case 0
        Results = Results/6894.757; %conv to PSI
    case 1
        Results = Results *1000; %conv to L
    case 2
        Results = Results*180/pi; %conv from radians to deg
    case 9
        Results(:,1) = Results(:,1) /6894.757; %conv to PSI
        Results(:,2) = Results(:,2) *1000; %conv to L
        Results(:,3) = Results(:,3)*180/pi; %conv from radians to deg
end
plot(Results, XResults, 'o');

xlabel(TestParam); 
ylabel("Distance (m)"); ylim([0,MaxDist]);
xlim([min(Results), max(Results)]);
title("Sensitivity Analysis");

%lines for best trial
Ybestline = [Results(winindex) Results(winindex); 0, MaxDist];
Xbestline = [Results(1), Results(end); XResults(winindex), XResults(winindex)];

plot(Ybestline(1,:), Ybestline(2,:), Xbestline(1,:), Xbestline(2,:));
BestString = sprintf("Max Distance: %f m\n Value: %f", XResults(winindex), Results(winindex));
text(Results(winindex),XResults(winindex)+5, BestString);
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Monte Carlo and Error elispes
elseif (VarType == 2) 
switch TestVar
%Reconversion to Units that make sense to real people
    case 0
        Results = Results /6894.757; %conv to PSI
    case 1
        Results = Results *1000; %conv to L
    case 2
        Results = Results*180/pi; %conv from radians to deg
    case 9
        Results(:,1) = Results(:,1) /6894.757; %conv to PSI
        Results(:,2) = Results(:,2) *1000; %conv to L
        Results(:,3) = Results(:,3)*180/pi; %conv from radians to deg
end
P = cov(XResults,YResults); %covariance matrix
Xave = mean(XResults);
Yave = mean(YResults);
points = 1:pi/N:3*pi; %angles in a circle

[eigvec, eigval] = eig(P);
xyvec = [cos(points'),sin(points')]*sqrt(eigval)*eigvec';
xvec = xyvec(:,1);
yvec = xyvec(:,2);

%Error ellipses
hold on;
plot(XResults,YResults,'.')
plot(1*xvec+Xave,1*yvec+Yave,'b')
plot(2*xvec+Xave,2*yvec+Yave,'r')
plot(3*xvec+Xave,3*yvec+Yave,'g')
plot(Launch1X, Launch1Y, 'o', 'LineWidth', 5);
xlabel("Downrange Distance (m)");
ylabel("Crossrange Distance (m)");
title("Error Ellipses for Isp Model (1000 samples)");


hold off;
end
%% Flight Data Plotting
%call to get best trial data
if(VarType > 0)
    switch ModelType
        case 0
            [Rocket, RocketTime, Thrust, ThrustTime] = ThermoBottleRocketAnalysis(PGauge(winindex), VolWaterInit(winindex), LaunchAngle(winindex), CoeffDrag(winindex), Wind(:,winindex));
        case 1
            [Rocket, RocketTime, Thrust, ThrustTime] = ThrustInterpBottleRocketAnalysis(PGauge(winindex), VolWaterInit(winindex), LaunchAngle(winindex), CoeffDrag(winindex), Wind(:,winindex));
        case 2
            %Put the function call for the Isp model here
            [Rocket, RocketTime] = Isp_Model(VolWaterInit(winindex), LaunchAngle(winindex), CoeffDrag(winindex), Wind(:,winindex));
    end
end


%%  Best Result Plotting and Data Display

%model labeling
switch ModelType
    case 0
        ModelName = "Thermodyanamic";
    case 1 
        ModelName = "Thrust Interpolation";
    case 2
        ModelName = "Isp";
end

DriftAngle = -atand(Rocket(end,2)/Rocket(end,1));

fprintf("\nTrial %d of %d\nInitial Conditions:\nP_Gauge: %.f Pa, Water Vol: %.3f L, Launch Angle: %.2f deg, Drag Coefficient: %.3f \nVaried Parameter: %s, Model Used: %s\n\n", winindex, N,  PGauge(winindex)/Psi2Pa, ...
    VolWaterInit(winindex)*1000, LaunchAngle(winindex)*180/pi, CoeffDrag(winindex), TestParam, ModelName);
fprintf("Results: \nMax height: %.2f m, Max distance: %.2f m, Flight time: %.2f s, Drift Angle: %.2f° \n\n", max(Rocket(:,3)), sqrt(Rocket(end,1)^2 + Rocket(end,2)^2), RocketTime(end), DriftAngle);

%graph of alt vs dist
figure('Name',['Trial ' num2str(winindex)]);
%subplot(1,2,1);
plot(Rocket(:,1),Rocket(:,3))
xlabel("Downrange Distance (m)");ylabel("Height (m)");
xlim([0 MaxDist]); ylim([0; 30]);
title("Trajectory");
DistPlot = gca;
DistPlot.XGrid = 'on';
DistPlot.YGrid = 'on';
%subplot(1,2,2);
if ModelType ~= 2
    %graph of thrust vs time
    plot(ThrustTime,Thrust)
    xlabel("time(s)"); ylabel("Thrust (N)");
    title("Thrust"); 
    ThrustPlot = gca;
    ThrustPlot.XGrid = 'on';
    ThrustPlot.YGrid = 'on';
    xlim([0 .45]); ylim([0 200]);
end
%plot 3d 
figure;
plot3(Rocket(:,1), Rocket(:,2), Rocket(:,3));
xlabel('Downrange (m)');
xlim([0, MaxDist]);
ylim([-40, 40]);
zlim([0, 40]);
ylabel('Cross (m)');
zlabel('Altitude (m)');
title('3-d Flight Profile');
threeDplot = gca;
threeDplot.XGrid = 'on';
threeDplot.ZGrid = 'on';
threeDplot.YGrid = 'on';

if (Record && VarType > 0)
%longtime data recording (Monte Carlo)
TheBest = fopen('AllTimeBests.txt','a+');
fprintf(TheBest, "\nTrial %d of %d\nInitial Conditions:\nP_Gauge: %.f Pa, Water Vol: %.3f L, Launch Angle: %.2f deg, Drag Coefficient: %.3f \nVaried Parameter: %s, Model Used: %s\n\n", winindex, N,  PGauge(winindex)/Psi2Pa, ...
    VolWaterInit(winindex)*1000, LaunchAngle(winindex)*180/pi, CoeffDrag(winindex), TestParam, ModelName);
fprintf(TheBest, "Results: \nMax height: %.2f m, Max distance: %.2f m, Flight time: %.2f s\n\n", max(Rocket(:,2)), max(Rocket(:,1)), RocketTime(end));

fclose(TheBest);
end
