% Input: An adjacent matrix adj of undirected graph.
% Ouput: A list containing all edges of A. Edge is stored in the way like
% this:[i, j, edge_weight].

function edge_list = get_edges(adj)
    vertex_num  = size(adj, 1);
    edges       = find(adj > 0);

    edge_list = [];
    for e = 1:length(edges)
        [i, j] = ind2sub([vertex_num, vertex_num], edges(e));
        edge_list = [edge_list; i, j, adj(i, j)];
    end
end
