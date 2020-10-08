%Lab 10 Material - signal generation

clear;close all

%want to characterize spectrum to 60 kHz (nyquist freq) so fs = 120 kHz
Fs=120000;
Fn=Fs/2;  
%set the sampling period
t=0:1/Fs:2;
%generate your two signals for 1 second
s1=2.5*cos(2*pi*t*20e3);
s2=2.5*cos(2*pi*t*24.8e3);
%generate the product
x = s1 .* s2;
%generate some plots
figure(1)
orient tall
subplot(321),plot(t(1:150),s1(1:150));grid;axis tight;
title('20kHz Sin');xlabel('time');ylabel('amplitude')
subplot(322),plot(t(1:150),s2(1:150));grid;axis tight;
title('24.8kHz Sin');xlabel('time');ylabel('amplitude')
subplot(3,2,[3 4]),plot(t(1:150),x(1:150));grid;axis tight;
title('Product: 20kHz Sin * 24.8kHz Sin');xlabel('time');ylabel('amplitude')

%compute and display the freq response using the FFT and Matlab app note
% Use next higher power of 2 greater than or equal to 
% length(x) to calculate FFT. 
NFFT= 2^(nextpow2(length(x))); 
% Take fft, padding with zeros so that length(FFTX) is equal to NFFT 
FFTX = fft(x,NFFT); 
% Calculate the numberof unique points 
NumUniquePts = ceil((NFFT+1)/2); 
% FFT is symmetric, throw away second half 
FFTX = FFTX(1:NumUniquePts); 
% Take the magnitude of fft of x 
MX = abs(FFTX); 
% Scale the fft so that it is not a function of the length of x 
MX = MX/length(x); 
% Take the square of the magnitude of fft of x. 
MX = MX.^2; 
% Multiply by 2 because you threw out second half of FFTX above 
MX = MX*2; 
% DC Component should be unique. 
MX(1) = MX(1)/2; 
% Nyquist component should also be unique.
if ~rem(NFFT,2) 
   % Here NFFT is even; therefore,Nyquist point is included. 
   MX(end) = MX(end)/2; 
end 
% This is an evenly spaced frequency vector with NumUniquePts points. 
f = (0:NumUniquePts-1)*Fs/NFFT; 
% Generate the plot, title and labels. 
subplot(325),plot(f,MX);grid;axis tight;
title('Linear Power Spectrum of Product'); xlabel('Frequency (Hz)'); 
ylabel('Power'); 
subplot(326),plot(f,10*log10(MX));grid;axis tight;
title('dB Power Spectrum of Product'); xlabel('Frequency (Hz)'); 
ylabel('Power (dB)'); 

%plot (added)
figure(2)
load('filt1.mat')
freqz(filt1.tf.num, filt1.tf.den, 1000,120e3);
title('Magnitude and Phase Response Plots');
y = filter(filt1.tf.num, filt1.tf.den, x);
%filtered version
figure(3)
%ime domain
subplot(2, 1,1)
t = 1:1:500;
plot(t, y(1:500));
title('Filter in the Time Domain');
xlabel('Time (s)');
ylabel('Magnitude (dB)');
grid on
%frequency domain
%follow same procedure as above to scale
FFTY = fft(y,NFFT)/length(y);
FFTY = 2*FFTY(1:NumUniquePts);
MY = abs(FFTY);
MY = MY/length(y); %scale
subplot(2,1,2)
plot(f, MY);
title('Filter in the Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on

%plot (added)
figure(4)
load('filt4.mat')
freqz(filt4.tf.num, filt4.tf.den, 1000,120e3);
title('Magnitude and Phase Response Plots (order = 32)');
y4 = filter(filt4.tf.num, filt4.tf.den, x);

%plot (added)
figure(5)
load('filt3.mat')
freqz(filt3.tf.num, filt3.tf.den, 1000,120e3);
title('Magnitude and Phase Response Plots (order = 128)');
y5 = filter(filt3.tf.num, filt3.tf.den, x);

%plot each in time domain
%time domain
figure(6)
plot(t, y4(1:500));
title('Filter in the Time Domain (order = 32)');
xlabel('Time (s)');
ylabel('Magnitude (dB)');
grid on

figure(7)
plot(t, y5(1:500));
title('Filter in the Time Domain (order = 128)');
xlabel('Time (s)');
ylabel('Magnitude (dB)');
grid on

