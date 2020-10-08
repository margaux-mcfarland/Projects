%matlab modulation portion of lab

%load in data
load asen3300mod

%create time scale
t = linspace(0,2,length(signal));
%% part a
%plot signal in time domain
figure(1)
plot(t(1:501),signal(1:501))
title('Modulated Signal vs Time')
xlabel('Time [s]')
ylabel('Amplitude [dB]')

%plot signal in frequency domain
f = fs/2*linspace(0, 1, length(signal)); x = fft(signal);
shiftx = fftshift(x);
figure(2)
plot(f,abs(shiftx))
title('Modulated Signal vs Frequency')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%% part b
%demodulate signals
signal_AMdemod = demod(signal,fc,fs,'am'); 
signal_FMdemod = demod(signal,fc,fs,'fm');
%test both demodulated signals to see what modulation type it is
sound(signal_AMdemod,fs) 
pause(7) 
sound(signal_FMdemod,fs) %FM is the correct type 

%% part c
%plot demodulated signal in time and frequency domain

figure(3)
plot(signal_FMdemod);
xlabel('Time [s]')
ylabel('Amplitude [V]')
title('FM Demodulated Signal vs Time')

x = fft(signal_FMdemod);
shiftx = fftshift(x);
f = fs/2*linspace(0, 1, length(signal_FMdemod));
figure(4)
plot(f,abs(shiftx))
title('FM Demodulated Singal vs Frequency')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%% part d (noisy)

%load in data
load asen3300mod_noisy

%plot signal in time domain
figure(5)
hold on
plot(t(1:501),signalnoisy(1:501))
title('Modulated Noisy Signal vs Time')
xlabel('Time [s]')
ylabel('Amplitude [dB]')

%plot signal in frequency domain
f = fs/2*linspace(0, 1, length(signalnoisy)); x = fft(signalnoisy);
shiftx = fftshift(x);
figure(6)
plot(f,abs(shiftx))
title('Modulated Noisy Signal vs Frequency')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%demodulate signals
signal_AMdemod = demod(signalnoisy,fc,fs,'am'); 
signal_FMdemod = demod(signalnoisy,fc,fs,'fm');
%test both demodulated signals to see what modulation type it is
sound(signal_AMdemod,fs) 
pause(7) 
sound(signal_FMdemod,fs) %FM is the correct type 

%plot demodulated signal in time and frequency domain

figure(7)
plot(signal_FMdemod);
xlabel('Time [s]')
ylabel('Amplitude [V]')
title('FM Demodulated Noisy Signal vs Time')

x = fft(signal_FMdemod);
shiftx = fftshift(x);
f = fs/2*linspace(0, 1, length(signal_FMdemod));
figure(8)
plot(f,abs(shiftx))
title('FM Demodulated Noisy Singal vs Frequency')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')


