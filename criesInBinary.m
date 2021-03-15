% main execution
clear all;
[s1,fs] = audioread('s1.wav');
s1 = s1(:,1);

% Normalize the amplitude to 1
scaled_Sig = ampNormalize(s1, 1);
s1 = scaled_Sig;

% stemp = round(s1, 3);  
crit = abs(s1) > 0.01;
s1 = s1(find(crit, 1, 'first'):find(crit, 1, 'last'));

%%% Input parameters
% Frame length = window length
N = 256;

% Number of Mel filter banks
p = 20;

% Frame overlap length
%M = round(N*2/3);
M=100;

% calculate MFCC coefficients
[MFCC_1, timeVec_1] = mfcc(s1, fs, N, p, M);

% normalize ceptral coefficents 
MFCC_1 = MFCC_1 ./ max(max(abs(MFCC_1)))

%%%%%%%%%%%%%%%
[s5,fs5] = audioread('s10.wav');
s5 = s5(:,1);

scaled_Sig5 = ampNormalize(s5, 1);
s5 = scaled_Sig5;

crit = abs(s5) > 0.01;
s5 = s5(find(crit, 1, 'first'):find(crit, 1, 'last'));

[MFCC_5, timeVec_5] = mfcc(s5, fs, N, p, M);
MFCC_5 = MFCC_5 ./ max(max(abs(MFCC_5)))

%%%%%%%%%%%%%%%%%%%%%%%

% plot ceptral coefficents 
% plot_ceptrum(timeVec_1, MFCC_1, p, 1)

% figure
% plot(MFCC_1(3,:), MFCC_1(5,:)', 'x')
% hold on
% plot(MFCC_5(3,:)', MFCC_5(5,:)', 'o')
% xlabel('mfcc-3'); ylabel('mfcc-5')
% %legend("Speaker 3", "Speaker 5")
% grid on
% title("mfcc space")



F = MFCC_1
feature_vector     = F;                                 % Input
number_of_clusters = 4;                                 % Number of Clusters
Kmeans_iteration   = 40;                                % K-means Iteration
%% Test K-means
[cluster_centers, data]  = km_fun(feature_vector, number_of_clusters, Kmeans_iteration); % K-means clusterig
%% Plot   
CV    = '+r+b+c+m+k+yorobocomokoysrsbscsmsksy';       % Color Vector
%hold on
 for i = 1 : number_of_clusters
     PT = feature_vector(data(:, number_of_clusters+1) == i, :);                % Find points of each cluster    
     plot(PT(:, 1),PT(:, 2),CV(2*i-1 : 2*i), 'LineWidth', 2);                   % Plot points with determined color and shape
     plot(cluster_centers(:, 1), cluster_centers(:, 2), '*k', 'LineWidth', 7);  % Plot cluster centers
 end
hold off
grid on



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
    %s = abs(s);
   s = s .* conj(s)
    
   %plot(s)
    
    % Mel-frequency Wrapping using filter banks
    m = melfb(p, N, fs);
    
    % mel filter bank output
    mel_output = m*s;
    
    % 
    log_mel_output = log10(mel_output);
    
    % discrete cosine transform
    MFCCcoef = dct(log_mel_output)
    
    % normalize ceptral coefficents 
 %   MFCC_1 = MFCC_1 ./ max(max(abs(MFCC_1)))
   
    % exclude 0'th order cepstral coefficient as it's the mean value 
    % (doesn't provide much info)
    %  output(1,:) = [];    
   
%    consider whether to do scaling here
    
% any plotting neeed


end
% ////////////////////////////////////////////


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
%/////////////////////////////////
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%
function scaled_Sig = ampNormalize(signal, maxAmp)
%     Normalize or scale the amplitude to a value specified
% 
%     Input Parameters : 
%                signal       Input signal
%                maxAmp       Expected peak value (0 ~ 1)
%     Output Parameters:  
%                out      Scaled signal

    scaled_Sig = zeros(length(signal),1);
    if( maxAmp > 1 || maxAmp < 0 )
        fprintf('(ampMax) out of bound.');
    else
        if max(signal) > abs(min(signal))
            scaled_Sig = signal*(maxAmp/max(signal));
        else
            scaled_Sig = signal*((-maxAmp)/min(signal));
        end
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function codebook = LBG(mfcc_coeff, num_centroids)

epsilon = 0.01;

% initializing single-vector codebook
codebook = mean(mfcc_coeff,2);
centroid = 1;
D = 1;

while centroid < num_centroids
    
    % doubling size of codebook
    temp = zeros([length(codebook), centroid*2]);
    
    % calculating yn+ and yn-
    if centroid == 1
            temp = [codebook*(1+epsilon), codebook*(1-epsilon)];
    else   
            for i = 0:range(centroid)
                temp = [codebook(:,i) * (1+epsilon), codebook(:,i) * (1-epsilon)];   
            end 
    end 
    
    codebook = temp;
    centroid = size(codebook);
    
end 

d = disteu(mfcc_coeff, codebook);

while abs(D) > epsilon
    
    % nearest neighbour search
    prev_distance = mean(d);
    nearest_codebook = min(d, [], 2);
    
    % cluster vectors and find new centroid
    for i = 0:range(centroid)
        codebook(:,i) = mean(mfcc_coeff(:, nearest_codebook == i), 2);
    end 
      
    % updating centroid
    % replace all NaN values with 0
    codebook(isnan(codebook)) = 0;
    
    d = disteu(mfcc_coeff, codebook);
    
    % computing distortion            
    D = (prev_distance - mean(d))/prev_distance;
    
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function d = disteu(x, y)
% DISTEU Pairwise Euclidean distances between columns of two matrices
%
% Input:
%       x, y:   Two matrices whose each column is an a vector data.
%
% Output:
%       d:      Element d(i,j) will be the Euclidean distance between two
%               column vectors X(:,i) and Y(:,j)
%
% Note:
%       The Euclidean distance D between two vectors X and Y is:
%       D = sum((x-y).^2).^0.5

[M, N] = size(x);
[M2, P] = size(y); 

if (M ~= M2)
    error('Matrix dimensions do not match.')
end

% output matrix
d = zeros(N, P);

% finding average distortion
if (N < P)
    copies = zeros(1,P);
    for n = 1:N
        d(n,:) = sum((x(:, n+copies) - y) .^2, 1);
    end
else
    copies = zeros(1,N);
    for p = 1:P
        d(:,p) = sum((x - y(:, p+copies)) .^2, 1)';
    end
end

% final distortion val
d = d.^0.5;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% K-means

function [CENTS, DAL] = km_fun(F, K, KMI)

CENTS = F( ceil(rand(K,1)*size(F,1)) ,:);              % Cluster Centers
DAL   = zeros(size(F,1),K+2);                          % Distances and Labels

for n = 1:KMI
        
   for i = 1:size(F,1)
      for j = 1:K  
        DAL(i,j) = norm(F(i,:) - CENTS(j,:));      
      end
      [Distance, CN] = min(DAL(i,1:K));                % 1:K are Distance from Cluster Centers 1:K 
      DAL(i,K+1) = CN;                                 % K+1 is Cluster Label
      DAL(i,K+2) = Distance;                           % K+2 is Minimum Distance
   end
   for i = 1:K
      A = (DAL(:,K+1) == i);                           % Cluster K Points
      CENTS(i,:) = mean(F(A,:));                       % New Cluster Centers
      if sum(isnan(CENTS(:))) ~= 0                     % If CENTS(i,:) Is Nan Then Replace It With Random Point
         NC = find(isnan(CENTS(:,1)) == 1);            % Find Nan Centers
         for Ind = 1:size(NC,1)
         CENTS(NC(Ind),:) = F(randi(size(F,1)),:);
         end
      end
   end

end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
