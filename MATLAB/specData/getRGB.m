function [r,g,b] = getRGB(inImg)
%this function takes in an image and returns the average RGB
%value of each pixel in the image

r_sum = int32(0);
g_sum = int32(0);
b_sum = int32(0);
[row,col,l] = size(inImg); %get size of image

for k = 1:l %loops through layers
    for i = 1:row %loops through rows
        for j = 1:col %loops through columns
            if(k == 1)
                r_sum = int32(inImg(i,j,k)) + r_sum;
            elseif(k == 2)
                g_sum = int32(inImg(i,j,k)) + g_sum;
            else
                b_sum = int32(inImg(i,j,k)) + b_sum;
            end

        end
    end
end
%take average
r = r_sum/(row*col);
g = g_sum/(row*col);
b = b_sum/(row*col);

end