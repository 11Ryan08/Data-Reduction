function [cluster_assignments, cluster_centers] = custom_kmeans2(data, k)
    cluster_centers = data(randperm(size(data, 1), k), :);    % k points are randomly selected from the data as the initial cluster center
    cluster_assignments = zeros(size(data, 1), 1);    % creates a vector to store the cluster assignment for each data point
    previous_assignments = cluster_assignments; 

    iteration = 0;
    while true % starts an infinite loop that will execute until the condition to break the loop is met.
        iteration = iteration + 1;
        
        % Assign each data point to the nearest cluster center
        for i = 1:size(data, 1)
            [~, closest_center] = min(sum((data(i, :) - cluster_centers) .^ 2, 2)); % Calculate the sum of squared deviations from data point to k centers and find the smallest.
            cluster_assignments(i) = closest_center;% Assign this data point to the cluster at that center
        end
        
        % Compare the centers of the old cluster and the new cluster, and stop the loop if they are the same, which means that they have convergede
        if isequal(cluster_assignments, previous_assignments)
            break;
        else
            previous_assignments = cluster_assignments; 
        end

        % Find the data points assgined to cluster j in the data. Calculate the mean of these data points, and set the mean as the center of the new cluster
        for j = 1:k
            cluster_centers(j, :) = mean(data(cluster_assignments == j, :), 1);
        end

        
       


     
    end
end


