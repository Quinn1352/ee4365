clc
close all
clear

load freq100
load freq200

load y11
load y12
load y21
load y22
load y31
load y32

Nfft = 256;

%%%%%%%%%%%%%% PROBLEM 1 %%%%%%%%%%%%%%%%%

%problem 1, part 1a
y11_fft = fft(y11, Nfft);
y11_fft = fftshift(y11_fft);

figure('Name', 'Problem 1, part 1a');
stem(freq200, abs(y11_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')

%problem 1, part 1b
y12_fft = fft(y12, Nfft);
y12_fft = fftshift(y12_fft);

figure('Name', 'Problem 1, part 1b');
stem(freq200, abs(y12_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')

%problem 1, part 2
y13 = y11 + y12;
y13_fft = fft(y13, Nfft);
y13_fft = fftshift(y13_fft);

figure('Name', 'Problem 1, part 2');
stem(freq200, abs(y12_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')

%problem 1, part 3
% while it appears that the frequency doesn't change when plotting y3, 
% this is just because the sampling frequency is too small. The frequency 
% of y11 + y12 should be the LCM of their respective frequencies, which is
%LCM(30, 50) = 150. Since the sampling frequency is 200, the max freqency
%that could be found by the fft is 100, so the peak appears at frequency
%50 because 150 mod 100 is 50.


%%%%%%%%%%%%%% PROBLEM 2 %%%%%%%%%%%%%%%%%

%problem 2 part 1a
y21_fft = fft(y21, Nfft);
y21_fft = fftshift(y21_fft);
figure('Name', 'Problem 2, part 1a');
stem(freq100, abs(y21_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')

%problem 2 part 1b
y22_fft = fft(y22, Nfft);
y22_fft = fftshift(y22_fft);
figure('Name', 'Problem 2, part 1b');
stem(freq200, abs(y22_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')

%problem 2 part 2
%you cannot correctly determine the frequencies of the signals from teh fft
%plots. This is because the fft plot will show a peak at the signal
%frequency modulo (sampling frequency/2). Thus, if sampling frequency is
%over two times the signal frequency, it will be represented on the the
%plot; however, if it isn't, then it will return a different value.



%%%%%%%%%%%%%% PROBLEM 3 %%%%%%%%%%%%%%%%%

%problem 3 part 1a
y31_fft = fft(y31, Nfft);
y31_fft = fftshift(y31_fft);
figure('Name', 'Problem 3, part 1a');
stem(freq200, abs(y31_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')

%problem 3 part 1b
y32_fft = fft(y32, Nfft);
y32_fft = fftshift(y32_fft);
figure('Name', 'Problem 3, part 1b');
stem(freq200, abs(y32_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')

%problem 3 part 2
%you can determine the frequency of the signal that has gaussian noise with
%standard deviation 1 because the peak frequency has a much larger
%amplitude than any of the added noise (in other words, the signal to noise
%ratio is high enough that the signal is distinguishable from the noise).
%However, for the plot with gaussian noise with standard deviation of 10,
%the peak is no longer recognizable because the noise overshadows the
%signal amplitude (in other words, the SNR is too low to distinguish the
%signal from the noise).