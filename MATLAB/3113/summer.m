function [] = summer(alpha, epsilon)
%24 hour simulation of GOES-R in summer

%givens
%time vector (24 hours)
t_vec = 0:1:(24*60); %minutes
ang_disp = t_vec.*(2*pi)/(24*60); %radians
%angle at which the radiator is exposed to sun
ang_radiator = linspace(-(pi/2), pi/2, length(t_vec)/2);
ang_radiator = [ang_radiator ang_radiator];
sigma = 5.67e-8; %constant


%AU for summer solstice
AU_summer = 1.0234;
%find solar constant (varies with R)
G1 = 1361; %W/m^2
R1 = 215; %solar radii
G2 = G1.*(1/AU_summer).^2;
%make solar constant
G2 = G2*ones(1,length(t_vec));

q_dot_sc = 63; %W/m^2, IR backloading from spacecraft (summer)
q_dot_instr = 20; %W, heat supplied from instrument

%calculate min area
A = 0.4577; %m^2

%loop through time
for i = 1:length(t_vec)
    if t_vec(i) <= (12*60) %12 hours the radiator is exposed to the sun
        q_dot_sun(i) = A*cos(ang_radiator(i))*alpha*G2(i)*cosd(23.5);
    else %12 hours the radiator is not exposed to sun/has no solar heat contribution
        q_dot_sun(i) = 0;
    end
end


%total heat in
q_in = q_dot_sc*A*epsilon + q_dot_instr + q_dot_sun;

%solve for instrument temp with nothing on
T_instr = ((q_dot_sc*A*epsilon*alpha + q_dot_sun)./(A*epsilon*sigma)).^(1/4);


%operation temperaure 
T_op = 25 + 273; %Kelvin
%surivival temperature
T_s = -40 + 273; %Kelvin
%heat out from radiator
q_out_op = A*sigma*epsilon*T_op^4;
q_out_s = A*sigma*epsilon*T_s^4;

%loop through temp of instrument
for i = 1:length(q_in)
%if temp of instrument is not >= operational temp/survival temp
%then turn on heater
    %operational case
    power_op(i) = q_out_op - q_in(i);
    if power_op(i) < 0
        power_op(i) = 0;
    end
    %survival case
    power_s(i) = q_out_s - q_in(i);
    if power_s(i) < 0
        power_s(i) = 0;
    end
end
figure(1)
yyaxis left
plot(t_vec, power_op);
hold on
plot(t_vec, power_s,'--b');
ylabel('Required Heater Power (W)');
hold on
yyaxis right
plot(t_vec, T_instr,'-');
ylabel('Temperature (K)');
title('Required Heater Power and Unheated Temperature: Summer Soltice');
xlim([0 t_vec(end)]);
ylim([-10 300]);
grid minor
xlabel('Time (s)');
legend('Science Mode', 'Survival Mode', 'Unheated Temperature');
end