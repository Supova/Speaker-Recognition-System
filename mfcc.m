% for mfcc

clear; clc;

% reading the audio signal
[sig,fs] = audioread('s1.wav');

% Frame Blocking
N = length(sig); %total num of samples
ts=0.01; %Frame step in seconds
frame_step=floor(ts*fs); %Frame step in samples
frame_duration=0.03; %Frame duration in seconds (30 ms)
frame_length=ceil(frame_duration*fs); %Number of samples per frame

for K = 1 : size(sig,2)
    y{K} = buffer(sig(:,K), frame_length, frame_step);
end

y = cell2mat(y);

% Reference for frame blocking: 
% https://www.mathworks.com/matlabcentral/answers/230815-how-can-i-divide-an-audio-signal-into-overlap-frames-and-take-fft-to-the-signal

% Windowing
hamwin = hamming(N+1)';
y_win = y.*hamwin;

% FFT
yfft = fft(y_win);
