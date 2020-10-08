% Coefficient of Drag from Test Data
function CD = CoeffofDrag(doplot)
%plot = 0 or 1, determines if the plots are displayed 
%% Read In

Data = csvread('WTDataTa3.csv', 1,0);

Data = Data(Data(:,4)>1,:);

Airspeed = Data(:,4); %m/s
AirDensity = Data(:,3); %kg/m^3
%ForceNormal = Data(:,24); %N
ForceAxial  = Data(:,25); %N
index = 2;
Airspeedlims(1)= min(Airspeed);
for i = 1:length(Airspeed)-1
    if (abs(Airspeed(i+1)-Airspeed(i)) > 1)
        Airspeedlims(index) = Airspeed(i+1);
        index = index + 1;
    end
end
Airspeedlims(index) = max(Airspeed);

%% Analysis
DiameterBottle = .105; %m
CSArea = pi/4*DiameterBottle^2; %m^2

CD = 2*ForceAxial./(AirDensity.*Airspeed.^2.*CSArea);

if doplot
    figure
    plot(Airspeed, ForceAxial, '.')
    xlabel("Airspeed (m/s)");
    ylabel("Axial Force (N)");

    figure;
    plot(Airspeed, CD, 'o');
    xlabel("Airspeed (m/s)");
    ylabel("Coefficient of Drag");
    
clc;
for i = 1:index-1
    LocalCD = CD(Airspeed > Airspeedlims(i) & Airspeed < Airspeedlims(i+1));
fprintf("Airspeed: %.2f m/s, Avg CD: %f, SD: %f\n", Airspeedlims(i), mean(LocalCD), std(LocalCD));
end
end


end