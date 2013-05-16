function [index] = makeLine(size_bw,point1,point2)
% vrati indexaci primky mezi body 
% point = [x,y]

X = [point1(1),point2(1)];
Y = [point1(2),point2(2)];

flag = 0; %flag prohozeni X <-> Y

if abs(diff(X)) < abs(diff(Y))
    [X,Y] = swapVectors(X,Y);
    flag = 1;
end

x = linspace(X(1),X(2),abs(X(2)-X(1))+1); %x-osa
d = (Y(2) - Y(1))/(X(2) - X(1)); %smernice primky
a = Y(1) - d*X(1); %posunuti primky
y = round(x*d + a); %y-osa
% ceil, fix floor


if flag
    [x,y] = swapVectors(x,y);
end    

index = sub2ind(size_bw,x,y);
end

function [Y,X] = swapVectors(X,Y)
end
