 %% info:
%{
 
 
 Author: Brendan Palmer
 Collaborators: Abdullah Alameri, Abdullah Almugairin

%}


 tic



%% housekeeping

clear
clc
close all
addpath('./Scripts');
[x, y] = NACA_Airfoils(0,0,(12/100),1,6);
[x1, y1] = NACA_Airfoils(2/100,4/10,12/100,1,6);
[x2, y2] = NACA_Airfoils(4/100,4/10,12/100,1,6);

figure(1);
subplot(2,1,1)
sgtitle('Panel Approximation for NACA 2412 and NACA 0012')
plot(x1,y1,'-*');
axis equal
subplot(2,1,2)
plot(x,y,'-*');
axis equal

axis equal

%% solve for Cp
V_inf = 1;
alpha = 8;
[x1, y1, Cp, Cl] = Vortex_Panel(x1,y1,V_inf,alpha);
[x,y,Cp1,Cl1] = Vortex_Panel(x,y,V_inf,alpha);

%% Plot Cp for airfoils

figure(2);
plot(x1,-Cp)
title('Coefficient of Pressure vs x location for NACA 2412 Airfoil')
xlabel('x location (m)')
ylabel('-Cp')

figure(3)
plot(x,-Cp1)
title('Coefficient of Pressure vs x location for NACA 0012 Airfoil')
xlabel('x location (m)')
ylabel('-Cp')

%% Question 2
fprintf('%%%%%%%%%%   Question 2   %%%%%%%%%% \n \n')
N = 2:2:300 ; % different N values, even values
alpha = 0; %AOA
V_inf = 1;
[ x_0012 y_0012 ] = NACA_Airfoils(0,0,(12/100),1,1000/2);
[x y Cp_exact Cl_exact V_exact] = Vortex_Panel(x_0012,y_0012,V_inf,alpha);
V_exact = V_exact.^2;
for i = 1:length(N)
    % run vortex panel method and for different NACA airfoils
    [ x_0012 y_0012 ] = NACA_Airfoils(0,0,(12/100),1,N(i)/2);
    [x y Cp Cl V] = Vortex_Panel(x_0012,y_0012,V_inf,alpha);


    % store results for different N values.
    NACA_0012_N(i,1) = abs((mean(abs(Cp_exact))-mean(abs(Cp)))/mean(abs(Cp_exact))); % relative error coefficient of pressure
    NACA_0012_N(i,2) = abs((mean(V_exact)-mean(V.^2))/mean(V_exact)); % error coefficient of lift
    NACA_0012_N(i,3) = N(i)'; %panels

    
end
save('NACA_0012_N.mat', 'NACA_0012_N');
% col 1: Cp relative error
% col 2: Cl relative error
% col 3: Panels.


load('NACA_0012_N.mat'); % Load results from analysis already saved to save time

table(NACA_0012_N(1:end,3),NACA_0012_N(1:end,2),NACA_0012_N(1:end,1),...
  'VariableNames',{'Panels','V_Rel_Error','Cp_Rel_Error'})

err = 0.05;
fprintf(['N = ' num2str(NACA_0012_N(find(NACA_0012_N(2:end,1)<err,1)+1,3)) ' for a relative mean Cp error of less than ' num2str(err*100) '%%' ]);
fprintf('\n')
fprintf(['N = ' num2str(NACA_0012_N(find(NACA_0012_N(2:end,2)<err,1)+1,3)) ' for a relative mean V error of less than ' num2str(err*100) '%%' ]);
fprintf('\n')
fprintf('\n')

err = 0.01;
fprintf(['N = ' num2str(NACA_0012_N(find(NACA_0012_N(2:end,1)<err,1)+1,3)) ' for a relative mean Cp error of less than ' num2str(err*100) '%%' ]);
fprintf('\n')
fprintf(['N = ' num2str(NACA_0012_N(find(NACA_0012_N(2:end,2)<err,1)+1,3)) ' for a relative mean V error of less than ' num2str(err*100) '%%' ]);
fprintf('\n')
fprintf('\n')


err = 0.005;
fprintf(['N = ' num2str(NACA_0012_N(find(NACA_0012_N(2:end,1)<err,1)+1,3)) ' for a relative mean Cp error of less than ' num2str(err*100) '%%' ]);
fprintf('\n')
fprintf(['N = ' num2str(NACA_0012_N(find(NACA_0012_N(2:end,2)<err,1)+1,3)) ' for a relative mean V error of less than ' num2str(err*100) '%%' ]);
fprintf('\n')
fprintf('\n')



figure(4)
plot(NACA_0012_N(2:end,3),NACA_0012_N(2:end,1))
title('Relative Error for Cp and V vs Number of Panels');
xlabel('Number of Panels')
ylabel('Relative Error')
hold on
plot(NACA_0012_N(2:end,3),NACA_0012_N(2:end,2))
legend('Cp','V')
N = 130; %number of panels determined in part 1 Q2
%varying alpha values
alpha = -5:5:10;

for j = 1:length(alpha)
    
    [ x y ] = NACA_Airfoils(0,0,(12/100),1,N/2);
    [x y Cp Cl V] = Vortex_Panel(x,y,V_inf,alpha(j));

    Cl_AOA(1,j) = Cl;
    Cp_AOA(:,j) = Cp;
    X_AOA(:,j) = x;

    figure(6)
    subplot(2,2,j)
    plot(x,-Cp)
    title(['NACA 0012 \alpha = ' num2str(alpha(j)) char(176)]);
    xlabel('x')
    ylabel('-Cp')
    hold on

end

hold off
sgtitle(['Coefficient of Pressure for NACA 0012 Airfoil, V_\infty = ' num2str(V_inf) ' m/s, N = ' num2str(N) ]);

figure(7)
plot(alpha,Cl_AOA)
title(['Coefficient of Lift vs AOA for NACA 0012 Airfoil, V_\infty = ' num2str(V_inf) ' m/s, N = ' num2str(N) ]);
xlabel('x')
ylabel('Cl')

table([-5;0;5;10],round(Cl_AOA(:),3),...
  'VariableNames',{'alpha_degrees','Cl'})
%% Question 3
fprintf('%%%%%%%%%%   Question 3   %%%%%%%%%% \n \n')
alpha = -4:2:20; % AOA's wanted
N = 100;

for j = 1:length(alpha)
    
% NACA0012
[ x_0012 y_0012 ] = NACA_Airfoils(0,0,(12/100),1,N/2);
[x y Cp Cl V] = Vortex_Panel(x_0012,y_0012,V_inf,alpha(j));
Cl_different_AOA_0012(j) = Cl;
Cp_different_AOA_0012(:,j) = Cp;
X_different_AOA_0012(:,j) = x;

% NACA2412
[ x_2412 y_2412 ] = NACA_Airfoils(2/100,4/10,(12/100),1,N/2);
[x y Cp Cl V] = Vortex_Panel(x_2412,y_2412,V_inf,alpha(j));
Cl_different_AOA_2412(j) = Cl;
Cp_different_AOA_2412(:,j) = Cp;
X_different_AOA_2412(:,j) = x;

% NACA4412
[ x_4412 y_4412 ] = NACA_Airfoils(4/100,4/10,(12/100),1,N/2);
[x y Cp Cl V] = Vortex_Panel(x_4412,y_4412,V_inf,alpha(j));
Cl_different_AOA_4412(j) = Cl;
Cp_different_AOA_4412(:,j) = Cp;
X_different_AOA_4412(:,j) = x;


% NACA2424
[ x_2424 y_2424 ] = NACA_Airfoils(2/100,4/10,(24/100),1,N/2);
[x y Cp Cl V] = Vortex_Panel(x_2424,y_2424,V_inf,alpha(j));
Cl_different_AOA_2424(j) = Cl;
Cp_different_AOA_2424(:,j) = Cp;
X_different_AOA_2424(:,j) = x;



end

% plot results
figure(8)
subplot(2,2,1)
plot(alpha,Cl_different_AOA_0012)
title('Cl vs AOA for NACA 0012');
xlabel('\alpha (degrees)')
ylabel('Cl')


subplot(2,2,2)
plot(alpha,Cl_different_AOA_2412)
title('Cl vs AOA for NACA 2412');
xlabel('\alpha (degrees)')
ylabel('Cl')


subplot(2,2,3)
plot(alpha,Cl_different_AOA_4412)
title('Cl vs AOA for NACA 4412');
xlabel('\alpha (degrees)')
ylabel('Cl')


subplot(2,2,4)
plot(alpha,Cl_different_AOA_2424)
title('Cl vs AOA for NACA 2424');
xlabel('\alpha (degrees)')
ylabel('Cl')

figure(9)
plot(alpha,Cl_different_AOA_0012)
save 'Cl_different_AOA_0012' 'Cl_different_AOA_0012'
hold on
plot(alpha,Cl_different_AOA_2412)
plot(alpha,Cl_different_AOA_4412)
plot(alpha,Cl_different_AOA_2424)
hold off
title('Cl vs AOA for Four Airfoils');
xlabel('\alpha (degrees)')
ylabel('Cl')
legend('NACA 0012','NACA 2412','NACA 4412','NACA 2424')
% estimate AOA L = 0, and lift slope

%NACA 0012
[xData, yData] = prepareCurveData( deg2rad(alpha), Cl_different_AOA_0012 );
% Set up fittype and options
ft = fittype( 'poly1' );
% Fit model to data
[fitresult, gof] = fit( xData, yData, ft );
a_0012 = fitresult.p1; % slope
alpha_L0_0012 = fzero(fitresult,0); % AOA lift = 0


%NACA 2412
[xData, yData] = prepareCurveData( deg2rad(alpha), Cl_different_AOA_2412 );
% Set up fittype and options
ft = fittype( 'poly1' );
% Fit model to data
[fitresult, gof] = fit( xData, yData, ft );
a_2412 = fitresult.p1; % slope
alpha_L0_2412 = fzero(fitresult,0); % AOA lift = 0



%NACA 4412
[xData, yData] = prepareCurveData( deg2rad(alpha), Cl_different_AOA_4412 );
% Set up fittype and options
ft = fittype( 'poly1' );
% Fit model to data
[fitresult, gof] = fit( xData, yData, ft );
a_4412 = fitresult.p1; % slopoe
alpha_L0_4412 = fzero(fitresult,0); % AOA lift = 0


%NACA 2424
[xData, yData] = prepareCurveData( deg2rad(alpha), Cl_different_AOA_2424 );
% Set up fittype and options
ft = fittype( 'poly1' );
% Fit model to data
[fitresult, gof] = fit( xData, yData, ft );
a2424 = fitresult.p1; % slope
alpha_L0_2424 = fzero(fitresult,0); % AOA lift = 0


a = [ round(a_0012,2) ; round(a_2412,2); round(a_4412,2) ; round(a2424,2)];
alpha_L0 = [ round(alpha_L0_0012*(180/pi),2) ; round(alpha_L0_2412*(180/pi),2) ; round(alpha_L0_4412*(180/pi),2) ; round(alpha_L0_2424*(180/pi),2)  ];

LiftSlopeThin = round(2*pi.*ones(4,1),2);
ThinL0 = zeros(4,1);
fprintf('\n')
fprintf('Zero Lift angles of attack and lift slope for 4 airfoils')

%calculate the zero lift angle of attack using thin airfoil theory
%camber equation for NACA 4 series airfoil
dyc1 = @(theta,m,p) (2.*m./(p.^2).*(p-(1-cos(theta))./2)).*(cos(theta)-1);
dyc2 = @(theta,m,p) (2.*m / (1-p).^2 * (p - (1-cos(theta))./2)) .*(cos(theta)-1);
%integration bound for change of variables
bound = @(p) acos(1-2.*p);
%integrate piecewise
aL0 = @(m,p) -1/pi * (integral(@(theta)dyc1(theta,m,p),0,bound(p)) + integral(@(theta) dyc2(theta,m,p),bound(p),pi));
%solve for all 4 airfoils
ThinL0(2) = round(rad2deg(aL0(2/100,4/10)),2);
ThinL0(3) = round(rad2deg(aL0(4/100,4/10)),2);
ThinL0(4) = round(rad2deg(aL0(2/100,4/10)),2);

table(a,alpha_L0,LiftSlopeThin,ThinL0,...
  'RowNames',{'NACA_0012','NACA_2412','NACA_4412','NACA_2424',},'VariableNames',{'Lift_Slope','Zero_Lift_AOA_degrees','Lift_Slope_Thin_Airfoil','Zero_Lift_AOA_degrees_Thin_Airfoil'})
%% Functions Called 
% The following functions were built and called as part of this assignment.
% 
% <include>Vortex_Panel.m</include>
%
% <include>NACA_Airfoils.m</include>