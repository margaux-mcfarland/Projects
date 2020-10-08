%prelab9 - question 1 part d

A = [0 0 0 0 1 1 1 1];
O = [0 0 1 1 0 0 1 1];
F = [0 1 0 1 0 1 0 1];

S = isSirenOn(A,O,F)

%% Functions Called

function s = isSirenOn(A,O,F)
%returns whether siren is on (1) or off (0)
s = F | (O & A);
end