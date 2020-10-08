% Date modified: Mar 18, 2019

function thrust_part = getThrust(filename)
%this function plots the given thrust data from the static tests and
%returns a vector of the thrust during the period when water is being
%expelled

data = load('LA8am_test1');
thrust_whole = data(:,3);
figure(1)
plot(thrust_whole);

thrust_indices = find(thrust_whole > 1);

start_index = thrust_indices(1);
end_index = thrust_indices(length(thrust_indices));
figure(2)
%zoomed in plot of thrust where water is expelled
thrust_part = thrust_whole(start_index:end_index)
plot(thrust_part);

return 

end
