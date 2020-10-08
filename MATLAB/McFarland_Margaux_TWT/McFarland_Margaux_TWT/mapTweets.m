function [] = mapTweets(xCoords,yCoords)
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

mapImg = plotm(xCoords,yCoords,'r.');
saveas(mapImg, 'mapOfTweets.jpg');

end
