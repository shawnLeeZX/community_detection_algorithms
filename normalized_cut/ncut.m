function clusters = ncut(A, k)
    A = sparse(A);
    % Construct the diagonal matrix.
    D = diag(sum(A) + diag(A)');

    % L <- D^(-1/2) * (D - A) * D^(-1/2)
    D_ = D^(-1/2);
    L = D_ * (D - A) * D_;
    % Compute smallest k eigenvectors of L
    [eigenvectors eigenvalues] = eigs(L, k, 'sm');
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
