function dRocket = getTrajectory(t, Rocket,mtotal,CoeffDrag,LaunchAngle,wind)

%Bottle Conditions
BottleCSArea = 0.0086590148; %m^2
LaunchRailL = 0.5*cosd(LaunchAngle); %m
LaunchRailH =  0.5*sind(LaunchAngle); %m
g = 9.81;
DensityAirAtm = 0.961; %kg/m^3


%State Vector
x = Rocket(1);
y = Rocket(2);
z = Rocket(3);
xdot = Rocket(4)-wind(1);
ydot = Rocket(5)-wind(2);
zdot = Rocket(6)-wind(3);

VelMagRel = sqrt((xdot)^2+(ydot)^2+(zdot)^2); %relative
Heading = [(xdot-wind(1))/VelMagRel; (ydot-wind(2))/VelMagRel; (zdot-wind(3))/VelMagRel]; %[Cos(theta) Sin(theta)], Relative

%Heading constrained while still on launch rail
if (x < LaunchRailL && z < LaunchRailH)
   Heading = [cosd(LaunchAngle); 0; sind(LaunchAngle)]; 
end

%drag
Drag = DensityAirAtm/2*VelMagRel^2*CoeffDrag*BottleCSArea.*Heading; %N [x; z]

%Final accleration
accel = -Drag/mtotal;
xddot = accel(1);
yddot = accel(2);
zddot = accel(3)-g;


dRocket = [xdot; ydot; zdot; xddot; yddot; zddot];
end

