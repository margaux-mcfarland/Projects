function Result = parseFile(filename)
%parseFile parses data of a given file into a struct
%   This function takes in a filename and separates each column into
%   instances of a results struct and returns that struct
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 3/20/20

M = dlmread(filename,'\t',1,0);

time = M(:,1); %ms
torque_in = M(:,2); %mNm
angvelocity = M(:,3); %rpm
current = M(:,4); %amp

Result = struct('Time', time, 'Torque', torque_in, 'AngVel', angvelocity, 'Current', current);


end