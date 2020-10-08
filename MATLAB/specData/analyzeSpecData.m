%This script analyzes the spectral data from SASSAGE
%Team 1 w/ da 4th
%ASEN 1400
%4/26/18

%load in images

% Get list of all png files in this directory
% DIR returns as a structure array of images in folder
imagefiles = dir('*.png');      
nfiles = length(imagefiles);    % Number of files found

%vectors for intensities of red/green/blue images
Intensity_Reds = 0;
Intensity_Greens = 0;
Intensity_Blues = 0;

for i=1:nfiles %loops through every screenshot
   %read in current image
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   %make larger-can more easily find red,green,and blue sections
   currentImage = imresize(currentimage,5);
   %size of image
   [row,col,l] = size(currentImage);
   
   %gets dimensions for each color section relative to image size
   [red_xCoor, green_xCoor, blue_xCoor, yCoor] = getDimensions(currentImage);
   
   %create new image sections of each color
   %switch x and y bc (r,c) correspond to (y,x)
   %change to int32 so because dimensions are large
   redImage = currentImage(int32(yCoor(1)):int32(yCoor(2)),int32(red_xCoor(1)):int32(red_xCoor(2)),:);
   greenImage = currentImage(int32(yCoor(1)):int32(yCoor(2)), int32(green_xCoor(1)):int32(green_xCoor(2)),:);
   blueImage = currentImage(int32(yCoor(1)):int32(yCoor(2)),int32(blue_xCoor(1)):int32(blue_xCoor(2)),:);
   
   %calculates average RBG values of each image 
   [r1,g1,b1] = getRGB(redImage);
   [r2,g2,b2] = getRGB(greenImage);
   [r3,g3,b3] = getRGB(blueImage);
   
   %calculates intensity of each image and stores in corresponding vector 
   Intensity_Reds(i) = calcIntensity(r1,g1,b1);
   Intensity_Greens(i) = calcIntensity(r2,g2,b2);
   Intensity_Blues(i) = calcIntensity(r3,g3,b3);
   
   
end
%plots the spec data
plotSpecData(Intensity_Reds,Intensity_Greens,Intensity_Blues);

