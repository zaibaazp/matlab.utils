function plotHorzLine(vector, values)
% Plot a(many) horizontal line(s) on a plot.
% 
gcf;
hold on;

if length(vector)==1
    nPoints = vector;
else
    nPoints = length(vector);
end

for ix=1:length(values)
    plot([1 nPoints], [values(ix) values(ix)]);
end
