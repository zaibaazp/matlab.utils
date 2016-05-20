function removeBorders()
% Remove borders from current figure
%
%

currAxPos = get(gca,'position');
if currAxPos(end) ==1
    set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);
    axis on
else
    set(gca,'position',[0 0 1 1 ]);
    axis off
end
clear currAxPos
