function data = combineData()
%this function combines all the data from the 3pm section, so that the angles of
%attack range from -15 to 15 degrees
data = cell(1,8);

data{:,1} = parseFile('AirfoilPressure_S014_G01.csv');
data{:,2} = parseFile('AirfoilPressure_S014_G03.csv');
data{:,3} = parseFile('AirfoilPressure_S014_G05.csv');
data{:,4} = parseFile('AirfoilPressure_S014_G07.csv');
data{:,5} = parseFile('AirfoilPressure_S014_G09.csv');
data{:,6} = parseFile('AirfoilPressure_S014_G11.csv');
data{:,7} = parseFile('AirfoilPressure_S014_G13.csv');
data{:,8} = parseFile('AirfoilPressure_S014_G15.csv');


end

 