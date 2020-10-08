function std_mean = calc_std_mean(mean, values)
%this function calculates the standard deviation of the mean 
sum = 0;
for i = 1:length(values)
    num = (abs(values(i) - mean))^2;
    sum = sum + num;
end

std_mean = sqrt(sum/length(values));

end