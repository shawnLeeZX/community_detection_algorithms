function clusters = k_means_clustering(A, k, max_iterations)

    % Randomly initialize k centroids.
    centroids = k_means_init_centroids(A, k);

    for i = 1:max_iterations
        % Categorize samples into the k centroids using Euclidean distance.
        clusters = find_closest_centroids(A, centroids);

        % Recalculate centroids.
        centroids = compute_centroids(A, clusters, k);
    end
end
