%ASEN 2003 Lab 2

%% read in files
data = parseFile('2003_lab_sheet.csv');
data_improved = parseFile2('improved.csv');
data_logger = parseFile3('loggerPro.csv');

%% calculate e for 3 methods
%number of trials
trial_num = 10;
for i = 1:trial_num
    [e1_1(i), e1_2(i)] = method1(data.Height(i,:));
    e2(i) = method2(data.BounceTimes(i,:));
    e3(i) = method3(data.Time_Stop(1,i),data.Height(1,1)); 
end

%% calculate e for logger pro data
trial_num_logger = 4;
for i = 1:trial_num_logger
   [e_logger1(i),e_logger2(i)] = method1(data_logger.Heights(i,:));
end

%% calculate e for improved trial
trial_num_improved_pp = 13;
trial_num_improved_t = 12;
%intial height of improved method 
initial_height = 51.1; %cm
for i = 1:trial_num_improved_pp
    e_improved_pp(i) = method3(data_improved.Diff_pp(i),initial_height);
end
for i = 1:trial_num_improved_t
    e_improved_t(i) = method3(data_improved.Diff_t(i),initial_height);
end

%% stats 

%averages
e1_1_av = mean(e1_1);
e1_2_av = mean(e1_2);
e2_av = mean(e2);
e3_av = mean(e3);
e_imp_pp_av = mean(e_improved_pp);
e_imp_t_av = mean(e_improved_t);
e_log_av1 = mean(e_logger1);
e_log_av2 = mean(e_logger2);

%medians
e1_1_med = median(e1_1,'all');
e1_2_med = median(e1_2,'all');
e2_med = median(e2,'all');
e3_med = median(e3,'all');
e_imp_pp_med = median(e_improved_pp);
e_imp_t_med = median(e_improved_t);
e_log_med1 = median(e_logger1);
e_log_med2 = median(e_logger2);

%standard deviations
e1_1_std = std(e1_1);
e1_2_std = std(e1_2);
e2_std = std(e2);
e3_std = std(e3);
e_imp_pp_std = std(e_improved_pp);
e_imp_t_std = std(e_improved_t);
e_log_std1 = std(e_logger1);
e_log_std2 = std(e_logger2);

%standard deviations of the mean
e1_1_std_mean = e1_1_av/sqrt(trial_num);
e1_2_std_mean = e1_2_av/sqrt(trial_num);
e2_std_mean = e2_av/sqrt(trial_num);
e3_std_mean = e3_av/sqrt(trial_num);
e_imp_pp_std_mean = e_imp_pp_av/sqrt(trial_num_improved_pp);
e_imp_t_std_mean = e_imp_t_av/sqrt(trial_num_improved_t);
e_log_std_mean1 = e_log_av1/sqrt(trial_num_logger);
e_log_std_mean2 = e_log_av2/sqrt(trial_num_logger);


%% error


%uncertainty associated with height measurments
sig_height = 0.0005; %half a millimeter (each tick mark on meter stick 
                    %represented a millimeter
%uncertainty associated with each time measurement
% reaction_time = 0.15;%seconds (reaction time)
% sig_time1 = sqrt(reaction_time^2 + time1_1_std_mean^2); 
% sig_time1_1 = sqrt(reaction_time^2 + time1_2_std_mean^2);
% sig_time2 = sqrt(reaction_time^2 + time2_std_mean^2);
% sig_time3 = sqrt(reaction_time^2 + time3_std_mean^2);
% 
% %uncertainty from improved data
% sig_time_improved = mean(data_improved.Uncert_pp);
% 
% for i = 1:trial_num
%     error_3(i) = generalMethod(data.Height(i,:),data.Time_Stop(1,i),sig_height,sig_time);
%     
%     %error_improved(i) = generalMethod(data.Height(i,:),data_imrove.Time_Stop(1,i),sig_height,sig_time);
% end
% error_3_av = mean(error_3);
% 
% 
