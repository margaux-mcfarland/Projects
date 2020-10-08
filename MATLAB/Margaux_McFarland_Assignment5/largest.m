%largest.m
%returns the largest element that is next to a zero in a vector
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 5

function x = largest(vec)
%transpose vec to add non zero min to end
vec = transpose(vec);
if min(vec) < 0
    vec1 = padarray(vec, 1, rand*min(vec) + min(vec), 'both');
elseif min(vec) >= 0
    vec1 = padarray(vec, 1, rand*min(vec) - min(vec) -1, 'both');
else
    vec1 = [];
end


%create a logical vec of non zero values
logvec = logical(vec1);

%checks if there are no zeros in v, returns empty matrix
if sum(logvec) == length(vec1)
    x = [];
end

%vec of values adjacent to zero
v2 = zeros(1, length(vec1) - length(logvec));

%index of vec1
i = 2;
%index of new vec (v2), used to find where to add new values
t = 1;
while i < length(vec1)   
    if vec1(i) == 0
        v2(t) = vec1(i-1);
        v2(t + 1) = vec1(i + 1);
        t = t+ 2;
    end
    i = i + 1;
end

%find max of v2
x = max(v2);
end


        




