%receives a row vector and the number of times each element
%is to be repeated and then returns the new row vector
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Lab 4
function vec_out = repvecR2(v, x)
%marks the index in vec
index_1 = 1;
%marks the index in v
index_2 = 1;
%creates a zero vector with a length  x*length(v)
vec = zeros(1,x*length(v));
%goes through v and adds each element into vec x amount of times
while(index_2 <= length(v))
    temp = x;
    while(temp > 0)
       vec(index_1)  = v(index_2);
       index_1 = index_1 + 1;
       temp = temp - 1;
    end
    index_2 = index_2 + 1;
end
vec_out = vec;
end


