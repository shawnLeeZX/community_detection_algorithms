function clusters = modularity(A, k)
    % Get relevant info.
    vertex_num = size(A, 1);

    A = sparse(A);
    % Construct the diagonal matrix.
    d = sum(A) + diag(A)';

    % B = A - d'd / 2m
    B = A - d' * d / (2 * vertex_num);
    % Compute smallest k eigenvectors of B
    [eigenvectors eigenvalues] = eigs(B, k, 'lm');
    % Form low dimension representation of vertice
    lower_dimension_representation = eigenvectors;

    % Cluster new representation of vertice using k means algorithm.
    clusters_vector = k_means_clustering(A, k, 300);

    % Change the representation of clusters into cell array.
    clusters = {};
    for i = 1:k
        clusters{i} = find(clusters_vector == i);
    end
end
