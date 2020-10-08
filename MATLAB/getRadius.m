function [thickness] = getRadius(f_o_s)
    %given properties
    stress = 214,000; %kPa
    gage_pressure = 0.01; %kPa
    %assume radius
    radius = 25;
    %radius = (f_o_s * stress *2*t)/gage_pressure;
    thickness = (radius*gage_pressure*f_o_s)/(stress *2);
    %given properties
    
end