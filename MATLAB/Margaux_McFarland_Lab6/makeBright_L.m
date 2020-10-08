%Margaux McFarland, CSC1 1320-112, ID: 107731341, Lab6/HW7
function [ outImg ] = makeBright_L(inImg, brightness)
%brightens an image given an image and a brightness level to be added


%get size of inImg
[r,c,l] = size(inImg);

outImg = zeros(r,c,l);
for k = 1:l %loops through layers
    for i = 1:r %loops through rows
        for j = 1:c %loops through cols
            newColor = inImg(i,j,k) + brightness;
            if newColor > 255
                outImg(i,j,k) = 255;
            elseif newColor < 0
                outImg(i,j,k) = 0;
            else
                outImg(i,j,k) = newColor;
            end
        end
    end
end

outImg = outImg/255;

end
