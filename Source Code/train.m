function code = train(traindir,n, N, p, M)
% Speaker Recognition: Training Stage
%
% Input:
%       traindir : string name of directory contains all train sound files
%       n        : number of train files in traindir
%       m        : number of centroids required
%
% Output:
%       code     : trained VQ codebooks, code{i} for i-th speaker
%
% Note:
%       Sound files in traindir is supposed to be: 
%                       s1.wav, s2.wav, ..., sn.wav
% Usage:
%       >> code = train('C:\Audio\Training\', 11);

% number of centroids required
m = 10;

% train a VQ codebook for each speaker
for i = 1:n                     
    file = sprintf('%ss%d.wav', traindir, i);           
    disp(file)
   
    % read in all audio files
    [s, fs] = audioread(file);
    
    % adding noise
    % s = add_noise(s, "white", 30); % adding 30 dB of white noise
    % s = add_noise(s, "pink", 30); % adding 30 dB of pink noise
    % s = add_noise(s, "brown", 30); % adding 30 dB of brown noise
    
    % notch filter computations
    % f0 = 60; % tone that needs to be removed
    % w0 = f0 / (fs/2);
    % q = 30; % q factor
    % bw = w0/q;
    % [num,den] = iirnotch(w0,bw);
    % s = filter(num,den,s); % notch filtered signal s
    
    % Compute MFCC
    v = mfcc(s, fs, N, p, M); 
    
    % Train VQ codebook
    code{i} = LBG(v, m);      
end
