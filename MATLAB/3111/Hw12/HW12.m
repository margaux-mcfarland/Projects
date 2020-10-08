clear all; clc;

M_inf = 2.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First the flat plate computations!

% [cl_5_linearized_plate,cd_5_linearized_plate] = Linearized(M_inf,5,0);
% [cl_15_linearized_plate,cd_15_linearized_plate] = Linearized(M_inf,15,0);
% [cl_30_linearized_plate,cd_30_linearized_plate] = Linearized(M_inf,30,0);

[cl_5_shock_plate,cd_5_shock_plate] = ShockExpansion(M_inf,5,0);
[cl_15_shock_plate,cd_15_shock_plate] = ShockExpansion(M_inf,15,0);
[cl_30_shock_plate,cd_30_shock_plate] = ShockExpansion(M_inf,30,0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next the diamond airfoil computations!

% [cl_5_linearized_diamond,cd_5_linearized_diamond] = Linearized(M_inf,5,5);
% [cl_15_linearized_diamond,cd_15_linearized_diamond] = Linearized(M_inf,15,5);
% [cl_30_linearized_diamond,cd_30_linearized_diamond] = Linearized(M_inf,30,5);

[cl_5_shock_diamond,cd_5_shock_diamond] = ShockExpansion(M_inf,5,5);
[cl_15_shock_diamond,cd_15_shock_diamond] = ShockExpansion(M_inf,15,5);
[cl_30_shock_diamond,cd_30_shock_diamond] = ShockExpansion(M_inf,30,5);