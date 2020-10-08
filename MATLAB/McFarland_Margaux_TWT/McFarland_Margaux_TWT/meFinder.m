function [meTweets] = meFinder(raw)
%finds all the tweets that contain ' me ' and/or ' I '
%and returns all the me/I tweets

[r,~] = size(raw);
%row vector of all the tweets
tweets = string(raw(1:r,8));

count = 1;

meTweets = {};

for i = 1:r % loops through each row
    if contains(tweets(i,1)," me ") == 1 || contains(tweets(i,1)," I ") == 1
        meTweets{count,1} = tweets(i,1);
        count = count + 1;
    end
end


end