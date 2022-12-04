clc;
clearvars;
close all;


i = sqrt(-1);

%part 1
x = 19;
y = 20.35 * 1023;
z = x - i*y;
t = i^(2*pi/3);

%part 2
a = ones(1,14) * 10;
b = zeros(1,14);
for k=1:14
    b(k) = 2 - (k-1)*0.3;
end
c = a.*b;

%part 3
A = ones(4,5) * 9;
B = ones(4,10) * 10;
ATB = A' * B;

C = ones(4,4) * (1 - i);
Cc = conj(C);
CHA = Cc';









