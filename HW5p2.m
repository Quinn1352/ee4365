clc
close all
clear

%variables and set up
vKmHr = 64.37;
pt = 30;
Gt = 1;
Gr = 8;
f = 1.4e9;
c = 3e8;
lambda = c/f;
dStartKm = 3;
dFinishKm = 5;
pDrop = -85;

dStart = dStartKm * 1000;
dFinish = dFinishKm * 1000;

v = vKmHr * 1000 / 3600;
tTot = ((dFinishKm - dStartKm) / vKmHr) * 3600;

%p2a
d = linspace(dStart, dFinish, 10000);

PrdW = (pt * Gt * Gr * (lambda ^ 2)) ./ ((4 * pi)^2 * d.^2);
PrddB = 10 * log10(PrdW);
dDropped =  (lambda / (4 * pi) ) * sqrt( (pt * Gt * Gr) / (10^(pDrop / 10)) );
%dDropped = 4697.7m

figure('Name', 'Problem 2a')
loglog(d, PrddB);
grid on
title('Power Received vs Distance for LOS Model')
xlabel('distance (m)')
ylabel('Power Received (dB)')


%p2b
t = 1:tTot + 1;

PrtW = (pt * Gt * Gr * (lambda ^ 2)) ./ ((4 * pi)^2 * (dStart + (v*t)).^2);
PrtdB = 10 * log10(PrtW);
tDropped = (dDropped - 3000) / v;
%tDropped = 99.9490s

figure('Name', 'Problem 2b')
loglog(t, PrtdB);
grid on
title('Power Received vs Time for LOS Model')
xlabel('time (s)')
ylabel('Power Received (dB)')


%p2c 
%This problem can be done by swithcing the value of f in the variables and 
%set up portion of the code. Rather than writing an entirely new set of 
%code, I just did that on my own, yielding dDropped = 4384.6 and tDropped =
%77.4337.

%p2d
%The lower frequency LTE carrier supports longer distance calls. This is
%because the transmission frequency is used to calculate lambda, and lambda
%is inversely proportional to the frequency. Since the power received is
%proportional to the square of lambda, increasing the frequency decreases
%lambda which decreases the power received


