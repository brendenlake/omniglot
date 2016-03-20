% Generate a matrix of uniformly distributed random integers.
%
% This replaces the deprecated matlab function by the same name.
%
% Input
%   m: number of rows
%   n: number of columns
%   rg: [1 x 2] uses numbers from [min max] inclusive
%
% Output
%   out: [m x n] matrix of random integers
function out = randint(m,n,rg)
    assert(numel(rg)==2);
    out = randi(rg,m,n);
end
