clc; clear all; close all;

n = 1:10;

%brute force solution:
o1 = factorial(n);

%dynamic programming algorithms
o2 = (n.^2).*(2.^n);


figure(1);
plot(n,o1,'r', n,o2,'b');
grid on;
legend('brute force','dynamic prog.');
