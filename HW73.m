clear
close all
clc

load freq100;
load freq200;

load y_X1_100_1;
load y_Y1_100_1;
load y_X2_100_1;
load y_Y2_100_1;

Nfft = 256;
C = 3E8;

%%%%%%%%%%%%%%%%%%%%%% PROBLEM 3 %%%%%%%%%%%%%%%%%%%%%%%%%%
%part a
y_X1_100_1_fft = fft(y_X1_100_1, Nfft);
y_X1_100_1_fft = fftshift(y_X1_100_1_fft);

figure('Name', 'Problem 3, part a, X1');
stem(freq100, abs(y_X1_100_1_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 40Hz
y_X1_100_1_fft_peak = 40;

y_Y1_100_1_fft = fft(y_Y1_100_1, Nfft);
y_Y1_100_1_fft = fftshift(y_Y1_100_1_fft);

figure('Name', 'Problem 3, part a, Y1');
stem(freq100, abs(y_Y1_100_1_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 60Hz
y_Y1_100_1_fft_peak = -40;

%part b
y_X2_100_1_fft = fft(y_X2_100_1, Nfft);
y_X2_100_1_fft = fftshift(y_X2_100_1_fft);

figure('Name', 'Problem 3, part B, X2');
stem(freq100, abs(y_X2_100_1_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 40Hz
y_X2_100_1_fft_peak = 40;

y_Y2_100_1_fft = fft(y_Y2_100_1, Nfft);
y_Y2_100_1_fft = fftshift(y_Y2_100_1_fft);

figure('Name', 'Problem 3, part b, Y2');
stem(freq100, abs(y_Y2_100_1_fft));
xlabel('freq (Hz)')
ylabel('Amplitude')
%peak freq = 10Hz
y_Y2_100_1_fft_peak = 10;

lambda1 = C / y_X1_100_1_fft_peak;
lambda2 = C / y_X2_100_1_fft_peak;

%part c
car1_100_1_fd = (y_Y1_100_1_fft_peak - y_X1_100_1_fft_peak)/2;
car1_100_1_vel = lambda1 * car1_100_1_fd;
%car 1 velocity is 3e8 m/s away from transmitter

%part d
car2_100_1_fd = (y_Y2_100_1_fft_peak - y_X2_100_1_fft_peak)/2;
car2_100_1_vel = lambda1 * car2_100_1_fd;
%car 2 velocity is 1.125e8 m/s away from transmitter



