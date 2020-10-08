%% part 2bb

%givens (in experiment)
R = 3300; %Ohms
C1 = 100e-9; %Farrads 
C2 = 1e-9; %Farrads

[w0, Q] = calcSallenKey(R,C1,C2)

%plot
%frequencies
f = 0:60000; %Hz
%angualr frequencies
s = 1i.*(2*pi).*f;
%transfer function
H = (w0^2)./(s.^2 + (w0./Q).*s + w0.^2);
%amplitude
dB = 20*log10(H);
figure(1)
plot(f,dB);
xlabel("Frequency (Hz)");
ylabel("Amplitude (dB)");
title("Calculted Frequency spectrum");
grid on

%% part 2c
%increase C1 and C2 such that Q increases but decrease R such
%that w0 stays constant

C1_new = 16*C1;
R_new = R/4;
[w0_new, Q_new] = calcSallenKey(R_new,C1_new,C2)

%plot
%frequencies
f = 0:60000; %Hz
%angualr frequencies
s = 1i.*(2*pi).*f;
%transfer function
H_new = (w0_new^2)./(s.^2 + (w0_new./Q_new).*s + w0_new.^2);
%amplitude
dB_new = 20*log10(H_new);
figure(2)
subplot(1,2,1)
plot(f,dB);
xlabel("Frequency (Hz)");
ylabel("Amplitude (dB)");
title("Frequency Spectrum (Q=5)");
grid on
subplot(1,2,2)
plot(f,dB_new);
xlabel("Frequency (Hz)");
ylabel("Amplitude (dB)");
title("Frequency Spectrum (Q=20)");
grid on
