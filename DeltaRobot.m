clear all;
% calc 2D delta robot axis

% constants:
l1 = 100; l2 = 100; d = 50;

% inputs:
x = 20; y = 10;
%x = 0:d; y = 0:20; [xx, yy] = m:shgrid(x,y);

%j = y + l1*sin(acos(x/l1));
%k = y + l2*sin(acos((d-x)/l2));

j = yy + sqrt(l1^2 - xx.^2);
k = yy + sqrt(l2^2 - (d-xx).^2);

