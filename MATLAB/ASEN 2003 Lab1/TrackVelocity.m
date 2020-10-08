clear all;
close all;
clc;

h = 125; %Initial height
x = 0; %Position along track
v = zeros(201,1); %Veloctiy Matrix
Gfb = zeros(201,1); %G's forward/backward Matrix
Gud = zeros(201,1); %G's up/down matrix
Gl = zeros(201,1); %G's lateral
Gud(1,1) = 0;
Gl(1,1) = 0;
Gfb(1,1) = 0;
v(1,1) = 0; %Initil Velocity
g = 9.81; %Grav constant
i = 1;
theta = 0;

%Analysis of ramp
while x <= 30
    hnew = h-1;
    v(i+1,1) = sqrt( (2 * ((0.5*(v(i,1))^2 + g*h - g*hnew)) ));
    Gfb(i+1,1) = sind(45);
    Gud(i+1,1) = 0;
    Gl(i+1,1) = 0;
    x = x+1;
    h = hnew;
    i = i+1;
    
    %Analysis of loop
    while theta >= 0 && theta <= 360 && x >= 30
        hnew = sqrt( 144-(x-(30 + sqrt(72)))^2 ) + 95 + sqrt(72);
        v(i+1,1) = sqrt( (2 * ((0.5*(v(i,1))^2 + g*h - g*hnew))) );
        addtheta = (v(i+1,1) / 12) * (pi / 180);
        theta = theta + addtheta;
        Gfb(i+1,1) = sind(theta);
        Gud(i+1,1) = ((((v(i+1,1))^2) / 12) / g);
        Gl(i+1,1) = 0;
        x = x+1;
        h = hnew;
        i = i+1;
        if x == 42
            v(44,1) = v(33,1);
            v(45,1) = v(34,1);
            v(46,1) = v(35,1);
            v(47,1) = v(36,1);
            v(48,1) = v(37,1);
            v(49,1) = v(38,1);
            v(50,1) = v(39,1);
            v(51,1) = v(40,1);
            v(52,1) = v(41,1);
            v(53,1) = v(42,1);
            v(54,1) = v(43,1);
            v(55,1) = v(44,1);
        end
    end
    
    %Analysis of zero G drop
    while x > (30+sqrt(72)) && x <= 117.084
        hnew = ((-1)* (g / (2*(24.26^2)))) * (x - (30 + sqrt(72)))^2 + (95 + sqrt(72) - 12);
        v(i+1,1) = sqrt( (2 * ((0.5*(v(i,1))^2 + g*h - g*hnew))) );
        x = x+1;
        h = hnew;
        i = i+1;
    end
%     while x > 117.084 && x <= 
    
    
end


%Plot values
s = [0:200];
figure(1)
plot(s, v);
figure(2)
plot(s, Gfb);
figure(3)
plot(s, Gud);