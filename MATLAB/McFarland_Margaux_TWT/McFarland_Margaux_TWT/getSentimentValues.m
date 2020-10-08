function [values] = getSentimentValues(tweets, sentiments)
%takes in a cell array of string array of each word in a tweet
%compares each word to the sentiments and gets an average sentiment
%value for the while tweet
%returns an array of sentiment values for each tweet

[~,c] = size(tweets);
[r1,~] = size(sentiments);
%words in sentiments
sentWords = string(sentiments(1:r1,1));
%values in sentiments
sentVals = str2double(string(sentiments(1:r1,2)));

values = zeros(c,1);


for i = 1:c %loops through each tweet
    tweet = tweets{1,i};
    
    [r2,~] = size(tweet);
    %total sentiment value for the tweet
    totVal = 0;
    
    for j = 1:r2 %loops through the array of words
        word = tweet{j,1};
       
        for k = 1:r1 % loops through sentiments
            
            if strcmpi(word,sentWords(k))
      
                totVal = totVal + sentVals(k);
            end
        end
        
        
    end
    values(i,1) = totVal/r2;
    
end

        



end
