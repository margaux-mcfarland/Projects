function [RGB,colors] = colorbars()
colors = [1 0 0; 1 .5 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1];

RGB = zeros(4,6,3);

for j = 1 : 4
    for i = 1 : 6
        for k = 1 : 3
            RGB(j,i,k) = colors(i,k);
        end
    end
end


imagesc(RGB);

end