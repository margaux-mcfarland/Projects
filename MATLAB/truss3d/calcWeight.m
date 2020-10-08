function [weight] = calcWeight(numBars,connectivity,joints,numJoints)
    %this function takes in the number of bars, the joints, and a matrix of
    %joints at which the bars connect, and the number of joints.
    %this function calculates and returns the weight of each magnet, bar, 
    %joint, and sleeve of the whole truss
    for i = 1:numBars
        xCoor_1 =joints(connectivity(i,1),1);
        xCoor_2 =joints(connectivity(i,2),1);
        yCoor_1 =joints(connectivity(i,1),2);
        yCoor_2 =joints(connectivity(i,2),2);
        zCoor_1 =joints(connectivity(i,1),3);
        zCoor_2 =joints(connectivity(i,2),3);
 
        total_length(i) = sqrt((xCoor_1-xCoor_2)^2 + (yCoor_1-yCoor_2)^2 + (zCoor_1-zCoor_2)^2);
    
    end
    
    %subtract length of magnets/ball joints
    total_length = total_length - 0.0254; %meters (1 inch)
    
    for i = 1:numJoints
        j = 0; %number of bars at one joint
        jointLength = 0;
        for k = 1:numBars
            if(i == connectivity(k,1) || i == connectivity(k,2))
                jointLength = jointLength + total_length(k);
                j = j + 1;
            end
        end
        
         weight_mag = j*(1.7/1000); %kg
         weight_bar = (jointLength*(32.386/1000))/2; %kg
         % our truss design uses no sleeves
         %weight_sleeve = 0;
         weight_sleeve = j*(5.35/1000)/2; %kg %use this for general sample files
         weight_joint = 8.356/1000; %kg   
         weight(i) = weight_mag+weight_bar+weight_sleeve+weight_joint;
        
    end

end