function Result = parseFile(filename, nameData)
%parseFile parses data of a given file into a struct
%   This function takes in a filename and separates each column into
%   instances of a results struct and returns that struct
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/11/19

M = csvread(filename,1,0);

atmP = M(:,1); %Pa
atmTemp = M(:,2); %K
atmDensity = M(:,3); %kg/m^3
airspeed = M(:,4); %m/s
pitot_q = M(:,5); %Pa
aux_q = M(:,6); %Pa ,dyn at the end- static not meausured behind but in front
P = M(:,7:22); %Pa %from each port
alpha = M(:, 23);
N = M(:,24); %axial force, N
A = M(:,25); %normal force, N
pitchM = M(:, 26); %pitching moment, Nm
xDist = M(:, 27); %mm
yDist = M(:, 28); %mm

%create a visited field which will see if the element has been looped
%through later... start out as no match (0/false)
matched = 0;

Result = struct('AtmP', atmP, 'AtmT', atmTemp, 'atmD', atmDensity,...
    'V', airspeed,'pitot_q', pitot_q, 'aux_q', aux_q, 'P', P, 'alpha', ...
    alpha, 'N', N, 'A', A, 'M', pitchM,  'xDist', xDist, 'yDist', yDist, 'nameData', nameData, 'matched', matched);

end