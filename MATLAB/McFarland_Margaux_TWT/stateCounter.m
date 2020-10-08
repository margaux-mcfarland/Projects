function [numStates, sArray] = stateCounter(states)
numStates = zeros(1, 48);
sArray = {'AL' 'AZ' 'AR' 'CA' 'CO' 'CT' 'DE' 'FL' 'GA' 'ID' 'IL' 'IN' 'IA'...
    'KS' 'KY' 'LA' 'ME' 'MD' 'MA' 'MI' 'MN' 'MS' 'MO' 'MT' 'NE' 'NV' 'NH'...
    'NJ' 'NM' 'NY' 'NC' 'ND' 'OH' 'OK' 'OR' 'PA' 'RI' 'SC' 'SD' 'TN'...
    'TX' 'UT' 'VT' 'VA' 'WA' 'WV' 'WI' 'WY'};
for i = 2:length(states)
    for j = 1:48
        if contains(states(i,14),sArray{1,j})==1
            numStates(1,j) = numStates(1,j) + 1;
        end
    end
end
end
