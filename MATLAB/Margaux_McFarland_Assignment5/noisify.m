%noisify.m
%adds noise to a set of data
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 5

%vector between 1 and 10
x = 1:1:10;
y = x;

figure,plot(x,y);
hold on
%noise
y2 = y + rand(1,10)/2 - 0.25;
%plot noise
plot(x, y2, '*k');

%axis/title labels
title('x vs y and x vs y+noise');
xlabel('x');
ylabel('y');
legend('y original', 'y + noise');

