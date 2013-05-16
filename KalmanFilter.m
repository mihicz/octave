clear all;
% filtrovani dat
% http://robotika.cz/guide/filtering/cs

x = 0:0.1:50;
n = length(x);

y_s = 5*ones(size(x));
y = y_s + 0.5*(rand(size(x))-0.5);

limits = [min(x),max(x),min(0,min([y_s,y])*0.8),max([y_s,y])*1.2];

%---------------------------
%sum = 0;
%for i = 1:n
	%sum = sum + y(i);
%end
%out = sum/n * ones(size(x));
% ekvivalent:
%out = mean(y,'a')*ones(size(x));

%---------------------------
%out = y(1);
%out = 0;
%for i = 2:n
	%out(i) = (out(i-1)*(i-1) + y(i))/i;
	% ekvivalent:
%	out(i) = out(i-1) + (y(i) - out(i-1))/i;
%end

%---------------------------
% prumerovaci okno/ plovouci prumer
%win = 100; % cim vetsi, tim lepsi, ale narocnejsi na vypocet
%out = y(1:win);
%for i = win+1:n;
%	out(i) = mean([out(i-win:i-1),y(i)]);
%end


win = 20;
out = y(1:win);
for i = win+1:n
	%out(i) = (out(i-1)*win - y(i-win) + y(i))/win;
	% ekvivalent:
	out(i) = out(i-1) + (y(i) - y(i-win))/win;
end




%figure(1); plot(x,y_s,'g',x,y,'r',x,out,'b'); 
%axis(round(limits));grid on; 
