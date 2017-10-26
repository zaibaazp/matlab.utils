% Scattered interpolation script: What to do with a scattered matrix that 
% needs to be interpolated to a larger size
%
%% Randomly generate matrices
clear all;
close all;
clc;

H = randi(100, [5 16]);
V = randi(100, [8 13]);
D1 = randi(10, [5 13]);
D2 = randi(10, [5 13]);

V2 = randi(1000, [8 12]);
H2 = randi(1000, [4 16]);

[mh, nh] = size(H);

%% Normalise matrices

H = H./max(H(:));
V = V./max(V(:));
D1 = D1./max(D1(:));
D2 = D2./max(D2(:));

H2 = H2./max(H2(:));
V2 = V2./max(V2(:));

% mean D
mD = (D1+D2)./2;

%% Fill out BM
% big matrix (output)
BM = zeros(15,31);

i_xh = 4:2:12;
i_yh = 1:2:31;
i_xv = 1:2:15;
i_yv = 4:2:28;
i_xd = 4:2:12;
i_yd = 4:2:28;

BM(i_xh, i_yh) = H;
BM(i_xv, i_yv) = V;
BM(i_xd, i_yd) = mD;

%% Scattered interpolation
[ix,iy] = ind2sub(size(BM), find(BM>0));
[qx, qy] = ind2sub(size(BM), find(BM==0));
F = scatteredInterpolant(ix,iy,BM(BM>0));
interpBM = F(qx,qy);
BM2 = BM;
BM2(BM==0) = interpBM;

figure
imagesc(BM2)
figure
spy(BM==BM2)
