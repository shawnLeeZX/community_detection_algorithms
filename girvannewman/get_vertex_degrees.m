% Input:    adjacent matrix(weighted or unweighted).
% Output:   vertice degrees.
% Note: it only works for undirected graph.
function degrees = get_vertex_degrees(adj)
    no_loop_degrees = sum(adj);

    % Add self loop edges if any.
    degrees = no_loop_degrees + (diag(adj))';
end
