function s = isSirenOn(A,O,F)
%returns whether siren is on (1) or off (0)
s = F | (O & A);
end