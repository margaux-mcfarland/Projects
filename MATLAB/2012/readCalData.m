function [time,waterTemp,sampleTemp1,sampleTemp2] = readCalData(inputfile)
%%this function takes in a text file and then parses the file to contain
%four different vectors, time, water temp, and two vectors on the sample's
%temperature

%open input file
myFile = fopen(inputfile);

%currentLine is the line in the text file being analyzed
currentLine = fgetl(myFile);

%make a variable for space
space = currentLine(1);

line = 1;%represents line number we are at

%continue looping through each line in file until end of file
while currentLine > -1
    
    endLine = 0; %true when reached the end of line
    indexLine = 1; %keeps track of index in each line
    indexVec = 1; %keeps track of index for each data vector
    
    %skip spaces
    while currentLine(indexLine) == space
        indexLine = indexLine+1;
        
    end
   
    %ignore lines that start with '%'
    if currentLine(indexLine) == '%'
        currentLine = fgetl(myFile);
        continue;
    end
    %loops through characters in each line
    %grabs portion of line before a space

    for i = 1:4
        %skip spaces
        while currentLine(indexLine) == space
            indexLine = indexLine+1;
        end
        
        while currentLine(indexLine) ~= space && indexLine < length(currentLine)
            if(i == 1)
                
                
                time(line,indexVec) = currentLine(indexLine);
            elseif(i == 2)
                waterTemp(line,indexVec) = currentLine(indexLine);
            elseif(i == 3) 
                sampleTemp1(line,indexVec) = currentLine(indexLine);
            else
                sampleTemp2(line,indexVec) = currentLine(indexLine);
            end
            indexLine = indexLine + 1;
            indexVec = indexVec + 1;
        end
      %reset index of vector
      indexVec = 1;
        
    end
    
    currentLine = fgetl(myFile);
    line = line + 1;
        
end

%convert strings to doubles
time = str2num(time);
waterTemp = str2num(waterTemp);
sampleTemp1 = str2num(sampleTemp1);
sampleTemp2 = str2num(sampleTemp2);



end