function [states] = countTweetsPerState(tweets)
%gets the frequency of tweets from each state

[r,~] = size(tweets);

%vec of all the states 
stateVec = ["AK","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"];


%cell array of 48 cell arrays representing each state
states = zeros(1,48);


for i = 1: r 
    
    for j = 1: length(stateVec) %loops through stateVec
        
        if contains(string(tweets(i,1)),stateVec(j)) == 1
            %array for each postal code of same state
            
           states(1,j) = states(1,j) + 1;
            
            
        end
    end
    
end

            


end
