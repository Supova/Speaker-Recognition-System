function [output, t] = mfcc(s, fs, N, p, M) %% fix this
% s - Audio vector (assuming 1-channel/mono-channel)
% fs - Sampling Frequency
% N - Number of elements in Hamming window for stft()
% p - Number of filters in the filter bank for melfb
% M - overlap length for stft()

    % using MATLAB's stft function to frame, window, and take fft
    [s,f,t] = stft(s, fs, 'Window', hamming(N), 'OverlapLength', M);
    
    % Mel-frequency Wrapping using filter banks
    m = melfb(p, N, fs)
    
    % taking the positive half of the stft due to symmetry
    s = s((N/2):end, :)
    
    % convert amplitude to dB 
    s = mag2db(abs(s));
    
    % mel filter bank output
    mel_output = m*s
    
    % discrete cosine transform
    output = dct(mel_output)
    
    
   
    
    % Step 6: Plot the amplitude output of the dct
    %plotSpec(ystt, 1:p, cn); caxis([-30 15]);
    %xlim([min(ystt), max(ystt)]); ylim([1 p]);
    %xlabel('Time (s)'); ylabel('mfc coefficients')
end
