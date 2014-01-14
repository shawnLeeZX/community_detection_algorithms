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
