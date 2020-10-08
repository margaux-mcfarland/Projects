function usMap = normalize(myMin, myMax, numStates, usa_image, state_mask)
range = myMax - myMin;
fracStates = zeros(1,48)
for i = 1:48
    fracStates(1,i) = (numStates(1,i) - myMin) / range;
end
for j = 1:900
    for k = 1:1200
        for g = 1:48
            if state_mask(j,k)==g
                usa_image(j,k,1) = fracStates(1,g) * 255;
            end
        end
    end
end
usMap = usa_image;
end
