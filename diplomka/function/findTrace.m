function [trace] = findTrace(distMat,start)
% vytvori trasu podle distancni mapy z vychoziho bodu
% trasa hleda nejmensi hodnotu v 8-okoli 
% dokud nenarazi na okraj (0)
% start = souradnice vychoziho bodu
% distMat = vstupni distancni obraz
% trace = indexace nalezene trasy
% tic

% vyuzito v
% - addTrace2
delta = [sqrt(2),1,sqrt(2); 1,sqrt(2),1; sqrt(2),1,sqrt(2)];
   
    ref = start;
    trace = ref;
    while 1
        if (distMat(ref(1),ref(2)) == 0) || (distMat(ref(1),ref(2)) == Inf); break; end
        submat = distMat(ref(1)-1:ref(1)+1,ref(2)-1:ref(2)+1) + delta; %submatice = 8-okoli
        minMat = min(min(submat));
        next = find(submat == minMat);
        if length(next) ~= 1
            idx = find(mod(next,2) == 0,1); % nalezne jedno sude cislo
            if isempty(idx) %pouze licha cisla
                next = next(1);
            else
                next = next(idx);
            end
        end
        
        ref = ref + relativeIdx2(next);
        trace = [trace; ref];
    end %while(1)
% toc
end

function [idx] = relativeIdx2(course)
% vrati index posunuti v x,y
% [1,4,7;
%  2,5,8;
%  3,6,9;]

    x = [-1,-1; 0,-1; 1,-1;  -1,0; 0,0; 1,0;  -1,1; 0,1; 1,1];
    idx = x(course,:);

end %function relativeIdx
