% main execution
clear all;

%%% Input parameters
% Frame length = window length
N = 256;

% Number of Mel filter banks
p = 20;

% Frame overlap length
%M = round(N*2/3);
M=100;

[sig,fs] = audioread('s1.wav');
sig = sig(:,1);

sig = preProcressing(sig, 1);
 
%plot_timeDomain(s1,1)

% calculate MFCC coefficients
[MFCC, timeVec] = mfcc(sig, fs, N, p, M);

% plot ceptral coefficents 
 plot_ceptrum(timeVec, MFCC, p, 1)

% plotting mfcc clusters
figure(2)
plot(MFCC(1,:)', MFCC(3,:)', 'o')
xlim([-2,2]); ylim([-2,2]);
hold on
xlabel('mfcc_1'); ylabel('mfcc_3')
legend("Speaker: 1")
title('MFCC cluster')
grid on

% [CENTS, DAL] = kmeans(F, K, KMI)
% codebook = LBG(mfcc_coeff, num_centroids)




% plot time domain
function plot_timeDomain(signal,speaker_id)
plot(signal)
xlabel('Time (s)');
ylabel('Amplitude');
title(strcat('Speaker: ', int2str(speaker_id)) );
end



% plot mfcc
function plot_ceptrum(timeVec, MFCCcoef, p, speaker_id)
    figure; 
    surf(timeVec, 1:p, MFCCcoef,'EdgeColor','none'); 
    view(0, 90); 
    colorbar;
    xlim([min(timeVec), max(timeVec)]); 
    ylim([1 p]);
    xlabel('Time (s)'); ylabel('Ceptral Coefficients');
    title(strcat('Speaker: ', int2str(speaker_id)) );
end
