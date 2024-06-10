function [spike_times, binned_spike_train] = poisson1(z, T, dt)
    spike_times = [];
    num_bins = floor(T / dt);
    binned_spike_train = zeros(1, num_bins);

    % Generate the spike time
    current_time = 0;
    while current_time < T
        interval = -log(rand)/z;% Generate an inter-spike interval through inversion method
        current_time = current_time + interval;
        if current_time < T % Ensure that the current spike does not occur for longer than duration
            spike_times(end+1) = current_time; % Record the occurrence time of the current spike into the spike_time sequence
        end
    end
    
    % Generate the spike train
    for spike = spike_times
        bin_index = floor(spike/dt) + 1;% Calculates the bin location of the current spike
        binned_spike_train(bin_index) = binned_spike_train(bin_index) + 1;% Assign this bin the value 1
    end
end
