classdef Dataset < matlab.mixin.Copyable
    %DATASET Class that stores structured character data
    %   This class stores, and provides easy access, to the
    %   sturctured character data. Using the "get" method,
    %   you can easily access particular alphabets/characters/drawers.
    %   You can also pick random characters as well.
    %
    %  Examples
    %
    %    load('data_background');
    %    D = Dataset(drawings,images,names,timing); // creates dataset
    %
    %    D.get('images','Latin',1,1)  // gets the first image of the letter 'a'
    %    D.get('images','Latin',1)    // gets all images of the letter 'a'
    %    D.get('images','Latin',2,1)  // gets the first image of the letter 'b' 
    %    D.get('images','Latin',[],1) // gets every Latin letter produced by
    %                                   just the first drawer
    %
    properties (SetAccess = private)
        drawings
        images
        names
        timing
        all
    end
    
    methods
        
        % constructor : all input parameters are necessary
        %   timing is optional
        % 
        function D = Dataset(drawings,images,names,timing)
            D.drawings = drawings;
            D.images = images;
            D.names = names;
            if exist('timing','var')
                D.timing = timing;
            end
            
            flip_img = ~UtilImage.check_black_is_true(images{1}{1}{1});
            
            % build additional structure for holding all
            % of the items in correspondence
            nalpha = length(images);
            D.all = cell(nalpha,1);
            for a=1:nalpha
                nchar = length(images{a});
                D.all{a} = cell(nchar,1);
                for c=1:nchar
                    nrep = length(images{a}{c});
                    D.all{a}{c} = cell(nrep,1);
                    for r=1:nrep
                        D.all{a}{c}{r}.drawing = drawings{a}{c}{r};
                        if flip_img
                            D.all{a}{c}{r}.image = ~images{a}{c}{r};
                            D.images{a}{c}{r} = ~D.images{a}{c}{r};
                        else
                            D.all{a}{c}{r}.image = images{a}{c}{r};
                        end
                        if exist('timing','var')
                            D.all{a}{c}{r}.timing = timing{a}{c}{r};
                        end
                    end
                end
            end            
            
        end
       
        % get a subset of the dataset
        function dat = get(obj,type,aindx,cindx,rindx)
            % type: "images","drawings", etc. or "all" for struct of all
            % aindx: alphabet index (or string with name)
            % cindx: character index
            % rindx: replication (drawer index)
            % 
            % Any of the "indx" parameters can also be set to "random",
            % in which case a random alphabet/character/rep is chosen.
            % Any blank indx parameters will default to the whole set.
            %
            % Returns a nested cell array that contains the requested
            %   subset of the dataset. 
            if ~exist('aindx','var')
               aindx = [];
            end
            if ~exist('cindx','var')
               cindx = []; 
            end
            if ~exist('rindx','var')
               rindx = []; 
            end
            random_alpha = strcmp(aindx,'random');
            random_char = strcmp(cindx,'random');
            random_rep = strcmp(rindx,'random');
            
            % convert an alphabet string into an index
            if ischar(aindx) && ~random_alpha
                aindx = name_to_indx(obj,aindx); 
            end
            
            dat = select_data_type(obj,type);
            nalpha = numel(dat);
            if ~isempty(aindx)
               if random_alpha                  
                  aindx = randint(1,1,[1 nalpha]);
               end                
               dat = dat(aindx);                
            end
            
            % for each alphabet
            nalpha = numel(dat); % this needs to be refreshed
            for a=1:nalpha
                
               % restrict to proper set of characters
               nchar = length(dat{a});
               if ~isempty(cindx)
                    if random_char
                        cindx = randint(1,1,[1 nchar]);
                    end
                    dat{a} = dat{a}(cindx);                    
               end
               
               % for each character
               nchar = length(dat{a}); % this needs to be refreshed
               for c=1:nchar
                  
                  % restrict to proper set of replications
                  nrep = length(dat{a}{c});
                  if ~isempty(rindx)
                     if random_rep
                         rindx = randint(1,1,[1 nrep]);                                           
                     end
                     dat{a}{c} = dat{a}{c}(rindx);
                  end
                  
               end               
            end
            
            dat = nested_squeeze(obj,dat);
            
        end        
    end
    
    methods (Access = private)
        
        % find the index of the alphabet named "str"
        function indx = name_to_indx(obj,str)
           lindx = strcmpi(str,obj.names);
           indx = find(lindx);
           if (numel(indx)~=1)
               error(['Name ',str,' not found']);
           end           
        end
        
        % choose the type of data
        function dat = select_data_type(obj,type)
            switch type
                case {'drawing','drawings'}
                    dat = obj.drawings;
                case {'image','images'}
                    dat = obj.images;
                case 'timing'
                    dat = obj.timing;
                case 'all'
                    dat = obj.all;
                otherwise
                    error('Invalid data type');
            end 
        end
        
        % analogous to squeeze function for matrices,
        % except that we stop at level 3
        function dat = nested_squeeze(obj,dat)
            depth = 1;
            dat = helper_nested_squeeze(obj,dat,depth);
            if iscell(dat) && numel(dat)==1
               dat = dat{1}; 
            end
        end        
        
        function dat = helper_nested_squeeze(obj,dat,depth)       
            if depth > 3
               return; 
            end
            if ~iscell(dat)
               return;
            end
            
            % see if we want to do the squeeze
            if numel(dat) == 1
                dat = dat{1};
                depth = depth + 1;
            end
                
            if iscell(dat)
                for i=1:numel(dat)
                    dat{i} = helper_nested_squeeze(obj,dat{i},depth+1);
                end
            end
                            
        end
        
    end
    
end

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