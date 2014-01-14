function clusters = rcut(A, k)
    A = sparse(A);
    % Construct the diagonal matrix.
    D = diag(sum(A) + diag(A)');

    % L <- D - A
    L = D - A;
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
