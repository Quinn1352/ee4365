clear
close all
clc

PtW = 30; %W
Pt = 10*log10(PtW / 10e-3);
fc = 1.4e9; 
c = 3e8;
lambda = c/fc;
Gt = 1;
Gr = 8;
gamma_thresh = -85; %dbm
PL_dropAfter = Pt - gamma_thresh;
d0 = 2;
d_start = 1;
vmph = 40;
vkph = vmph * 1.60934;
vkpm = vkph / 60;

xafterd0 = 2:0.1:10; %distance vector
xbefored0 = 0:0.1:2;

PLd0 = -10*log10((Gt * Gr * lambda^2)/(((4*pi)^2)*(d0*1000)^2));
PL_afterd0 = PLd0 + 40 * log10(xafterd0 / d0);
PL_befored0 = PLd0 + 20*log10(xbefored0 / d0);

y = ones(102, 1);
threshold = PL_dropAfter * y;

x = [xbefored0, xafterd0];
PL = [PL_befored0, PL_afterd0];

figure('Name', 'Problem 2 Question 1')
plot(x, PL)
hold on
grid on
plot(x, threshold)
title('Pathloss')
xlabel('Distance from transmitter (km)')
ylabel('Pathloss (dB)')
%from figure: signal dropped after 9.7km

t = 0:1:300;
d = 1 + vkpm * t;
figure('Name', 'Problem 2 Question 1')
