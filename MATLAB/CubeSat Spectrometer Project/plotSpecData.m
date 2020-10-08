function [] = plotSpecData(Intensity_Reds,Intensity_Greens,Intensity_Blues)
%this function plots the intensity of each color throughout flight

figure(1);
%time vector incremented by 30 seconds bc screenshots taken every 30
%seconds 
time = 0:0.5:119.5;
plot(time,Intensity_Reds,'r');
hold on;
plot(Intensity_Greens,'g');
hold on;
plot(Intensity_Blues, 'b');
xlim([0, 120]);
ylim([0, 100]);
ylabel('Intensity');
xlabel('Time (min)');
title('Intensity of Red, Green, and Blues (SASSAGE) vs Time');
legend('Red','Green','Blue');

end