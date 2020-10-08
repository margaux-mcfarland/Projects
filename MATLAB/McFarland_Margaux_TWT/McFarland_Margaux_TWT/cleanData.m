function [cleanTweets] = cleanData(raw)
%cleans all the data
%excludes all tweets that aren't in English or are from Hawaii or Alaska

%removes top row
[raw,~] = removerows(raw,'ind',1);

%turns all cells that aren't a number into an empty string
for k = 1:numel(raw)
  if isnan(raw{k})
    raw{k} = '';
  end
end

location = raw(:,[13 14]);
%finds the empty string calls and removes them
lograw = cellfun('isempty',location);
index = find(lograw==1);
trueindex = index(index<=size(raw,1));
[clean,~] = removerows(raw,'ind',trueindex);


%from cell array to a matrix
country = cell2mat(clean(:,13));
state = string(clean(:,14));
language = cell2mat(clean(:,19));


%vectors of the indices of tweets to be removed
langIndex = find(language~='en');
countryIndex = find(country~='US');
TF = contains(state,'HI')+contains(state,'AL');
stateIndex = find(TF==1);

%returns values unique/the same between two vectors
%gets rid of repeats (ex)if a tweet was not in english and from alaska)
langCountryIndex = setxor(setxor(langIndex,countryIndex),intersect(langIndex,countryIndex));
finalIndex = setxor(setxor(stateIndex,langCountryIndex),intersect(stateIndex,langCountryIndex));

combinedIndex = finalIndex(finalIndex<=size(clean,1));
%removes those tweets
[tweets,~] = removerows(clean,'ind',combinedIndex);

cleanTweets = tweets;


end




