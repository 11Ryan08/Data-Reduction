 function [spike_times, binned_spike_train] = poisson3(Z, T, dT)
    numBins = floor(T/dT);
    binned_spike_train = zeros(1, numBins);
    
    for i = 1:numBins
        % Unlike possion2, z now has different values in different bins, and the rest of the steps are the same
        currentRate = Z(i);
        randNum = rand;
        threshold = currentRate * dT;
        if randNum < threshold
            binned_spike_train(i) = 1;
        end
    end
    
    spike_times = find(binned_spike_train) * dT;
end

