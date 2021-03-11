% main execution 
[s1,fs] = audioread('s1.wav');

frameLength=256;
frameHop = 100;

% STFT is positive half of fft
[STFT,time, freq] = stft(s1,frameLength,frameHop,fs);

STFT=mag2db(abs(STFT)); % convert to dB = 20log10(value)
plotSTFT(time,freq,STFT)

nfft = 2^nextpow2(frameLength);
m = melfb(12, 256, fs)
plot(m)


% nov = floor((256-100)/256);
% nff = max(256,2^nextpow2(256));
% spectrogram(s1,hamming(256),nov,nff,'color')





function [STFT,time, freq] = stft(x,frameLength,frameHop,fs)
x = x(:); % column vector
sigLength = length(x);
numFrames = floor((sigLength-frameLength)/frameHop);
nfft = 2^nextpow2(frameLength); % number of fft points
halfFFT = ceil((1+nfft)/2);  % positive fft points

% create STFT matrix
STFT = zeros(halfFFT,numFrames);

% window fuction
window = hamming(frameLength);

% apply window to each frame then take fft
k = 1;
for i = 1:numFrames
    windowedSignal = window.*x(k:k+frameLength-1);
    xFFT = fft(windowedSignal,nfft);
    STFT(:,i) = xFFT(1:halfFFT);
    k = k+frameHop; % update index
end

% time vector
time = (frameLength/2:frameHop:frameLength/2+(numFrames-1)*frameHop)/fs;

% frequency vector
freq = (0:halfFFT-1)*fs/nfft;

end
%%%%%%%%%%%%%%%%%%%%%
function plotSTFT(time,freq,STFT)
surf(time, freq, STFT)
shading interp
axis tight
view(0, 90)
set(gca, 'FontName', 'Times New Roman', 'FontSize', 13)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Short-Time Fourier Transform')

hcol = colorbar;
set(hcol, 'FontName', 'Times New Roman', 'FontSize', 12)
ylabel(hcol, 'Magnitude (dB)')

view(-45,65)
colormap jet
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function mel = frq2mel(freq)
mel = 2595*log(1+freq/500);
end

function freq = mel2frq(mel)
freq = 700*10^(mel/2595) - 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function m = melfb(p, n, fs)
% MELFB         Determine matrix for a mel-spaced filterbank
%
% Inputs:       p   number of filters in filterbank
%               n   length of fft
%               fs  sample rate in Hz
%
% Outputs:      x   a (sparse) matrix containing the filterbank amplitudes
%                   size(x) = [p, 1+floor(n/2)]
%
% Usage:        For example, to compute the mel-scale spectrum of a
%               colum-vector signal s, with length n and sample rate fs:
%
%               f = fft(s);
%               m = melfb(p, n, fs);
%               n2 = 1 + floor(n/2);
%               z = m * abs(f(1:n2)).^2;
%
%               z would contain p samples of the desired mel-scale spectrum
%
%               To plot filterbanks e.g.:
%
%               plot(linspace(0, (12500/2), 129), melfb(20, 256, 12500)'),
%               title('Mel-spaced filterbank'), xlabel('Frequency (Hz)');

f0 = 700 / fs;
fn2 = floor(n/2);

lr = log(1 + 0.5/f0) / (p+1);

% convert to fft bin numbers with 0 for DC term
bl = n * (f0 * (exp([0 1 p p+1] * lr) - 1));

b1 = floor(bl(1)) + 1;
b2 = ceil(bl(2));
b3 = floor(bl(3));
b4 = min(fn2, ceil(bl(4))) - 1;

pf = log(1 + (b1:b4)/n/f0) / lr;
fp = floor(pf);
pm = pf - fp;

r = [fp(b2:b4) 1+fp(1:b3)];
c = [b2:b4 1:b3] + 1;
v = 2 * [1-pm(b2:b4) pm(1:b3)];

m = sparse(r, c, v, p, 1+fn2);
end












