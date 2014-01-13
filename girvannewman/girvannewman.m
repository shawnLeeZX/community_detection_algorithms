% Input:    Adjacent matrix adj, and intended number k clusters.
% Output:   A cell array containing clusters.
% Algorithm: Keep removing edge with the highest edge betweenness score until
% there are k clusters.
% After each time a division is made, the next computation of edge
% betweenness is performed on the cluster who has the largest number of
% vertice.

function clusters = girvannewman(adj, k)
    % Initialization.
    vertex_num          = size(adj, 1);
    clusters_verbose    = struct('vertice', 0, 'vertice_num', vertex_num);
    clusters_verbose.vertice = {1:vertex_num};
    current_comp_num    = 1;
    subgraph_adj        = adj;

    % Keep removing edge with the highest edge betweenness score until
    % there are k clusters.
    while length(clusters_verbose.vertice) < k

        % Keep removing edges until the graph is not connected.
        while is_connected(subgraph_adj)
            edge_betweenness = get_edge_betweenness(subgraph_adj);

            % Get the edge with the largest edge betweenness.
            [discarded e] = max(edge_betweenness(:, 3));

            % Remove the edge.
            i = edge_betweenness(e, 1);
            j = edge_betweenness(e, 2);
            subgraph_adj(i, j) = 0;
            subgraph_adj(j, i) = 0;
            % Update the original adjacenct matrix as well.
            adj( ...
                clusters_verbose.vertice{current_comp_num}(i), ...
                clusters_verbose.vertice{current_comp_num}(j) ...
                ) = 0;
            adj( ...
                clusters_verbose.vertice{current_comp_num}(j), ...
                clusters_verbose.vertice{current_comp_num}(i) ...
                ) = 0;
        end

        % Add new components of the subgraph into cluster_verbose.
        conn_comps                  = find_connected_component(subgraph_adj);
        % Change the vertex number back to real vertex number.
        for i = 1:length(conn_comps)
            clusters_verbose.vertice = {clusters_verbose.vertice{:}, ...
                clusters_verbose.vertice{current_comp_num}(conn_comps{i})};
        end
        % Delete current components.
        clusters_verbose.vertice(current_comp_num) = [];

        % Find component with the largest number of vertice and set it as next
        % current component.
        components_num                  = length(clusters_verbose.vertice);
        clusters_verbose.vertice_num    = zeros(1, components_num);
        for i = 1:components_num
            clusters_verbose.vertice_num(i) = length(clusters_verbose.vertice{i});
        end
        [discarded, current_comp_num]   = max(clusters_verbose.vertice_num);
        subgraph_adj                    = adj( ...
                                clusters_verbose.vertice{current_comp_num}, ...
                                clusters_verbose.vertice{current_comp_num});
    end

    clusters = clusters_verbose.vertice;
end
