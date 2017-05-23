function [rmap] = randommap(maxcolours)

if nargin == 0 
    maxcolours = 255;
end

rmap = rand(255,3);
rmap(:,1) = sort(rmap(:,1));
rmap = [[0 0 0]; rmap];
