%invertC.m
%takes C, a 5x5 matrix and checks
%to see if its inverse equals C or C^2 = I
%5.2.1

%rows/cols
n =5;

%DCT matrix
C = makeDCT(n);

%identity matrix
I = zeros(n);
%creates identity matrix 
for i = 1:n %loops through rows
    for j = 1:n %loops through cols
        if j == i
            I(i,j) = 1;
        end       
    end
end
disp(C);
disp(C*C);



