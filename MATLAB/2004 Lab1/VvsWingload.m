%velocity plot
clc; clear all;close all;
%swet=0.07866875;
%swet=0.09756875;
% swet=0.15145;
swet=.144211;
sref=0.045;
v=(3:.01:6);
Re=1.0581*6*0.3/(1.74*10^(-5));
CDo=(0.074/Re^(0.2))*(swet/sref);
C_L=10*2*CDo;
q=.5*1.0581*v.^2;
wos=(q*C_L);
b=(0.3:.001:0.9);
%weightoverS=5.4625494+.184187668./(b*.05);
weightoverS=4.648581+.1716421./(b*.075);

span=b/.9;
plot(v,wos)
figure;
plot(b,weightoverS)
hold on 
plot(b,span)
%%
m_wing=.0064008+.3952875*sref;
m_fuse=.00193548; %l=.3
%m_fuse=.00225806;%l=.35
m_vert=.00196;
m_hori=.0029196;
S_h=.007299;
syms m_ball;
eqn1=(m_wing*(.4*.075)+m_fuse*(.05)+(1/6)*m_vert+(.176)*m_hori-m_ball*.1)==0;
m_ball=double(solve(eqn1,m_ball));
% m_ball=.012212;
Mto=m_wing+m_fuse+m_vert+m_hori+m_ball;
ws=(Mto*9.81)/sref;
syms x
eqn=(m_wing*.4*.075+m_fuse*(.15-x)+(.26666666-x)*m_vert+(.276-x)*m_hori-m_ball*x)/Mto==0.05*.075;
x=double(solve(eqn,x));
c_t=.06;
V_h=S_h*((.3-.25*c_t)-(x+0.05*.075))/(sref*.075);
S_hneed=.3*(sref*.075)/((.3-.25*c_t)-(x+0.05*.075));
%find vertical stabilizer planform area

%volumes of vertical stab

V_v = 0.02:0.01:0.05;
S_v = (V_v.*(sref*0.9))./((.3-.25*c_t)-(x+0.05*.075));

%%
AirfoilData = [-1.9,-.007,.0214;.16,.218,.0169;2.10,.428,.0186;4.3,.75,.0215;6.34,.905,.0263;8.20,1.017,.0306;10.32,1.067,.0764]; 
Reair=1.0581*5.86*0.075/(1.74*10^(-5));
Winge = .7;
AR = 8;
Wing2dk = 1/(pi*Winge*AR);
Wing2dAoA = AirfoilData(:,1);
Wing2dCl = AirfoilData(:,2);
Wing2dCd = AirfoilData(:,3);
dlod=Wing2dCl./Wing2dCd;
figure
plot(Wing2dAoA,dlod)
figure
plot(Wing2dAoA,Wing2dCl)
hold on
Wing2da0 = (Wing2dCl(4)-Wing2dCl(1))/(Wing2dAoA(4)-Wing2dAoA(1));
Wing2da = Wing2da0/(1+57.3*Wing2dk*Wing2da0);

Wing2dAoAlis0 = lininterp(Wing2dCl(1:2), Wing2dAoA(1:2), 0);

WingCL = Wing2da*(Wing2dAoA-Wing2dAoAlis0);
WingCD = Wing2dCd + WingCL.^2*Wing2dk;
plot(Wing2dAoA,WingCL)
CDMin=(0.074/Reair^(0.2))*(swet/sref);
ArCfte = 1.78*(1-0.045*AR^(0.68))-0.64;
ArCftk = 1/(pi*ArCfte*AR);
MinCDAoA = find(WingCD == min(WingCD));

Wing2dAoA(WingCD == min(WingCD));
CLMinD = Wing2da*(Wing2dAoA(MinCDAoA)-Wing2dAoAlis0);
CLmind=mean(CLMinD);
ParasiteDrag = CDMin+ArCftk*CLmind^2;
InducedDrag = ArCftk*(WingCL).^2-WingCL.*2*ArCftk*CLmind;

CD = ParasiteDrag + InducedDrag;
figure;
plot(WingCL,CD)
LoD=WingCL./CD;
figure;
plot(Wing2dAoA,LoD)
l=LoD(4);
[T, SoS, P, rho] = atmosisa(1500);
[v_R_rangecal, v_R_endurcal,alpha_rangecal,alpha_endcal] = performance(CDMin,ArCftk,rho,CLmind,Wing2dAoA,WingCL,l,ParasiteDrag)
range=8*l
%%
%utilities
function [y] = lininterp(xpts, ypts, x)
%linearly interpolate from data in a table or graph

y = (ypts(2) - ypts(1))/(xpts(2)-xpts(1))*(x-xpts(1)) + ypts(1);


end

function [xcoords, ycoords] = linextrap(leftpts, rightpts)
%linarly extrapolate from data points on a graph
%leftpts - [x1 x2; y1 y2]

leftslope = (leftpts(2,1) - leftpts(2,2))/(leftpts(1,1) - leftpts(1,2));
rightslope = (rightpts(2,1) - rightpts(2,2))/(rightpts(1,1) - rightpts(1,2));

xrange = linspace(leftpts(1,2), rightpts(1,2), 100);

leftline = leftpts(2,2) + (xrange - leftpts(1,2))*leftslope;
rightline = rightpts(2,2) + (xrange - rightpts(1,2))*rightslope;

xcoords = xrange(abs(leftline - rightline) <= .0001);
ycoords = leftline(abs(leftline - rightline) <= .0001);

end