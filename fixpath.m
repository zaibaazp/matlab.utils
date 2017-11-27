function [newpath] = fixpath(basefilename)
% FIX PATH INTO THE FITTING OS STRUCTURE.
%
newpath = basefilename;

if isdir(basefilename)
    fprintf('%s: Folder names appear to be consistent. No changes done.\n',...
        mfilename);
    return
end

switch chooseplatform
    case 'win'
        [~,volumes] = system('wmic logicaldisk get caption');
        b = strsplit(volumes,':');
        b = b{1};
        A = strsplit(volumes,b(end-1));
        
        ix = 1;
        clear volumes;
        for i=1:length(A)
            if ~isempty(strfind(A{i},':'))
                volumes{ix} = strcat(A{i},'\');
                ix=ix+1;
            end
        end
    case 'linux'
        volumes = dir('/home');
        volumes(1:2) = [];
        volumes = {volumes.name};
        
        for jx=1:length(volumes)
            volumes{jx} = fullfile('/media', volumes{jx});
        end
    case 'mac'
        volumes = dir('/Volumes');
        volumes(1:2) = [];
        volumes = {volumes.name};
        
        for jx=1:length(volumes)
            volumes{jx} = fullfile('/Volumes', volumes{jx});
            
        end
end

[~, splitpath] = comesfrom(basefilename, chooseplatform);
for jx=1:length(volumes)
    dirtest = joindirname([volumes(jx) splitpath]);
    if isdir(dirtest)
        newpath = dirtest;
    end
end


end

function [platformused] = chooseplatform()
% return the platform in which phagosight is being run.
test = isunix + ismac;

switch test
    case 0
        platformused = 'win';
    case 1
        platformused = 'linux';
    case 2
        platformused = 'mac';
end
end

function [joineddir] = joindirname(splitdirname)
% join folder name from splitstr's output.
joineddir ='';
for jx=1:length(splitdirname)
    joineddir = strcat(joineddir, filesep, splitdirname{jx});
end
if strcmp(chooseplatform, 'win')
    if strcmp(joineddir(1), '\') || strcmp(joineddir(1), '/')
        joineddir(1)=[];
    end
end
end


function [op, splitpath] = comesfrom(somedatapath, goesto)
% returns which platform does the
if contains(somedatapath, ':')
    op = 'win';
    if nargout > 1
        splitpath = strsplit(somedatapath, '\');
        splitpath(1) = [];
    end
else
    if contains(somedatapath, '/Volumes')
        op = 'mac';
        if nargout > 1
            splitpath = strsplit(somedatapath, '/');
            splidx = find(contains(splitpath, 'Volumes'));
            switch goesto
                case {'linux', 'mac'}
                    splitpath(1:splidx) = [];
                case 'win'
                    splitpath(1:(splidx+1)) = [];
            end
        end
    else
        op = 'linux';
        if nargout > 1
            splitpath = strsplit(somedatapath, '/');
            splidx = find(contains(splitpath, 'media'));
            splitpath(1:(splidx+1)) = [];
        end
    end
end
end