function [ outImg ] = color_swap(inImg, r1, g1, b1, r2, g2, b2, allowed)
%Take in an RGB (3D array) image and swap pixels that equal
%r1,g2,b2 with r2,g2,b2 (if in allowed range)

%get size of inImg
[r, c, l] = size(inImg);

outImg = inImg;

%threshold values
redMin = r1 - allowed;
redMax = r1 + allowed;

greenMin = g1 - allowed;
greenMax = g1 + allowed;

blueMin = b1 - allowed;
blueMax = b1 + allowed;

for j = 1:c
    for i = 1:r
        if inImg(i,j,1) > redMin && inImg(i,j,1) < redMax
           outImg(i,j,1) = r2; 
        end
        
        if inImg(i,j,2) > greenMin && inImg(i,j,2) < greenMax
           outImg(i,j,2) = g2;
        end
        
        if inImg(i,j,3) > blueMin && inImg(i,j,3) < blueMax
           outImg(i,j,3) = b2;
        end
    end
end

        



end