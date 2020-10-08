function Result = parseFile(filename)

M = csvread(filename,1,0);

atmosphPressure = M(:,1); %Pa
atmosphTemp = M(:,2); %K
atmosphDensity = M(:,3); %kg/m^3
airSpeed = M(:,4); %m/s
dynPres_Pitot = M(:,5); %Pa
dynPres_Aux = M(:,6); %Pa
%matrix of pressures at each port
portPres = [M(:,7),M(:,8),M(:,9),M(:,10),M(:,11),M(:,12),M(:,13),...
    M(:,14),M(:,15),M(:,16),M(:,17),M(:,18),M(:,19),M(:,20),M(:,21),M(:,22)];

angleOfAttack = M(:,23); %degrees
normalForce = M(:,24); %N
axialForce = M(:,25); %N
moment = M(:,26); %Nm

xDist = M(:,27);%m
yDist = M(:,28);%m

Result = struct('AtmP', atmosphPressure, 'AtmT', atmosphTemp,'AtmDensity',atmosphDensity, 'AirSpeed', airSpeed,...
    'DynPres_Pitot', dynPres_Pitot, 'DynPres_Aux', dynPres_Aux, 'portPres', portPres,...
    'Angle', angleOfAttack,'Normal_Force',normalForce,'Axial_Force',axialForce,'Moment',moment,'xDist',xDist,'yDist',yDist);

end
