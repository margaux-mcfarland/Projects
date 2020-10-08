function error = generalMethod(diffPres,sig_diffPres, atmosphPres, sig_atmosphPres, atmosphTemp, sig_atmosphTemp,method,V)
%calculates error in air speed using general method
%calculates error for either the venturi tube method or the pitot-static
%probe method 
    % R value for air 
    R = 0.2871*1000; %J/kg/K
    areaRatio = 1/9.5;
   if(method == 1) %Venturi Tube
       %V = sqrt((2*diffPres*R*atmosphTemp)/(atmosphPres*(1-(A2/A1)^2)))
       %assume no uncertainty in R or area
       
       %partial derivatives
       if diffPres == 0
           d_diffPres = 0; %so we don't divide by zero
       else
           d_diffPres = (1/2)*sqrt((2*R*atmosphTemp)/(diffPres*atmosphPres*(1-(areaRatio)^2)));
       end
       d_atmosphPres = -(1/2)*sqrt((2*diffPres*R*atmosphTemp)/(atmosphPres^3*(1-(areaRatio)^2)));
       d_atmosphTemp = (1/2)*sqrt((2*diffPres*R)/(atmosphPres*atmosphTemp*(1-(areaRatio)^2)));
     
   else %Pitot-Static Probe
       %V = sqrt(2*diffPres*((R*atmosphTemp)/atmosphPres))
       %assume no uncertainty in R
       
       %partial derivatives
       d_diffPres = (R*atmosphTemp/atmosphPres)*(1/(sqrt((2*R*atmosphTemp*diffPres)/(atmosphPres))));
       d_atmosphPres = (-diffPres*R*atmosphTemp/(atmosphPres^2))*(1/(sqrt((2*R*atmosphTemp*diffPres)/(atmosphPres))));
       d_atmosphTemp = (diffPres*R/atmosphPres)*(1/(sqrt((2*R*atmosphTemp*diffPres)/(atmosphPres))));
      
   end
   
   error = sqrt((d_diffPres*sig_diffPres)^2+(d_atmosphPres*sig_atmosphPres)^2+(d_atmosphTemp*sig_atmosphTemp)^2);


end