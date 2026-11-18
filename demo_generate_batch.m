%DEMO_GENERATE_BATCH  Reproduce the held-out batches of the allocation experiments.
%   Runs the six seeds of Section 4.2 (20261012 ... 20261017), 32 scenarios each,
%   and prints the size of each batch. Nothing in the repository depends on a
%   solver, so this runs in a plain MATLAB session with no toolboxes.

root = fileparts(mfilename('fullpath'));
addpath(fullfile(root, 'generators'));

seeds = 20261012:20261017;
for seed = seeds
    b = makeScenarioBatch(seed, 32);
    fprintf('seed %d : %2d scenarios, 20-ft %5d, 40-ft %4d, tarpaulins %5d\n', ...
        seed, b.nS, sum(b.demand20, 'all'), sum(b.demand40, 'all'), ...
        sum(b.tarpDemand, 'all'));
end
