function[outImg] = binaryMask( inImg )
%creates a binary mask of an image
%separates background and object of interest

%size 
[r,c] = size(inImg)

for i = 1:r %loops through rows
    for j = 1:c %loops through columns
        if inImg(i,j) < 125
            outImg(i,j) = 1;
                
        else
            outImg(i,j) = 0;
        end
    end
end
end

        