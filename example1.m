%clc
a = [3 4 6];
b = [8 6 4];
d = [4 3 2];

e = 13 - 2*d;
c = 13 - d - a;


[a;b;c;d;e]'

return
% podm. 1:
a(i).*b(i) == 24

% podm. 2:
b(i)/2 == d(i)

% podm. 3:
d(i) + e(i) == a(i) + c(i)

% podm. 4:
a(i) + b(i) + c(i) + d(i) + e(i) == 26

% podm. 5:
b(i) + c(i) >= e(i)
