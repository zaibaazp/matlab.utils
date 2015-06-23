% script file: GIF all the results
%

close all;
clc

foldername = '/media/jsolisl/DATA/ISBI_CELLTRACKING/2015/RESULTS/';
outputdir = '/media/jsolisl/DATA/ISBI_CELLTRACKING/2015/GIF/';
A = dir(foldername);
B = {A.name};
B([1:3 end]) = [];

for i=1:length(B)
    C = dir([foldername, char(B(i))]);
    C = {C.name};
    C(1:2) = [];
    if ~isempty(strfind(char(C(1)),'.DS_Store'))
        C(1) = [];
    end
    for j=1:length(C)
        D = dir([foldername,char(B(i)),'/',char(C(j))]);
        D = {D.name};
        D(1:2) = [];
        if ~isempty(strfind(char(D(1)),'.DS_Store'))
            D(1) = [];
        end
        D(end) = [];
        fprintf('\n%s & 0%d & & & \\\\ ', char(B(i)), j);
        
        for k=1:length(D)
            try
                NAME = strcat(foldername, char(B(i)),'/',...
                    char(C(j)),'/',char(D(k)));
                
                numIm = size(imfinfo(NAME),1);
                if numIm == 1
                    dataL = imread(NAME);
                    hSurf = imagesc(dataL);
                else
                    for r=1:numIm
                        dataL(:,:,r) = imread(NAME,r);
                    end
                    dataL = mean(dataL,3);
                    hSurf = imagesc(dataL);
                    
                end
                
                set(hSurf, 'CData', dataL);
                axis image
                axis off
                jet2=jet; jet2(1,:) = 0;
                colormap(jet2);
                title(strcat(char(B(i)), '-0', num2str(j)));
                colorbar
                drawnow;
                
                f = getframe;
                if k==1
                    [im, mapGIF] = rgb2ind(f.cdata, 256, 'nodither');
                    im(1,1,1,length(D)) = 0;
                else
                    im(:,:,1,k) = rgb2ind(f.cdata,mapGIF);
                end
            catch ME
                disp('oops');
            end
        end
        
        fname = strcat(outputdir,char(B(i)),'-0',num2str(j),'.gif');
        imwrite(im,mapGIF,fname,'DelayTime',0,'LoopCount',inf);
        clear dataL;
    end
end

%% using patch(isosurface)

close all;
clc

foldername = '/media/jsolisl/DATA/ISBI_CELLTRACKING/2015/RESULTS/';
outputdir = '/media/jsolisl/DATA/ISBI_CELLTRACKING/2015/GIF/';
A = dir(foldername);
B = {A.name};
B([1:3 end]) = [];

figure

for i=1:length(B)
    C = dir([foldername, char(B(i))]);
    C = {C.name};
    C(1:2) = [];
    if ~isempty(strfind(char(C(1)),'.DS_Store'))
        C(1) = [];
    end
    for j=1:length(C)
        D = dir([foldername,char(B(i)),'/',char(C(j))]);
        D = {D.name};
        D(1:2) = [];
        if ~isempty(strfind(char(D(1)),'.DS_Store'))
            D(1) = [];
        end
        D(end) = [];
        fprintf('\n%s & 0%d & & & \\\\ ', char(B(i)), j);
        
        for k=1:length(D)
            clf
            try
                NAME = strcat(foldername, char(B(i)),'/',...
                    char(C(j)),'/',char(D(k)));
                
                numIm = size(imfinfo(NAME),1);
                if numIm == 1
                    dataL = imread(NAME);
                    hSurf = imagesc(dataL);
                else
                    for r=1:numIm
                        dataL(:,:,r) = imread(NAME,r);
                    end
                    surfdat(dataL,'all');
                    
                end
                
                if(numIm == 1)
                    set(hSurf, 'CData', dataL);
                    jet2=jet; jet2(1,:) = 0;
                    colormap(jet2);
                else
                    view(123,80);
                end
                %set(gcf,'units','normalized','outerposition',[0 0 1 1])
                axis square
                title(strcat(char(B(i)), '-0', num2str(j)));
                drawnow;
                
                if(numIm==1)
                    f = getframe;
                    if k==1
                        [im, mapGIF] = rgb2ind(f.cdata, 256, 'nodither');
                        im(1,1,1,length(D)) = 0;
                    else
                        im(:,:,1,k) = rgb2ind(f.cdata,mapGIF, 'nodither');
                    end
                else
                    f = getframe(gcf);
                    if k==1
                        [im, mapGIF] = rgb2ind(f.cdata, 256, 'nodither');
                        im(1,1,1,length(D)) = 0;
                    else
                        im(:,:,1,k) = rgb2ind(f.cdata,mapGIF, 'nodither');
                    end
                end
                
            catch ME
                disp(ME);
            end
        end
        
        fname = strcat(outputdir,char(B(i)),'-0',num2str(j),'.gif');
        imwrite(im,mapGIF,fname,'DelayTime',0,'LoopCount',inf);
        clear dataL;
    end
end

%% using patch(isosurface)

close all;
clc

foldername = '/media/jsolisl/DATA/ISBI_CELLTRACKING/2015/RESULTS/';
outputdir = '/media/jsolisl/DATA/ISBI_CELLTRACKING/2015/GIF/';
A = dir(foldername);
B = {A.name};
B([1:3 end]) = [];

for i=1:length(B)
    C = dir([foldername, char(B(i))]);
    C = {C.name};
    C(1:2) = [];
    if ~isempty(strfind(char(C(1)),'.DS_Store'))
        C(1) = [];
    end
    for j=1:length(C)
        D = dir([foldername,char(B(i)),'/',char(C(j))]);
        D = {D.name};
        D(1:2) = [];
        if ~isempty(strfind(char(D(1)),'.DS_Store'))
            D(1) = [];
        end
        D(end) = [];
        fprintf('\n%s & 0%d & & & \\\\ ', char(B(i)), j);
        
        for k=1:length(D)
            try
                NAME = strcat(foldername, char(B(i)),'/',...
                    char(C(j)),'/',char(D(k)));
                
                numIm = size(imfinfo(NAME),1);
                if numIm == 1
                    dataL = imread(NAME);
                    hSurf = imagesc(dataL);
                else
                    for r=1:numIm
                        dataL(:,:,r) = imread(NAME,r);
                    end
                    hSurf = surfdat(dataL,'all');
                    
                end
                
                if(numIm == 1)
                    set(hSurf, 'CData', dataL);
                    jet2=jet; jet2(1,:) = 0;
                    colormap(jet2);
                else
                    view(25,12);
                end
                set(gcf,'units','normalized','outerposition',[0 0 1 1])
                axis square
                title(strcat(char(B(i)), '-0', num2str(j)));
                drawnow;
                
                if(numIm==1)
                    f = getframe;
                    if k==1
                        [im, mapGIF] = rgb2ind(f.cdata, 256, 'nodither');
                        im(1,1,1,length(D)) = 0;
                    else
                        im(:,:,1,k) = rgb2ind(f.cdata,mapGIF, 'nodither');
                    end
                else
                    f = getframe(gcf);
                    if k==1
                        [im, mapGIF] = rgb2ind(f.cdata, 256, 'nodither');
                        im(1,1,1,length(D)) = 0;
                    else
                        im(:,:,1,k) = rgb2ind(f.cdata,mapGIF, 'nodither');
                    end
                end
                
            catch ME
                disp(ME);
            end
            delete(hSurf);
        end
        
        fname = strcat(outputdir,char(B(i)),'-0',num2str(j),'.gif');
        imwrite(im,mapGIF,fname,'DelayTime',0,'LoopCount',inf);
        clear dataL;
    end
end




