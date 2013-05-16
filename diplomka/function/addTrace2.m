function [indxs]=addTrace2(D,startPoint)
% indxs - indexy trasy od startPoint k nejblizzi nenulove trase

% vyuzito v 
% - preprocess_img2.m

%vytvoreni dist. mapy
% D2 = ones(size(D)+2)*Inf; D2(2:end-1,2:end-1) = D; %zvetseni obrazku o okraj
D2 = padarray(D,[1 1],Inf);
startPoint = startPoint +1;

% hledani trasy
if D2(startPoint(1),startPoint(2)) == 0;
    trace = startPoint;
else
    trace = findTrace(D2,startPoint);
end
trace = trace-1;

%prevod na indexaci
if ~isempty(trace)
    indxs = sub2ind(size(D),trace(:,1),trace(:,2));
else
    indxs = [];
end