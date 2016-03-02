% Script file:
% Idea taken from:
% http://www.mathworks.com/matlabcentral/...
%           answers/32601-manual-segmentation-of-image
%
% Reworked by Jose Alonso Solis Lemus.
%
% Demo to have the user freehand draw an irregular shape over
% a gray scale image, have it extract only that part to a new image,
% and to calculate the mean intensity value of the image within that shape.
% Also calculates the perimeter, centroid, and center of mass 
% (weighted centroid).
% 

clear all
close all
imtool close all;
clc

fontSize = 16;

% Read in a standard MATLAB gray scale demo image.
[baseFileName, folder] = uigetfile('*.*');

% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
%fullFileName = strcat('/media/jsolisl/DATA/ISBI_CELLTRACKING/2013/',...
%     'TRAINING/C2DL-MSC/01/t00.tif');

% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there. 
    % Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = ...
            sprintf('Error: %s does not exist in the search path folders.',...
            fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end

grayImage = imread(fullFileName);

% is it really gray?
if size(grayImage,3)>1
    grayImage = rgb2gray(grayImage);
end

imagesc(grayImage);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

% Ask for the number of objects to be segmented.
numCells = inputdlg('How many objects are we segmenting?');
numCells = str2num(numCells{1});

if isempty(numCells)
    uiwait(msgbox('Incorrect input, using numCells=1'));
    numCells = 1;
end

%
message = sprintf(['Left click and hold to begin drawing.' ...
    '\nSimply lift the mouse button to finish']);
uiwait(msgbox(message));
binaryImage = zeros(size(grayImage));
binaryImage = binaryImage > 5;
binaryImageSum = binaryImage;

for i=1:numCells
    hFH = imfreehand();
    % Create a binary image ("mask") from the ROI object.
    binaryImage = hFH.createMask();
    xy = hFH.getPosition;
    %
    binaryImageSum = bitor(binaryImageSum,binaryImage);
end

labeledImage = bwlabeln(binaryImageSum);
imagesc(labeledImage);

