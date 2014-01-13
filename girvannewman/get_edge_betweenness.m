% Edge betweenness computation.
% INPUTs: adjacent matrix A.
% OUTPUTs: edge_betweenness -- a edge list with each row with the format [i, j,
% edge_betweenness].
% Note: Valid for undirected graphs only

function edge_betweenness = get_edge_betweenness(A)
    % Get relevant information about the adjacent matrix.
    vertex_num          = size(A, 1);
    edge_betweenness    = get_edges(A);

    % Set edge_betweenness of each edge to zero(function get_edges return an edge
    % list with third column to be edge weight.
    edge_betweenness(:, 3) = 0;

    % Do DFS travese for each vertex in the graph.
    for s = 1:vertex_num
        % DFS travese.
        % Initialization.
        queue       = [s];
        edge_list   = edge_betweenness;

        % Abstract info about vertice into one structure.
        vertex_info = struct( ...
            'visited', false(1, vertex_num), ...
            'in_queue', false(1, vertex_num), ...
            'distance', inf(1, vertex_num), ...
            'weight', zeros(1, vertex_num) ...
            );

        % Initialize source node distance and weight.
        vertex_info.distance(s) = 0;
        vertex_info.weight(s)   = 1;

        while not(isempty(queue))
            % Dequeue.
            u                       = queue(1);
            queue                   = queue(2:end);
            vertex_info.in_queue(u) = false;

            vertex_info.visited(u)  = true;

            % Input: adjacent matrix A, a vertex u 
            % Ouput: return the neighbors of the vertex u.
            % neighbors = get_neighbors(A, u);
            neighbors = find(A(u, :) > 0);

            % For vertex in neighbors, add to queue if unvisited and not in
            % queue.
            for neighbor = neighbors
                if not(vertex_info.in_queue(neighbor) | ...
                vertex_info.visited(neighbor))
                    queue                           = [queue neighbor];
                    vertex_info.in_queue(neighbor)  = true;
                end
            end

            % (a) If j has not yet been assigned a distance, it
            % is assigned distance dj = di + 1 and weight
            % wj = wi .
            % (b) If j has already been assigned a distance and
            % dj = di + 1, then the vertex’s weight is in-
            % creased by wi , that is wj ← wj + wi .
            % (c) If j has already been assigned a distance and
            % dj < di + 1, we do nothing.
            for neighbor = neighbors
                if vertex_info.distance(neighbor) == inf
                    vertex_info.distance(neighbor)  = vertex_info.distance(u) + 1;
                    vertex_info.weight(neighbor)    = vertex_info.weight(u);
                elseif vertex_info.distance(neighbor) == vertex_info.distance(u) + 1
                    vertex_info.weight(neighbor) = vertex_info.weight(neighbor) ...
                                                    + vertex_info.weight(u);
                end

            end
        end

        % Compute edge betweenness from distance and weight computed.
        % Starting from the vertice that are farthest from the source, computer
        % edge betweenness between them and their neighbors.
        distance_sorted     = unique(vertex_info.distance);
        distance_descend    = (-sort(-distance_sorted));

        for distance = distance_descend
            % Find vertice whose distance equals current distance.
            vertice = find((vertex_info.distance == distance) > 0);

            for vertex = vertice
                % Get its neighbors.
                neighbors = find(A(vertex, :) > 0);

                % Categorize its neighbors into the ones that are farther than it
                % and that are closer than it. Remove neighbors with the same
                % distance.
                farther = [];
                closer  = [];
                for neighbor = neighbors
                    if vertex_info.distance(neighbor) < distance
                        closer = [closer neighbor];
                    elseif vertex_info.distance(neighbor) > distance
                        farther = [farther neighbor];
                    end
                end

                % For neighbors that are closer to the source than it, compute the
                % edge betweenness of the edge connecting the vertex and the
                % neighbor.
                %% Compute the score that is 1 plus the sum of the scores on the
                %% neighboring edges immediately below it (i.e., those with which it
                %% shares a common vertex).
                score = 1;
                for neighbor = farther
                    i_list = find(edge_list(:, 1) == vertex);
                    j_list = find(edge_list(:, 2) == neighbor);
                    e = intersect(i_list, j_list);
                    score = score + edge_list(e, 3);
                end

                %% For each closer neighbor, the edge betweenness between it and the
                %% vertex is the score computed multiplied by wi/wj.
                for neighbor = closer
                    i_list = find(edge_list(:, 1) == vertex);
                    j_list = find(edge_list(:, 2) == neighbor);
                    e = intersect(i_list, j_list);
                    i = edge_list(e, 1);
                    j = edge_list(e, 2);
                    rate = vertex_info.weight(neighbor) / ...
                            vertex_info.weight(vertex);
                    edge_list(e, 3) = score * rate;
                    % Note: two edges should be updated since (i,j) and (j,i) are
                    % both stored.
                    i_list = find(edge_list(:, 1) == neighbor);
                    j_list = find(edge_list(:, 2) == vertex);
                    e_ = intersect(i_list, j_list);
                    edge_list(e_, 3) = edge_list(e, 3);
                end

            end
        end

        edge_betweenness(:, 3) = edge_betweenness(:, 3) + edge_list(:, 3);
    end

    % Normalize the final edge betweenness.
    edge_betweenness(:, 3) = edge_betweenness(:, 3) / vertex_num * (vertex_num - 1);
end
