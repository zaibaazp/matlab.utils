function C = colormapORG(M)
%  PRETTY PURPLE COLORMAPPING
% 
R = linspace(230,0,M)';
G = linspace(128,0,M)';
B = linspace(194,0,M)';
C = [R G B];

C = C/255;
