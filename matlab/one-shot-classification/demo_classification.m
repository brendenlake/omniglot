% Compute one-shot classification error for
% Modified Hausdorff Distance baseline.
%
% Running this code should lead to a result of 38.8 percent errors.
%
%   M.-P. Dubuisson, A. K. Jain (1994). A modified hausdorff distance for object matching.
%     International Conference on Pattern Recognition, pp. 566-568.
% 
% You can plug in your own fucntion for the variable 'fcost',
%  and set ftype='cost' to  ftype='score' depending on whether a low or high value is
%  good.
%
% ** Models must be trained on data_background.mat to avoid 
% using images and alphabets used in the one-shot evaluation **
%
function demo_classification()

    addpath(genpath('..'));
    
    load('items_classification','nrun','cell_train','cell_test','cell_Y');
    %   20 different mini one-shot classification experiments,
    %   where each cell is a different experiment

    fcost = @(itrain,itest) HD(itrain,itest);
    
    fprintf(1,'One-Shot Classification (Modified Hausdorff Distance)\n');
    perror = zeros(nrun,1);
    for r=1:nrun
        trainset = cell_train{r};
        testset = cell_test{r};
        Y = cell_Y{r};
        perror(r) = myclassify(trainset,testset,fcost,Y,'cost');
        fprintf(1,' run %d (error %s%%)\n',r,num2str(perror(r),3));
    end
    fprintf(1,'average error: %s%%\n',num2str(mean(perror),3));
        
end

function cost = HD(itrain,itest)
    % Return distance (cost) between training (itrain) and test image (itest)
    assert(UtilImage.check_black_is_true(itrain.img));
    assert(UtilImage.check_black_is_true(itest.img));
    [irow,icol] = find(itrain.img);
    dtrain = [irow icol];
    dtrain = normalize(dtrain);
    [irow,icol] = find(itest.img);
    dtest = [irow,icol];
    dtest = normalize(dtest);
    cost = ModHausdorffDist(dtrain,dtest);
end


function d = normalize(d)
    % Subtract off the center of mass for set of points
    % rows of d are points
    assert(size(d,2)==2);
    d1 = d(:,1);
    d2 = d(:,2);
    d(:,1) = d(:,1) - mean(d1);
    d(:,2) = d(:,2) - mean(d2);
end

function mhd = ModHausdorffDist(A,B)
    % Input
    %  A : [n x 2] x,y coordinates of "on" pixels
    %  B : [m x 2] x,y coordinates of "on" pixels
    % Output
    %  mhd: distance between images
    assert(size(A,2)==2);
    assert(size(B,2)==2);
    D = pdist2(A,B);
    mindist_A = min(D,[],2);
    mindist_B = min(D,[],1);
    mean_A = mean(mindist_A);
    mean_B = mean(mindist_B);
    mhd = max(mean_A,mean_B);
end