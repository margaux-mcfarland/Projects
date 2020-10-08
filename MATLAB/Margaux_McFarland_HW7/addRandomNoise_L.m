function [ outImg ] = addRandomNoise_L( inImg )
%adds random noise to each pixel in image
%get size of image
[r,c,l] = size(inImg);

outImg = inImg;

for k = 1:l %loops through layers
    for i = 1:r %loops through rows
        for j = 1:c %loops through columns
            outImg(i,j,k) = inImg(i,j,k) + (randi(511)-256);
        end
    end
end

end
