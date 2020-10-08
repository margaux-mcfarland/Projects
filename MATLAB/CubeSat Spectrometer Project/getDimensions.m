function [red_xCoor, green_xCoor, blue_xCoor, yCoor] = getDimensions(inImg)
%this function takes in an image and locates where the top left cornor of
%the spectrum begins, then
%splits up spectrum into three: Red, green, and blue sections.
%finds and returns the dimensions of spectrum

%image size
[row,col,l] = size(inImg);
%find coordinates where spectrum starts by finding where pixel has a high 
%enough red value
foundSpectrum = 0; %true when spectrum is found
for i = 1:col %loops through columns
    if ~foundSpectrum
        for j = 1:row %loops through rows
            if inImg(1,1,1) < 10 %if mostly black background
            %then look for lower red value
                if inImg(j,i,1) < 30 
                    %spectrum found
                    left_x = i;
                    top_y = j;
                    foundSpectrum = 1;
                    break;
                end
        
            else %look for higher value
                if inImg(j,i,1) > 75 
                    %spectrum found
                    left_x = i;
                    top_y = j;
                    foundSpectrum = 1;
                    break;
                end
        
            end
        end
    else
        %if spectrum is found, break from loop
        break;
    end
end

%vector that stores starting and ending values for the x dimensions
red_xCoor = [left_x, (col/18)+left_x];
green_xCoor = [(col/18)+left_x, 2*(col/18)+left_x];
blue_xCoor = [2*(col/18)+left_x, (col/6)+left_x];
%vector that stores starting and ending value for the y dimensions
yCoor = [top_y, row-top_y];

end