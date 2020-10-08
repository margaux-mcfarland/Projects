function Result = parseData(filename)
%parseFile parses data of a given file into a struct
%   This function takes in a filename and separates each column into
%   instances of a results struct and returns that struct
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 11/26/19

M = csvread(filename,3,0);

iteration = M(:,1); 
forceCoeff = M(:,2); 


Result = struct('iteration', iteration, 'forceCoeff', forceCoeff);

end