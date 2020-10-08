%%this script calculates lift and drag for the whole sections data and
%%plots the results


%chord length
c = 0.0889;

%initializee 
lift_co = 0;
drag_co = 0;
angles = 0;

L = 0;

data = combineData();

for i = 1:length(data)
   x = (data{:,i}.xDist)./1000;
   y = (data{:,i}.yDist)./1000;
   p = data{:,i}.portPres;
   dynP = data{:,i}.DynPres_Pitot;
   atmP = data{:,i}.AtmP;
   atmDen = data{:,i}.AtmDensity;
   V = data{:,i}.AirSpeed;
   alpha = data{:,i}.Angle;
   
   [C_l,C_d] = calcLift_Drag(p,dynP,atmDen,V,c,alpha);
   
   %three different velocities are 9, 17, and 34 m/s
   
   %vector of lift coefficients
   lift_co = [lift_co; C_l];
        
   drag_co = [drag_co; C_d];
   %vector of angles
   angles = [angles; alpha];
   
   %lift
   l = 0.5.*C_l.*atmDen.*(V.^2).*c;
   %lift vector
   L = [L;l]; 
end

% [sortedAngles, previousIndex] = sort(angles,'ascend');
% for i = 1:length(L)
%     for j = 1:length(previousIndex)
%         if previousIndex(j) == i
%        
%             sortedL(i) = L(j);
%         end
%     end
% end

%sort different velocities
lift_co1 = 0;
lift_co2 = 0;
lift_co3 = 0;
drag_co1 = 0;
drag_co2 = 0;
drag_co3 = 0;
angles1 = 0;
angles2 = 0;
angles3 = 0;
 %three different velocities are 9, 17, and 34 m/s
 for i = 1:length(data)
     V = data{:,i}.AirSpeed;
     alpha = data{:,i}.Angle;
     if i == 1
         index = 0;
     else
         index = index + length(V);
     end
     for j = 1:length(V)
         if V(j) < 13
             lift_co1 = [lift_co1; lift_co(index + j)];
             drag_co1 = [drag_co1; drag_co(index + j)];
             angles1 = [angles1; angles(index + j)];
         elseif V(j) < 27
             lift_co2 = [lift_co2; lift_co(index + j)];
             drag_co2 = [drag_co2; drag_co(index + j)];
             angles2 = [angles2; angles(index + j)];
         else
             lift_co3 = [lift_co3; lift_co(index + j)];
             drag_co3 = [drag_co3; drag_co(index + j)];
             angles3 = [angles3; angles(index + j)];
         end
     end
 end
 
drag_co1 = drag_co1(2:end);
drag_co2 = drag_co2(2:end);
drag_co3 = drag_co3(2:end);
lift_co1 = lift_co1(2:end);
lift_co2 = lift_co2(2:end);
lift_co3 = lift_co3(2:end);
angles1 = angles1(2:end);
angles2 = angles2(2:end);
angles3 = angles3(2:end);
%plot lift vs angle of attack       
figure(1);
scatter(angles1, lift_co1);
hold on;
scatter(angles2, lift_co2);
hold on;
scatter(angles3, lift_co3);
title('Lift Coefficient vs Angle of Attack at varying Airspeeds');
xlabel('Angle of Attack (degrees)');
ylabel('Lift Coefficient');
legend('Airspeed = 9 m/s', 'Airspeed = 17 m/s', 'Airspeed = 34 m/s','Location','northwest');

figure(2);
scatter(angles1,drag_co1); 
hold on
scatter(angles2,drag_co2); 
hold on
scatter(angles3,drag_co3); 
title('Drag Coefficient vs Angle of Attack at varying Airspeeds');
xlabel('Angle of Attack (degrees)');
ylabel('Drag Coefficient');
legend('Airspeed = 9 m/s', 'Airspeed = 17 m/s', 'Airspeed = 34 m/s','Location','northwest');

figure(3)
scatter(lift_co,drag_co);
title('Drag Coefficient vs Lift Coefficient');
xlabel('Lift Coefficient');
ylabel('Drag Coefficient');



