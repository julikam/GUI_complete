function [smoothed_load ,smoothed_unload] = smooth_and_overlap(smoothed_load,smoothed_unload)
% SMOOTH_AND_OVERLAP 

% smoothed_load = load;   
% smoothed_unload = unload;
% overlap the maximum point of loading curve with the max. point of
% unloading curve.

xmin_load = min(smoothed_load(:,1)); 
ymax_load = max(smoothed_load(:,2));
xmin_unload = min(smoothed_unload(:,1)); 
ymax_unload = max(smoothed_unload(:,2));


if  (xmin_load > xmin_unload) && (ymax_load > ymax_unload)
    xoverlap = xmin_load-xmin_unload;
    yoverlap = ymax_load-ymax_unload;

    smoothed_unload(:,1)=smoothed_unload(:,1)+xoverlap;
    smoothed_unload(:,2)=smoothed_unload(:,2)+yoverlap;
    
elseif  (xmin_load > xmin_unload) && (ymax_load < ymax_unload)
    xoverlap = xmin_load-xmin_unload;
    yoverlap = ymax_unload-ymax_load;
    
    smoothed_unload(:,1)=smoothed_unload(:,1)+xoverlap;
    smoothed_unload(:,2)=smoothed_unload(:,2)-yoverlap;
    
elseif  (xmin_load < xmin_unload) && (ymax_load < ymax_unload)
    xoverlap = xmin_unload-xmin_load;
    yoverlap = ymax_unload-ymax_load;

    smoothed_unload(:,1)=smoothed_unload(:,1)-xoverlap;
    smoothed_unload(:,2)=smoothed_unload(:,2)-yoverlap;
    
elseif  (xmin_load < xmin_unload) && (ymax_load > ymax_unload)
    xoverlap = xmin_unload-xmin_load;
    yoverlap = ymax_load-ymax_unload;

    smoothed_unload(:,1)=smoothed_unload(:,1)-xoverlap;
    smoothed_unload(:,2)=smoothed_unload(:,2)+yoverlap;
end
