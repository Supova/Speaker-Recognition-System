function [s_with_noise, noise] = add_noise(s, noisetype, snr)

    threshold = 10; % 10 dB

    if nargin < 3
        snr = 25;
    end
    if nargin < 2
        noisetype = "white";
    end

    % Set param
    num_samples = length(s);
    num_channels = 1;
    
    bounded_output = (noisetype ~= "brown");

    % Get Noise
    noise = dsp.ColoredNoise(noisetype, num_samples, num_channels, 'BoundedOutput', bounded_output);

    % Scale to specified dB
    scale = db2mag(-1*snr-threshold) * max(abs(s));
    
    if nargin == 1
        scale = 1/2;
    end
    
    scale = scale / max(abs(noise)); % Normalized
    
    noise = scale * noise;

    % Add noise to output
    s_with_noise = s + noise;
    
end