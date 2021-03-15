function code = training(trainingdir, n)

k = 11;                         % number of centroids required

for i = 1:n                     % train a VQ codebook for each speaker
    file = sprintf('%ss%d.wav', trainingdir, i);           
    disp(file);
   
    [s, fs] = audioread(file);
    
    v = mfcc(s, fs);            % Compute MFCC's
   
    code{i} = LBG(v, k);      % Train VQ codebook
end