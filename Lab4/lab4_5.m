close all
clear all
[sampled_data, sample_rate] = audioread('/corrupted_voice.wav');
Fs = sample_rate;            % Sampling frequency                    
T = 1/Fs;             % Sampling period  
t = (0:numel(sampled_data) - 1)/Fs;
L = length(sampled_data); % Length of signal

y = fft(sampled_data);
% y = fftshift(fft(sampled_data));
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
f1 = figure;
plot(f,P1) 
title('Magnitude')

fcutlow=1000;   %low cut frequency in Hz
fcuthigh=2000;   %high cut frequency in Hz
order=6;   %order of filter
[b,a]=butter(order,[fcutlow,fcuthigh]/(Fs/2),'bandpass');
filtered = filter(b,a,sampled_data);
P3 = abs(filtered/L);
P4 = P3(1:L/2+1);
P4(2:end-1) = 2*P4(2:end-1);
f = Fs*(0:(L/2))/L;
f2 = figure;
figure(f2)
plot(f,P4) 
title('filter')
audiowrite('filterd.wav',filtered,Fs);
[filtered,Fs] = audioread('filterd.wav');
sound(filtered,Fs);
