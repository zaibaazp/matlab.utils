function [s] = timeDisplay(t, processName)
% TIME DISPLAY FUNCTION.
% Takes the output of a tic..toc implementation and displays it in
% a human readable way. Optionally, it outputs the string (instead
% of displaying it on the screen).
% 

Thours = 0;
Tmin = 0;
Tsec = t;
if t > 60
    Tmin = fix(t/60);
    Tsec = (t/60 - Tmin)*60;
    if t > 3600
        Thours = fix(Tmin/60);
        Tmin = fix((Tmin/60 - Thours)*60);
    end
end
        
if nargin > 1
    S = [32 'on ' 32 processName];
else
    S = '';
end

fprintf('\n');

if nargout == 0
    fprintf('Time spent%s: %2d:%2d:%2f\n', S, Thours, Tmin, Tsec);
else
    s = strcat('Time spent', S, ':', num2str(Thours),':', num2str(Tmin), ...
               ':', num2str(Tsec));
end



