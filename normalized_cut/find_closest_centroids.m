function idx = find_closest_centroids(X, centroids)
% FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

idx = zeros(size(X,1), 1);

% Go over every example, find its closest centroid, and store the index inside
% idx at the appropriate location.  Concretely, idx(i) should contain the index
% of the centroid closest to example i. Hence, it should be a value in the range
% 1..K

    for i = 1:size(X, 1)
        minDistance = (centroids(1, :) - X(i, :)) * (centroids(1, :) - X(i, :))';
        minCluster = 1;
        for j = 2:K
            distanceTmp = (centroids(j, :) - X(i, :)) * (centroids(j, :) - X(i, :))';
            if distanceTmp < minDistance
                minDistance = distanceTmp;
                minCluster = j;
            end
        end
        idx(i) = minCluster;
    end

end

