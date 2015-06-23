close all;
clc

warning('off', 'all');
foldername = '/media/jsolisl/DATA/ISBI_CELLTRACKING/2015/ChallengeDatasets/';
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
        if ~isempty(strfind(char(C(j)),'mat_Ha'))
            STR = strcat(foldername,char(B(i)),'/',...
                char(C(j)));
            disp(STR);
            %load(STR);
            %plotNeutrophilMovie(STR,2);
        end
    end
end