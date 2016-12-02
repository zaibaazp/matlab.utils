function [logstr] = logline(fname, messagetype, message)
%                  LOGLINE
% Display information on the function. Makes the coding of functions neater.
% Types of information include: 
%
%            'info' - information on status of function.
%           'error' - displaying errors.
%         'warning' - displaying warnings.
%       <any other> - displays any other string in capital letters.
%
% Format of the console output is: 
%
% e.g [fname].MESSAGETYPE.message
% 

str = strcat('[', fname,'].',upper(messagetype),['.' 32],message);
disp(str);

if nargout > 0
    logstr = str;
end

