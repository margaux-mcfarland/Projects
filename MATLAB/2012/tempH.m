function [tH,errortH] = tempH(xVec,yVec,startTime)
%returns temp2 from data given time, temp, and start value
[m,b,sigmaM,sigmaB] = bestFit(xVec(startTime:length(xVec)),yVec(startTime:length(xVec)));
tH = xVec(300)*m + b;
%calculating error in temp (sigma y)
sum = 0;
for i = startTime:length(xVec)
    sum = sum + (yVec(i)-m*xVec(i)-b)^2;
end
errortH = sqrt(sum/(length(xVec)-startTime-2));
end

