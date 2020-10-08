%calcEigenvals.m
%computes the eigenvalues of C (512X512)
%plots the eigenvalues on complex plane
%5.2.3

%num rows/cols
n = 512;
%DCT matrix
C = makeDCT(n);

%col vector of eigenvalues 
eVals = eig(C);

disp(prod(eVals));

%plot real part vs imaginary part
figure;
plot(real(eVals),imag(eVals),'*');
xlabel('real part of eigenvalue');
ylabel('imaginary part of eigenvalue');
title('Eigenvalues of DCT matrix on complex plane');

