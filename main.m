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























function scaled_Sig = ampNormalize(signal, maxAmp)
%     Normalize or scale the amplitude to a value specified
% 
%     Input Parameters : 
%                signal       Input signal
%                maxAmp       Expected peak value (0 ~ 1)
%     Output Parameters:  
%                out      Scaled signal

    % preallocate scaled signal vector
    scaled_Sig = zeros(length(signal),1);
    
    % if the maximum amplitude is greater than 1 or is a negative valuem then throw error
    if( maxAmp > 1 || maxAmp < 0 )
        fprintf('(ampMax) out of bound.');
    else
    % scale appropriately by max and min of signal
        if max(signal) > abs(min(signal))
            scaled_Sig = signal*(maxAmp/max(signal));
        else
            scaled_Sig = signal*((-maxAmp)/min(signal));
        end
    end

end



% plot the MFCC coefficents 
function plot_ceptrum(timeVec, MFCCcoef, p, speaker_id)
    figure; 
    surf(timeVec, 1:p, MFCCcoef,'EdgeColor','none'); 
    view(0, 90); 
    colorbar;
    xlim([min(timeVec), max(timeVec)]); 
    ylim([1 p]);
    xlabel('Time (s)'); 
    ylabel('Ceptral Coefficients');
    title(strcat('Speaker: ', int2str(speaker_id)) );
end
