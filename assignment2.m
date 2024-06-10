%% 1.1 The Poisson distribution (15 points)

r = 5; 
T = 1; 
n_values = 0:20;
probabilities = arrayfun(@(n) mypoisson(r, T, n), n_values);% Calculates the probability for each n through arrayfun.

% Plot the probabilities
bar(n_values, probabilities);
xlabel('Number of spikes');
ylabel('Probability');
title('Poisson Distribution');
%% 1.2 Generating Poisson spike trains (15 points)

z = 10;  
T = 1;  
dt = 0.01;  
[spike_times, binned_spike_train] = poisson1(z, T, dt);

% Visualize with a raster plot using vertical lines
figure;
for i = 1:length(spike_times)
    line([spike_times(i) spike_times(i)], [0 1], 'Color', 'k'); 
end
xlabel('Time (s)');
ylabel('Spike Train');
title('Raster Plot of Poisson Spike Train');

%The selection of dt should be small enough to capture the details of the spike train. But too small a dt can also increase the computational load.
%% 1.3 An alternative method for generating Poisson spike trains (10 points)

z = 10;  
T = 1;  
dt = 0.01;  
[spike_times, binned_spike_train] = poisson2(z, T, dt);

% Visualize with a raster plot using vertical lines
figure;
for i = 1:length(spike_times)
    line([spike_times(i) spike_times(i)], [0 1], 'Color', 'k'); 
end
xlabel('Time (s)');
ylabel('Spike Train');
title('Raster Plot of Poisson Spike Train');

% poisson2 has higher computing efficiency than poisson1
% poisson1 is a more accurate representation of the randomness of Poisson processes than poisson2
% Because the probability of a spike for a bin of poisson2 is independent of how long it has been since the last spike occurred, this does not conform to Poisson process
%% 1.4 The inhomogeneous Poisson process (10 points)
% Test the function
T = 2; 
dT = 0.001; 
Z = [ones(1, T/(2*dT)) * 50, ones(1, T/(2*dT)) * 200];
[spike_times, binned_spike_train] = poisson3(Z, T, dT);

% Visualize the spike train as a raster plot
figure;
for i = 1:length(spike_times)
    line([spike_times(i) spike_times(i)], [0 1], 'Color', 'k'); 
end
xlabel('Time (s)');
ylabel('Spike Train');
title('Raster Plot of Poisson Spike Train');


T = 2; 
dT = 0.0001; 
Z = [ones(1, T/(2*dT)) * 100, ones(1, T/(2*dT)) * 800];% The firing rate is 100 for the first half of duration and 800 for the second half
[spike_times, binned_spike_train] = poisson3(Z, T, dT);

% Visualize the spike train as a raster plot
figure;
for i = 1:length(spike_times)
    line([spike_times(i) spike_times(i)], [0 1], 'Color', 'k'); 
end
xlabel('Time (s)');
ylabel('Spike Train');
title('Raster Plot of Poisson Spike Train');

%% 2.1 Implement the k-means algorithm for spike sorting (30 points)

load('waveforms.mat'); 
[coeff, score, latent] = pca(waveforms); % Run PCA 
data2D = score(:, 1:2); % Select the first two principal components
%%
k = 3;
[assignments, centers] = custom_kmeans(data2D, k);

% Visualize the final clusters after convergence
figure;
gscatter(data2D(:,1), data2D(:,2), assignments);
title('Final Cluster Assignments');

%If the initial cluster centers are located in a centralized location, the method may take more time to sort.
%If the number of clusters used is too large, some clusters should be classified as one cluster. 
%If the number of clusters used is too small, the difference within the
%cluster would be large.
%% 2.2 A more challenging spike sorting problem (20 points)

load('waveforms_difficult.mat');
[coeff, score, latent] = pca(waveforms);% Run PCA 
explainedVariance = cumsum(latent)./sum(latent);
nComponents = find(explainedVariance > 0.85, 1); % Select the number of components that capture 85 portion of variance
data4D = score(:, 1:nComponents); % Reduce data to 4-dimensional data
% Unlike the above data, this one requires more dimensions to explain its
% features. And it is  difficult to visualize
%%
sse = [];
for k = 1:10
    [assignments, centers] = custom_kmeans2(data4D, k); 
    sse(end+1) = sum(sqrt(sum((data4D - centers(assignments, :)) .^ 2, 2)));% Caculate SSE, which measures the compactness of cluster allocation - the smaller the SSE, the more compact the cluster.
end

figure;
plot(1:10, sse, '-o');
xlabel('Number of clusters');
ylabel('Sum of squared errors');
title('Decline of SSE')

% It can be seen from the image that when k=6, the rate of SSE decline begins to slow down.
% This means that more clusters do not significantly increase the compactness of clusters.
% So 6 clusters are enough to classify these data points

% Pitfalls and problems with the k-means method
%If the specific number of clusters k is not known in advance, it is difficult to determine the correct value of k, especially for data that is difficult to distinguish visually
%For data that requires multidimensional interpretation, k-mean makes it difficult to visualize the results
%As mentioned above, k-mean is sensitive to the initial cluster center and number of cluster used


