function [d1, d2, d3] = calcDeterm()
%calculates the determinant of the DCT matrix (3X3)
%5.2.2

%DCT matrix
C1 = makeDCT(3);
C2 = makeDCT(5);
C3 = makeDCT(10);

%determinant 
d1 = det(C1)
d2 = det(C2)
d3 = det(C3)

end
