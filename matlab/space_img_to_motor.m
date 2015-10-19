%
% Map from image space to motor space
%
% Input
%   pt: [n x 2] points (rows) in motor coordinates
%
% Output
%  new_pt: [n x 2] points (rows) in image coordinates
function new_pt = space_img_to_motor(pt)

    if iscell(pt)
        new_pt = apply_to_nested(pt,@(x)space_img_to_motor(x)); 
        return;
    end

    if isempty(pt)
       new_pt = [];
       return;
    end
    
    y = pt(:,1)-1;
    x = pt(:,2)-1;
    new_pt  = [x -y];
end