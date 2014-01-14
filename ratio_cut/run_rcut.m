for i = 1:10
    % polbook dataset.
    load('../data/full/polbooks.mat');

    clusters = rcut(A, k);

    [discarded vertex_num] = size(A);

    write_clustering_results_to_file(clusters, vertex_num, ['polbook_' i+48 '_rcut.txt']);

    [nmi acc] = evaluation(['polbook_' i+48 '_rcut.txt'], '../data/ground/polbooks_gd.txt', k)
    fid = fopen('polbook_rcut_evaluation', 'a');
    fprintf(fid, '%f\n', [nmi acc]);
    fprintf(fid, '\n');
    fclose(fid);

    % football dataset.
    load('../data/full/football.mat');

    clusters = rcut(A, k);

    [discarded vertex_num] = size(A);

    write_clustering_results_to_file(clusters, vertex_num, ['football_' i+48 '_rcut.txt']);

    [nmi acc] = evaluation(['football_' i+48 '_rcut.txt'], '../data/ground/football_gd.txt', k)
    fid = fopen('football_rcut_evaluation', 'a');
    fprintf(fid, '%f\n', [nmi acc]);
    fprintf(fid, '\n');
    fclose(fid);

end

% dblp dataset.
load('../data/full/DBLP.mat');

clusters = rcut(A, k);

[discarded vertex_num] = size(A);

write_clustering_results_to_file(clusters, vertex_num, 'DBLP_rcut.txt');
