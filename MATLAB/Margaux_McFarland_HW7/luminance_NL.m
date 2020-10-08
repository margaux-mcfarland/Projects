function [outImg] = luminance_NL(inImg)
%converts RGB image to a grey scale image

%get size of image
[r,c,~] = size(inImg);
%preallocate
outImg = zeros(r,c);

i = 1:r; %row vector
j = 1:c; %column vector

outImg(i,j) = 0.299*inImg(i,j,1)+ 0.587*inImg(i,j,2) + 0.114*inImg(i,j,3);

end
