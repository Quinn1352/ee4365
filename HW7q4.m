clear
close all
clc

load freq100;

load y_X1_100_10;
load y_Y1_100_10;
load y_X2_100_10;
load y_Y2_100_10;

Nfft = 256;
C = 3E8;

%%%%%%%%%%%%%%%%%%%%%% PROBLEM 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%part a
y_X1_100_10_fft = fft(y_X1_100_10, Nfft);
y_X1_100_10_fft = fftshift(y_X1_100_10_fft);

figure('Name', 'Problem 4, part a, X1');
stem(freq100, abs(y_X1_100_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
y_X1_100_10_fft_peak = 9;

y_Y1_100_10_fft = fft(y_Y1_100_10, Nfft);
y_Y1_100_10_fft = fftshift(y_Y1_100_10_fft);

figure('Name', 'Problem 4, part a, Y1');
stem(freq100, abs(y_Y1_100_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
y_Y1_100_10_fft_peak = 14;

%part b
y_X2_100_10_fft = fft(y_X2_100_10, Nfft);
y_X2_100_10_fft = fftshift(y_X2_100_10_fft);

figure('Name', 'Problem 4, part B, X2');
stem(freq100, abs(y_X2_100_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
y_X2_100_10_fft_peak = 43;

y_Y2_100_10_fft = fft(y_Y2_100_10, Nfft);
y_Y2_100_10_fft = fftshift(y_Y2_100_10_fft);

figure('Name', 'Problem 4, part b, Y2');
stem(freq100, abs(y_Y2_100_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
y_Y2_100_10_fft_peak = -8;

lambda1 = C / y_X1_100_10_fft_peak;
lambda2 = C / y_X2_100_10_fft_peak;

%part c
car1_100_10_fd = (y_Y1_100_10_fft_peak - y_X1_100_10_fft_peak)/2;
car1_100_10_vel = lambda1 * car1_100_10_fd;
%car 1 velocity is 8.33e7 m/s towards transmitter

%part d
car2_100_10_fd = (y_Y2_100_10_fft_peak - y_X2_100_10_fft_peak)/2;
car2_100_10_vel = lambda2 * car2_100_10_fd;
%car 2 velocity is 1.78e8 m/s towards from transmitter



