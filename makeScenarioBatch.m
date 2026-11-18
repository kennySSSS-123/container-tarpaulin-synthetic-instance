function b = makeScenarioBatch(seed, N)
%MAKESCENARIOBATCH  Build one held-out demand batch from the released instance.
%   b = MAKESCENARIOBATCH(seed, N) reads the synthetic instance in inputs/,
%   sets the random seed, and returns N seven-day scenarios together with the
%   per-scenario container and tarpaulin demand matrices.
%
%   b = MAKESCENARIOBATCH(seed) uses N = 32, the batch size of the paper.
%
%   Example:
%       b = makeScenarioBatch(20261012, 32);
%       sum(b.demand20, 1)        % 20-ft demand per generated scenario
%
%   See also GENERATETEST.

if nargin < 2
    N = 32;
end

inputs = fileparts(mfilename('fullpath'));  
% all data files sit in this folder

d.nJ         = size(readmatrix(fullfile(inputs, 'demand20.csv')), 1);
d.demand20   = readmatrix(fullfile(inputs, 'demand20.csv'));
d.demand40   = readmatrix(fullfile(inputs, 'demand40.csv'));
d.tarpDemand = readmatrix(fullfile(inputs, 'demand_tarp.csv'));

w            = readtable(fullfile(inputs, 'scenario_weights.csv'), ...
    'VariableNamingRule', 'preserve');
d.prob       = w.Weight(:);
d.capFactor  = w.CapacityMultiplier(:);
d.nS         = numel(d.prob);

rng(seed, 'twister');
b = generateTest(d, N);
b.seed = seed;
end
