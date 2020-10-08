% Date modified: Mar 18, 2019

function [thrust_part,t_span] = getThrust(filename)
%this function plots the given thrust data from the static tests and
%returns a vector of the thrust during the period when water is being
%expelled

data = load(filename);
thrust_whole = data(:,3);
%  figure(1)
%  plot(thrust_whole);
% xlabel('Samples');
%  ylabel('Thrust (lbs)');
%  title('Thrust Profile of Static Test (Raw data)');
thrust_indices = find(thrust_whole > 1);

start_index = thrust_indices(1);
end_index = thrust_indices(length(thrust_indices));
%zoomed in plot of thrust where water is expelled
thrust_part = thrust_whole(start_index:end_index);
%convert force to Newtons
thrust_part = 4.448.*thrust_part;
%  figure(2)
%  plot(thrust_part);
%  xlabel('Samples');
%  ylabel('Thrust (N)');
%  title('Thrust Profile of Static Test');
%get time interval
sampling_freq = 1/1652;
t1 = start_index * sampling_freq;
t2 = end_index *sampling_freq;

t_span = t1:sampling_freq:t2;

end
