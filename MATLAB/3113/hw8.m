%Homework 8, Problem 21.21

%sun temp
T_s = 5789; %K

%wavelength range
lamda = 0.01:0.01:1000; %micrometers

%constants
C1 = 3.74177e8; %W/um^4/^2
C2 = 1.43878e4; %umK

E_b = C1./((lamda.^5).*(exp(C2./(lamda.*T_s))-1));

%plot
figure(1)
plot(lamda, E_b);
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
ylim([1e-4 1e8]);
xlabel('wavelengths (micrometers)');
ylabel('E_{b.lamda}');
title('Spectral Blackbody Emissivity Power of Sun vs Wavelength');
