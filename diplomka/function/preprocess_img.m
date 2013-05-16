function [bw] = preprocess_img(img,value,delta)
% predzpracovani sedotonoveho obrazu
% img - sedotonovy obraz
% value - stredni hodnota pro roi
% delta - +- rozsah pro hodnotu roi 
% bw - zpracovany bw obraz

%% selekce trasy
img_trace = roicolor(img, value-delta,value+delta);
bw = double(img_trace);

%% filtrace
% conv2, filter, fspecial, imfilter, edge
% bw = medfilt2(bw); %median, 0.205052
bw = bwmorph(bw,'majority'); %filtrace podle 8-okoli, 0.119885, tj. 2x rychlejsi 

%% morf.operace
% shrink - srazeni, "vlnkovate"
% skel - kostra, 1,2 (>2 == 2), "rohate"
% spur - ostrouhani, 1,2 (>2 == 2), celkem ujde
% thin - lepsi nez skel  - jak funguje? viz doc bwmorph('thin')

bw = bwmorph(bw,'dilate',2); %dilatace
bw = bwmorph(bw,'thin',inf); %ztencovani
% bw = bwmorph(bw,'spur'); % odstranuje poslednich n pixelu v trase

%% nalezeni koncovych bodu
end_points = bwmorph(bw,'endpoints'); %koncove body
% figure, imshow(end_points,[]), title('okrajove body'), set(gcf,'Position', get(0,'Screensize'));

% okraj = 5;
% mask = zeros(size(end_points)); mask(1+okraj:end-okraj,1+okraj:end-okraj) = 1;
% end_points = end_points .* mask; % odstraneni koncovych bodu na okraji
% figure, imshow(end_points,[]), title('koncove body'), set(gcf,'Position', get(0,'Screensize'));

[row, col] = find(end_points==1); %nalezeni souradnic koncovych bodu
points = [row,col]'; %souradnice v radku

%% spojeni prerusenych tras
prah = 38; %heuristicka promenna
indexes = makeConnection(size(end_points),points,prah);
bw(indexes) = 1;

bw = bwmorph(bw,'dilate',2);
bw = bwmorph(bw,'thin',inf);

end