% Evaluate n-way one-shot classification task,
%  requiring a cost function that measures pairwise didstances
% 
% Input
%   trainset: [ntrain x 1 cell] training examples 
%   testset: [ntest x 1 cell] test examples
%   fcost: [function] fcost(trainset{i},testset{j}) returns the cost
%      where small values indicate class membership (if you want the
%      opposite,  set ftype='score')
%   Y: [ntest x 1 int] the correct class labels
%   ftype: [string] either "score" or "cost", where you want the highest
%        score or the lowest cost
%
% Output
%   perror: [scalar] overall percent error
%   YHAT: [ntest x 1 int] the estimated classes
%
function [perror,YHAT] = myclassify(trainset,testset,fcost,Y,ftype)

    assert(strcmp(ftype,'cost') || strcmp(ftype,'score'));
    bool_fscore = true;
    if strcmp(ftype,'cost')
        bool_fscore = false;
    end
        
    % Error checking
    assert(iscell(trainset) && isvector(trainset));
    assert(iscell(testset) && isvector(testset));
    ntrain = length(trainset);
    ntest = length(testset);
    assert(isvector(Y) && length(Y)==ntest);

    % Compute cost matrix
%     costM = compute_costM_slow(trainset,testset,fcost);
    costM = compute_costM_fast(trainset,testset,fcost);
    
    % Score the classifier
    if bool_fscore
        [~,YHAT] = max(costM,[],2);
    else
        [~,YHAT] = min(costM,[],2);
    end
    correct = Y==YHAT;
    pcorrect = mean(correct)*100;
    perror = 100-pcorrect;
end


function costM = compute_costM_fast(trainset,testset,fcost)
% Compute cost matrix costM, where rows are test examples and columns are training examples
    ntrain = length(trainset);
    ntest = length(testset);

    % Generate comparison indices
    sz = [ntest ntrain];
    ncomp = ntest*ntrain;       
    
    % Compute all the costs in parallel
    cost = nan(ncomp,1);
    parfor ind=1:ncomp
    %for ind=1:ncomp
       [i,c] = ind2sub(sz,ind);
       cost(ind) = fcost(trainset{c},testset{i});
    end
    costM = reshape(cost,sz);
end

function costM = compute_costM_slow(trainset,testset,fcost)
    ntrain = length(trainset);
    ntest = length(testset);
    costM = nan(ntest,ntrain);
    for i=1:ntest
        for c=1:ntrain
            costM(i,c) = fcost(trainset{c},testset{i});
        end
    end    
end