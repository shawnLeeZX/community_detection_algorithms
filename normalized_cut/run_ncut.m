for i = 1:10
    % polbook dataset.
    load('../data/full/polbooks.mat');

    clusters = ncut(A, k);

    [discarded vertex_num] = size(A);

    write_clustering_results_to_file(clusters, vertex_num, ['polbook_' i+48 '_ncut.txt']);

    [nmi acc] = evaluation(['polbook_' i+48 '_ncut.txt'], '../data/ground/polbooks_gd.txt', k)
    fid = fopen('polbook_ncut_evaluation', 'a');
    fprintf(fid, '%f\n', [nmi acc]);
    fprintf(fid, '\n');
    fclose(fid);

    % football dataset.
    load('../data/full/football.mat');

    clusters = ncut(A, k);

    [discarded vertex_num] = size(A);

    write_clustering_results_to_file(clusters, vertex_num, ['football_' i+48 '_ncut.txt']);

    [nmi acc] = evaluation(['football_' i+48 '_ncut.txt'], '../data/ground/football_gd.txt', k)
    fid = fopen('football_ncut_evaluation', 'a');
    fprintf(fid, '%f\n', [nmi acc]);
    fprintf(fid, '\n');
    fclose(fid);

end

% dblp dataset.
load('../data/full/DBLP.mat');

clusters = ncut(A, k);

[discarded vertex_num] = size(A);

write_clustering_results_to_file(clusters, vertex_num, 'DBLP_ncut.txt');
