function [force_system] = getForceSystem(f_o_s)
    radius = getRadius(f_o_s);
    g = 9.7; %m/2/2 %gravity at 35 km
    %given properties
    density_air = 0.0082; %kg/m^3
    density_gas = 0.0017; %hydrogen %kg/m^3
    density_material = 1400; %mylar %kg.m^3
    volume_displaced = (4/3)*pi*(radius)^3;
    force_system = g*volume_displaced*(density_air+density_gas+density_material);

end