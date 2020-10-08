%easterSunday.m
%prompts the user for a year and prints out the
%year, month, and day of Easter Sunday (task 5)
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 4

disp('Find out the date of Easter! Please enter the year\n');
y = input('Year: ');
a = rem(y, 19);
b = floor(y/100);
c = rem(y, 100);
d = floor(b/4);
e = rem(b, 4);
g = floor((8*b+13)/25);
h = rem(19*a+b-d-g+15, 30);
j = floor(c/4);
k = rem(c, 4);
m = floor((a+11*h)/319);
r = rem(2 * e + 2 * j - k - h + m + 32, 7);
n = floor((h-m+r+90)/25);
p = rem(h - m + r + n + 19, 32);
%%
%print out date
fprintf('In %d, Easter Sunday fell on %d/%d.\n', y, n, p);


