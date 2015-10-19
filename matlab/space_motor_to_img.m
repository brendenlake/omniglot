%
% Map from motor space to image space
%
% Input
%   pt: [n x 2] points (rows) in motor coordinates
%
% Output
%  new_pt: [n x 2] points (rows) in image coordinates
function new_pt = space_motor_to_img(pt)

    if iscell(pt)
        new_pt = apply_to_nested(pt,@(x)space_motor_to_img(x)); 
        return;
    end

    if isempty(pt)
       new_pt = [];
       return;
    end    
    
    x = pt(:,1);
    y = pt(:,2);
    new_pt = [-y x] + 1;
end