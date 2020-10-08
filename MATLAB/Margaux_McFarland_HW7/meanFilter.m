function[ outImg ] = meanFilter(inImg)
%smoothes the image by finding the mean filter

%find the size
[r,c,l] = size(inImg);


outImg = inImg;

for k = 1:l %layer loop
    for i = 1:r % row loop
        for j = 1:c % col loop
            %case for top left corner
            if i == 1 && j == 1 
                meanVal = (inImg(i,j,k) + inImg(i,j+1,k) + inImg(i+1,j+1,k) + inImg(i+1,j,k))/4
                
                outImg(i,j,k) = meanVal;
                outImg(i,j+1,k) = meanVal;
                outImg(i+1,j+1,k) = meanVal;
                outImg(i+1,j,k) = meanVal;
            %case for top right corner
            elseif i == 1 && j == c
                meanVal = (inImg(i,j,k)  + inImg(i,j-1,k) + inImg(i+1,j,k) + inImg(i+1,j-1,k))/4;
                
                outImg(i,j,k) = meanVal;
                outImg(i,j-1,k) = meanVal;
                outImg(i+1,j,k) = meanVal;
                outImg(i+1,j-1,k) = meanVal;
            %case for bottom left corner
            elseif i == r && j == 1
                meanVal = (inImg(i,j,k) + inImg(i-1,j,k)+ inImg(i-1,j+1,k) + inImg(i,j+1,k))/4;
                
                outImg(i,j,k) = meanVal;
                outImg(i-1,j,k) = meanVal;
                outImg(i-1,j+1,k) = meanVal;
                outImg(i,j+1,k) = meanVal;
            %case for bottom right corner
            elseif i == r && j == c
                meanVal = (inImg(i,j,k) + inImg(i-1,j-1,k) + inImg(i-1,j,k) + inImg(i,j-1,k))/4;
                
                outImg(i,j,k) = meanVal;
                outImg(i-1,j-1,k) = meanVal;
                outImg(i-1,j,k) = meanVal;
                outImg(i,j-1,k) = meanVal;
            %case for left hand edge
            elseif i == 1
                meanVal = (inImg(i,j,k) + inImg(i,j-1,k) + inImg(i,j+1,k) +...
                    inImg(i+1,j+1,k) + inImg(i+1,j,k) + inImg(i+1,j-1,k))/6;
                
                outImg(i,j,k) = meanVal;
                outImg(i,j-1,k) = meanVal;
                outImg(i,j+1,k) = meanVal;
                outImg(i+1,j+1,k) = meanVal;
                outImg(i+1,j,k) = meanVal;
                outImg(i+1,j-1,k) = meanVal;
            %case for right hand edge
            elseif i == r
                meanVal = (inImg(i,j,k) + inImg(i-1,j-1,k) + inImg(i-1,j,k) +...
                    inImg(i,j-1,k) + inImg(i-1,j+1,k) + inImg(i,j+1,k))/6;
                
                outImg(i,j,k) = meanVal;
                outImg(i-1,j-1,k) = meanVal;
                outImg(i-1,j,k) = meanVal;
                outImg(i,j-1,k) = meanVal;
                outImg(i-1,j+1,k) = meanVal;
                outImg(i,j+1,k) = meanVal;
            %case for top edge
            elseif j == 1
                meanVal = (inImg(i,j,k) + inImg(i-1,j,k) + inImg(i-1,j+1,k)+...
                    inImg(i,j+1,k) + inImg(i+1,j+1,k) + inImg(i+1,j,k))/6;
                
                outImg(i,j,k) = meanVal;
                outImg(i-1,j,k) = meanVal;
                outImg(i-1,j+1,k) = meanVal;
                outImg(i,j+1,k) = meanVal;
                outImg(i+1,j+1,k) = meanVal;
                outImg(i+1,j,k) = meanVal;
            %case for bottom edge
            elseif j == c
                meanVal = (inImg(i,j,k) + inImg(i-1,j-1,k) + inImg(i-1,j,k)+...
                    inImg(i,j-1,k) + inImg(i+1,j,k) + inImg(i+1,j-1,k))/6;
                
                outImg(i,j,k) = meanVal;
                outImg(i-1,j-1,k) = meanVal;
                outImg(i-1,j,k) = meanVal;
                outImg(i,j-1,k) = meanVal;
                outImg(i+1,j,k) = meanVal;
                outImg(i+1,j-1,k) = meanVal;
        
            else
                meanVal = (inImg(i,j,k) + inImg(i-1,j-1,k) + inImg(i-1,j,k) + inImg(i,j-1,k) + ...
                    inImg(i-1,j+1,k) + inImg(i,j+1,k) + inImg(i+1,j+1,k) + inImg(i+1,j,k) + inImg(i+1,j-1,k))/9;
                
                outImg(i,j,k) = meanVal;
                outImg(i-1,j-1,k) = meanVal;
                outImg(i-1,j,k) = meanVal;
                outImg(i,j-1,k) = meanVal;
                outImg(i-1,j+1,k) = meanVal;
                outImg(i,j+1,k) = meanVal;
                outImg(i+1,j+1,k) = meanVal;
                outImg(i+1,j,k) = meanVal;
                outImg(i+1,j-1,k) = meanVal;
            end
        end
    end
end

                
                
                
                