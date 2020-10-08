function Result = parseFile(filename)
%parseFile parses data of a given file into a struct
%   This function takes in a filename and separates each column into
%   instances of a results struct and returns that struct
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 4/14/20

M = csvread(filename,2,0); %start reading at third row

time = M(:,1); %s
acc0 = M(:,2); %mm/s^2
acc1 = M(:,3); %mm/s^2
acc2 = M(:,4); %mm/s^2
acc3 = M(:,5); %mm/s^2
disp0 = M(:,6); %mm
disp1 = M(:,7); %mm
disp2 = M(:,8); %mm
disp3 = M(:,9); %mm
laser_vib_disp = M(:,10); %mm


Result = struct('time', time, 'acc0', acc0, 'acc1', acc1,...
    'acc2', acc2,'acc3', acc3, 'disp0', disp0, 'disp1', disp1, 'disp2', ...
    disp2, 'disp3', disp3, 'laser_disp', laser_vib_disp);

end