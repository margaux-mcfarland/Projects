%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   ASEN 2003 - Dynamics and Systems
%
%   Experimental Lab 1 - Bouncing Ball Experiment
%
%   Created By:
%       Jordan Abell
%       Margaux Mcfarland
%
%   Created On: 
%       31 January 2019
%
%   Purpose:
%       Analyze experimental data of a ping pong ball and tennis ball to
%       determine the coefficients of restitution of the two balls.
%       Understand experimental sources of error and how to minimize such
%       sources. Use multiple experimental methods and tools to determine
%       the best method and most accurate estimate of the coefficients of
%       restitution.
%
%   Method Definitions:
%       Method 1-1: Using the equation e = (h_n/h_(n-1))^1/2
%
%       Method 1-2: Using the equation e = (h_n/h_0)^1/(2n)
%
%       Method 2: Using the equation e = t_n/t_(n-1)
%
%       Method 3: Using the equation e = [t_s - sqrt(2*h_0/g)]/[t_s +
%           sqrt(2*h_0/g)]
%
%       Video Method 1: Using equation from Method 1-1 with video analysis
%           using LoggerPro
%
%       Video Method 2: Using equation from Method 1-2 with video analysis
%           using LoggerPro
%
%       Improved Method: Using equation from Method 3 with improved
%           procedures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Housekeeping
clear
close all
clc

% Graph bool
graph = 1;

%% Read Input Files
data = parseFile('2003_lab_sheet.csv');
data_vid = parseFile3('loggerPro.csv');
data_improved = parseFile2('improved.csv');

% Number of trials
trial_num = 10;

% Initialize vectors
e1_1 = zeros(trial_num, 1);
e1_2 = zeros(trial_num, 1);
e2 = zeros(trial_num, 1);
e3 = zeros(trial_num, 1);

% Initial Drop Height
h0 = 0.865; % [m]

for i = 1:trial_num
    [e1_1(i), e1_2(i)] = method1(data.Height(i,:));     % Method 1-1 and 1-2
    e2(i) = method2(data.BounceTimes(i,:));             % Method 2
    e3(i) = method3(data.Time_Stop(1,i), h0);           % Method 3
end


%%%%%%%%%%%%%%%%%
% Video Analysis
%%%%%%%%%%%%%%%%%
% Number of trials used in video analysis
trial_num_vid = 4;

% Initialization
e_vid1 = zeros(trial_num_vid, 1);
e_vid2 = zeros(trial_num_vid, 1);

for i = 1:trial_num_vid
   [e_vid1(i),e_vid2(i)] = method1(data_vid.Heights(i,:));
end


%%%%%%%%%%%%%%%%%%
% Improved Method
%%%%%%%%%%%%%%%%%%
% Improved Method - Ping Pong Trials
trial_num_Ip = 13;

% Intial height of improved method 
initial_height = 0.511; % [m]

% Initialization
e_Ip = zeros(trial_num_Ip, 1);

for i = 1:trial_num_Ip
    e_Ip(i) = method3(data_improved.Diff_pp(i),initial_height);
end

% Improved Method - Tennis Ball Trials
trial_num_It = 12;

% Initialization
e_It = zeros(trial_num_It, 1);

for i = 1:trial_num_It
    e_It(i) = method3(data_improved.Diff_t(i),initial_height);
end


%% Statistical Analysis
% Average
e1_1_av = mean(e1_1);                           % Method 1-1
e1_2_av = mean(e1_2);                           % Method 1-2
e2_av = mean(e2);                               % Method 2
e3_av = mean(e3);                               % Method 3
e_vid1_av = mean(e_vid1);                       % Video Analysis 1
e_vid2_av = mean(e_vid2);                       % Video Analysis 2
e_Ip_av = mean(e_Ip);                           % Improved Method - Ping Pong
e_It_av = mean(e_It);                           % Improved Method - Tennis Ball

% Median
e1_1_med = median(e1_1,'omitnan');              % Method 1-1
e1_2_med = median(e1_2,'omitnan');              % Method 1-2
e2_med = median(e2,'omitnan');                  % Method 2
e3_med = median(e3,'omitnan');                  % Method 3
e_vid1_med = median(e_vid1);                    % Video Analysis 1
e_vid2_med = median(e_vid2);                    % Video Analysis 2
e_Ip_med = median(e_Ip);                        % Improved Method - Ping Pong
e_It_med = median(e_It);                        % Improved Method - Tennis Ball

% Standard deviation
e1_1_std = std(e1_1);                           % Method 1-1
e1_2_std = std(e1_2);                           % Method 1-2
e2_std = std(e2);                               % Method 2
e3_std = std(e3);                               % Method 3
e_vid1_std = std(e_vid1);                       % Video Analysis 1
e_vid2_std = std(e_vid2);                       % Video Analysis 2
e_Ip_std = std(e_Ip);                           % Improved Method - Ping Pong
e_It_std = std(e_It);                           % Improved Method - Tennis Ball

% Standard deviation of the mean
e1_1_std_mean = e1_1_av/sqrt(trial_num);        % Method 1-1
e1_2_std_mean = e1_2_av/sqrt(trial_num);        % Method 1-2
e2_std_mean = e2_av/sqrt(trial_num);            % Method 2
e3_std_mean = e3_av/sqrt(trial_num);            % Method 3
e_vid1_std_mean = ...
    e_vid1_std/sqrt(trial_num_vid);             % Video Analysis 1
e_vid2_std_mean = ...
    e_vid2_std/sqrt(trial_num_vid);             % Video Analysis 2
e_Ip_std_mean = ...
    e_Ip_std/sqrt(trial_num_Ip);                % Improved Method - Ping Pong
e_It_std_mean = ...
    e_It_std/sqrt(trial_num_It);                % Improved Method - Tennis Ball


%% Uncertainty Calculations
%%%%%%%%%%%%
% Method 1
%%%%%%%%%%%%
% Heights
h0 = data.Height(:, 1);
h1 = data.Height(:, 2);
h2 = data.Height(:, 3);

% Uncertainty associated with height measurments
sig_height = 0.005; % 2.5 millimeter

% Standard error of the mean for measurements of height h0
h0_std_error = std(h0)/sqrt(trial_num);
% Standard error of the mean for measurements of height h1
h1_std_error = std(h1)/sqrt(trial_num);
% Standard error of the mean for measurements of height h2
h2_std_error = std(h2)/sqrt(trial_num);

% Total uncertainty of height measurement h0
dh0 = sqrt(sig_height^2 + h0_std_error^2);
% Total uncertainty of height measurement h1
dh1 = sqrt(sig_height^2 + h1_std_error^2);
% Total uncertainty of height measurement h2
dh2 = sqrt(sig_height^2 + h2_std_error^2);

% Uncertainty of method 1-1
de1_1 = generalMethod1(h2, h1, 1, dh2, dh1);

% Uncertainty of method 1-2
de1_2 = generalMethod1(h2, h0, 2, dh2, dh0);


%%%%%%%%%%%
% Method 2
%%%%%%%%%%%
% Human-caused uncertainty associated with each time measurement
reaction_time = 0.15;   % [s]

% Times
tn = data.BounceTimes(:, 1);
tn1 = data.BounceTimes(:, 2);

% Standard error of the mean for measurements of time tn
tn_std_error = std(tn)/sqrt(trial_num);
% Total uncertainty of time measurements tn
dtn = sqrt(tn_std_error^2 + reaction_time^2);

% Standard error of the mean for measurements of time tn-1
tn1_std_error = std(tn1)/sqrt(trial_num);
% Total uncertainty of time measurements tn-1
dtn1 = sqrt(tn1_std_error^2 + reaction_time^2);

% Uncertainty associated with method 2
de2 = generalMethod2(tn, tn1, dtn, dtn1);


%%%%%%%%%%%
% Method 3
%%%%%%%%%%%
% Time
ts = data.Time_Stop(:);
% Standard error of the mean for measurements of time ts
ts_std_mean = std(ts)/sqrt(trial_num);
% Total uncertainty of time measurements tn
dts = sqrt(ts_std_mean^2 + reaction_time^2);

% Total uncertainty for Method 3
de3 = generalMethod3(ts, h0, dts, dh0);


%%%%%%%%%%%%%%%%%
% Video Analysis
%%%%%%%%%%%%%%%%%
% Heights
h0_vid = data_vid.Heights(:, 1);
h1_vid = data_vid.Heights(:, 2);
h2_vid = data_vid.Heights(:, 3);

% Uncertainty associated with height measurments
sig_height_vid = 0.005; % 1 millimeter

% Standard error of the mean for measurements of height h0
h0_vid_std_error = std(h0_vid)/sqrt(trial_num_vid);
% Standard error of the mean for measurements of height h1
h1_vid_std_error = std(h1_vid)/sqrt(trial_num_vid);
% Standard error of the mean for measurements of height h2
h2_vid_std_error = std(h2_vid)/sqrt(trial_num_vid);

% Total uncertainty of height measurement h0_vid
dh0_vid = sqrt(sig_height_vid^2 + h0_vid_std_error^2);
% Total uncertainty of height measurement h1_vid
dh1_vid = sqrt(sig_height_vid^2 + h1_vid_std_error^2);
% Total uncertainty of height measurement h2_vid
dh2_vid = sqrt(sig_height_vid^2 + h2_vid_std_error^2);

% Uncertainty of video method 1-1
devid1 = generalMethod1(h2_vid, h1_vid, 1, dh2_vid, dh1_vid);

% Uncertainty of video method 1-2
devid2 = generalMethod1(h2_vid, h0_vid, 2, dh2_vid, dh0_vid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Improved Method - Ping Pong
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time
ts_Ip = data_improved.Diff_pp(:, 1);
sig_ts_Ip = data_improved.Uncert_pp(1, 1);

% Number of trials in improved - ping pong method
trial_num_Ip = length(ts_Ip);

% Height
h0_Ip = .511*ones(trial_num_Ip, 1);         % [m] Initial drop height of improved method
sig_h0_Ip = 0.0005;                         % [m] Uncertainty of h0_Ip

% Standard error of the mean for measurements of time ts improved - ping
% pong
ts_Ip_std_mean = std(ts_Ip)/sqrt(trial_num_Ip);
% Total uncertainty of time measurements tn
dts_Ip = sqrt(ts_Ip_std_mean^2 + sig_ts_Ip^2);

% Standard error of the mean for measurements of height h0 improved - ping
% pong
dh0_Ip_std_mean = std(h0_Ip)/sqrt(trial_num_Ip);
% Total uncertainty of the height measurements h0
dh0_Ip = sqrt(dh0_Ip_std_mean^2 + sig_h0_Ip^2);

% Uncertainty associated with the improved method
de_Ip = generalMethod3(ts_Ip, h0_Ip, dts_Ip, dh0_Ip);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Improved Method - Tennis Ball
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Times
ts_It = data_improved.Diff_t(:, 1);
sig_ts_It = data_improved.Uncert_t(1, 1);

% Number of trials in improved - tennis ball method
trial_num_It = length(ts_It);

% Height
h0_It = .511*ones(trial_num_It, 1);         % [m] Initial drop height of improved method
sig_h0_It = 0.0005;                         % [m] Uncertainty of h0_Ip

% Standard error of the mean for measurements of time ts improved - tennis
% ball
ts_It_std_mean = std(ts_It)/sqrt(trial_num_It);
% Total uncertainty of time measurements tn
dts_It = sqrt(ts_It_std_mean^2 + sig_ts_It^2);

% Standard error of the mean for measurements of height h0 improved -
% tennis ball
dh0_It_std_mean = std(h0_It)/sqrt(trial_num_It);
% Total uncertainty of the height measurements h0
dh0_It = sqrt(dh0_It_std_mean^2 + sig_h0_It^2);

% Uncertainty associated with the improved method
de_It = generalMethod3(ts_It, h0_It, dts_It, dh0_It);

%% Final coefficient calculations
% Weighted averages

% Method 1_1
e1_1_W = 1./(de1_1.^2);
e1_1_num = e1_1_W.*e1_1;
e1_1_final = sum(e1_1_num)/sum(e1_1_W);
de1_1_final = 1/sqrt(sum(e1_1_W));

% Method 1_2
e1_2_W = 1./(de1_2.^2);
e1_2_num = e1_2_W.*e1_2;
e1_2_final = sum(e1_2_num)/sum(e1_2_W);
de1_2_final = 1/sqrt(sum(e1_2_W));

% Method 2
e2_W = 1./(de2.^2);
e2_num = e2_W.*e2;
e2_final = sum(e2_num)/sum(e2_W);
de2_final = 1/sqrt(sum(e2_W));

% Method 3
e3_W = 1./(de3.^2);
e3_num = e3_W.*e3;
e3_final = sum(e3_num)/sum(e3_W);
de3_final = 1/sqrt(sum(e3_W));

% Video Analysis 1_1
evid1_W = 1./(devid1.^2);
evid1_num = evid1_W.*e_vid1;
evid1_final = sum(evid1_num)/sum(evid1_W);
devid1_final = 1/sqrt(sum(evid1_W));

% Video Analysis 1_2
evid2_W = 1./(devid1.^2);
evid2_num = evid2_W.*e_vid2;
evid2_final = sum(evid2_num)/sum(evid2_W);
devid2_final = 1/sqrt(sum(evid2_W));

% Improved Method - Ping Pong
e_Ip_W = 1./(de_Ip.^2);
e_Ip_num = e_Ip_W.*e_Ip;
e_Ip_final = sum(e_Ip_num)/sum(e_Ip_W);
de_Ip_final = 1/sqrt(sum(e_Ip_W));

% Improved Method - Tennis Ball
e_It_W = 1./(de_It.^2);
e_It_num = e_It_W.*e_It;
e_It_final = sum(e_It_num)/sum(e_It_W);
de_It_final = 1/sqrt(sum(e_It_W));


%% Print Results
fprintf('Method 1-1:                      %.4f %c %.4f\n', e1_1_final, char(177), de1_1_final);
fprintf('Method 1-2:                      %.4f %c %.4f\n', e1_2_final, char(177), de1_2_final);
fprintf('Method 2:                        %.4f %c %.4f\n', e2_final, char(177), de2_final);
fprintf('Method 3:                        %.4f %c %.4f\n', e3_final, char(177), de3_final);
fprintf('Video Analysis Method 1-1:       %.4f %c %.4f\n', evid1_final, char(177), devid1_final);
fprintf('Video Analysis Method 1-2:       %.4f %c %.4f\n', evid2_final, char(177), devid2_final);
fprintf('Improved Method - Ping Pong:     %.4f %c %.4f\n', e_Ip_final, char(177), de_Ip_final);
fprintf('Improved Method - Tennis Ball:   %.4f %c %.4f\n', e_It_final, char(177), de_It_final);


%% Plot Results
x = 1:.1:1.6;
y = [e1_1_final, e1_2_final, e2_final, e3_final, evid1_final, evid2_final, e_Ip_final];
e = [de1_1_final, de1_2_final, de2_final, de3_final, devid1_final, devid2_final, de_Ip_final];

if graph == 1
    figure
    hold on
    errorbar(x(1), y(1), e(1), '*b', 'LineStyle', 'none', 'DisplayName', 'Method 1-1');
    errorbar(x(2), y(2), e(2), '*g', 'LineStyle', 'none', 'DisplayName', 'Method 1-2');
    errorbar(x(3), y(3), e(3), '*r', 'LineStyle', 'none', 'DisplayName', 'Method 2');
    errorbar(x(4), y(4), e(4), '*c', 'LineStyle', 'none', 'DisplayName', 'Method 3');
    errorbar(x(5), y(5), e(5), 'ob', 'LineStyle', 'none', 'DisplayName', 'Video Method 1-1');
    errorbar(x(6), y(6), e(6), 'og', 'LineStyle', 'none', 'DisplayName', 'Video Method 1-2');
    errorbar(x(7), y(7), e(7), 'or', 'LineStyle', 'none', 'DisplayName', 'Improved Method');
    % ylim([0.6 1])
    xlim([0.9 2])
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    title('Coefficient of Restitution of a Ping Pong Ball')
    ylabel('Coefficient of Restitution, e')
    legend('Location', 'southeast')
end