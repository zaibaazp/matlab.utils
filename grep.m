function [str] = grep(varargin)
% like grep, but for matlab. 
%
% grep [-e PATTERN] ...[OPTIONS]...  [-f FILE]...
%
% options:
%       -e --regexp PATTERN
%           Look for expression in PATTERN. This is used by default.
%
%       -f --file FILE
%           Search PATTERN in FILE.
%
%       -v --invert-match OTHERPATTERN
%           Do not display or return PATTERN.
%
%       -r DIR,
%           Search recursively in folder DIR.
%
%       --exclude-dir DIR
%           Exclude DIR from search.
%

wrapN = @(x, N) (1 + mod(x-1, N));
str = '';
options = {{'-e', '--regexp'},...
    {'-f', '--file'},...
    '-r', ...
    {'-v','--invert-match'},...
    '--exclude-dir'};
optionpairs = cell(length(options), 2);
optionpairs(:,1) = {'-f','-r','-e','-v','--exclude-dir'};

for ix=1:length(options)
    whereidx = find(contains(varargin, options{ix}));
    wherepairs = find(contains(optionpairs(:,1), options{ix}));
    if ~isempty(whereidx)
        optionpairs{wherepairs(1),2} = varargin{whereidx(1)+1};
    end
end
optionpairs(cellfun('isempty',optionpairs(:,2)),:) = [];

for jx=1:size(optionpairs,1)
   switch optionpairs(jx,1)
       case '-f'
           
           fname = optionpairs{jx,2};
           qq = fileread(fname);
           
       case '-r'
           
       case '-e'
           
       case '-v'
           
       case '--exclude-dir'
           
   end
end