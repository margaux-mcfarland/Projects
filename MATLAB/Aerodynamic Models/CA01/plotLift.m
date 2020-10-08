function [] = plotLift(a, b, p, q, d, n)
%This function plots lift and drag versus the number of panels used for
%simpsons rule. Takes in the upper and lower bounds, free stream pressure,
%dynamic pressure, diameter, and total number of panels.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 9/13/19

N = 4:n;

for i = N
    theta = a:b/(i*2):b;
    c_p = 1 - 4.*(sin(theta)).^2; %coefficient of pressure
    P = q*c_p + p; %solve for pressure 
    lift_func = -P.*sin(theta).*(d/2);
    drag_func = P.*cos(theta).*(d/2);
    %lift and drag vectors for each number of panels
    Lift(i-3) = simpRule(lift_func, a, b, i, theta);
    Drag(i-3) = simpRule(drag_func, a, b, i, theta);
end
%plot lift
figure(1)
plot(N, Lift);
grid on
xlabel("Number of Panels");
ylabel("Lift (N)");
title("Lift vs Number of Panels");
hold on
yline(0);
%plot drag
figure(2);
plot(N, Drag);
grid on
xlabel("Number of Panels");
ylabel("Drag (N)");
title("Drag vs Number of Panels");
hold on
yline(0);

end