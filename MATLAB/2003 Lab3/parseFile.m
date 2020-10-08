function Data = parseFile(filename)
%this function takes in a file name and parses the data into a struct

M = dlmread(filename,'\t',1,0);

time = M(:,1);
wheel_pos = M(:,2);
slide_pos = M(:,3);
wheel_speed = M(:,4);
slide_speed = M(:,5);
actual_sample_times = M(:,6);

Data = struct('Time',time,'Wheel_Pos',wheel_pos,'Slide_Pos',slide_pos,...
    'Wheel_Speed',wheel_speed, 'Slide_Speed',slide_speed,'Act_Samp_Times',actual_sample_times);



end