function [CL, CD] = calcLift_Drag(p,dynPres_Pitot,atmDen,V,c,alpha)
%this function takes in the x and y positions of ports and the pressures
%correspoding to those locations in a vector. This function calculates and
%returns lift and drag coefficients
%also takes in atmospheric pressure, density, and free stream velocity,
%chord length, and angle of attack

% %normal force
% N = zeros(length(p),1);
% %axial force
% A = zeros(length(p),1);
% 
% C_n = 0;
% C_a = 0;
% 
% for i = 1:length(p)-1
%     delta_x(i,1) = x(i+1) - x(i);
%     delta_y(i,1) = y(i+1) - y(i);
% end
% 
% delta_x = [0; delta_x];
% delta_y = [0; delta_y];
% 
% for i = 1:15
%     N = -0.5*(p(:,i) + p(:,i+1)).*delta_x;
%     A = 0.5*(p(:,i) + p(:,i+1)).*delta_y;
%     %coefficient for normal force
%     C_n = C_n + 0.5.*((p(:,i)-atmP)/(0.5.*atmDen.*V.^2)+(p(:,i+1)-atmP)/(0.5*atmDen.*V.^2)).*(delta_x/c);
%     %coefficient for normal force
%     C_a = C_a + 0.5.*((p(:,i)-atmP)/(0.5.*atmDen.*V.^2)+(p(:,i+1)-atmP)/(0.5.*atmDen.*V.^2)).*(delta_y/c);
% end
% 
% total_N = sum(N);
% total_A = sum(A);
% 
% 
% C_n = -C_n;
% 
% %lift coefficient
% C_l = C_n*cosd(alpha) - C_a*sind(alpha);
% %drag coefficient 
% C_d = C_n*sind(alpha) - C_a*cosd(alpha);

Q_inf = (0.5.*((V).^2).*atmDen);
CP = (p)./Q_inf;


Local_Vel = sqrt(((V).^2).*(-CP +1));

x_pos = [0 0.175 0.35 0.7 1.05 1.4 1.75 2.1 2.8 2.8 2.1 1.4 1.05 0.7 0.35 0.175];

x_pos = convlength(x_pos, 'in', 'm');

y_pos = [0.14665 0.33075 0.4018 0.476 0.49 0.4774 0.4403 0.38325 0.21875 0 0 0 0 0.0014 0.0175 0.03885];

y_pos = convlength(y_pos, 'in', 'm');

C = convlength(3.5, 'in', 'm');

for i = 1:15 
    Delta_x(i) = x_pos(i+1) - x_pos(i);
    Delta_y(i) = y_pos(i+1) - y_pos(i);
end 
% Delta_x = Delta_x';
% Delta_y = Delta_y';


CA = 0; 
CN = 0;

for i = 1:15
    
    CN = CN + 0.5*((CP(:,i) + CP(:,i+1)).*((Delta_x(i))/c));
    CA = CA + 0.5*((CP(:,i) + CP(:,i+1)).*((Delta_y(i))/c));
end

CN = -CN;

CL = CN.*cosd(alpha) - CA.*sind(alpha);
CD = CN.*sind(alpha) + CA.*cosd(alpha);



end