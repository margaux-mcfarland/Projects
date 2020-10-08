%% ASEN 3111 - CFD Lab - Pre-Main
%  CFD Lab - parses raw data and saves as mat file
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 12/6/19

clc
clear all
close all

%% loop through all data files
currentFolder = pwd; %path of this folder
dataPath = currentFolder + "/CFD_Data";
dataFiles = dir(fullfile(dataPath,'*.csv'));
numFiles = length(dataFiles); %number of .csv files in this folder 

for i = 1:numFiles
  filename = dataFiles(i).name;
  %get data inside file
  filepath = dataPath + "/" + filename;
  results(i) = parseData(filepath); %struct
  
end

save Data_CFD_McFarland_Margaux results

