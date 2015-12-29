%
% Plot a motor trajectory on top of the image
%
% Input
%   I [105 x 105] image (double or binary) (large numbers are BLACK)
%   drawings: [ns x 1 cell] of strokes in motor space
%   bool_start: [logical] (default=true) show start position?
%   lw: [scalar] (default=4) line width
%
function plot_motor_on_image(I,drawing,bool_start,lw)

    if ~exist('bool_start','var')
       bool_start = true; % show start position?
    end
    if ~exist('lw','var')
       lw = 4; % line width 
    end
    
    % conversion of coordinates
    drawing = space_motor_to_img(drawing);
    
    % plot image
    hold on
    plot_image_only(I);
    
    % plot each stroke
    ns = length(drawing);
    for i=1:ns
        stroke = drawing{i};
        color = get_color(i);
        plot_traj(stroke,color,lw);
    end    
    
    % Plot starting locations and stroke order
    if bool_start
        for i=1:ns
            stroke = drawing{i};
            plot_start_loc(stroke(1,:),i);
        end
    end
      
    set(gca,'YDir','reverse','XTick',[],'YTick',[]);
    xlim([1 105]);
    ylim([1 105]);
end

function plot_traj(stk,color,lw)
    ystk = stk(:,2);
    stk(:,2) = stk(:,1);
    stk(:,1) = ystk;       
    plot(stk(:,1),stk(:,2),color,'LineWidth',lw);
end

% Plot the starting location of a stroke
%
% Input
%  start: [1 x 2]
%  num: number that denotes stroke order
function plot_start_loc(start,num)
    mysize = 18;
    plot(start(2),start(1),'o','MarkerEdgeColor','k','MarkerFaceColor','w',...
        'MarkerSize',mysize);
    text(start(2),start(1),num2str(num),...
        'BackgroundColor','none','EdgeColor','none',...
        'FontSize',mysize,'FontWeight','normal','HorizontalAlignment','center');
end

% Color map for the stroke of index k
function out = get_color(k)
    scol = {'r','g','b','m','c'};
    ncol = length(scol);
    if k <=ncol
       out = scol{k}; 
    else
       out = scol{end}; 
    end
end