%
%
%% dummy signal

tidy ;

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


%% plot signal in time (inner function)
% in: 

ma = max(xnoisy);
mi = min(xnoisy);

% interval size in seconds
intsizeseconds = 5;
intsizeidx = intsizeseconds*100;

% starting point of interval
startingsec = 30;
startingidx = find(time2==startingsec);

thisinterval = startingidx:(startingidx+intsizeidx);

figure(1)
clf;
set(gcf, 'Position', [2 291 1233 705]);
subplot(4,1,1)
plot(time2, xnoisy, time2(thisinterval), xnoisy(thisinterval), ':');
ylim([mi*0.8 ma*1.2]);
rectangle('Position', [time2(startingidx) 0.8*mi intsizeseconds (ma-mi)],...
    'EdgeColor', 'k', 'linestyle', '--', 'linewidth', 2);
grid on;


subplot(4,1,[2 3])
plot(time2(thisinterval), xnoisy(thisinterval));
ylim([mi*0.8 ma*1.2]);
grid on;


%% visualise (interactively)

close all
clc
mysignalAnayser(time2, xnoisy);


