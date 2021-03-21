function test(testdir, n, code, N, p, M)
% Input:
%       testdir : string name of directory contains all test sound files
%       n       : number of test files in testdir
%       code    : codebooks of all trained speakers
%       N       : Frame length = window length
%       p       : Number of Mel filter banks
%       M       : Frame overlap length

% Note:
%       Sound files in testdir is supposed to be: 
%               s1.wav, s2.wav, ..., sn.wav
%
% Example:
%       >> test('C:\Audio\Test\', 11);

% read test sound file of each speaker

disp("Speaker Recognition verification:");

for k = 1:n                    
    file = sprintf('%ss%d.wav', testdir, k);
    [s, fs] = audioread(file);      
    
     % Compute MFCC
    v =  mfcc(s, fs, N, p, M);            
   
    distmin = inf;
    k1 = 0;
   
    % compute distortion for each trained codebook
    for l = 1:length(code)     
        d = disteu(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
      
        % compare distance with threshold
        if dist < distmin
            distmin = dist;
            k1 = l;
        end      
    end
 
    % output results
    msg = sprintf('Speaker ID: %d matches with ID: %d', k, k1);
    disp(msg);
    
end
