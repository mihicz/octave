%% diplomova prace hledani cest v mapach
% 13.1.2012, xmihal00
clc; clear all; close all;

%porovnani rychlosti:
% Matlab 
% t = [8.842, 12.485, 9.356, 9.061, 8.737], mean(t) = 9.6962, std(t) = 1.5769;

functionFolder = [pwd,'/function/'];
path(path,functionFolder);

%% nacteni obrazu
img = (imread('images/bouzov_z12.PNG'));
% img = (imread('images/bouzov_z13.PNG'));

% x = [1,1]; delta = [size(img,1)-1, size(img,2)-1]; % cely obraz
x = [10 600]; delta = [500,500]; %vyrez obrazu
% x = [192 677]; delta = [100,100]; %vyrez obrazu pro alg2

img = img(x(1):x(1)+delta(1),x(2):x(2)+delta(2),:);
figure(1), imshow(img,[]), title('original obraz'), %set(gcf, 'Position', get(0,'Screensize'));

% return
%% HSV
imgHSV = (rgb2hsv(img));
imgH = imgHSV(:,:,1);

purple_trace = [0.798,0.01]; %OK !!!
purple_trace = round(purple_trace*255);
img_purple_trace = roicolor(imgH, purple_trace(1)-purple_trace(2), purple_trace(1)+purple_trace(2));

%% YCbCr
imgY = (rgb2ycbcr(img));
imgCb = imgY(:,:,2);
imgCr = imgY(:,:,3);

%green_trace = [0.295, 0.004]; %OK !!!
%green_trace = round(green_trace*255);
green_trace = [75, 20]; %OK !!!

img_green_trace = (roicolor(imgCr, green_trace(1)-green_trace(2),green_trace(1)+green_trace(2)));

%blue_trace = [0.662, 0.005]; %OK !!!
blue_trace = [173,7]; %OK !!!
img_blue_trace = roicolor(imgCb, blue_trace(1)-blue_trace(2),blue_trace(1)+blue_trace(2));

%yellow_trace = [0.102, 0.003]; %OK !!!
yellow_trace = [8,7]; %OK !!!
img_yellow_trace = roicolor(imgCb, yellow_trace(1)-yellow_trace(2),yellow_trace(1)+yellow_trace(2));

%red_trace = [0.831,0.004]; %OK !!!
red_trace = [236,15]; %OK !!!
img_red_trace = roicolor(imgCr, red_trace(1)-red_trace(2),red_trace(1)+red_trace(2));

%figure, imshow(img_green_trace); title('green trace');
%figure, imshow(img_blue_trace); title('blue trace');
%figure, imshow(img_yellow_trace); title('yellow trace');
%figure, imshow(img_red_trace); title('red trace');

%% slouceni tras a predzpracovani2
bw = img_red_trace | img_green_trace | img_blue_trace |img_yellow_trace;% | img_purple_trace; 

%bw = bwmorph(bw,'majority');
bw = preprocess_img2(bw);

figure(3), imshow(bw, []), title('predzpracovane trasy'), set(gcf,'Position', get(0,'Screensize'));

 return
%% pridani startu a cile
figure(1)
%points = round(ginput(2)); points = points(:,end:-1:1);
%startPoint = points(1,:); endPoint   = points(2,:);
startPoint = [218,51]; endPoint = [452,466];

[startIndxs,endIndxs] = addTrace(bw,startPoint,endPoint); %0.344993
bw(startIndxs) = 1; bw(endIndxs) = 1;

% return
%% nalezeni vrcholu grafu
img_cross = bwmorph(bw,'branchpoints'); %krizovatky
end_points = bwmorph(bw,'endpoints'); %koncove body
nodes = (img_cross | end_points);

[row, col] = find(nodes==1); %nalezeni souradnic vrcholu grafu
V = [startPoint;endPoint]; %pokud jsou body na ceste, predchozi zpracovani je neodhali
V = [V;[row, col]];
V = unique(V,'rows'); %odstraneni opakujicich se vrcholu

% return
%% trasovani
% nalezeni matice vzdalenosti a tras mezi vrcholy

[DistM,TracesM] = getDistM(bw,V);

% zobrazeni grafu:
% h = view(biograph(DistM,[],'ShowWeights','on'))
% h = view(biograph(DistM,[],'ShowArrows','off','ShowWeights','on'))

% return
%% nalezeni nejkratsi trasy

startVertex = find(ismember(V,startPoint,'rows')); %cislo startovniho vrcholu
endVertex = find(ismember(V,endPoint,'rows')); %cislo koncoveho vrcholu

% [dist,path,pred] = graphshortestpath(sparse(DistM),startVertex,endVertex); %matlab fce, 0.024207
[dist,path,pred] = dijkstra(sparse(DistM),startVertex,endVertex); %moje fce, 0.033184

fprintf('Delka trasy je %5.2f\n',dist);

%% vykresleni vysledne trasy

figure(2), imshow(bw,[]); set(gcf,'Position', get(0,'Screensize')), title('vysledna trasa v mape')
for i = 1:length(path)-1 
    trace = TracesM{path(i),path(i+1)};
    hold on;
    plot(trace(:,2),trace(:,1),'r','LineWidth',5); %zobrazeni vypoctene trasy
end
hold on; plot(V(:,2), V(:,1),'g*','LineWidth',7); %oznaceni vrcholu v mape bodem
for node = 1:length(V(:,1)) %ocislovani vrcholu
     text(V(node,2),V(node,1),num2str(node),'Color',[1 1 0]);%,'BackgroundColor',[.7 .9 .7]);
end
hold on; plot(startPoint(2),startPoint(1),'ro','LineWidth',2,'MarkerSize',15); %oznaceni startovniho vrcholu v mape bodem
text(startPoint(2)+10,startPoint(1)+15,'Start','Color',[1,1,1],'FontSize',15);
hold on; plot(endPoint(2),endPoint(1),'ro','LineWidth',2,'MarkerSize',15); %oznaceni ciloveho vrcholu v mape bodem
text(endPoint(2)+10,endPoint(1)+15,'End','Color',[1,1,1],'FontSize',15);

figure(1), imshow(img,[]); set(gcf,'Position', get(0,'Screensize')), title('vysledna trasa v mape')
for i = 1:length(path)-1 
    trace = TracesM{path(i),path(i+1)};
    hold on;
    plot(trace(:,2),trace(:,1),'c','LineWidth',5); %zobrazeni vypoctene trasy
end
hold on; plot(startPoint(2),startPoint(1),'co','LineWidth',2,'MarkerSize',15); %oznaceni startovniho vrcholu v mape bodem
text(startPoint(2)+10,startPoint(1)+15,'Start','Color',[0,0,0],'FontSize',15,'BackgroundColor',[0.95 0.95 0.95],'EdgeColor','red');
hold on; plot(endPoint(2),endPoint(1),'co','LineWidth',2,'MarkerSize',15); %oznaceni ciloveho vrcholu v mape bodem
text(endPoint(2)+10,endPoint(1)+15,'End','Color',[0,0,0],'FontSize',15,'BackgroundColor',[0.95 0.95 0.95],'EdgeColor','red');
