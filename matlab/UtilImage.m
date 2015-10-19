classdef UtilImage
   % Image utilities
    
   methods (Static)
       
    function out = check_black_is_true(I)
        % check whether the black pixels are labeled as 
        % "true" in the image format, since there should
        % be fewer black pixels
        out = sum(I(:)==true) < sum(I(:)==false);
    end
   
   end
        
end