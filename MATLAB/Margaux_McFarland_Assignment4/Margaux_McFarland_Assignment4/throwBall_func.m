%throwBall_func.m
%returns true or false depending on whether the ball
%hits the ground in the allowed time
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Assignment 4

function log = throwBall_func(v, theta, maxTime)
%constants
initHeight = 1.5;
gravity = 9.8;
%%
%time
T = linspace(0,maxTime,10000);
%%
%expressions for height and distance
y = initHeight + T.*v*sin(theta*(pi/180)) - (.5*gravity*T.^2);


%%
%find index when ball hits ground or creates a zero vector if no indices in
%time interval
t_index = find(y < 0);
  
log = isempty(t_index);
end
