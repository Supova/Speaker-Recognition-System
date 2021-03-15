function [MFCCcoef, timeVec] = mfcc(s, fs, N, p, M) 
% Inputs:
%     s : speech signal
%     fs : Sampling Frequency
%     N : Frame length = window length
%     p : Number of Mel filter banks
%     M : Frame overlap length
    
% Outputs:
%     MFCCcoef : MFCC coefficents 
%     timeVec : time vector 

    % using MATLAB's stft function to frame, window, and take fft
    [s,freqVec,timeVec] = stft(s, fs, 'Window', hamming(N), 'OverlapLength', M)
    
    % taking the positive half of the stft due to symmetry
    s = s((N/2):end, :);
    
    % take absolute value 
    s = abs(s);
   
   %plot(s)
    
    % Mel-frequency Wrapping using filter banks
    m = melfb(p, N, fs);
    
    % mel filter bank output
    mel_output = m*s;
    
    % 
    log_mel_output = log(mel_output);
    
    % discrete cosine transform
    MFCCcoef = dct(log_mel_output);
    
    % exclude 0'th order cepstral coefficient as it's the mean value 
    % (doesn't provide much info)
    %  output(1,:) = [];    
   
%    consider whether to do scaling here
    
% any plotting neeed

end
