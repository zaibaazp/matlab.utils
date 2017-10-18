function plotsignalintime(time2, xnoisy, startingsec, winsizesec, opts)
% plosignaltime.
%
%

if nargin < 3
    startingsec = 30;
    winsizesec = 5;
    [ma, mi, fs, save2file] = getoptions('default', xnoisy);
elseif nargin < 4
    winsizesec = 5;
    [ma, mi, fs, save2file] = getoptions('default', xnoisy);
elseif nargin < 5
    [ma, mi, fs, save2file] = getoptions('default', xnoisy);
else
    [ma, mi, fs, save2file] = getoptions(opts);
end

startingidx = find(time2==startingsec);
sizeidx = winsizesec*fs;

endinterval = min(startingidx+sizeidx, length(time2));
thisInterval = startingidx:endinterval;
winsizesec = time2(thisInterval(end)) - time2(thisInterval(1));

set(gcf, 'Position', [2 291 1233 705]);
subplot(4,1,1)
plot(time2, xnoisy, time2(thisInterval), xnoisy(thisInterval,:), ':');
ylim([mi*0.8 ma*1.2]);
rectangle('Position', [time2(startingidx) 0.8*mi winsizesec (ma-mi)],...
    'EdgeColor', 'k', 'linestyle', '--', 'linewidth', 3);
grid on;

subplot(4,1,[2 3])
plot(time2(thisInterval), xnoisy(thisInterval,:));
ylim([mi*0.8 ma*1.2]);
grid on;
axis tight;

if save2file==true
    save('thisInterval.mat', 'thisInterval')
end
end

function [ma, mi, fs , save2file] = getoptions(s, x)
%
if nargin < 2
    ma = 1;
    mi = -1;
else
    ma = max(x(:));
    mi = min(x(:));
end
save2file = false;
fs = 100;
if isstruct(s)
    fnames = fieldnames(s);
    for ix=1:length(fnames)
        switch fnames{ix}
            case 'ma'
                ma = s.(fnames{ix});
            case 'mi'
                mi = s.(fnames{ix});
            case 'fs'
                fs = s.(fnames{ix});
            case 'save2file'
                save2file = s.(fnames{ix});
            otherwise
                fprintf('%s: ERROR, option %s not recognised.\n', ...
                    mfilename, upper(fnames{ix}));
        end
    end
end
end