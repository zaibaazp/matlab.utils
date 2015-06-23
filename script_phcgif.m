% script file: PhC script
% 

clear all;
close all
clc

A = dir('../../ISBI/CHALLENGE/PhC-C2DL-PSC/01_mat_La');
B = {A.name};
B(1:2) = [];

for i=1:length(B)
    str = strcat('~/Documents/PhD/ISBI/CHALLENGE/',...
        'PhC-C2DL-PSC/01_mat_La/',char(B(i)));
    load(str);
    
    hSurf = imagesc(dataL);
    set(hSurf, 'CData', dataL);
    axis image
    axis off
    colormap jet
    title(char(B(i)));
    colorbar
    drawnow;
    
    f = getframe;
    if i==1
        [im, mapGIF] = rgb2ind(f.cdata, 256, 'nodither');
        im(1,1,1,length(B)) = 0;
    else
        im(:,:,1,i) = rgb2ind(f.cdata,mapGIF);
    end
    
end

fname = strcat('~/Documents/PhD/ISBI/CHALLENGE/',...
        'PhC-C2DL-PSC/','phaseContrastDSET.gif');
imwrite(im,mapGIF,fname,...
         'DelayTime',0,'LoopCount',inf);