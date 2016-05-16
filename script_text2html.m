% script file: Text to HTML
% 


%% Print on screen
clear all; 
close all;
clc;

filename = '~/Documents/propio/PhD/WEBPAGE/RCBE_projects.txt';

fid = fopen(filename,'r');
tline = fgets(fid);

while ischar(tline)
    s = strsplit(tline,'*');
    
    if length(s)==1
        testString = 'empty';
    else
        testString = s{1};
        printString = s{2};
    end
    
    switch testString
        case {'title'}
            fprintf('%s\n', printString); 
        case {'Principal Investigator', 'Principal Investigators',...
                'Co-Investigators', 'Co-Investigator'...
                'Researchers', 'Researcher', 'Funding'}
            fprintf('%s: %s', testString, printString);
        case {'text'}
            s2 = strsplit(s{2}, ' ');
            for ix=1:length(s2)
                fprintf('%s ', s2{ix});
                if mod(ix,10)==0
                    fprintf('\n');
                end
            end
            fprintf('\n');
        case {'empty'}
%            fprintf('\n');
        otherwise
            disp('ERROR');
            disp(s{1});
    end
      
    tline = fgets(fid);
end

%% All in one accordion
clear all; 
close all;
clc;

filename = '~/Documents/propio/PhD/WEBPAGE/RCBE_projects.txt';
outputname = '~/Documents/propio/PhD/WEBPAGE/projects.html';

fid = fopen(filename,'r');
outid = fopen(outputname, 'w+');

tline = fgets(fid);

fprintf(outid, '<div class="accordion">');

projectIndx = 1;
while ischar(tline)
    s = strsplit(tline,'*');
    
    if length(s)==1
        testString = 'empty';
    else
        testString = s{1};
        printString = s{2};
    end
    
    switch testString
        case {'title'}
            fprintf(outid, strcat('<h3>\n<a href="#proj',...
                num2str(projectIndx),'">\n%s</a>\n</h3>\n'), printString);
             fprintf(outid, strcat('<div id=proj',num2str(projectIndx),...
                '>\n'));
            fprintf(outid,'<h4> Details:</h4>\n');
            projectIndx = projectIndx+1;
            
        case {'Principal Investigator', 'Principal Investigators',...
                'Co-Investigators', 'Co-Investigator'...
                'Collaborator', 'Collaborators',...
                'Researchers', 'Researcher', 'Funding'}
            
            fprintf(outid, '<p style="text-align: justify;">');
            fprintf(outid, '<strong>%s: </strong>%s</p>\n',...
                testString, printString);
            
        case {'text'}
            
%             fprintf(outid,'<h4>\n Project Description </h4>\n');
%             fprintf(outid, '<p style="text-align: justify;">\n');
%             s2 = strsplit(s{2}, ' ');
%             for ix=1:length(s2)
%                 fprintf(outid, '%s ', s2{ix});
%                 if mod(ix,10)==0
%                     fprintf(outid, '\n');
%                 end
%             end
%             fprintf(outid,'</p>\n');
            fprintf(outid,'</div>\n');
        case {'empty'}
            %
        otherwise
            disp('ERROR');
            disp(s{1});
    end
      
    tline = fgets(fid);
end


%% Do individual pages

clear all; 
close all;
clc;

filename = '~/Documents/propio/PhD/WEBPAGE/RCBE_projects.txt';
outputname = '~/Documents/propio/PhD/WEBPAGE/projects.html';

fid = fopen(filename,'r');
outid = fopen(outputname, 'w+');

tline = fgets(fid);

fprintf(outid, '<div class="accordion">');

projectIndx = 1;
while ischar(tline)
    s = strsplit(tline,'*');
    
    if length(s)==1
        testString = 'empty';
    else
        testString = s{1};
        printString = s{2};
    end
    
    switch testString
        case {'title'}
            fprintf(outid, strcat('<h3>\n<a href="#proj',...
                num2str(projectIndx),'">\n%s</a>\n</h3>\n'), printString);
            fprintf(outid, strcat('<div id=proj',num2str(projectIndx),...
                '>\n'));
            projectIndx = projectIndx+1;
            
        case {'Principal Investigator', 'Principal Investigators',...
                'Co-Investigators', 'Co-Investigator'...
                'Collaborator', 'Collaborators',...
                'Researchers', 'Researcher', 'Funding'}
            fprintf(outid,'<h4>\n');
            fprintf(outid,'%s', testString);
            fprintf(outid, '</h4>\n');
            fprintf(outid, '<p style="text-align: justify;">%s</p>\n',...
                printString);
        case {'text'}
            
            fprintf(outid,'<h4>\n Project Description </h4>\n');
            fprintf(outid, '<p style="text-align: justify;">\n');
            s2 = strsplit(s{2}, ' ');
            for ix=1:length(s2)
                fprintf(outid, '%s ', s2{ix});
                if mod(ix,10)==0
                    fprintf(outid, '\n');
                end
            end
            fprintf(outid,'</p>\n');
        case {'empty'}
            fprintf(outid,'</div>\n');
        otherwise
            disp('ERROR');
            disp(s{1});
    end
      
    tline = fgets(fid);
end
