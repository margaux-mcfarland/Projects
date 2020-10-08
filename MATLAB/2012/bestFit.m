function [m,b,sigmaM,sigmaB] = bestFit(xVec,yVec)
%inputs column vectors for x,y, outputs m & b for line of best fit ...
%and the uncertainties associated. 

% A matrix is created
Amat = zeros(length(xVec),2);
for i = 1:length(xVec)
    Amat(i,1) = xVec(i);
    Amat(i,2) = 1;
end
% B matrix is created
Bmat = yVec;
% m and b are retrieved from x
x = Amat\Bmat;
m = x(1,1);
b = x(2,1);
% Q matrix is created
Qmat = zeros(length(xVec));
for j = 1:length(xVec)
    sigmaYSqr = (yVec(j)-(m*xVec(j))-b)^2/((length(xVec)-2));
    Qmat(j,j) = 1/sigmaYSqr;
end
% W matrix is created
Wmat = (Amat'*Qmat*Amat)';
sigmaM = sqrt(Qmat(1,1));
sigmaB = sqrt(Qmat(2,2));
end
%[m,b,sm,sb]=bestFit([1;2;3;4;5;6],[2;2;3;4;6;6])
