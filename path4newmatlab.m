function [str] = path4newmatlab()
% CREATE FILE WITH PATH FOR NEW MATLAB. Sentitive to different platforms!
%

A = strsplit(path, ':');
a = '';

B = ver;
B = B(1).Release(2:end-1);

for ix=1:length(A)
    a=strcat(a,A{ix},':');
end

f=fopen(strcat(chooseplatform,'-oldpathfrom-', B, '.txt'), 'w');

fprintf(f, a);
fclose(f);

if nargout > 0 
    str = a;
end

