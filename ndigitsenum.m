function [str] = ndigitsenum(num, n)
%   n-DIGITS ENUMERATION
% 
str = num2str(num);
while length(str)<n
    str = strcat('0', str);
end
