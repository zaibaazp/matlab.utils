function allhandsondeck
%
clc;

values = {'King', 'Queen', 'Jack', 'Ace'};
clubs = {'Spades','Clubs','Hearts', 'Diamonds'};
combinations = cell(16,1);

indx = 1;
for ix=1:4
    for jx=1:4
        combinations{indx} = strcat(values{jx},32,'of',32,clubs{ix});
        indx = indx+1;
    end
end

disp(combinations(randperm(16)));