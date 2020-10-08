function [ outImg ] = addRandomNoise_NL( inImg )
%adds random noise to each pixel in image without loops
%get size of image
[r,c,l] = size(inImg);

outImg = inImg;

%vectors
i = 1:r; %rows
j = 1:c; %columns
k = 1:l; %layers

%random values matrix
randVals = uint8(randi(511,r,c,l)-256);


outImg(i,j,k) = inImg(i,j,k) + randVals(i,j,k);
end
