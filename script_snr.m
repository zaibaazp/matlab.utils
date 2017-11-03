% quick snr tests:
%
%% Generation of signal (with energy in frecuencies 0.5 to 10)
fs = 100;
fi = linspace(1,3, 10);
%fi=4;
t = 0:(1/fs):10;
N = length(t);
x = zeros(size(t));
for ix=1:length(fi)
    x = x + randi([1 5]).*sin(2*pi*fi(ix).*t);
end

powx = rms(x)^2;

[pxx, f] = pwelch(x,120,60,500,fs);

%% Generation of a noise variable for a given SNR
SNR = 2;
powe = powx/(10^(SNR/10));

e = sqrt(powe).*randn(1,N);

xawgn = awgn(x, SNR);
xnoisy = x+e;

%% create noisy signal

[pxxnoisy] = pwelch(xnoisy,120,60,500,fs);

figure(1)
subplot(231)
plot(t(1:1000),x(1:1000));
title('normal')
subplot(234)
pwelch(x,120,60,500,fs);

subplot(232)
plot(t(1:1000),xnoisy(1:1000));
title('noisy')
subplot(235)
pwelch(xnoisy,120,60,500,fs);

subplot(233)
plot(t(1:1000),xawgn(1:1000));
title('AWGN')
subplot(236)
pwelch(xawgn,120,60,500,fs);

thSNR = 10*log10(powx/powe);
%% SOME MINOR PPG TESTS
tidy;

currData = load('onetestppg.mat');
t = currData.t;
x = currData.x;
Fs = 500; % from this data
SNR = 1;

% "additive white gaussian noise"
xawgn = awgn(x, SNR, 'measured');

% play around with this value
windw = 100;
xsmooth = smoothdata(xawgn, 'rloess', windw);

mysignalAnayser(t, [xawgn' x' xsmooth']);

%% calculate snr through various methods

% ground truth using SNR function in matlab (known noise, i.e cheating)
gtsnr = snr(x,e);

% via normal matlab function 
%r = snr(x,fs);
rnoisy = snr(xnoisy,fs);

% evar
revar = 10*log10(var(xnoisy)/evar(xnoisy))-1;

fprintf('Pre-set SNR = %d, \n', SNR);
fprintf('|snr (normal)|snr (pxx)|  mean/std | |\n')
fprintf('|%2.2f | %2.2f |%2.2f | |\n',...
        gtsnr, rnoisy, revar);

