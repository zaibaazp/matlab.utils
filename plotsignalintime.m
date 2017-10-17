function plotsignalintime(time2, xnoisy, startingsec, winsizesec, opts)
% plosignaltime.
%
%

if nargin < 3
    startingsec = 30;
    winsizesec = 5;
    ma = max(xnoisy(:));
    mi = min(xnoisy(:));
elseif nargin < 4
    winsizesec = 5;
    ma = max(xnoisy(:));
    mi = min(xnoisy(:));
elseif nargin < 5 
    ma = max(xnoisy(:));
    mi = min(xnoisy(:));
else
    [ma, mi] = getoptions(opts);
end

startingidx = find(time2==startingsec);
sizeidx = winsizesec*100;

endinterval = min(startingidx+sizeidx, length(time2));
thisinterval = startingidx:endinterval;
winsizesec = time2(thisinterval(end)) - time2(thisinterval(1));

set(gcf, 'Position', [2 291 1233 705]);
subplot(4,1,1)
plot(time2, xnoisy, time2(thisinterval), xnoisy(thisinterval,:), ':');
ylim([mi*0.8 ma*1.2]);
rectangle('Position', [time2(startingidx) 0.8*mi winsizesec (ma-mi)],...
    'EdgeColor', 'k', 'linestyle', '--', 'linewidth', 3);
grid on;

subplot(4,1,[2 3])
plot(time2(thisinterval), xnoisy(thisinterval,:));
ylim([mi*0.8 ma*1.2]);
grid on;
axis tight;

end

function [ma, mi] = getoptions(s)
% 
fnames = fieldnames(s);
ma = 1;
mi = -1;
for ix=1:length(fnames)
    switch fnames{ix}
        case 'ma'
            ma = s.(fnames{ix});
        case 'mi'
            mi = s.(fnames{ix});
        otherwise 
            fprintf('%s: ERROR, option %s not recognised.\n', ...
                mfilename, upper(fnames{ix}));
    end
end
end