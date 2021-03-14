function codebook = LBG(feature, M)

epsilon = 0.01;

% initializing single-vector codebook
codebook = mean(feature, 1);
centroid = 1;
D = 1;

while centroid < M
    
    % doubling size of codebook
    temp = zeros([length(codebook), centroid*2]);
    
    % calculating yn+ and yn-
    if centroid == 1
            temp(:,0) = codebook*(1+epsilon);
            temp(:,1) = codebook*(1-epsilon);
    else   
            for i = 0:range(centroid)
                temp(:,2*i) = codebook(:,i) * (1+eps);
                temp(:,2*i+1) = codebook(:,i) * (1-eps);   
            end 
    end 
    
    codebook = temp;
    centroid = size(codebook);
    
end 

d = disteu(feature, codebook);

while abs(D) > epsilon
    
    % nearest neighbour search
    prev_distance = mean(d);
    nearest_codebook = min(d,axis == 1);
    
    % cluster vectors and find new centroid
    for i = 0:range(centroid)
        codebook(:,i) = mean(feature(:,nearest_codebook == i), 2);
    end 
      
    % updating centroid
    % replace all NaN values with 0
    codebook(isnan(codebook)) = 0;
    
    d = disteu(feature, codebook);
    
    % computing distortion            
    D = (prev_distance - mean(d))/prev_distance;
    
end

end