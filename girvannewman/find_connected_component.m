function connected_components = find_connected_component(adj)
    % Get relevant info about the graph.
    vertex_num = size(adj, 1);

    connected_components        = {};

    % For each vertex in graph, if its degree is not zero, then find the
    % connected components it belongs. If its degree is zero, it is already an
    % independent connected graph. Add it to connected_components.
    vertex_degrees = get_vertex_degrees(adj);

    for i = 1:vertex_num
        if vertex_degrees(i) > 0
            found = false;
            % Check whether vertex i is already in a component.
            for j = 1:length(connected_components)
                if sum(connected_components{j} == i) > 0
                    found = true;
                    break;
                end
            end

            % If not, find the component it belongs and add it to
            % connected_components.
            if not(found)
                component = find_which_component_belong(adj, i);
                connected_components{length(connected_components) + 1} = component;
            end
        else
            connected_components{length(connected_components) + 1} = i;
        end
    end

end

% Input:    adjacent matrix A, and the vertex number i.
% Output:   A vector containing all vertex in the connected component.
% Starting from neighbors of u, keep expanding the set that u can reach until
% the set will not change. Then the set then is the connected
% component u belongs.
function connected_component = find_which_component_belong(adj, u)
    % Get relevant info about the graph.
    vertex_num = size(adj, 1);

    neighbors = find(adj(u, :) > 0);
    reach_set = [neighbors u];

    while 1
        old_reach_set       = reach_set;
        old_reach_set_len   = length(reach_set);
        for v = old_reach_set
            neighbors = find(adj(v, :) > 0);
            reach_set = unique([reach_set neighbors]);
        end

        if length(reach_set) == old_reach_set_len
            connected_component = reach_set;
            return;
        end
    end
end
