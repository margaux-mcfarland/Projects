%The purpose of this program is to compare static test stand data between
%lab groups and sections as well as calculate Isp from the thrust data. 
%Authors: Margaux McFarland (107731341)
%           Braden Campbell (107523915)
%Date Created: 4/16/19
%Date Modified: 4/16/19


filenames = ["Group1_1PM_statictest1","Group01_08AM_statictest1","Group01_10AM_statictest1"...
    "Group02_1PM_statictest1","Group02_08AM_statictest1",'Group02_10AM_statictest1',...
    "Group03_1PM_statictest1","Group03_10AM_statictest1",...
    "Group04_1PM_statictest1","Group04_08AM_statictest1","Group04_10AM_statictest1",...
    "Group05_1PM_statictest1","Group05_08AM_statictest1",...
    "Group06_1PM_statictest1","Group06_08AM_statictest1","Group06_10AM_statictest1",...
    "Group07_1PM_statictest1","Group07_08AM_statictest1","Group07_10AM_statictest1",...
    "Group08_1PM_statictest1","Group08_8AM_statictest1","Group08_10AM_statictest1",...
    "Group09_1PM_statictest1","Group09_8AM_statictest1","Group09_10AM_statictest1",...
    "Group10_01PM_statictest1","Group10_08AM_statictest1","Group10_10AM_statictest1",...
    "Group11_1PM_statictest1","Group11_08AM_statictest1","Group11_10AM_statictest1",...
    "Group12_1PM_statictest1","Group12_08AM_statictest1","Group12_10AM_statictest1",...
    "Group13_10AM_statictest1","Group14_10AM_statictest1","Group15_10AM_statictest1",...
    "Group16_10AM_statictest1","Group17_10AM_statictest1"];


%constants / baseline conditions
g = 9.81; %m/s^2
m_prop = 1; %kg
m_bottle = 0.24; %kg
m_init = m_bottle + m_prop;%kg
m_final = m_init - m_prop; %assume all water leaves bottle

for i = 1:length(filenames)
    [thrust,t_span] = getThrust(filenames(i));
    maxThrust(i) = max(thrust(i));
    totalTime(i) = t_span(end)-t_span(1);
    I_sp(i) = calcIsp(thrust, t_span, g,m_prop);
    averages(i) = mean(thrust);
 
end
%Isp
figure
histogram(I_sp,'BinWidth',0.1);
xlabel('Isp (s)');
ylabel('Number of data sets with the same Isp');
title('Isp values over all 2004 lab sections');
figure
%max thrust
histogram(maxThrust,'BinWidth',10);
xlabel('Thrust (N)');
ylabel('Number of data sets with the same max Thrust');
title('Max Thrust values over all 2004 lab sections');

%average thrust/ standard deviation
avg_thrust = mean(averages);
std_thrust = std(averages);

%total thrust time
histogram(totalTime,'BinWidth',0.1);
xlabel('Time (s)');
ylabel('Number of data sets with the same total thrust times');
title('Total thrust times over all 2004 lab sections');

%average time/ standard deviation
avg_totalTime = mean(totalTime);
std_totalTime = std(totalTime);


%% SEM

for i = 1:length(I_sp)
    std_Isp(i) = std(I_sp(1:i));
    N(i) = i;
    SEM(i) = std_Isp(i)/sqrt(i);
end

complete_SEM = std(I_sp)/sqrt(length(N));

%number of samples so Isp within 0.1 s
N_95 = (1.96*std(I_sp)/0.1)^2;
N_975 = (2.24*std(I_sp)/0.1)^2;
N_99 = (2.58*std(I_sp)/0.1)^2;

%number of samples so Isp within 0.01 s
N_950 = (1.96*std(I_sp)/0.01)^2;
N_9750 = (2.24*std(I_sp)/0.01)^2;
N_990 = (2.58*std(I_sp)/0.01)^2;

