function [timeidx] = mysignalAnayser(time2, xnoisy)
% mysignalAnalyser. Tool to dynamically visualise the tracks from
% structure handles, that allows the user to change the parameters of
% plotTracksAndFrame in the same GUI.
%
% USAGE:
%       visualiseTracksAndFrames(handles)
%
% INPUT:
%               handles := structure containing
%                   nodeNetwork : [numRBC detected x 12 params]
%                   finalNetwork: either 1 track or [depth of tracks x numTracks]
%                   dataRe      : string with path to Reduced data (mat_Re)
%                   dataLa      : string with path to Labelled data (mat_La)
%
%
% see also plotTracks, PLOTTRACKSANDFRAME
%

if nargin < 2
    fprintf('%s: ERROR time vecttor and signal required!.\n', mfilename);
    timeidx = [];
end

test = false;

opts.ma = max(xnoisy);
opts.mi = min(xnoisy);

startingsec = 5;
stepsStartsize = 1:round(length(xnoisy)/100);
numstepstarts = length(stepsStartsize)-1;

sizesec = 20;
stepsWinsize = 5:5:55;
numstepswin = length(stepsWinsize)-1;

% figure
f = gcf;
set(gcf, 'Position', [2 291 1233 705]);
clf

ax = axes('Parent',f,'position',[0.13 0.29  0.77 0.64]);
b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
    'value',sizesec, 'min',stepsWinsize(1), 'max',stepsWinsize(end), ...
    'SliderStep', [1/numstepswin , 1/numstepswin]);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
    'String',num2str(stepsWinsize(1)),'BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],...
    'String',num2str(stepsWinsize(end)),'BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
    'String','Window size','BackgroundColor',bgcolor);

b2 = uicontrol('Parent',f,'Style','slider','Position',[81,104,419,23],...
    'value',startingsec, 'min',1, 'max',stepsStartsize(end), ...
    'SliderStep', [1/numstepstarts , 1/numstepstarts]);
b2l1 = uicontrol('Parent',f,'Style','text','Position',[50,104,23,23],...
    'String','1','BackgroundColor',bgcolor);
b2l2 = uicontrol('Parent',f,'Style','text','Position',[500,104,23,23],...
    'String',num2str(stepsStartsize(end)),'BackgroundColor',bgcolor);
b2l3 = uicontrol('Parent',f,'Style','text','Position',[240,80,100,23],...
    'String','Interval starting time','BackgroundColor',bgcolor);


b3 = uicontrol('Style', 'pushbutton', 'String', 'Get interval', ...
    'Position', [550,54,121,23], 'Callback', @returnValues);


opts.ma = max(xnoisy);
opts.mi = min(xnoisy);

b.Callback = @(es,ed) plotsignalintime(time2, xnoisy, ...
    round(b2.Value), round(es.Value), opts);
b2.Callback = @(es,ed) plotsignalintime(time2, xnoisy, ...
    round(es.Value), round(b.Value), opts);

timeidx = [round(b2.Value) round(b.Value)];

%if exist(b3.returnValues)
    timeidx = [round(b2.Value) round(b.Value)];
    close(f);
%end

end


function returnValues(ObjectH, EventData)
   handles = guidata(ObjectH);  % Get struct from figure
   handles.returnValues = true;
   guidata(ObjectH, handles);  % Put struct to figure
end
