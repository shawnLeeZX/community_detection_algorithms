% This is the test file for testing the correctness of algorithms which are
% coding in progress.

% ---------------- Test section for alinkjaccard ---------
% load("./data/full/polbooks.mat");

% A = [
    % 0 1 1
    % 1 0 0
    % 1 0 0
    % ];

% k = 2;


% [discarded vertex_num] = size(A);

% clusters = alinkjaccard(A, k);
% write_clustering_results_to_file(clusters, vertex_num, "polbook_out.txt");

% evaluation("polbook_out.txt", "data/ground/polbooks_gd.txt", 3)
% ---------------- Test section for alinkjaccard ---------

% ---------------- Test section for girvan-newman ---------
load("./data/full/polbooks.mat");

% A = [
    % 0 1 1 0 0 0 0;
    % 1 0 0 0 1 0 0;
    % 1 0 0 1 0 1 0;
    % 0 0 1 0 0 0 0;
    % 0 1 0 0 0 0 1;
    % 0 0 1 0 0 0 1;
    % 0 0 0 0 1 1 0;
    % ];
% A = [
    % 0 1 1 0 0 0 0;
    % 1 0 0 1 0 0 0;
    % 1 0 0 1 1 0 0;
    % 0 1 1 0 0 1 0;
    % 0 0 1 0 0 1 1;
    % 0 0 0 1 1 0 0;
    % 0 0 0 0 1 0 0;
    % ];
% ------ For testing find_connected_component.m.------
% A = [
    % 0 1 1 0;
    % 1 0 0 0;
    % 1 0 0 0;
    % 0 0 0 0;
    % ];
% find_connected_component(A);
% ------ Done for testing find_connected_component.m.------
[discarded vertex_num] = size(A);

clusters = girvannewman(A, k)
write_clustering_results_to_file(clusters, vertex_num, "polbook_out_girvannewman.txt");

evaluation("polbook_out_girvannewman.txt", "data/ground/polbooks_gd.txt", 3)
% ---------------- Test section for girvan-newman ---------
