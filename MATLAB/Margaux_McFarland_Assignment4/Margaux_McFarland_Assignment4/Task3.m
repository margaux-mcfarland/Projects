%Task3.m
%eliminate the positve values from a vector
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 4

vec = [-11, 5, 3, -2, 18, 4, -5, -25, 66]

%using find to eliminate positve values
vec1 = vec(find(vec < 0))

%using a logical vector
vec2 = vec(logical(vec < 0))


