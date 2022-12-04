clc
close all
clear

%%%%%%%%%%%%%%%% PROBLEM 1 %%%%%%%%%%%%%%%%%%

theta1a = linspace(-pi, pi, 10);
p1q1a = sin(theta1a);

theta1b = linspace(-90, 270, 10);
p1q1b = cosd(theta1b);

x1c = linspace(-2, 2, 10);
p1q1c = x1c.^3 + x1c.^2 -1;

figure('Name', 'Problem 1 Question 1a')
plot(theta1a, p1q1a)
grid on
title('y = sin(theta)')
xlabel('Radians')
ylabel('y')

figure('Name', 'Problem 1 Question 1b')
plot(theta1b,p1q1b)
grid on
title('y = cos(theta)')
xlabel('Degrees')
ylabel('y')

figure('Name', 'Problem 1 Question 1c')
plot(x1c, p1q1c)
grid on
title('y = x^3 + x^2 -1')
xlabel('x')
ylabel('y')


x2a = linspace(0,1,20);
y2a = x2a.^2;

x2b = linspace(1,2,20);
y2b = 10.^(x2b.^3);

x2c = linspace(0.5,1,20);
y2c = exp(x2c + 1);


figure('Name', 'Problem 1 Question 2a')
semilogy(x2a, y2a)
grid on
title('y = x^2')
xlabel('x')
ylabel('log(y)')

figure('Name', 'Problem 1 Question 2b')
semilogx(x2a,y2a)
grid on
title('y = 10^(x^3)')
xlabel('log(x)')
ylabel('y')

figure('Name', 'Problem 1 Question 2c')
loglog(x1c, p1q1c)
grid on
title('y = exp(x+1)')
xlabel('log(x)')
ylabel('log(y)')


