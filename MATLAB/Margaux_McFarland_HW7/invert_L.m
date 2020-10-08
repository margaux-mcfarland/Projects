function [outImg] = invert_L(inImg)
%inverts the colors of the image

%get size of inImg
[r,c,l] = size(inImg);

outImg = inImg;

for k = 1:l %loops through layers
    for i = 1:r %loops through rows
        for j = 1:c %loops through columns  
            outImg(i,j,k) = 255 - inImg(i,j,k);
        end
    end
end

end
