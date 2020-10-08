%TweetAnalysis.m
%Analyzes twitter data via various metrics.
%Completed by:
%Margaux Mcfarland 107731341 Section 112
%Braden Campbell 107523915 Section 110

%% Task 1

[num, txt, raw] = xlsread('parsed_tweets_small.xlsx');
%call function which takes all the tweets from the continental US.
tweets = cleanData(raw);
%counts the total remaining tweets after data is cleaned
numTweets = countTweets(tweets);
fprintf('There are %d tweets remaining, all from the Continental US, all using the English language\n',numTweets);

%% Task 2
%matrix of latitude and longitide extracted from raw 
[r,c] = size(tweets);
xCoords = str2double(string(tweets(1:r, 11)));
yCoords = str2double(string(tweets(1:r, 12)));
%marks each tweet with a red dot on the US map, where each tweet came from
mapTweets(xCoords,yCoords);

%% Task 3
%goes through each tweet and retreives its postal code and puts it into a
%array with the number of tweets in each index (index cooresponds to state)
[r,~] = size(tweets);
%row vector of the locations of each tweet 
locations = string(tweets(1:r,14));
states = countTweetsPerState(locations);

%vec of all the states 
stateVec = {"AK","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"};
catstateVec = categorical({'AK','AZ','AR','CA','CO','CT','DE','FL','GA','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY'});

        
%creates histogram with number of tweets in each state.
figure
bellCurve = bar(catstateVec,states);
title('Tweets By State');
ylabel('Number of Tweets');
xlabel('States');
saveas(bellCurve,'bellCurve.jpg');

%% Task 4
%creates matrix of tweets including the word 'me' and/or 'I'
meMat = meFinder(tweets);
%retrieves postal codes for all tweets in matrix
meStates = countTweetsPerState(meMat);
%creates histogram with number of tweets in each state.
meBell = bar(catstateVec, meStates);
title('Most Narcisistic States');
ylabel('Number of Tweets including "me" and/or "I"');
xlabel('States');
saveas(meBell,'meBell.jpg');

%% Task 5
%creates matrix with number of tweets for each state (1-48).
[numStates, sArray] = stateCounter(tweets);
%creates variable for max and min number of tweets by state
myMin = min(numStates);
myMax = max(numStates);
%normalizes each pixel in image of US using the min and max number of tweets
%per state
load('state_mask');
load('usa_image');

usMap = normalize(myMin, myMax, numStates, usa_image, state_mask);
imagesc(usMap);
imwrite(usMap, 'usMapNormalized.jpg');

%% Task 6

%Twitter_visualization_help.m

words=cell(size(Tweets,1),1);
hashtags = cell(size(Tweets,1),1);
%hashtags for every tweet
for j=1:size(Tweets)
    if isempty(Tweets{j})==1
    Tweets(j)=' ';
    end
        
words{j} = split(Tweets{j});
hashindex = contains(words{j,:}, '#');
 for e = find(hashindex~=0)

    hashtags{j} = words{j}(e);

 end
end

%create cell with states and tweets in each state
for j = 1:length(statevec3)
   QW = contains(newstate, statevec3{j});
   statevecindex = find(QW ==1);
   statevec3{j}=hashtags(statevecindex); 
end

%preallocates 
%takes out all the nulls
for j = 1:length(statevec3)
       statevec3{j} = statevec3{j}(~cellfun('isempty',statevec3{j}));
end

%put all of the hashtages in each state 
statehash = cell(1,length(statevec3));
for i = 1:length(statevec3)
       for j = 1:length(statevec3{i})
           for k = 1:length(statevec3{i}(j))
               statehash{i}(j) = statevec3{i}{j}(k); 
           end
       end
end

for j = 1:length(statehash)
       tagger = categorical(statehash{j});
       statehash{j}= mode(tagger);
end

statehash{49} = statehash{48};
statehash = transpose(statehash);

for j = 1:length(statehash)
    statehash{j} = cellstr(statehash{j});
end



%Create figure for plotting
figure; 
%load a map of the CONUS
ax = usamap('conus');
%select only states within CONUS
states = shaperead('usastatelo', 'UseGeoCoords', true,...
  'Selector',...
  {@(name) ~any(strcmp(name,{'Alaska','Hawaii'})), 'Name'});
%Show the state borders on the map with a white face
geoshow(ax, states, 'Facecolor',[1 1 1])
%Keep the axis on for refrence along with labels
framem on; gridm on; mlabel on; plabel on
%Get the coordinates for every state
lat = [states.LabelLat];
lon = [states.LabelLon];
%select the states that require text
tf = ingeoquad(lat, lon, latlim, lonlim);

%This line just plots the text on the map axis.
textm(lat(tf), lon(tf), statehash, ...
   'HorizontalAlignment', 'center')
saveas(gcf,'mvp.jpg');


%following with out a space
%then put in into a matrix with the hashtag and the number of times used;

%% Task 7
%function to find the the person or persons with the most followers
% look at the date ans the the followers = to a varriable in a loop
% check to see if the number of foloers of the next person is greater. if
% so tthen make the variable = to the number of followers for every state
% if the same save both
%finds the user with the max number of followers per state

%creates a cell array with handles from each state and followers on each
%row
for j = 1:length(statevec)
    QW = contains(newstate,statevec2{j});
    statevecindex = find(QW==1);
    statevec2{j} = horzcat(handle(statevecindex,:),followers(statevecindex,:));
end
%removes all rows that aren't the maximum number of followers and returns
%that as statevec2
for j = 1:length(statevec)
    mat = statevec2{1,j};
    matnums = double(mat(:,2));
    maxfols = max(matnums);
    FR = find(matnums~=maxfols);
    statevec2{:,j} = removerows(statevec2{:,j},'ind',FR);
end
%sets statevec{j} equal to the most popular handle
for j = 1:length(statevec2)
    if isempty(statevec2{j})==1
        statevec2{j} = string("notauser");
    end
    statevec2{j} = statevec2{j}(1,1);
end
%Create figure for plotting
figure; 
%load a map of the CONUS
ax = usamap('conus');
%select only states within CONUS
states = shaperead('usastatelo', 'UseGeoCoords', true,...
  'Selector',...
  {@(name) ~any(strcmp(name,{'Alaska','Hawaii'})), 'Name'});
%Show the state borders on the map with a white face
geoshow(ax, states, 'Facecolor',[1 1 1])
%Keep the axis on for refrence along with labels
framem on; gridm on; mlabel on; plabel on
%Get the coordinates for every state
lat = [states.LabelLat];
lon = [states.LabelLon];
%select the states that require text
tf = ingeoquad(lat, lon, latlim, lonlim);

statevec2{49} = statevec2{48};
statevec2 = transpose(statevec2);
%The next part is going to be your job. The example that we have created
%puts the words '#TEXT' over every state. This is achieved by creating the
%variable 'hashtag'. This is a 49x1 cell array where the contents of every
%element are text. In your case, you will want the text to correspond with
%the most popular hash tag for that state. Once again, the number of rows
%is not a coincidence. Notice how they correspond with the structure
%variable, 'states

%This line just plots the text on the map axis.
textm(lat(tf), lon(tf), statevec2, ...
   'HorizontalAlignment', 'center')
saveas(gcf,'mvp.jpg');


%% Task 8
%loop through using a time index
%find the number of tweets for each state at all time in a day 
% find the max (myMax)
%find the Min (myMin)
% subtract the myMin from each state and Divide by the myMax
%map.mat generates a picture of the united states
% state_mask
%for each state add to the intensity based on the number of tweets

%cat function to concatenate in 4th demension 
%function immovie creates a playable moveie

%movie2avi saves the movie


%animates task five

%creates gradiated images for images 1 thru 60 and then concatenates them
%along the fourth dimension
image = cell(1,60);
for j = 1:60
    image{j} = (j-1)*(usa_image)/59;
    image{j}(:,:,1) = cleanimage(:,:,1);
    image{j}(:,:,3) = image{j}(:,:,1);
end

movie = cat(4,image{1:60});
playable = immovie(movie);
implay(playable)
movie = VideoWriter('state_masktimelapse.avi');
open(movie);
writeVideo(movie,playable);
%movie()
%% task 9 EXTRA CREDIT
%save number of tweets to altitude

%map the lattide longitude and altitude on the map
%  use function kmlwritepoint to create .kme files
% Puts each user on the map at the location of their tweet at a height
% correlating to the number of followers the user has

terrestrial(latitude,longitude,followers);


%% Task 10
%reads in file for dog and cat tweets and analyses the "sentiment"
%of each tweet and plotting those sentiments on the map

[num1, txt1, raw1] = xlsread('cat.xlsx');
[num2, txt2, raw2] = xlsread('dog.xlsx');

%cell array of string vectors of each word in each tweet
catTweets = splitWords(raw1);
dogTweets = splitWords(raw2);


[num3, txt3, raw3] = xlsread('sentiments.xlsx');

%vector of avaerge sentiment value of each tweet
catSentiments = getSentimentValues(catTweets,raw3);
dogSentiments = getSentimentValues(dogTweets',raw3);

displaySentiments(catSentiments,dogSentiments,raw1,raw2);




