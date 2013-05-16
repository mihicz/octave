function [dist,path,pred] = dijkstra(DG,source,destination)
% [dist,path,pred] = dijkstra(DG,source,destination)
% 28-Nov-2011, xmihal00
% Nalezne nejkratsi cestu ze startovniho do ciloveho vrcholu pomoci
% Dijkstroveho algoritmu.
% Determines the single source-single destination shortest path from node
% source to node destination.
% DG = matice vzdalenosti
% source = startovni vrchol
% destination = cilovy vrchol
% dist = vzdalenost z 'source' do 'destination'
% path = cesta pres uzly z 'source' do 'destination'
% pred = predchudci vsech uzlu

% podobna funkce Matlabu: [dist,path,pred] = graphshortestpath(DG,1,6)


%% inicializace
num_V = size(DG,1); %pocet vrcholu

d = inf*ones(1,num_V); %seznam nejkatsi cesty z s do v pro vsechny v
d(source) = 0; %vzdalenost z s do s je 0

pred = zeros(1,num_V); %predchudce na nejkratsi ceste z s do jakohokoli v

H = 1:num_V; %prioritni fronta (priorita podle d)

%% hledani nejkratsi cesty v grafu - Dijkstra
iter = 0;
while any(H)
    v = find(d == min(d(H))); %vrchol s nejmensi vzdalenosti v prior fronte
    for i = 1:length(v)
        if ismember(v(i),H)
            v = v(i); break;
        end
    end
    
    H(H == v) = []; %odstrani vrchol z prioritni fronty
    iter = iter + 1;
    if (iter > num_V) break; end
%     if (v == destination); break; end %nalezeni zdroje (wikipedia) %ukoncovaci podminka

% uprava vzdalenosti d    
    for w = 1:num_V %pouze vrcholy w z dvojice (v,w), tj. sousedni ?
        if (w ~= v) && (DG(v,w)~=0) %pokud nejsou totozne uv a zaroven existuje takova hrana        
            if d(w) > d(v)+DG(v,w) 
                d(w) = d(v)+DG(v,w);

                pred(w) = v;

            end    
        end
    end
    
end

%% minimalni cesta
dist = d(destination);

%% nalezeni cesty ze zdroje do cile

path = []; %empty sequence
v = destination;
while v ~= 0
    path = [v,path];
    v = pred(v);
end


%%

% neorientovany graf
% W = [2 1 3 1]; DG = sparse([1 1 2 3],[3 2 3 4],W,length(W),length(W));
% [dist,path,pred] = dijkstra(DG,1,4)
% dist = [3];
% path = [1 3 4];
% pred = [0 1 1 3];

% orientovany graf - cesta neexistuje
% UG = tril(DG + DG');
% [dist,path,pred] = dijkstra(UG,1,4)
% dist = inf;
% path = [];
% pred = 0 NaN NaN NaN NaN NaN;