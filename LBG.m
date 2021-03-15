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