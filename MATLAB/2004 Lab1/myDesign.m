%MY DESIGN

%% Overall Aircraft Configuration
%max span
b_max = 0.9; %m

ct = 0.02; %chord at tip
cr = 0.08; %chord at root

%wing planform area
S_ref = b_max*(ct+cr); %m^2
%aspect ratio
AR = b_max^2/S_ref;
%taper ratio
taper = ct/cr;
%wing sweep angle
sweep_angle = 0;

%positioning - mid-wing

%T-tail

%winglet (w/ wing-tip extensions)

S_wet_fuselage = 0.003348+0.032+0.0198; %m^2
S_wet_tail = 0.0262 + 0.03; %m^2

%wing
S_ref_exp = b_max*(ct+(cr-0.05));
thick_chord_r = 0.005/cr; %estimate thickness
thick_chord_t = 0.005/ct; %estimate thickness
tau = thick_chord_r/thick_chord_t;
S_wet_planform_wing = 2*S_ref_exp*(1+0.25*thick_chord_r*(1+(tau*taper))/(1+taper));

%tail
%vertical
S_ref_exp_tail_v = 0.5*(0.15+0.025)*0.15; %m^2
cr_v = 0.15;
ct_v = 0.025;
taper_v = ct_v/cr_v;
thick_chord_r_v = 0.002/cr_v;
thick_chord_t_v = 0.002/ct_v;
tau_v = thick_chord_r_v/thick_chord_t_v;
S_wet_tail_v = 2*S_ref_exp_tail_v*(1+0.25*thick_chord_r_v*(1+(tau_v*taper_v))/(1+taper_v));


%horizontal
S_ref_exp_tail_h = 0.08*0.3;
cr_h = 0.05;
ct_h = 0.05;
taper_h = ct_v/cr_v;
thick_chord_r_h = 0.005/cr_h;
thick_chord_t_h = 0.005/ct_h;
tau_h = thick_chord_r_h/thick_chord_t_h;
S_wet_tail_h = 2*S_ref_exp_tail_h*(1+0.25*thick_chord_r_h*(1+(tau_v*taper_h))/(1+taper_h));

S_wet_tail2 = 0.0173 + S_wet_tail_h; %horizontal stablizer will also be airfoil

S_wet = S_wet_planform_wing + S_wet_fuselage + S_wet_tail2;


%% Weight/Mass Estimates

%balsa wood - for strength 
density_balsa = 160; %kg/m^3
thickness_balsa = 0.002; %assume 
vol_fuselage = S_wet_fuselage * thickness_balsa;
W_fuselage = vol_fuselage * density_balsa; %kg

vol_tail_v = 0.5*(cr_v+ct_v)*0.15 * thickness_balsa; %assume thickness of balsa(0.001)
W_tail_v = vol_tail_v * density_balsa;
vol_tail_h = 0.05*0.3 * thickness_balsa;
W_tail_h_structure = vol_tail_h * density_balsa;

%wing - structure = balsa wood , covering = tissue paper
density_tissue = 0.024; %kg/m^2
vol_structure = S_ref*thickness_balsa;
area_covering = S_wet_planform_wing;
W_wing = (vol_structure*density_balsa) + (area_covering*density_tissue);

W_tail_h = W_tail_h_structure + (S_wet_tail_h * density_tissue);

%estimate weight of glue (wood glue) 
glue_density = 0.00119; % kg/ml
W_glue = glue_density*5; %10 millileters of glue

W_total = W_fuselage + W_tail_v + W_tail_h + W_wing + W_glue; %must be less than 0.08


x_cg_wing = 0.4*(cr+ct)/2;
x_cg_fuse = (((0.25/3)+0.2) + 0.1 -((0.04/3)))/3;
x_cg_vert  = 0.45-(1/3)*0.15;
x_cg_horz = 0.45;


W_ball = (0.003348)*density_balsa;
x_cg_ball = -((1/3)*0.04);
M_ball = x_cg_ball*W_ball;

M_total = (x_cg_wing*W_wing)+(x_cg_fuse*W_fuselage)+(x_cg_vert*W_tail_v)+(x_cg_horz*W_tail_h) + M_ball;
x_cg_total = M_total/W_total;
x_cg_total_max = 0.3*(cr+ct)/2;

x_cg_percent_c = x_cg_total/((ct+cr)/2);

%wing loading
wing_loading = 9.81*W_total/S_ref;

%% Performance
%launch height 
h = 8; %m
%target range
R_max = 80; %m

L_D_max = R_max/h;

%Std atm conditions at 1.5 km
AirDensity = 1.0581; %kg/m^3
viscosity = 1.74*10^-5; %kg/m*s
V_max = 7; %m/s
L_fuselage = 0.04+0.2+0.25;
Re = (AirDensity*V_max*L_fuselage)/viscosity;
%equivalent skin friction
C_fe = 0.074/(Re^0.2);

%zero-lift drag coeff
C_D0 = C_fe*(S_wet/S_ref);
C_D = 2*C_D0;
C_L = L_D_max *C_D;
k = C_D0/(C_L^2);

%range of allowable velocities
V_range = 3:0.5:7; %3 to 7 m/2s;
wing_loading_var = (C_L*0.5*AirDensity).*V_range.^2;

plot(V_range, wing_loading_var);
hold on
title('Wing Loading vs Allowable Velocities');
xlabel('Allowable Velocities (m/s)');
ylabel('Wing Loading (N/m^2)');

%esitimated velociy at calculated wing loading ->(V for max range)
V = sqrt(wing_loading/(C_L*0.5*AirDensity));
plot(V,wing_loading,'*');

V_LDmax = sqrt((2*W_total*9.81)/(AirDensity*S_ref*C_L));

%find angle of attack at L/D max and C_L
Re_airfoil = (AirDensity*V_max*((cr+ct)/2))/viscosity; %NACA 64A010






