function [tweets] = splitWords(raw)
%takes in a row of all the tweets
%creates an array of each word in one tweet
%stores each array in a cell array
[r,~] = size(raw);
text = string(raw(1:r,4));


%cell array of array of strings
tweets = {};

for i = 1:r %loops through rows of tweets
    
    tweets{i} = split(text(i));
    
end



end