clc
close all
clear

%variables and setup
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
ht = 30;
hr = 1.5;

dStart = dStartKm * 1000;
dFinish = dFinishKm * 1000;

v = vKmHr * 1000 / 3600;
tTot = ((dFinishKm - dStartKm) / vKmHr) * 3600;

%p3a
d = linspace(dStart, dFinish, 10000);

PrdW = (pt * Gt * Gr * ht^2 * hr^2) ./ d.^4;
PrddB = 10 * log10(PrdW);
dDropped = nthroot(((pt * Gt * Gr * ht^2 * hr^2) / (10^(pDrop / 10))), 4);
%dDropped = 3520.9m

figure('Name', 'Problem 3a')
loglog(d, PrddB)
grid on
title('Power Received vs Distance for 2-Ray Model')
xlabel('distance (m)')
ylabel('Power Received (dB)')

%p3b
t = 1:tTot + 1;
PrtW = (pt * Gt * Gr * ht^2 * hr^2) ./ (dStart + (v*t)).^4;
PrtdB = 10 * log10(PrtW);
tDropped = (dDropped - 3000) / v;
%tDropped = 29.1346s

figure('Name', 'Problem 3b')
loglog(t, PrtdB)
grid on
title('Power Received vs Time for 2-Ray Model')
xlabel('time (s)')
ylabel('Power Received (dB)')

%p3c
%The freespace/LOS model supports a call for longer. This is because the
%two ray model is based off of having obstacles in the way which cause
%waves reaching the received that destructively interfere with the intended
%transmission signal. The 2-Ray model is a worst case scenario for
%transmission.