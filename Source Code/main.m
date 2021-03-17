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

[s1,fs] = audioread('s1.wav');
s1 = s1(:,1);

s1 = preProcressing(s1, 1);
 
%plot_timeDomain(s1,1)

% calculate MFCC coefficients
[MFCC_1, timeVec_1] = mfcc(s1, fs, N, p, M);

% normalize ceptral coefficents 
MFCC_1 = MFCC_1 ./ max(max(abs(MFCC_1)));

% plot ceptral coefficents 
 plot_ceptrum(timeVec_1, MFCC_1, p, 1)

% plotting mfcc clusters
figure(2)
plot(MFCC_1(1,:)', MFCC_1(3,:)', 'o')
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
