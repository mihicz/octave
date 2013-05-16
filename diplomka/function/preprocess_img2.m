function [bw] = preprocess_img2(img)
% predzpracovani sedotonoveho obrazu
% img - sedotonovy obraz
% bw - zpracovany bw obraz

% filtrace, morf. operace
% spojeni prerusenych tras 1
% spojeni tras 2

% vyuziva:
% - makeConnection
% - addTrace2

%bw = double(img);

%% filtrace
% conv2, filter, fspecial, imfilter, edge
%bw = medfilt2(bw); %median, 0.205052
bw = bwmorph(img,'majority'); %filtrace podle 8-okoli, 0.119885, tj. 2x rychlejsi 

%% morf.operace
% shrink - srazeni, "vlnkovate"
% skel - kostra, 1,2 (>2 == 2), "rohate"
% spur - ostrouhani, 1,2 (>2 == 2), celkem ujde
% thin - lepsi nez skel  - jak funguje? viz doc bwmorph('thin')

bw = bwmorph(bw,'dilate',2); %dilatace
bw = bwmorph(bw,'thin',inf); %ztencovani
% bw = bwmorph(bw,'spur'); % odstranuje poslednich n pixelu v trase

%% spojeni prerusenych tras 1
% pozn: spojeni cest pomoci druheho algoritmu take funguje,
% ale je pomale (bwfill a bwdist), proto je vyhodne predzpracovani
% bez pouziti spojeni c.1: 4.002515 sec
% s pouzitim spojeni c.1: 1.778177 sec

end_points = bwmorph(bw,'endpoints'); %koncove body

okraj = 5;
mask = zeros(size(bw)); mask(1+okraj:end-okraj,1+okraj:end-okraj) = 1;
end_points = end_points .* mask; % odstraneni koncovych bodu na okraji

[row, col] = find(end_points); %nalezeni souradnic koncovych bodu
points = [row,col]; %souradnice ve sloupci

prah = 38; %heuristicka promenna
indexes = makeConnection(size(end_points),points,prah);
bw(indexes) = 1;

bw = bwmorph(bw,'dilate',2);
bw = bwmorph(bw,'thin',inf);
%% spojeni tras 2
end_points = bwmorph(bw,'endpoints'); %koncove body
end_points = end_points .* mask; % odstraneni koncovych bodu na okraji

[row, col] = find(end_points); %nalezeni souradnic koncovych bodu
points = [row,col]; %souradnice ve sloupci


while ~isempty(points)
    [bw2, idx_trace] = bwfill(~bw,points(1,2),points(1,1),4); %odstrani cestu daneho bodu
    bw2 = ~bw2;
    
    D = bwdist(bw2,'euclidean'); %distancni mapa
    
    %vyjmuti vsech bodu na stejne trace (pro danou dist. mapu)
    member = members(size(bw),idx_trace,points);
    vect = points(member,:);
    points(member,:) = [];
    
    for j = 1:size(vect,1);
        start = vect(j,:);
        if (D(start(1),start(2)) < 30)
            [indxs] = addTrace2(D,start);
            bw(indxs) = 1;
        
            %pokud trasa konci v jinem bode, odstranit ze seznamu
            member = members(size(bw),indxs(end),points); 
            points(member,:) = [];
        end
    end
        
end

bw = bwmorph(bw,'dilate',2);
bw = bwmorph(bw,'thin',inf);

end

function member = members(s,idx,points)
    [x,y] = ind2sub(s,idx); %prevod na abs.indexy
    member = ismember(points,[x,y],'rows');
end
