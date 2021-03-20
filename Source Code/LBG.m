function codebook = LBG(mfcc_coeff, num_centroids)

epsilon = 0.01;

% initializing single-vector codebook
codebook = mean(mfcc_coeff,2);
centroid = 1;
distortion = 10000;

for i = 1:log2(num_centroids)
    codebook = [codebook*(1+epsilon), codebook*(1-epsilon)];
    
    while (1 == 1)
        
        d = disteu(mfcc_coeff, codebook);
        [nearest_codebook, index] = min(d, [], 2);
        temp = 0;
        
        for j = 1:2^i
            
            codebook(:,j) = mean(mfcc_coeff(:, index == j), 2);
            d = disteu(d(:, index == j), codebook(:,j));
            
            for k = 1:length(d)
                temp = temp + d(k);
            end
            
        end
        
        if (((distortion - temp)/temp) < epsilon)
            break;
        else 
            distortion = temp;
        end
    
    end
    
end