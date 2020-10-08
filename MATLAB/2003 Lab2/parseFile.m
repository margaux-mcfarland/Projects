function Data = parseFile(filename)
%this function parses a file of data of bouncing a ball

M = csvread(filename, 1, 1);
%first 3 height
%next two bounce time
%last one time to stop
heights(:,1) = M(1,:);
heights(:,2) = M(2,:);
heights(:,3) = M(3,:);
bounce_times(:,1) = M(4,:);
bounce_times(:,2) = M(5,:);
time_stop = M(6,:);

Data = struct('Height',heights,'BounceTimes',bounce_times,'Time_Stop',time_stop);

end