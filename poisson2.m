function [spike_times, binned_spike_train] = poisson2(Z, T, dT)
    numBins = floor(T/dT);% Calculate the number of bins
    binned_spike_train = zeros(1, numBins);
    
    % Generate the spike train
    for i = 1:numBins
        randNum = rand;
        threshold = Z * dT;
        %If the random number is less than thereshold, then the value 1 is assigned to the bin, indicating that a spike occurred in the bin
        if randNum < threshold
            binned_spike_train(i) = 1;
        end
    end
    
    % Convert the binned spike train to spike times
    % Find the non-0 bin of the binned_spike_train, which is the bin where the spike occurs. Multiply the width of the bin dt, and get the time point at which the spike actually occurs
    spike_times = find(binned_spike_train) * dT;
end
