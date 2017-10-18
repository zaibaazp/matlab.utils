%
%
%% dummy signal

tidy ;
[time2, xnoisy] = getdummysignal();
xnoisy = [xnoisy -xnoisy./2];

%% plot signal in time (inner function)
% in: 

opts.ma = max(xnoisy(:));
opts.mi = min(xnoisy(:));
opts.save2file = false;
opts.fs = 100; % change your sampling frequency

winsizesec = 5; % interval size in seconds
startingsec = 30; % second where the interval starts

figure(1)
plotsignalintime(time2, xnoisy, startingsec, winsizesec, opts)

%% visualise (interactively)

close all
clc
mysignalAnayser(time2, xnoisy);

while ~exist('thisInterval.mat', 'file')
    % tell matlab to wait around while you choose your figure
    pause(3);
end
close all;
disp('out of the while')
load('thisInterval');
delete('thisInterval.mat');

%%
function [time2, xnoisy] = getdummysignal()
fs = 100;
fi = linspace(0.4,15, 10);
time2 = (0:(1/fs):60)';
N = length(time2);
x = zeros(size(time2));
for ix=1:length(fi)
    x = x + 2^(ix).*sin(2*pi*fi(ix).*time2);
end
powx = rms(x)^2;
[pxx, f] = pwelch(x,120,60,500,fs);

SNR = 10;
powe = powx/(10^(SNR/10));
e = sqrt(powe).*randn(size(time2));
xnoisy = x+e;
end