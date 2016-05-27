function imagescool(imageToDisplay)
%   IMAGESC - COOLJET COLORMAP
%

imagesc(imageToDisplay); 
cooljet3(max(imageToDisplay(:)));