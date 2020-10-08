function [ X Y Cp Cl V ] = Vortex_Panel(x,y,V_inf,alpha)
% This function perfomes the vortex panel method on a 
% given airfoil.
% 
%     Inputs:
%             1- X: list of x coordinates
%             2- Y: list of y coordinates
%             3- V_inf: free stream velocity
%             4- alpha: AOA
%             
%     Outputs:
%             1- X: x location
%             2- Y: Y location
%             3- Cp: coefficient of pressure
%             4- Cl: coefficient of lift
%
%

XB = x;
YB = y;

m = length(XB)-1;
alpha = deg2rad(alpha);

MP1 = m + 1; 

% S : Length of panel
% Panel 1 will have gamma1, and gamma2, gamma 1 is on right gamma 2 left

CN2 = zeros(m);
CN1 = zeros(m);
CT1 = zeros(m);
CT2 = zeros(m);

for i = 1:m
    % copied from Fortran
    X(i) = 0.5*(XB(i)+XB(i+1));
    Y(i) = 0.5*(YB(i)+YB(i+1));
    S(i) = sqrt( (XB(i+1) - XB(i)).^2 +  (YB(i+1) - YB(i))^2) ;
    Theta(i) = atan2((YB(i+1) - YB(i)),(XB(i+1) - XB(i))) ;
    RHS(i) = sin(Theta(i)-alpha);
    COSINE(i) = cos(Theta(i));
    SINE(i) = sin(Theta(i));
    
end

for i = 1:m
    
    for j = 1:m
       
        if i == j
            
            CN1(i,j) = -1;
            CN2(i,j) = 1;
            CT1(i,j) = pi/2;
            CT2(i,j) = pi/2;
            
        else
            
            A = - (X(i) - XB(j))*COSINE(j) - (Y(i) - YB(j))*SINE(j) ; 
            B = (X(i) - XB(j))^2 + (Y(i)-YB(j))^2 ;
            C = sin ( Theta(i) - Theta(j) );
            D = cos ( Theta(i) - Theta(j) );
            E = (X(i) - XB(j))*SINE(j) - (Y(i) - YB(j))*COSINE(j) ; 
            F = log( 1 +  S(j)*(S(j) + 2*A)/B  );
            G = atan2( E*S(j), B+(A*S(j)) );
            P = ( X(i) - XB(j) ) * sin( Theta(i) - 2.*Theta(j) ) ...
                + ( Y(i) - YB(j) ) * cos( Theta(i) - 2.*Theta(j) );
            
            Q = ( X(i) - XB(j) ) * cos( Theta(i) - 2.*Theta(j) ) ...
                - ( Y(i) - YB(j) ) * sin( Theta(i) - 2.*Theta(j) );
            


            
            CN2(i,j) = D + (0.5*Q*F)/S(j) - (A*C + D*E) *  G / S(j)   ;
            CN1(i,j) = 0.5*D*F + C*G - CN2(i,j) ;
            CT2(i,j) = C + 0.5*P*F/S(j) +  (A*D - C*E) * G / S(j) ;
            CT1(i,j) = 0.5*C*F - D*G - CT2(i,j) ;
            
        end
        
    end
    
    
    
end


% compute influance coefficients in eq 5.47, 5.49 from Kueth and Chow.


for i = 1:m
    
    AN(i,1) = CN1(i,1);
    AN(i,MP1) = CN2(i,m);
    AT(i,1) = CT1(i,1);
    AT(i,MP1) = CT2(i,m);
    
    for j = 2:m
        
        AN(i,j) = CN1(i,j) + CN2(i,j-1);
        AT(i,j) = CT1(i,j) + CT2(i,j-1);  
        
    end  
end

AN(MP1,1) = 1;
AN(MP1,MP1) = 1;


for j = 2:m
    
    AN(MP1,j) = 0;
    
end


RHS(MP1) = 0;


% using cramers rule to solve for the individual gamma strength

gamma = AN\RHS';
for i = 1:m
    V(i) = cos(Theta(i)-alpha);
    for j = 1:MP1 
        V(i) = V(i) + AT(i,j)*gamma(j);
        Cp(i) = 1 - V(i)^2;    
    end
    
    
end

%sum the circulation and use kutta jakowski to calculate lift
for j = 1:m
    
    Circulation(j) = V(j)*S(j);
    
end

Circulation_0 = sum(Circulation);

Cl = ( 2 * Circulation_0 ) / (V_inf*XB(end)) ;


end