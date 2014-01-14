function centroids = compute_centroids(X, idx, K)
% centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by computing
% the means of the data points assigned to each centroid. It is given a dataset
% X where each row is a single data point, a vector idx of centroid assignments
% (i.e. each entry in range [1..K]) for each example, and K, the number of
% centroids. Return a matrix centroids, where each row of centroids is the mean
% of the data points assigned to it.

% Useful variables
[m n] = size(X);

centroids = zeros(K, n);


% Go over every centroid and compute mean of all points that belong to it.
% Concretely, the row vector centroids(i, :) should contain the mean of the data
% points assigned to
% centroid i.

logicalIdx = zeros(length(idx), K);
for i = 1:K
	logicalIdx(:, i) = (idx == i);
end

for i = 1:K
	centroids(i, :) = mean(X(find(logicalIdx(:, i)), :));
end






% =============================================================


end

