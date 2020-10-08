function [] = terrestrial(lat, long, followers)
filename = 'Terrestrial.kml';
kmlwritepoint(filename,lat,long,followers);
end
