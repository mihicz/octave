% script file to plot a sine wave
figure;
x = 0:0.01:2*pi;
plot(x,sin(x));
grid on;
xlabel('x'); ylabel('y = sin x');
title("graf závislosi 1 +ìšèøžýáíé")

print -dpng graph1.png
