%Margaux McFarland, CSC1 1320-112, ID: 107731341, Lab6/HW7
function [ outImg ] = makeBright_NL(inImg, brightness)
%brightens an image given an image and a brightness level to be added

%get size of inImg
[r,c,l] = size(inImg);

i = 1:r;
j = 1:c;
k = 1:l;

%preallocate
outImg = inImg;

outImg(:,:,k) = inImg(:,:,k) + brightness; %brightens each layer
outImg(:,j,:) = inImg(:,j,:) + brightness; %brightens each column
outImg(i,:,:) = inImg(i,:,:) + brightness; %brightens each row



end
