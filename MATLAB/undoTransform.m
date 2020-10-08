%undoTransform.m
%undoes the 2D DCT
%5.2.4

%reads image
X = imread('boulder.jpg');

%get size of image
[r,c] = size(X);

%make DCT
C = makeDCT(r);

%converts to doubles
X_double = double(X);

%original transform
Y1 = C*X_double*C;
imshow(Y1,[0,255]);

%undone transform
Y2 = C*Y1*C;
imshow(Y2,[0,255]);
