function [] = displaySentiments(catSentiments,dogSentiments,catTweets,dogTweets)
%takes in vector of sentiment value for each tweet and the tweets
%and plots tweet on map 
[r1,~] = size(catTweets);
[r2, ~] = size(dogTweets);
lat = string(catTweets(1:r1, 1));
long = string(catTweets(1:r1,1));
xCoords1 = str2double(lat(2:(strfind(lat,',')-1)));
yCoords1 = str2double(long((strfind(lat,',')+1):length(long))); 

lat = string(dogTweets(1:r2, 1));
long = string(dogTweets(1:r2,1));
xCoords2 = str2double(lat(2:(strfind(lat,',')-1)));
yCoords2 = str2double(long((strfind(lat,',')+1):length(long))); 

%maps the coordinates of each tweet on the US map
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

length(catSentiments)
for i = 1: length(catSentiments)
    if catSentiments(i) > 0 %positve cat tweets
        plotm(xCoords1(i,1),yCoords1(i,1),'r.');
    elseif catSentiments(i) < 0 %negative cat tweets
        plotm(xCoords1(i,1),yCoords1(i,1),'g.');
    
    
    end
    hold;
end
for i = 1:length(dogSentiments)
    if dogSentiments(i) > 0 %positve dog tweets
        plotm(xCoords2(i,1),yCoords2(i,1),'b.');
    else
        plotm(xCoords2(i,1),yCoords2(i,1),[255,165,0],'.');
    end
    hold;
end


end
