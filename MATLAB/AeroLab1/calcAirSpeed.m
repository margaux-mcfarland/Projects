function [airv, PlotTitle] = calcAirSpeed(atmosphPressure, atmosphTemp, diffPres, method)
%calculation of airspeed from pitot tube pressure differential data
%method = 1 - pitot-static
%       = 2 - Venturi Tube

% R value for air 
R = 0.2871*1000; %J/kg/K

% Velocity 
if (method == 1)
    airv = sqrt((2*diffPres.*R.*atmosphTemp)./atmosphPressure);
    PlotTitle = 'Pitot-Static Probe';
else
    A2 = 1;
    A1 = 9.5;
    airv = sqrt((2*diffPres.*R.*atmosphTemp)./(atmosphPressure.*(1-(A2/A1)^2 )));
    PlotTitle = 'Venturi Tube';
end

end

