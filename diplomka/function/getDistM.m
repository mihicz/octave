function [DistM, TracesM] = getDistM(bw,V)
% vytvori matici vzdalenosti a tras mezi danymi vrcholy
% bw = vstupni obraz
% V = souradnice vrcholu
% DistM = matice vzdalenosti
% TracesM = matice tras (cell)

% 6.1.2012
% problem s krizenim tras (ne v jednom bode)?
% vyuziva
% - tracing

num_V = length(V(:,1)); %celkovy pocet vrcholu

DistM = zeros(num_V,num_V); %matice vzdalenosti
TracesM = cell(num_V,num_V); %matice pro ulozeni nelezenych tras

for k = 1:num_V-1
    start = V(k,:);
%     while(len_trace ~= 1)
    while(1)
        [trace,len_trace] = tracing(bw,start,V); 
        if len_trace == 0
            break;
        end
        
        x = k; %cislo startovniho vrcholu = k
        y = find(ismember(V,trace(end,:),'rows')); %cislo koncoveho vrcholu
        if DistM(x,y) == len_trace
            break;
        else
            DistM(x,y) = len_trace; DistM(y,x) = len_trace; %ulozeni delky trasy do matice vzdalenosti
        end
        TracesM{x,y} = trace; TracesM{y,x} = trace; %ulozeni trasz do matice tras
        

        for i = 2:length(trace(:,1))-1
            bw(trace(i,1),trace(i,2)) = 0; %vymazani aktualne nalezene trasy
        end
    end
end
