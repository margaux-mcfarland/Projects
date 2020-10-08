function data = parseFile3(filename)
%this function reads in the logger pro trials 

M = csvread(filename,1,1);
heights(:,1) = M(:,1);
heights(:,2) = M(:,2);
heights(:,3) = M(:,3);

data = struct('Heights',heights);


end