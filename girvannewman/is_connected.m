function is_connected = is_connected(adj)
    vertex_num  = size(adj, 1);
    x           = [1; zeros(vertex_num - 1, 1)];

    % Starting from the first vertex, see whether it can traverse the entire
    % graph or not.
    while 1
        y = x;
        x = adj * x + x;
        x = x > 0;

        if y == x
            break;
        end
    end

    if sum(x) < vertex_num
        is_connected = false;
    else
        is_connected = true;
    end
end
