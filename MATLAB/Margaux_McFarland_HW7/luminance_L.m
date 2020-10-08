function [outImg] = luminance_L(inImg)
%turns a RGB image into grey scale image

%get size of image
[r,c,~] = size(inImg);

outImg = zeros(r,c);


for i = 1:r %loops through rows
    for j = 1:c %loops through columns
        
        outImg(i,j) = 0.299*inImg(i,j,1)+ 0.587*inImg(i,j,2) + 0.114*inImg(i,j,3);
    end
end




end
