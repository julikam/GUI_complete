%% valid data
% final step selecting data for post-process
% Here only valid data are selected for statistical analysis
% Valid data are those whose:
% 1. DZslope value ranges between 0.20 to 0.85. Outside this range,
% experience has shown that the sensitivity of the instrument is
% compromised, providing invalid data.
% 2. The stiffness value is negative or ubnormaly large value. Negative 
% stiffness value occurs when the sample is much stiffer than the stiffness
% of the cantilever.


save (fullfile(resultsFolder,'before_last_filter_data.mat'))
set(handles.text15,'String', ['save workspace for postprocess to ', (fullfile(resultsFolder,'before_last_filter_data.mat'))])
% valid = cell(length(flistmap),1); % if it comes out that valid=0 then all data are invalid
invalid = zeros(1,1);
valid_index = cell(1,1);
% NOTE!: If the DZ slope on the sample is very close to the one on the
% glass slide then the stiffness will appear


i=fib;
%     valid=0; % if it comes out that valid=0 then all data are invalid
%     invalid=0;
    results_valid(i,1).Fibril = fnamemap; 
    k=1;
    for j = 1 : length(curves_to_ANALYSE(:,1)); 
     
        if (results2(j).DZslope > 0.005) && ...
                (results2(j).DZslope < 0.85) && ...
                (results2(j).Stiffness > 0)
            
%             valid{i,1}(i,1)=valid(i,1)+1; % total number of indices that correspond to valid data    
            valid_index{i,1}(k,1) = results2(i).Index;
        
            results_valid(i).Index(k,1) = curves_to_ANALYSE(j,1);
            results_valid(i).Dmax(k,1) = results2(j).Dmax;
            results_valid(i).Zmax(k,1) = results2(j).Zmax;     
            
            
            results_valid(i).DZslope(k,1) = results2(j).DZslope;
            
            results_valid(i).Hmax(k,1) = results2(j).Hmax;    
            results_valid(i).Fmax(k,1) = results2(j).Fmax;    
            results_valid(i).Hc(k,1) = results2(j).Hc;    
            results_valid(i).Stiffness(k,1) = results2(j).Stiffness;    
            results_valid(i).Area(k,1) = results2(j).Area;    
            results_valid(i).Elastic_modulus(k,1) = results2(j).Elastic_modulus;
            

            k=k+1;
        else 
            
%             invalid(i,1)=invalid(i,1)+1;
            
        end
       
    end
    
    


clear Dmax Zmax DZslope Hc Hmax Fmax stiffness area Ereduced Esample dD ...
      dh df index ans i j;