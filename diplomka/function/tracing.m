function [trace,len_trace] = tracing (bw, start, end_points)
% funkce trasuje po ceste ze startovniho bodu
% pokud narazi na nektery z end_points, konec
% vraci souradnice trasy trace(x,y) a delku trasy len_trace (Euklid)

% 6.1.2012 - upraveno getNeighbor pro direction empty

% vyuzito v
% - getDistM

ref_point = start;
next = getNeighbor(bw,start);
bw(ref_point(1),ref_point(2)) = 0;
trace = start;
len_trace = 0; %vlozit kontrolu, zda dalsi bod neni koncovy
while next
    ref_point = ref_point+relativeIdx(next);
    bw(ref_point(1),ref_point(2)) = 0;
    trace = [trace; ref_point];
    len_trace = len_trace + get_length(next);

    if max(ismember(end_points,ref_point,'rows'))
        break;
    end
     
    next = getNeighbor(bw,ref_point);
end

end %function tracing

function [direction] = getNeighbor(bw, point)
% vrati pozici vsech sousedu od startovniho bodu
% [8,1,2;
%  7,0,3;
%  6,5,4;]

    [n,m] = size(bw);
    direction = [];    
    
    for i = 1:8
        rel = relativeIdx(i);
        if (point(1)+rel(1) > 0) && (point(1)+rel(1) <= n) && (point(2)+rel(2) > 0) && (point(2)+rel(2) <= m)
            if bw(point(1)+rel(1),point(2)+rel(2))
                direction = [direction, i];
            end
        end
    end
    
    if isempty(direction)
        direction = 0;
    end
    
    if length(direction) ~= 1
        idx = find(mod(direction,2),1); % nalezne jedno nejmensi liche cislo
        if isempty(idx) %pouze suda cisla (rohy)
            direction = direction(1);
        else
            direction = direction(idx);
        end
    end
   

end %function getNeighbor


function [idx] = relativeIdx(course)
% vrati index posunuti v x,y
% idxs = [4,7,8,9,6,3,2,1];
% [8,1,2;
%  7,0,3;
%  6,5,4;]

    x = [0,0; -1,0; -1,1; 0,1; 1,1; 1,0; 1,-1; 0,-1; -1,-1];
    idx = x(course+1,:);

end %function relativeIdx

function [len] = get_length(next)
% vrati eulerovskou vzdalenost pri posunu danym smerem

if mod(next,2) %tj. liche cislo (1,3,5,7)
    len = 1;
else %tj. sude cislo (2,4,6,8)
    len = sqrt(2);
end
if next == 0
    len = 0;
end

end
