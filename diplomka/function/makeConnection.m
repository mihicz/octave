function [indexes] = makeConnection(size_bw,points,thresh)
% vrati indexy spojenych cest
% size_bw - rozmery zkoumane matice: size_bw = size(bw)
% points - radkovy vektor souradnic vysetrovanych bodu: points = [X;Y]
% thresh - prah maximalni euklidovy vzdalenosti mezi pospojovanymi body

% vyuzito v 
% - preprocess_img2

indexes = [];
if size(points,1) > 1 %pouze jeden bod nelze v mape sparovat
        
    matD = dist(points'); %Euclidean distance
    matD(matD>thresh) = 0; %prahovani pro vzdalenost vetsi nez
    matD = sparse(triu(matD)); % pouze horni troj. matice, ridka matice
    [x,y] = find(matD); %cisla vrcholu, kt. se maji spojit

    for i = 1:length(x);
        p1 = points(x(i),:);
        p2 = points(y(i),:);
        indexes = [indexes, makeLine(size_bw,p1,p2)];
    end
end %if 

end    %function