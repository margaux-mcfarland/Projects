%% ASEN 3111 - Experimental Lab 01 - Pre-Main
%  Flow Over Thin Airfoils - parses raw data
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/23/19

clc
clear all
close all

%% sort files
all_configurations = sortFiles(); %vector of structs of data files

save Data_EXP_McFarland_Margaux all_configurations