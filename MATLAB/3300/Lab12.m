%% ASEN 3300: Lab 12 GPS data collection/analyis

%%load in GPS data
%location 1 - outside
lat1 = [41.430842 41.458754 39.546488 41.258996 41.293547 41.580962 41.697286 ...
    41.482140 41.347711 41.106161];

long1 = [18.391317 18.900669 20.069196 18.473091 18.689747 18.712680 18.471583 ...
    18.266092 18.506887 18.569349];

%location 2 - inside

lat2 = [14.999030 15.544441 15.286505 14.880896 15.327182 15.244352 15.517887 ...
    14.914771 15.667911 14.957389];

long2 = [10.927568 11.937219 12.640207 11.091719 13.114339 11.536195 11.965583 ...
    12.236050 11.712306 11.877774];

%compute averages/std deviaitons
lat1_avg = mean(lat1)
lat1_std = std(lat1)
long1_avg = mean(long1)
long1_std = std(long1)

lat2_avg = mean(lat2)
lat2_std = std(lat2)
long2_avg = mean(long2)
long2_std = std(long2)

%difference between google maps
google_lat1 = 40.011634;
google_long1 = 105.254980;
google_lat2 = 40.004299;
google_long2 = 105.253409;

diff_lat1 = abs(google_lat1 - lat1_avg)
diff_long1 = abs(google_long1 - long1_avg)
diff_lat2 = abs(google_lat2 - lat2_avg)
diff_long2 = abs(google_long2 - long2_avg)

%difference in meters
diff1 = norm(lla2ecef([lat1_avg/3600,long1_avg/3600,1655])-lla2ecef([google_lat1/3600,google_long1/3600,1655]))
diff2 = norm( lla2ecef([lat2_avg/3600,long2_avg/3600,1655]) -lla2ecef([google_lat2/3600,google_long2/3600,1655]) )


