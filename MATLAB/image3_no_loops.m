%image3_no_loops.m
%creates an image with gradations of color but not diagonally
%w no loops
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


i = 1:rows;
j = 1:cols;
redLay = (j-1)/255;
blueLay = (i-1)/255;
vec = linspace(i-1 ,255,256);

greenLay= ()/255;

%invert the green layer
greenLay = (greenLay-1)*-1;

%create matrix of color vecs
redLay2 = repmat(redLay,rows,1);
greenLay2 = repmat(greenLay.',1,cols);
blueLay2 = repmat(blueLay.',1,cols);

%%
%3D color array
RGB1 = zeros(rows,cols,3);
RGB1(:,:,1) = redLay2;
RGB1(:,:,2) = greenLay2;
RGB1(:,:,3) = blueLay2;

%%
%plot
figure
subplot(2,2,1);
imshow(redLay2);
title('Red Layer');

subplot(2,2,2);
imshow(greenLay2);
title('Green Layer');

subplot(2,2,3);
imshow(blueLay2);
title('Blue Layer');

subplot(2,2,4);
imshow(RGB1);
title('Task 1');