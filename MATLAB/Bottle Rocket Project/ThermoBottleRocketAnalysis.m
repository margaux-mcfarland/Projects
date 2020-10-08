function [Rocket, RocketTime, Thrust, ThrustTime] = ThermoBottleRocketAnalysis(PGauge, VolWaterInit, LaunchAngle, CoeffDrag, wind)

%Global vars
global ThrustValues i tGlobal
i = 0; ThrustValues = 0; tGlobal = 0;

%Rocket Conditions
VolBottle = 0.002; %m^3
DiameterBottle = .105; %m
DiameterThroat = 0.021; %m
%MassBottle = 0.132; %kg
MassBottle = .123; %kg, test case
CoeffDis = 0.8; %dimensionless
LaunchRailL = 0.5; %m
LaunchRailH = 0.25;

%Atmospheric Conditions/Constants
RAir = 287; %J/kg*K
PAtm = 12.1*6894.7572932; %Pa (Atmospheric Pressure)
TAtm = 66; %F
TAtm = (TAtm-32)*5/9+273; %K
%TAtm = 300; %K, test case
DensityWater = 1000; %kg/m^3
DensityAirAtm = 0.961; %kg/m^3
MassWaterInitial = DensityWater*VolWaterInit; %kg/m^3
gamma = 1.4; %specific heat ratios


%Inital condition calculations
%PAir = PAtm + PGauge;
PAir = PGauge;
TAir = TAtm;%*((PGauge+PAtm)/PAtm)^((gamma-1)/gamma);
%DensityAirInitial = (PAtm+PGauge)/(RAir*TAir); %Pa/(Pa*m^3)*kg*K/K = kg/m^3 
MassAirInitial = PAir*(VolBottle-VolWaterInit)/RAir/TAir;%(VolBottle-VolWaterInitial)*DensityAirInitial; %kg
CSArea = pi/4*DiameterBottle^2;
ThroatCSArea = pi/4*DiameterThroat^2;


%%
%Calculations

%ODE45 Setup

%Rocket - state vector for rocket
%       -[x position, z position, x velocity, z velocity, total mass,
%       internal pressure, volume of gas inside]
RocketInitial = [0; 0; LaunchRailH; 0; 0; 0; MassAirInitial+MassWaterInitial+MassBottle; PGauge+PAtm; VolBottle-VolWaterInit];

%RocketCond - Initial information about bottle rocket 
%           - 8 things
%           -[Volume of Bottle, Coefficient of Drag, Discharge Coefficient,
%           Bottle cross-section area, throat cross-section area, Launch
%           Angle, LaunchRail Length, LaunchRail Height]
RocketCond = [VolBottle, CoeffDrag, CoeffDis, CSArea, ThroatCSArea, LaunchAngle, ...
    LaunchRailL, LaunchRailH];
    
%PropCond - Initial state of gas/liquid propelling rocket 
%         - 6 things
%         -[Initial Pressure, Mass, and Volume, Ideal gas constant (per kg),
%        specific heat ratio, Density of liquid]
PropCond = [PGauge+PAtm, MassAirInitial, VolBottle-VolWaterInit, RAir, gamma, DensityWater];

%AtmCond - Atmospheric Conditions
%        - 2 things
%        - [Atmospheric Pressure, Atmospheric Density of Air outside rocket]
AtmCond = [PAtm, DensityAirAtm, wind(1), wind(2), wind(3)];

%ode options
opts=odeset('RelTol',1e-5,'Events',@phase_swap);
TSpan = [0 10];

%ODE45 Call
[RocketTime, Rocket] = ode45(@(t,y) ThermoRocketForces(t,y,RocketCond, PropCond, AtmCond) ...
    ,TSpan, RocketInitial, opts);

%Trim end time 
Rocket = Rocket(Rocket(:,3)>=-.01,:);
RocketTime = RocketTime(Rocket(:,3)>=-.01);

%Extract only Thrust and time values used by ODE45
index = zeros(length(RocketTime),1);
index(1) = 1;
for j=1:length(index)
    if ~isempty(find(RocketTime(j) == tGlobal,1))
        index(j) = find(RocketTime(j) == tGlobal,1);
    end
end
index = index(index>0);
ThrustValues = ThrustValues(index);
tGlobal = tGlobal(index);
ThrustValues = ThrustValues(tGlobal<0.5);
tGlobal = tGlobal(tGlobal<0.5);

Thrust = ThrustValues;
ThrustTime = tGlobal;
end



%% State Function for ODE45
function [dRocket] = ThermoRocketForces(t, Rocket, RocketCond, PropCond, AtmCond)
%State function for ODE45 Call
%
%Assumptions - Near earth's surface, all flows are steady, isentropic,
%Thrust is never negative (P inside of rocket is >= P atmospheric)
%
%Rocket - state vector for rocket
%       -[x position, y position, z position, x velocity, y velocity, z velocity, total mass,
%       internal pressure, volume of gas inside]
%RocketCond - Initial information about bottle rocket
%           -[Volume of Bottle, Coefficient of Drag, Discharge Coefficient,
%           Bottle cross-section area, throat cross-section area, Launch
%           Angle, LaunchRail Length, LaunchRail Height]
%PropCond - Initial state of gas/liquid propelling rocket
%         -[Initial Pressure, Mass, and Volume, Ideal gas constant (per kg),
%        specific heat ratio, Density of liquid]
%AtmCond - Atmospheric Conditions
%        - [Atmospheric Pressure, Atmospheric Density of Air outside rocket,
%        - wind x, wind y, wind z]

global i ThrustValues tGlobal
persistent PEnd

%Bottle Conditions
VolBottle = RocketCond(1); %m^3
CoeffDrag = RocketCond(2); %Dimensionless
CoeffDis = RocketCond(3); %Dimensionless
BottleCSArea = RocketCond(4); %m^2
ThroatCSArea = RocketCond(5); %m^2
LaunchAngle = RocketCond(6); %rads
LaunchRailL = RocketCond(7); %m
LaunchRailH = RocketCond(8); %m

%Propelling Gas 
PAirInit = PropCond(1); %Pa
MAirInit = PropCond(2); %kg
VolAirInit = PropCond(3); %m^3
R = PropCond(4); %J/kgK
gamma = PropCond(5); %Dimensionless
%Propelling Liquid
DensityWater = PropCond(6); %kg/m^3

%Atmoshperic Conditions
PAtm = AtmCond(1); %Pa
DensityAirAtm = AtmCond(2); %kg/m^3
g = [0; 0; -9.80665]; %m/s^2
Wind = AtmCond(3:5)'; %wind vector, m/s

%State Vector
x = Rocket(1);
y = Rocket(2);
z = Rocket(3);
xdot = Rocket(4);
ydot = Rocket(5);
zdot = Rocket(6);
mtotal = Rocket(7);
PAir = Rocket(8);
VolAir = Rocket(9); 

VelMagRel = sqrt((xdot-Wind(1))^2+(ydot-Wind(2))^2+(zdot-Wind(3))^2); %relative
HeadingRel = [(xdot-Wind(1))/VelMagRel; (ydot-Wind(2))/VelMagRel; (zdot-Wind(3))/VelMagRel]; %[Cos(theta) Sin(theta)], Relative

VelMag = sqrt(xdot^2+ydot^2+zdot^2); %absolute
Heading = [xdot/VelMag; ydot/VelMag; zdot/VelMag]; %[Cos(theta) Sin(theta)]
%Heading constrained while still on launch rail
if (x < LaunchRailL*cos(LaunchAngle) && z < LaunchRailH + LaunchRailL*sin(LaunchAngle))
   Heading = [cos(LaunchAngle); 0; sin(LaunchAngle)]; %theta in rads
   HeadingRel = Heading;
end

%Phase independent calculations
Drag = DensityAirAtm/2*VelMagRel^2*CoeffDrag*BottleCSArea.*HeadingRel; %N [x; z]
DensityAirInit = MAirInit/VolAirInit;
DensityAir = DensityAirInit*(PAir/PAirInit)^(1/gamma);
MAir = DensityAir*VolAir;

%Second regime (air pressure propulsion)
if (VolAir >= VolBottle) 
    PAir = PEnd*(MAir/MAirInit)^gamma;
    DensityAir = DensityAirInit*(PAir/PAirInit)^(1/gamma);
    TAir = PAir/(DensityAir*R);
    PCrit = PAir*(2/(gamma+1))^(gamma/(gamma-1));
    %Choked flow
    if PCrit>PAtm
        TExit = (2/(gamma+1))*TAir;
        VelExit = sqrt(gamma*R*TExit);
        PExit = PCrit;
    %non-choked flow
    else
        MachExit = sqrt(((PAir/PAtm)^((gamma-1)/gamma)-1)*(2/(gamma-1)));
        %Cannot have Mach < 0, bound check keeps ode45 from trying to use
        %complex numbers
        if(((PAir/PAtm)^((gamma-1)/gamma)-1)*(2/(gamma-1)) <0)
            MachExit = 0;
        end
        TExit = TAir/(1+(gamma-1)/2*MachExit^2);
        PExit = PAtm;
        VelExit = MachExit*sqrt(gamma*R*TExit);
    end
    DensityExit = PExit/(R*TExit);
    VolAirdot = 0;
    mtotaldot = -CoeffDis*DensityExit*ThroatCSArea*VelExit;
    Thrust = (-mtotaldot*VelExit + (PExit-PAtm)*ThroatCSArea);
    %Bound check, prevents thrust from being negative
    if (Thrust < 0)
        Thrust = 0;
    end    
    PAirdot = PEnd*gamma/MAirInit*(MAir/MAirInit)^(gamma-1)*mtotaldot;
    %Tracking thrust values
    i = i+1;
    ThrustValues(i) = Thrust;
    tGlobal(i) = t;
    Thrust = Thrust*Heading;
    
%Third regime (ballistic phase)
elseif (PAir <= PAtm + (PAtm*.01)) 
    Thrust = 0*HeadingRel;
    mtotaldot  = 0;
    PAirdot = 0; 
    VolAirdot = 0;
    
%First regime (Water propulsion)
else 
    VelExit = sqrt(2*(PAir-PAtm)/DensityWater);
    VolAirdot = CoeffDis*ThroatCSArea*VelExit;
    mtotaldot = -CoeffDis*ThroatCSArea*DensityWater*VelExit; 
    Thrust = -mtotaldot*VelExit;
    
    %Thrust Magnitude
    i = i+1;
    ThrustValues(i) = Thrust;
    tGlobal(i) = t;
    
    Thrust = Thrust*Heading;
    PAirdot = -PAirInit*gamma*VolAirInit/VolAir^2*((VolAirInit/VolAir)^(gamma-1))*VolAirdot;
    
    %Last pressure in first regime
    PEnd = PAir;
end

%Final accleration
accel = Thrust/mtotal-Drag/mtotal+g;
xddot = accel(1);
yddot = accel(2);
zddot = accel(3);

dRocket = [xdot; ydot; zdot; xddot; yddot; zddot; mtotaldot; PAirdot; VolAirdot];
end

function [value,isterminal,direction]=phase_swap(t,state)
%Event control function for ODE45 call, increases accuracy around critical
%areas 
   
%Constants
vol_bottle=0.002;
p_atm=83426.56;
stand_length=0.5;
stand_height=0.25;

%state of rocket
x=state(1);
z=state(3);
P=state(8);
Vol_air=state(9);

%1 - leaving launch rail
%2 - end of water propulsion
%3 - end of air propulsion
%4 - end of flight
value=[stand_length-sqrt(x^2+(z-stand_height)^2), vol_bottle-Vol_air,...
    P-p_atm,z];
isterminal=[0,0,0,1];
direction=[-1,-1,-1,-1];
end