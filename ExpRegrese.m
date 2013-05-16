clc; clear all;
x_i = [1,23];
y_i = [20,100];

% y = a*b.^(x) -> log(y) = log(a) + x*log(b)
% log(y) = c + x*d
d = (log(y_i(2))-log(y_i(1)))/(x_i(2)-x_i(1));
c = log(y_i(1)) - d*x_i(1);
a = exp(c);
b = exp(d);

x = x_i(1):x_i(2);
y = round(a*b.^(x))
%y = (a*b.^(x))
figure(1); plot(x,y,'r.-'); grid on;
%axis([x_i,y_i]);
axis auto;
print -dsvg figure1.svg
