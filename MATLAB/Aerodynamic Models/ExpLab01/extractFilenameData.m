function nameData = extractFilenameData(filename)
%extractFilenameData gets necessary data from the filename
%   This functions takes in the filename and extracts the model geometry,
%   upstream/downstream, wind tunnel speed, streamwise position, and
%   repetition number
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/11/19

%first find model geometry
index = strfind(filename, "_"); %find first instance of '_'
if (lower(filename(index(1) + 1)) == 'c')
    model = "cylinder";
else
    model = "airfoil";
end
filename = extractAfter(filename, "_"); %cut down string each time at the underscore
%upstream/downstream
index = strfind(filename, "_"); %find first instance of '_'
if (lower(filename(index(1) + 1)) == 'u')
    direction = "up";
else
    direction = "down";
end
filename = extractAfter(filename, "_");
%wind tunnel speed
filename = extractAfter(filename, "_");
speed = extractBefore(filename, "_"); %speed is in between each underscore

%streamwise position
filename = extractAfter(filename, "_");
xPos = extractBetween(filename, 1, "_"); %don't include 'x'

%repetition number
filename = extractAfter(filename, "_");
rep = extractBetween(filename, 1, "."); %don't include 'r'

nameData = [model, direction, speed, xPos, rep];

end