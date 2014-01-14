% Input: clusters in cell array format. 
%       vertex num
%       filename
% This function write clustering results into file in the following format:
% 1 each vertex takes up a row, the num is the group id it belongs to.
% 2
% 2
% ...

function write_clustering_results_to_file(clusters, vertex_num, filename)
    cluster_num         = length(clusters);
    clustering_result   = zeros(1, vertex_num);

    for i = 1:cluster_num
        for vertex = clusters{i}
            clustering_result(vertex) = i;
        end
    end

    fid = fopen(filename, 'w');
    fprintf(fid, '%i\n', clustering_result);
    fclose(fid);

end
