%%% PROBLEM 5:
% only Fs = 200 and sigma = 1 gave correct values for both speeds because
% there wasn't enough noise to interfere and the sampling frequency was
% high enough to capture everything.

%%%%% PROBLEM 6:
% when 2, 3, and 4 all calculated wrong. If Fs = 100, the sampling
% frequency is too low and a wrong value is output by the fft. If sigma is
% 10, then there is too much noise causing a random frequency to be read
% for the frequency received.