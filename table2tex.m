function [texble] = table2tex(onetable, varnames, rownames)
% TABLE 2 LATEX. Turn a table into a LaTeX formatted string. Uses the
% variable names of the table as the headings and rownames. Make sure the
% values in the table are single numeric.
% 
% USAGE:
%       table2tex(onetable);
%       table2tex(onetable, varnames);
%       table2tex(onetable, varnames, rownames);
%       [texble] = table2tex( ____ );
% 
% 

switch nargin
    case 1
        varnames = onetable.Properties.VariableNames;
        rownames = onetable.Properties.RowNames;
    case 2 
        rownames = onetable.Properties.RowNames;
end

values = onetable.Variables;
whichInt = isint(values);

texble = '';
for ix=1:size(values, 1)
    line = '';
    for jx=1:size(values,2)
        if whichInt(ix,jx)==1
            line = strcat(line, num2str(values(ix,jx),0), '&');
        else
            line = strcat(line, num2str(values(ix,jx),2), '&');
        end
    end
    texble = sprintf('%s // \n %s', texble, line);
end

end

function [Y] = isint(values)
%
Y = zeros(size(values));
s1 = size(values,1);
for ix=1:size(values,2)
    x = floor(values(:,ix))==values(:,ix);
    if sum(x)==s1
        Y(:,ix) = x;
    end
end
end
        