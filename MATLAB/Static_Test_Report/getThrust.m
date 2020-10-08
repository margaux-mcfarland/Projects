% Date modified: April 16, 2019

function [thrust_part,t_span] = getThrust(filename)
%this function plots the given thrust data from the static tests and
%returns a vector of the thrust during the period when water is being
%expelled

data = load(filename);
thrust_whole = data(:,3);
% figure(1)
% plot(thrust_whole);

thrust_indices = find(thrust_whole > 1);

start_index = thrust_indices(1);
end_index = thrust_indices(length(thrust_indices));
%zoomed in plot of thrust where water is expelled
thrust_part = thrust_whole(start_index:end_index);
%convert force to Newtons
thrust_part = 4.448.*thrust_part;

%get time interval
sampling_freq = 1/1652;
t1 = start_index * sampling_freq;
t2 = end_index *sampling_freq;

t_span = t1:sampling_freq:t2;

% figure(2)
% plot(t_span, thrust_part);
% xlabel('Time (s)');
% ylabel('Thrust (N)');
% title('Thrust vs Time');
% grid on
end
