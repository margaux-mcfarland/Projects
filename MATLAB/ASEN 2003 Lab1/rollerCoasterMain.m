clear all
close all


r1 = 12; %radius of loop
r2 = 28; %radius of trans to flat 1
r3 = 45.53; %radius of trans to vert
r4 = 13.59;% radius of trans to flat 2
r5 = 5.88; %radius of banked turn
r6 = 10.19; %radius of transition to final hill
r7 = 109.7; %radius of transition to braking
g = 9.81; % Grav constant



%ramp1 
x1 = linspace(1,125-(107-r1*cosd(45)));
z1 = -x1 + 125;
y1 = linspace(0,0);


%loop
theta2 = linspace(5*pi/4,7*pi/2);
x2 = r1*cos(theta2)+x1(end)+r1*cosd(45);
z2 = r1*sin(theta2) + 107;
y2 = linspace(0,0);


%parabolic hill
v1 = sqrt(2*g*(125-z2(end))); %calc velocity to find 0g parabola

x3 = linspace(x2(end),x2(end)+69.28);
z3 = (-g/(2*v1^2)*(x3-x2(end)).^2)+z2(end);
y3 = linspace(y2(end),y2(end));


%transition to flat 1
theta4 = linspace(180+atand(1.155),270);
x4 = r2*cosd(theta4) + x3(end)+r2*cosd(atand(1.155));
z4 = r2*sind(theta4) + z3(end)+r2*sind(atand(1.155));
y4 = linspace(y3(end),y3(end));


%flat section 1
x5 = linspace(x4(end),x4(end)+5);
z5 = linspace(z4(end),z4(end));
y5 = linspace(y4(end),y4(end));


%transition to vertical
theta6 = linspace(270,360);
x6 = r3*cosd(theta6) + x5(end)-r3*cosd(270);
z6 = r3*sind(theta6) + z5(end)-r3*sind(270);
y6 = linspace(y5(end),y5(end));


%vertical hill
x7 = linspace(x6(end),x6(end));
z7 = linspace(z6(end),z6(end)+12.5993);
y7 = linspace(y6(end),y6(end));


%transition to flat 2
theta8 = linspace(180,90);
x8 = r4*cosd(theta8) + x7(end)-r4*cosd(180);
z8 = r4*sind(theta8) + z7(end)-r4*sind(180);
y8 = linspace(y7(end),y7(end));


%flat 2
x9 = linspace(x8(end),x8(end)+10);
z9 = linspace(z8(end),z8(end));
y9 = linspace(y8(end),y8(end));


%Banked Turn
theta10 = linspace(270,360);
x10 = r5*cosd(theta10) + x9(end);
y10 = r5*sind(theta10) + y9(end)+r5;
z10 = linspace(z9(end),z9(end));

%flat 3
x11 = linspace(x10(end),x10(end));
z11 = linspace(z10(end),z10(end));
y11 = linspace(y10(end),y10(end)+10);


%transition to final hill
theta12 = linspace(90,0);
x12 = linspace(x11(end),x11(end));
z12 = r6*sind(theta12) + z11(end)-r6;
y12 = r6*cosd(theta12) + y11(end);


%transition to braking
theta13 = linspace(180,270);
x13 = linspace(x12(end),x12(end));
z13 = r7*sind(theta13) + z12(end);
y13 = r7*cosd(theta13) + y12(end)+r7;


%braking zone
x14 = linspace(x13(end),x13(end));
z14 = linspace(z13(end),z13(end));
y14 = linspace(y13(end),y13(end)+32);



%combine into total x,y,z vectors

x_tot = [x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14];
y_tot = [y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14];
z_tot = [z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14];

%% calculate Velocity 
vel = zeros(1,length(z_tot));
for i = 1:length(z_tot)
    if i < 1301
        vel(i) = sqrt(2*g*(125-z_tot(i)));
    else
        vel(i) = vel(i-1)-.495227;
    end
        
end



%% calc accel
    
%ramp
Gfb1 = linspace(0,0);
Gud1 = linspace(0,0);
Gl1 = linspace(0,0);

%loop
Gfb2 = linspace(0,0);
Gud2 = ((vel(100:200)).^2/r1)/g;
Gl2 = linspace(0,0);

%Parabolic hill
Gfb3 = linspace(0,0);
Gud3 = linspace(0,0);
Gl3 = linspace(0,0);

%transition to flat 1;
Gfb4 = linspace(0,0);
Gud4 = ((vel(300:400)).^2/r2)/g;
Gl4 = linspace(0,0);

%flat 1
Gfb5 = linspace(0,0);
Gud5 = linspace(1,1);
Gl5 = linspace(0,0);

%tans to vert
Gfb6 = linspace(0,0);
Gud6 = ((vel(500:600)).^2/r3)/g;
Gl6 = linspace(0,0);

%Vert hill
Gfb7 = linspace(0,0);
Gud7 = linspace(0,0);
Gl7 = linspace(0,0);

%Trans to flat 2
Gfb8 = linspace(0,0);
Gud8 = ((vel(700:800)).^2/r4)/g;
Gl8 = linspace(0,0);

%flat2 CHECK WITH TREVOR/AXELRAD
Gfb9 = linspace(0,0);
Gud9 = linspace(1,1);
Gl9 = linspace(0,0);

%Banked Turn
Gfb10 = linspace(0,0);
Gud10 = (((vel(800:900)).^2/r5)*sind(60))/g;
Gl10 = (((vel(800:900)).^2/r5)*cosd(60))/g;

%flat3 CHECK WITH TREVOR/AXELRAD
Gfb11 = linspace(0,0);
Gud11 = linspace(1,1);
Gl11 = linspace(0,0);

%Trans down
Gfb12 = linspace(0,0);
Gud12= ((vel(1100:1200)).^2/r6)/g;
Gl12 = linspace(0,0);

%transition to braking
Gfb13 = linspace(0,0);
Gud13= ((vel(1200:1300)).^2/r7)/g;
Gl13 = linspace(0,0);

%braking section
Gfb14 = linspace(-4,-4);
Gud14 = linspace(0,0);
Gl14 = linspace(0,0);


%make one big vector
Gfb_tot = [Gfb1,Gfb2,Gfb3,Gfb4,Gfb5,Gfb6,Gfb7,Gfb8,Gfb9,Gfb10,Gfb11,Gfb12,Gfb13,Gfb14];
Gud_tot = [Gud1,Gud2,Gud3,Gud4,Gud5,Gud6,Gud7,Gud8,Gud9,Gud10,Gud11,Gud12,Gud13,Gud14];
Gl_tot = [Gl1,Gl2,Gl3,Gl4,Gl5,Gl6,Gl7,Gl8,Gl9,Gl10,Gl11,Gl12,Gl13,Gl14];



%% plotting


%3d curve
    figure(1)
        plot3(x_tot,y_tot,z_tot)
        grid on
        xlabel('x')
        ylabel('y')
        zlabel('Height')
        
        hold on
        scatter3(x_tot,y_tot,z_tot,5,vel)
        title('Roller Coaster')
        colorbar;
        

%velocity 
    figure(2)
        plot(vel)
        hold on
        ylabel('Velocity (m/s)')
        title('Velocity')

        
%accel
    figure(3)
        subplot(3,1,1), plot(Gfb_tot), title('Longitudinal Acceleration') ,ylabel('Acceleration (g)')
        subplot(3,1,2), plot(Gud_tot), title('Vertical Acceleration') ,ylabel('Acceleration (g)')
        subplot(3,1,3), plot(Gl_tot), title('Lateralal Acceleration') ,ylabel('Acceleration (g)')
        

