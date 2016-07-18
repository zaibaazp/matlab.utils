function D = imdiv(I)

[Ix, Iy] = imgradientxy(I);
[X Y] = meshgrid(1:size(I, 2), 1:size(I, 1));

D = divergence(X, Y, Ix, Iy);