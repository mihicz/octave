function [startIndxs,endIndxs]=addTrace(img_trace,startPoint,endPoint)
% indxs - indexy trasy od startPoint k nejblizzi nenulove trase

% vyuziva
% - findTrace

%vytvoreni dist. mapy
D = bwdist(img_trace,'euclidean'); %vytvori distancni mapu
D = padarray(D,[1 1],Inf);

startPoint = startPoint +1;
endPoint = endPoint +1;


%% startPoint
% hledani trasy
if D(startPoint(1),startPoint(2)) == 0;
    startTrace = startPoint;
else
    startTrace = findTrace(D,startPoint);
end
startTrace = startTrace-1;

%prevod na indexaci
if ~isempty(startTrace)
    startIndxs = sub2ind(size(img_trace),startTrace(:,1)',startTrace(:,2)');
else
    startIndxs = [];
end
    

%% endPoint
% hledani trasy
if D(endPoint(1),endPoint(2)) == 0;
    endTrace = endPoint;
else
    endTrace = findTrace(D,endPoint);
end
endTrace = endTrace-1;

%prevod na indexaci
if ~isempty(endTrace)
    endIndxs = sub2ind(size(img_trace),endTrace(:,1)',endTrace(:,2)');
else
    endIndxs = [];
end
