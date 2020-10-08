function [C] = makeDCT(n)

%creates DCT matrix 
%n is row vector that DCT matrix is applied to
for i = 1:n %loops through rows
    for j = 1:n %loops through cols       
        C(i,j) = sqrt(2/n)*cos((pi*(i-0.5)*(j-0.5))/n);
    end
end
end
