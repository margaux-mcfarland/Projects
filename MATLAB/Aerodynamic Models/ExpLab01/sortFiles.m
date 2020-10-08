function [all_configurations] = sortFiles()
%sortFiles sorts csv files in a folder into matching configurations
%   This function opens a folder of csv files and sorts the files based on
%   the filename which states the experimental configuration in which the
%   data was taken. This function returns a vector of all structs of each
%   configuration.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/19/19

%% loop through all data files - sort
currentFolder = pwd; %path of this folder
dataPath = currentFolder + "/DataFiles";
dataFiles = dir(fullfile(dataPath,'*.csv'));
numFiles = length(dataFiles); %number of .csv files in this folder 

%keep track of size of each configuration vector
count1 = 1; count2 = 1; count3 = 1; count4 = 1; count5 = 1; count6 = 1; count7 = 1;
  count8 = 1; count9 = 1; count10 = 1; count11 = 1; count12 = 1; count13 = 1; count14 = 1;

for i = 1:numFiles
  filename = dataFiles(i).name;
  %extract all necessary data from file name
  nameData = extractFilenameData(filename); %vector
  %get data inside file
  filepath = dataPath + "/" + filename;
  results = parseFile(filepath, nameData); %struct
  %group 14 configurations
  switch nameData(1) %model geometry
      case "cylinder"
          switch nameData(4) % wake position
              case "x60"
                config1(count1) = results;
                count1 = count1 + 1;
              case "x90"
                config2(count2) = results;
                count2 = count2 + 1;
              case "x120"
                config3(count3) = results;
                count3 = count3 + 1;
              case "x150"
                config4(count4) = results;
                count4 = count4 + 1; 
              case "x180"
                  config5(count5) = results;
                count5 = count5 + 1;
              case "x210"
                  config6(count6) = results;
                count6 = count6 + 1;
              case "x240"
                config7(count7) = results;
                count7 = count7 + 1;
          end
 
      case "airfoil"
         switch nameData(4) % wake position
              case "x13"
                config8(count8) = results;
                count8 = count8 + 1;
              case "x18"
                config9(count9) = results;
                count9 = count9 + 1;
              case "x23"
                config10(count10) = results;
                count10 = count10 + 1;
              case "x28"
                config11(count11) = results;
                count11 = count11 + 1; 
              case "x33"
                  config12(count12) = results;
                count12 = count12 + 1;
              case "x38"
                  config13(count13) = results;
                count13 = count13 + 1;
              case "x43"
                config14(count14) = results;
                count14 = count14 + 1;
         end
  end
  
end

all_configurations = {config1; config2; config3; config4; config5; config6; config7;...
    config8; config9; config10; config11; config12; config13; config14};

end