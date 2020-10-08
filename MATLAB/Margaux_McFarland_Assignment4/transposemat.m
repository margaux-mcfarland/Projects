%transposemat.m (Task 4)
%transposes a given matrix (converts the rows into columns)
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 4
function Y = transposemat(x)
%x is a 3x3 matrix
Y = [x(1,1),x(2,1),x(3,1);x(1,2),x(2,2),x(3,2);x(1,3),x(2,3),x(3,3)];
end
