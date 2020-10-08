
%% Surface area estimates

%max surface area (assume body is a cylinder with max radius)
r_max = 0.08;
h_max = 1.56-0.13;
S_wet_max = (2*pi*r_max*h_max) + (2*pi*r_max^2);

%min surface area (assume body is a cyliner with min radius)
r_min = (2/3)*r_max;%assume radius is 2/3 max radius
h_min = h_max;
S_wet_min = (2*pi*r_min*h_min) + (2*pi*r_min^2);


%average estimate

%fuselage
a = 0.45;
b = r_max;
c = r_max; %assume same max radius as b
S_wet_f = 4*pi*(((a*b)^1.6+(a*c)^1.6+(b*c)^1.6)/3)^(1/1.6);

%cylinder in between tail and fuselage
r = r_min; 
h = 1.56 - 0.9-0.13;
S_wet_c = (2*pi*r*h); %excluding the base circles

%tail 
%vertical stabilizer
c_r = 0.3; %assume chord at root
taper = 0.13/c_r;
thick_chord = 0.4/c_r;
tau = thick_chord/(0.4/0.13);
S_exp_plf = 2*(((0.26+0.13)/2)*(0.4-r_min)); %assume side (not in fuselage) is 2*0.13
S_wet_tail_v = 2*S_exp_plf*(1+0.25*thick_chord*((1+tau*taper)/(1+taper)));

%horizontal stabilizer
S_wet_tail_h = 0.23156;

S_wet_tail = S_wet_tail_v + S_wet_tail_h;

%wing
S_wet_wing = 1.2874;

S_wet = S_wet_f+S_wet_c+S_wet_tail+S_wet_wing


%% Whole planform area

%fuselage
S_f = pi*a*b;
S_c = h*r;
S_tail = 0.092625;
S_wing = 0.63;

S = S_f + S_c + S_tail + S_wing
