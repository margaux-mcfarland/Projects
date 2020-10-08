function [T0,errorT0] = temp0(xVec,yVec)
%returns inital temperature from time and temp vectors
[m,b,sigmaM,sigmaB] = bestFit(xVec(1:300),yVec(1:300));
T0 = xVec(300)*m + b;
%calculating error in temp (sigma y)
sum = 0;
for i = 1:300
    sum = sum + (yVec(i)-m*xVec(i)-b)^2;
end
errorT0 = sqrt(sum/(300-2));
end

