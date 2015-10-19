% Apply a function (fnc) to the lowest level of a
% nested cell array.
%
% input
%   dataset: nested cell arrays, where the bottom level is
%      a non-cell array (like the vector of a stroke). Any
%      nesting structure works.
%   fnc: function handle to apply
%  
% output
%   ndataset: same nesting structure as the original
%     but with the function applied to each element
%     at the lowest nesting level
function ndataset = apply_to_nested(dataset,fnc)
    ndataset = process(dataset,fnc);
end

% Recursive function for normalization
function Ac = process(A,fnc)
    if ~iscell(A)
       Ac = fnc(A);
    else
       n = numel(A);
       Ac = A;
       for i=1:n
         Ac{i} = process(A{i},fnc);
       end
    end
end