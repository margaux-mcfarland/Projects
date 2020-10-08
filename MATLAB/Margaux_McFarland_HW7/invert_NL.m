function [outImg] = invert_NL(inImg)
%inverts image without loops

%size of image
[r,c,l] = size(inImg);

outImg = inImg;

%vectors
i = 1:r; %rows
j = 1:c; %columns
k = 1:l; %layers

outImg(i,j,k) = 255 - inImg(i,j,k);

end

