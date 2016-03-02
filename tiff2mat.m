function tiff2mat(dataIn, outputfolder)
%         TIFF TO MAT FILE CONVERSION
% INPUT: 
%
% OUTPUT: 
%
 
 if isdir(dataIn)
    if ~strcmp(dataIn(end), '/')
        dataIn = strcat(dataIn, '/');
    end
    if nargin < 2
        outputfolder = strcat(dataIn(1:end-1),'_mat_La/');
        mkdir(outputfolder);
    end
    
    imname = dir(strcat(dataIn, '*.tif'));
    imname = {imname.name};
    
    name = strcat(outputfolder, 'T');
    
    for i=1:length(imname)
        [dataL, xatt] = readParseInput(strcat(dataIn,imname{i}));
        if i<10
            str = strcat(name, '000', num2str(i));
        elseif i<100
            str = strcat(name, '00',num2str(i));
        elseif i<1000
            str = strcat(name, '0',num2str(i));
        else 
            str = strcat(name,num2str(i));
        end
        
        save(str,  'dataL');
    end
        
else
    if nargin < 2
        outputfolder = './DATASET_mat_La/';
        mkdir(outputfolder);
    end
    [~, ~, ~, numImages] = size(dataIn);
    name = strcat(outputfolder, 'T');
    
    for i=1:numImages
        dataL = dataIn(:,:,:,i);
        if i<10
            str = strcat(name, '000', num2str(i));
        elseif i<100
            str = strcat(name, '00',num2str(i));
        elseif i<1000
            str = strcat(name, '0',num2str(i));
        else 
            str = strcat(name,num2str(i));
        end
        
        save(str,'dataL');
    end
    
end