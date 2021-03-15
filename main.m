% main execution
clear all;
[s1,fs] = audioread('s1.wav');

% Normalize the amplitude to 1
scaled_Sig = ampNormalize(s1, 1)
s1 = scaled_Sig;

%%% Input parameters
% Frame length = window length
N = 256;

% Number of Mel filter banks
p = 20;

% Frame overlap length
M = round(N*2/3);

% calculate MFCC coefficients
[MFCC_1, timeVec_1] = mfcc(s1, fs, N, p, M);

% normalize ceptral coefficents 
MFCC_1 = MFCC_1 ./ max(max(abs(MFCC_1))

% plot ceptral coefficents 
plot_ceptrum(timeVec_1, MFCC_1, p, 1)
