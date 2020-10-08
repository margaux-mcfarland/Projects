



[alpha,numeric,raw] = xlsread('parsed_tweets_small.csv');
[raw,~] = removerows(raw,'ind',1);

for k = 1:numel(raw)
  if isnan(raw{k})
    raw{k} = '';
  end
end

location = raw(:,[13 14]);
lograw = cellfun('isempty',location);
index = find(lograw==1);
trueindex = index(index<=size(raw,1));
[clean,~] = removerows(raw,'ind',trueindex);

country = cell2mat(clean(:,13));
state = string(clean(:,14));
language = cell2mat(clean(:,19));

langindex = find(language~='en');
countryindex = find(country~='US');
TF = contains(state,'HI')+contains(state,'AL');
stateindex = find(TF==1);

langcountryindex = setxor(setxor(langindex,countryindex),intersect(langindex,countryindex));
finalindex = setxor(setxor(stateindex,langcountryindex),intersect(stateindex,langcountryindex));
superfinalindex = finalindex(finalindex<=size(clean,1));
[tweets,~] = removerows(clean,'ind',superfinalindex);

followerslog = zeros(size(tweets(:,16),1),1);

for j = 1:length(tweets(:,16))
    if isempty(tweets{j,16})
        followerslog(j) = 1;
    else
        followerslog(j) = 0;
    end
end


for j = 1:length(tweets(:,16))
    if followerslog(j)==1
        tweets{j,16} = 0;
    end
end

username = string(tweets(:,5));
handle = string(tweets(:,6));
Tweets = string(tweets(:,7));
time = cell2mat(tweets(:,4));
followers = cell2mat(tweets(:,16));
following = tweets(:,17);
latitude = cell2mat(tweets(:,11));
longitude = cell2mat(tweets(:,12));
newstate = string(tweets(:,14));
tweetcount = size(tweets,1);

fprintf('There are %d tweets remaining, all from the Continental US,\nall using the English language.\n',tweetcount)