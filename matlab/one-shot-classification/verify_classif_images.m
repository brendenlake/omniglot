% Check correspondence between images in items_classification.mat
%   and data_evaluation.mat

addpath(genpath('..'));
fprintf(1,'Loading dataset...\n');
load('data_evaluation','drawings','images','names','timing');
load('items_classification','nrun','ntrain','ntest','cell_train','cell_test','cell_Y');
D = Dataset(drawings,images,names,timing);

fprintf(1,'Images are loaded...\n');
for r=1:nrun
     trainset = cell_train{r};
     for i=1:ntrain
         item = trainset{i};
         assert(isequal(item.img,D.get('image',item.a,item.c,item.r)));
     end
     
     testset = cell_test{r};
     for i=1:ntest
         item = testset{i};
         assert(isequal(item.img,D.get('image',item.a,item.c,item.r)));
     end
     
end
fprintf(1,'Images are verified as the same as in evaluation set...\n');