function data = parseFile2(filename)
%this function parses the file of improved data

M = csvread(filename, 1,3);
%first 13 rows are ping pong
startTime_pp = M((1:13),1);
endTime_pp = M((1:13),2);
diff_pp = M((1:13),3);
uncert_pp = M((1:13),4);

%last 12 rows are tennis ball
startTime_t = M((14:25),1);
endTime_t = M((14:25),2);
diff_t = M((14:25),3);
uncert_t = M((14:25),4);

data = struct('StartTime_pp',startTime_pp,'EndTime_pp',endTime_pp,'Diff_pp',...
    diff_pp,'Uncert_pp',uncert_pp,'StartTime_t',startTime_t,'EndTime_t',...
    endTime_t,'Diff_t',diff_t,'Uncert_t',uncert_t);
    



end