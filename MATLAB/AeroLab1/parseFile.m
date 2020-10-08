function Result = parseFile(filename)

M = csvread(filename,1,0);

atmosphPressure = M(:,1); %Pa
atmosphTemp = M(:,2); %K
diffPres1 = M(:,3); %Pa
diffPres2 = M(:,4); %Pa
xDist = M(:,5); %mm
yDist = M(:,6); %mm
voltage = M(:,7); %V

Result = struct('AtmP', atmosphPressure, 'AtmT', atmosphTemp, 'PDiff1', diffPres1,...
    'PDiff2', diffPres2, 'xDist', xDist, 'yDist', yDist, 'V', voltage);

end
