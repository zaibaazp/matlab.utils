function [fr] = fname2number(fname)
% FRAME TO INDEX. All digits are assumed to be straight before the 'dot' of
% the filename.
%

str = strsplit(fname,'.');
str = str{end-1};

idx=0;

while ~isempty(str2num(str(end-idx:end)))
    idx=idx+1;
end

idx = idx-1;

fr = str2num(str(end-idx:end));