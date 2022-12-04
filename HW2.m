clc;
clearvars;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 1 %%%%%%%%%%%%%%%%%%%%%
t = 1:10;

%q1 part a
x = exp(2 * t / 3);
normX = sqrt(sum(x.^2));

%q1 part b
magNormX = x / norm(x);
magNorm = norm(magNormX);

%q1 part c
zeroMeanX = x - mean(x);
zeroMean = mean(zeroMeanX);

%q1 part d
minmaxT = t ./ max(t);
minT = min(minmaxT);
maxT = max(minmaxT);

%q1 part e
neg5meanX = x - (mean(x) + 5);
neg5mean = mean(neg5meanX);

%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 2 %%%%%%%%%%%%%%%%%%%%%

%q2 part a
A = [1, 1, 1; 2, 2, 2; 3, 3, 3];
detA = det(A);

%q2 part b
%A is not invertable bc the determinant is 0

%q2 part c
B = [1, 0, 0; 1, 1, 0; 0, 1 1];
detB = det(B);

%q2 part d
%B is invertable bc detB =/ 0
invB = inv(B);

%%%%%%%%%%%%% QUESTION 3 %%%%%%%%%%%%%%%%%%%

%q3 part a
A3 = [1,1,0;0,1,1;1,0,1];
c1 = A3(1:3, 1);
c2 = A3(1:3, 2);
c3 = A3(1:3, 3);

r1 = A3(1, 1:3);
r2 = A3(2, 1:3);
r3 = A3(3, 1:3);

%q3 part b
B3 = [c3.'; c2.'; c1.'];

%q3 part c
C = [r3.', r2.', r1.'];

%q3 part d
D = A3(2:3, 1:2);
E = A3([1, 3], 1:2);




