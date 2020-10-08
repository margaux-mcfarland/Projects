function [ outImg ] = composite(inImg)
%creates an image that is 2x wider and taller with red/green/blue 
%versions of the image in each corner

%creates 4 of same image
outImg = repmat(inImg,2,2);

%get size of image
[r,c,l] = size(outImg);

%red image vectors
redRow = 1:r/2;
redCol = c/2:c;

outImg(redRow,redCol,1) = 255;

%green image vectors
greenRow = r/2:r;
greenCol = 1:c/2;

outImg(greenRow,greenCol,2) = 255;

%blue image vectors
blueRow = r/2:r;
blueCol = c/2:c;

outImg(blueRow,blueCol,3) = 255;

end


