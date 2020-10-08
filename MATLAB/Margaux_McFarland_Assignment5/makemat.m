%makemat.m
%creates a 2 column matrix out of two vectors
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 5

function mat = makemat(v1, v2)
[r,c] = size(v1);
[m,n] = size(v2);

%checks to see if v1 / v2 are matrices
if (r > 1 && c > 1) || (m > 1 && n > 1)
    error('Whoops v1 or v2 is a matrix. Try again.');
%checks to see if v1/v2 is a row vec, if so then transposes
else
    if c > 1
        v1 = reshape(v1, [c, 1]);
    end
    if n > 1
        v2 = reshape(v2, [n, 1]);
    end
end

%reinitializes new row and column sizes
[r,c] = size(v1);
[m,n] = size(v2);

%checks to see if v1 and v2 are diff lengths, if so pad with zeros
if r > m
    v2(numel(v1)) = 0;
elseif m > r
    v1(numel(v2)) = 0;
end

%combine v1 and v2 to create matrix
mat = [v1, v2];

end

