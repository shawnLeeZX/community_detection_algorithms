function clusters = alinkjaccard(A, k)
    if nargin != 2
       error('alinkjaccard requires two arguments');
       help(mfilename)
       return
    end

    % Variables initialization.
    jaccard_distance_matrix = -ones(size(A));

    % Get relevant info about adjacent matrix.
    [discarded vertex_num] = size(A);

    % Get Jaccard distance adjacent matrix from normal adjacent matrix.
    for i = 1:(vertex_num - 1)
        for j = (i + 1):vertex_num
            jaccard_distance_matrix(i, j) = ...
            jaccard_distance_matrix(j, i) = ...
            (sum(A(i, :) & A(j, :))) / (sum(A(i, :) | A(j, :)));
        end
    end

    % Create clusters using cells.
    clusters = num2cell(1:vertex_num);

    for i = 1:(vertex_num - k)

        % Merge closest cells into k clusters using average link.
        %% Find the closest pair of clusters.
        [closests closest_row_nums] = max(jaccard_distance_matrix);
        [discarded cluster_col]     = max(closests);
        cluster_row                 = closest_row_nums(cluster_col);

        %% Use i, j to make the code more obvious -- i is the more with less index.
        cluster_i = min(cluster_row, cluster_col);
        cluster_j = max(cluster_row, cluster_col);

        %% Merge the two cluster into the one with smaller index.
        clusters{cluster_i} = [clusters{cluster_i}, clusters{cluster_j}];
        %% Delete the one with larger index.
        clusters(cluster_j) = [];

        %% Update jaccard_distance_matrix.
        jaccard_distance_matrix(cluster_i, :) = ...
            (jaccard_distance_matrix(cluster_i, :) + ...
            jaccard_distance_matrix(cluster_j, :)) / 2;

        jaccard_distance_matrix(:, cluster_i) = jaccard_distance_matrix(cluster_i, :)';
        jaccard_distance_matrix(cluster_i, cluster_i) = -1;
        jaccard_distance_matrix(cluster_j, :) = [];
        jaccard_distance_matrix(:, cluster_j) = [];
    end
end
