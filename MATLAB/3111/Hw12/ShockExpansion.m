function [c_l,c_d] = ShockExpansion(M_inf,alpha,epsilon)

gamma = 1.4;

%%%%%%%%%%%%%%%%%%%%%%
% First find p1/pinf

if alpha < epsilon
    beta_inf = beta(M_inf,epsilon-alpha,gamma,0);
    if ~isreal(beta_inf) || real(beta_inf) < 0
        fprintf('Configuration M = %.3f, alpha = %.3f, epsilon = %.3f produces a bow shock.\n',M_inf,alpha,epsilon);
        c_l = NaN; c_d = NaN;
        return;
    end
    Mn_inf = M_inf*sind(beta_inf);
    [~,~,p1_over_pinf,~,Mn_1,~,~] = flownormalshock(gamma,Mn_inf,'mach');
    M_1 = Mn_1/sind(beta_inf-(epsilon-alpha));
else
    if alpha > epsilon
        [~,nu_inf,~] = flowprandtlmeyer(gamma,M_inf,'mach');
        nu_1 = (alpha-epsilon) + nu_inf;
        [M_1,~,~] = flowprandtlmeyer(gamma,nu_1,'nu');
        [~,~,pinf_over_p0,~,~] = flowisentropic(gamma,M_inf,'mach');
        [~,~,p1_over_p0,~,~] = flowisentropic(gamma,M_1,'mach');
        p1_over_pinf = p1_over_p0/pinf_over_p0;
    else
        M_1 = M_inf;
        p1_over_pinf = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%
% Second find p2/pinf

[~,nu_1,~] = flowprandtlmeyer(gamma,M_1,'mach');
nu_2 = (2*epsilon) + nu_1;
[M_2,~,~] = flowprandtlmeyer(gamma,nu_2,'nu');
[~,~,p1_over_p0,~,~] = flowisentropic(gamma,M_1,'mach');
[~,~,p2_over_p0,~,~] = flowisentropic(gamma,M_2,'mach');
p2_over_p1 = p2_over_p0/p1_over_p0;
p2_over_pinf = p2_over_p1*p1_over_pinf;

%%%%%%%%%%%%%%%%%%%%%%
% Third find p3/pinf

beta_inf = beta(M_inf,epsilon+alpha,gamma,0);
Mn_inf = M_inf*sind(beta_inf);
if ~isreal(beta_inf) || real(beta_inf) < 0
    fprintf('Configuration M = %.3f, alpha = %.3f, epsilon = %.3f produces a bow shock.\n',M_inf,alpha,epsilon);
    c_l = NaN; c_d = NaN;
    return;
end
[~,~,p3_over_pinf,~,Mn_3,~,~] = flownormalshock(gamma,Mn_inf,'mach');
M_3 = Mn_3/sind(beta_inf-(epsilon+alpha));

%%%%%%%%%%%%%%%%%%%%%%
% Fourth find p4/pinf

[~,nu_3,~] = flowprandtlmeyer(gamma,M_3,'mach');
nu_4 = (2*epsilon) + nu_3;
[M_4,~,~] = flowprandtlmeyer(gamma,nu_4,'nu');
[~,~,p3_over_p0,~,~] = flowisentropic(gamma,M_3,'mach');
[~,~,p4_over_p0,~,~] = flowisentropic(gamma,M_4,'mach');
p4_over_p3 = p4_over_p0/p3_over_p0;
p4_over_pinf = p4_over_p3*p3_over_pinf;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next evaluate axial and normal force coefficients

c_n = 1/(gamma*M_inf^2)*( -p1_over_pinf - p2_over_pinf + p3_over_pinf + p4_over_pinf);
c_a = 1/(gamma*M_inf^2)*( p1_over_pinf - p2_over_pinf + p3_over_pinf - p4_over_pinf)*tand(epsilon);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finally evaluate lift and drag force coefficients

c_l = c_n*cosd(alpha) - c_a*sind(alpha);
c_d = c_n*sind(alpha) + c_a*cosd(alpha);