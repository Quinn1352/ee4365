clear
close all
clc

load freq200;

load y_X1_200_10;
load y_Y1_200_10;
load y_X2_200_10;
load y_Y2_200_10;

Nfft = 256;
C = 3E8;

%%%%%%%%%%%%%%%%%%%%%% PROBLEM 2 %%%%%%%%%%%%%%%%%%%%%%%%%%
%part a
y_X1_200_10_fft = fft(y_X1_200_10, Nfft);
y_X1_200_10_fft = fftshift(y_X1_200_10_fft);

figure('Name', 'Problem 2, part a, X1');
stem(freq200, abs(y_X1_200_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 40Hz
y_X1_200_10_fft_peak = 60;

y_Y1_200_10_fft = fft(y_Y1_200_10, Nfft);
y_Y1_200_10_fft = fftshift(y_Y1_200_10_fft);

figure('Name', 'Problem 2, part a, Y1');
stem(freq200, abs(y_Y1_200_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 60Hz
y_Y1_200_10_fft_peak = 62;

%part b
y_X2_200_10_fft = fft(y_X2_200_10, Nfft);
y_X2_200_10_fft = fftshift(y_X2_200_10_fft);

figure('Name', 'Problem 2, part B, X2');
stem(freq200, abs(y_X2_200_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 40Hz
y_X2_200_10_fft_peak = -64;

y_Y2_200_10_fft = fft(y_Y2_200_10, Nfft);
y_Y2_200_10_fft = fftshift(y_Y2_200_10_fft);

figure('Name', 'Problem 2, part b, Y2');
stem(freq200, abs(y_Y2_200_10_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 10Hz
y_Y2_200_10_fft_peak = 21;

lambda1 = C / y_X1_200_10_fft_peak;
lambda2 = C / y_X2_200_10_fft_peak;

%part c
car1_200_10_fd = (y_Y1_200_10_fft_peak - y_X1_200_10_fft_peak)/2;
car1_200_10_vel = lambda2 * car1_200_10_fd;
%car 1 velocity is 4.68e6 m/s away from transmitter

%part d
car2_200_10_fd = (y_Y2_200_10_fft_peak - y_X2_200_10_fft_peak)/2;
car2_200_10_vel = lambda2 * car2_200_10_fd;
%car 2 velocity is 1.99e8 m/s away from transmitter


