% script file: LOW LEVEL IMAGE PROCESSING 
% 

%% INITIALISATION UNIX

clear all; 
close all;
clc;

plat = 'OSX'; % or 'linux'
[dn,ds] = loadnames('macros',plat);

gtfolder = strcat(dn,ds(1:end-1),'_GT_mat_Ha/');
datafolder = strcat(dn,ds);

load(strcat(gtfolder, 'handles.mat'));

binAtt.fileName = strcat(dn,ds);
binAtt.outputfolder = strcat(dn,ds(1:end-1),'_GT/');
binAtt.handles = gtfolder;

names = binAtt.names;
whichIndx = 1; 
imname = strcat('man00', num2str(names(whichIndx)));

%% INITIALISATION WINDOWS

clear all; 
close all;
clc;

% Change platform acoordingly
plat = 'win';
[dn,ds] = loadnames('macros',plat);

gtfolder = strcat(dn,ds(1:end-1),'_GT_mat_Ha\');
datafolder = strcat(dn,ds);

load(strcat(gtfolder, 'handles_sequence.mat'));

binAtt.fileName = strcat(dn,ds);
binAtt.outputfolder = strcat(dn,ds(1:end-1),'_GT\');
binAtt.handles = gtfolder;

names = binAtt.names;
whichIndx = 3; 
imname = strcat('man00', num2str(names(whichIndx)));

%% SIMPLE CLUMPS SEGMENTATION BY THRESHOLDING

[X, xatt] = readParseInput(strcat(datafolder,imname, '.tif'));
[nuclei, clumps] = simpleClumpsSegmentation(X);

clumpsPlusNuclei = nuclei+clumps;

[vB, vatt] = voronoiSegmentation(X,xatt);

re=regionprops('table', clumps>0, 'Area');
prc = prctile(re.Area,25);
clumps = bwareafilt(clumps, [prc Inf]);

boundies = bwboundaries(clumps, 'noholes');


%% Check for angles

% 3,6,9,10,11
testBoundy = boundies{8}(1:end-1,:);
numPointsBoundy = size(testBoundy,1);
thisAngle = zeros(1,numPointsBoundy);
for idx=1:numPointsBoundy
    this = testBoundy(idx,:);
    if idx==1
        previous = testBoundy(end,:);
        next = testBoundy(idx+1,:);
    elseif idx==numPointsBoundy
        previous = testBoundy(idx-1,:);
        next = testBoundy(1,:);
    else 
        previous = testBoundy(idx-1,:);
        next = testBoundy(idx+1,:);
    end
    
    allthree = [previous;
            this;
            next];
    % centered around this point
    thisC = [previous - this;
           next - this];
    
    theta = angle(thisC(:,2)+thisC(:,1).*1i);
    thisAngle(idx) = theta(1)-theta(2);
end

%[peaks, wherePeaks] = findpeaks(abs(thisAngle));

wherePeaks = find(abs(thisAngle)<=(pi/2));


figure(2)
stem(thisAngle);

figure(1);
%imagesc(clumps);
imagesc(X);
hold on;
plot(testBoundy(:,2), testBoundy(:,1),'b.--');
plot(testBoundy(wherePeaks,2), testBoundy(wherePeaks,1),'dm');
plot(testBoundy(1,2), testBoundy(1,1),'*g');
plot(testBoundy(end,2), testBoundy(end,1),'+g');
%% 

close all;

Skel = bwmorph(clumps,'skel', Inf);
figure;
imagesc(Skel+nuclei);
showX = X;
showX(:,:,3) = Skel;

DistNuclei = bwdist(nuclei,'chessboard');
figure;
imagesc(X); hold on;
%imcontour(DistNuclei,30);

surf(DistNuclei,'EdgeColor','none');
alpha(0.5);
%%
DistTr = bwdist(clumps,'chessboard');
figure;
imagesc(showX); hold on;
imcontour(DistTr,30);
hold off;

%%
boundariesOverOriginal(X,clumps);
%boundariesOverOriginal([],nuclei);
%% 


%% 