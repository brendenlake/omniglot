%
% Demo of how to load and use the dataset
%

% Parameters
nletter_per_alpha = 20; % number of letters of each alphabet to show

% Load the dataset
if ~exist('D','var')
    load('data_background','drawings','images','names','timing');
    D = Dataset(drawings,images,names,timing);
end

nrow = ceil(sqrt(nletter_per_alpha));
ncol = nrow;
nalpha = numel(D.images);

% for each alphabet
for a=1:nalpha 
    msg = ['Alphabet ',D.names{a},' ',num2str(a),' of ',num2str(nalpha)];
    fprintf(1,[msg,'\n']); 
    
    figure(1);
    clf
    for r=1:nletter_per_alpha % for each replication
       item = D.get('all',a,1,r); % get image 'r' of first character in alphabet 'a'
       
       % display the motor plotted on the image
       subplot(nrow,ncol,r);
       
       % switch between these two lines to show either image vs. motor data
       plot_motor_on_image(item.image,item.drawing,true,1); 
%        plot_image_only(item.image);
    end
    
    % keyboard prompt
    str = input('  press <enter> to continue (''q'' to quit) : ','s');
    if str == 'q'
       break 
    end
end