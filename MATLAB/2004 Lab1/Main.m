
clear; close all; clc;

%airfoil data

AirfoilData = [-5.0000, -0.2446, 0.0140;-4.0000,-0.1465,0.0091;...
    -3.0000,-0.0401,0.0073;-2.0000,0.0658,0.0059;-1.0000,0.1717,0.0049;...
    0.0000,0.2737,0.0043;1.0000,0.4058,0.0045;2.0000,0.5143,0.0050;3.0000,...
    0.6167,0.0057;4.0000,0.7194,0.0066;5.0000,0.8201,0.0078;6.0000,...
    0.9193,0.0092;7.0000,1.0129,0.0112;8.0000,1.1027,0.0134;9.0000,...
    1.1844,0.0165;10.0000,1.2533,0.0201;11.0000,1.2865,0.0252;12.0000,...
    1.2763,0.0332;13.0000,1.2329,0.0475;14.0000,1.1635,0.0720;15.0000,...
    1.0951,0.1052];

%Tempest data
Tempest=[-5,-0.32438,0.044251;-4,-0.21503,0.033783;-3,-0.10081,0.028627;...
    -2,0.010503,0.025864;-1,0.12155,0.024643;0,0.24163,0.025099;1,...
    0.34336,0.025635;2,0.45256,0.02766; 3,0.56037,0.030677;4,0.66625,...
    0.034855;5,0.76942,0.040403;6,0.86923,0.04759;7,0.96386,0.057108;...
    8,1.0441,0.070132;9,1.0743,0.090921;10,1.0807,0.11193;11,1.0379,...
    0.13254;12,1.034,0.15645];


%%
%Calculated Wing Drag Polar

Wing2dAoA = AirfoilData(:,1);
Wing2dCl = AirfoilData(:,2);
Wing2dCd = AirfoilData(:,3);

TempestCFDAoA = Tempest(:,1);
TempestCFDCL = Tempest(:,2);
TempestCFDCD = Tempest(:,3);

Winge = .9;
AR = 16.5;
Wing2dk = 1/(pi*Winge*AR);

Wing2da0 = (Wing2dCl(14)-Wing2dCl(6))/(Wing2dAoA(14)-Wing2dAoA(6));
Wing2da = Wing2da0/(1+57.3*Wing2dk*Wing2da0);

Wing2dAoAlis0 = lininterp(Wing2dCl(3:4), Wing2dAoA(3:4), 0);

WingCL = Wing2da*(Wing2dAoA-Wing2dAoAlis0);

WingCD = Wing2dCd + WingCL.^2*Wing2dk;


%%
%Whole Aircraft Drag Polar

Cfe = 0.004;

%original
%SWet = 2.3997; %m^2
%SPForm = 0.8640; %m^2

SWet = 3; %m^2
SPForm = 0.63; %m^2


CDMin = Cfe*SWet/SPForm;

ArCfte = 1.78*(1-0.045*AR^(0.68))-0.64;
ArCftk = 1/(pi*ArCfte*AR);


%TODO: calc by extrapolating from nearest points


MinCDAoA = find(WingCD == min(WingCD));
MinCDAoA = [MinCDAoA-1, MinCDAoA, MinCDAoA + 2, MinCDAoA + 1]; 
Leftedge = [Wing2dAoA(MinCDAoA(1:2))'; WingCD(MinCDAoA(1:2))'];
Rightedge = [Wing2dAoA(MinCDAoA(3:4))'; WingCD(MinCDAoA(3:4))'];
[WingAoAMinD, ~] = linextrap(Leftedge, Rightedge);

%Wing2dAoA(WingCD == min(WingCD));
CLMinD = Wing2da*(WingAoAMinD-Wing2dAoAlis0);

ParasiteDrag = CDMin;
InducedDrag = ArCftk*(WingCL-CLMinD).^2;

ArCftCD = ParasiteDrag + InducedDrag; 

CDCLerror = (ArCftCD(Wing2dAoA<10) - TempestCFDCD(TempestCFDAoA < 10))./TempestCFDCD(TempestCFDAoA < 10)*100;

%subplot(2,1,1)
hold on;
plot(WingCL(Wing2dAoA < 10),ArCftCD(Wing2dAoA < 10), WingCL(Wing2dAoA < 10), WingCD(Wing2dAoA < 10))
%legend("Whole Aircraft", "3d Wing")
%ylabel('CD')
%subplot(2,1,2)
plot(TempestCFDCL, TempestCFDCD)
legend("Whole Aircraft", "3d Wing","CFD Data")
xlabel('CL'); ylabel("CD")
hold off;
figure;
plot(WingCL(Wing2dAoA < 10),ArCftCD(Wing2dAoA < 10), WingCL(Wing2dAoA < 10), ParasiteDrag*ones(1,length(Wing2dAoA(Wing2dAoA < 10))),WingCL(Wing2dAoA < 10), InducedDrag(Wing2dAoA < 10))
legend("Total Drag","Parasite Drag", "Induced Drag")
xlabel('CL'); ylabel("CD")

LoDCalc = WingCL(Wing2dAoA < 10)./ArCftCD(Wing2dAoA < 10);
LoDTempest = TempestCFDCL./TempestCFDCD;

%max
[LoDCalc_max, index] = max(LoDCalc);
[LoDTempest_max,indexCFD] = max(LoDTempest);

figure; 
plot(Wing2dAoA(Wing2dAoA < 10), LoDCalc, TempestCFDAoA, LoDTempest)
legend("Calculated L/D", "CFD L/D")
xlabel("AoA (degrees)"); ylabel("L/D")

AirDensity = lininterp([1.5 2], [1.0581, 1.0066], 1.8);
WingArea = .63;

V = sqrt(2*(62.784)/cosd(4)/(AirDensity*WingCL(Wing2dAoA == 4)*WingArea));

% 
%%
%Range + Endurance
CruisingAlt = 1.8; %km
%Std Atm at Cruising Altitude;
[T,SoS,P, AirDensity] = atmosisa(1800); %at 1.8 km

%Max range
[v_R_range, v_R_endur] = performance(CDMin,mean(CLMinD), ArCfte, AirDensity);
%index = find(==CDMin);
angle = Wing2dAoA(index);


[v_R_rangeCFD, v_R_endurCFD] = performance(min(TempestCFDCD),mean(CLMinD), ArCfte, AirDensity);
angleCFD = TempestCFDAoA(indexCFD);


%%
%utilities
function [y] = lininterp(xpts, ypts, x)
%linearly interpolate from data in a table or graph

y = (ypts(2) - ypts(1))/(xpts(2)-xpts(1))*(x-xpts(1)) + ypts(1);


end

function [xcoords, ycoords] = linextrap(leftpts, rightpts)
%linarly extrapolate from data points on a graph
%leftpts - [x1 x2; y1 y2]

leftslope = (leftpts(2,1) - leftpts(2,2))/(leftpts(1,1) - leftpts(1,2));
rightslope = (rightpts(2,1) - rightpts(2,2))/(rightpts(1,1) - rightpts(1,2));

xrange = linspace(leftpts(1,2), rightpts(1,2), 100);

leftline = leftpts(2,2) + (xrange - leftpts(1,2))*leftslope;
rightline = rightpts(2,2) + (xrange - rightpts(1,2))*rightslope;

xcoords = xrange(abs(leftline - rightline) <= .0001);
ycoords = leftline(abs(leftline - rightline) <= .0001);

end