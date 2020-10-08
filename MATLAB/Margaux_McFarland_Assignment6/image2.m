%image2.m
%creates an image with gradations of color
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 6

%image dimensions
rows = 256;
cols = 256;

%greyscale matrix for green layer
greenLay = zeros(rows,cols);

%greyscale matrix for blue layer
blueLay = zeros(rows,cols);

%greyscale matrix for red layer
redLay = zeros(rows,cols);

for i = 1:rows
    for j = 1:cols
        redLay(i,:) = (i-1)/255;
        greenLay(:,j) = (j-1)/255;
        blueLay(:,j) = (cols-j)/255;
    end
end

%%
%3D color array
RGB1 = zeros(rows,cols,3);
RGB1(:,:,1) = redLay;
RGB1(:,:,2) = greenLay;
RGB1(:,:,3) = blueLay;


%%
%plot
figure
subplot(2,2,1);
imshow(redLay);
title('Red Layer');

subplot(2,2,2);
imshow(greenLay);
title('Green Layer');

subplot(2,2,3);
imshow(blueLay);
title('Blue Layer');

subplot(2,2,4);
imshow(RGB1);
title('Task 1');



