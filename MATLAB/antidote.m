% Assign parameter values
alpha = 0.00002; beta = 0.00003; gamma = 0.000025; N0 = 60000; 
%rate at which pathogen kills zombies
k = 0.32;
%4 pathogens created in 5 days 
pathogenBirthRate = (log(4)/5);


% Set length of simulation
tspan = [0 35];
% Set initial conditions
y0 = [59999; 1];
% Solve system
[t,y] = ode45(@(t,y) szr(t,y,alpha,beta,gamma,N0,k,pathogenBirthRate), tspan, y0);



%plot S(t) and Z(t) and R(t)
figure
plot(t,y(:,1),t,y(:,2),t,N0-y(:,1)-y(:,2));
ylabel('Population');
xlabel('Time (days)');
title('Population of Susceptibles and Zombies with Anti-Zombie Pathogen');
legend('Susceptibles','Zombies','Removed');
hold;








