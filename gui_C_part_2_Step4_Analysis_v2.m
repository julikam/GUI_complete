%% diregard curves that were droped out
k=1;
k2=1;
for i = 1 : length(indices);
    
    if strcmp(str{i,1},'No')==1;
        curves_to_disregard(k,1) = i;
        k=k+1;
    elseif strcmp(str{i,1},'Yes')==1;
        curves_to_ANALYSE(k2,1) = i;
        k2=k2+1;
    end
end
    % save the overview figure as a pdf file
    
clear indent;

clear figure1 axes1 annot i j scaling prompt f2 ans;

save fullfile(resultsFolder, 'selected_data_for_analysis.mat')
%++++++++++ Input figure size be in centimeters ++++++++++
%        prompt = {'Figure square size in centimeters:'};
%        dlg_title = 'Input data';
%        num_lines = [1 50];
%        def = {'8 and no less than 5'};
%        answer = inputdlg(prompt,dlg_title,num_lines,def);  
%        figure_size = str2double(cell2mat(answer(1,1)));
%        clear prompt dlg_title num_lines def answer;
%   Figure size is then used as an input in the following function with the
%   name PLOT_INDENTATION_CURVE
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
figure_size = 5;
%% Calculation of indentation contact depth
% NEED TO DO:
% Select positive unloading data
% Select positive loading data
% prompt = {'Percent of upper portion to calculate slope (eg. 0.1 for upper 10%)'};
% dlg_title = 'Percent to find linear slope';
% num_lines = 1;
% def = {'0.5'};
% answer = inputdlg(prompt,dlg_title,num_lines,def);  
% percent = str2double(cell2mat(answer(1,1)));
% clear prompt dlg_title num_lines def answer;
DZslope=zeros(length(curves_to_ANALYSE(:,1)),1);
Dmax = zeros(length(curves_to_ANALYSE(:,1)),1);
Zmax = zeros(length(curves_to_ANALYSE(:,1)),1);

%%  Plot the force displacement curves with line fit in postscript
       
if (length(indices) < 4)
    
        for i = transpose(curves_to_ANALYSE(:,1)); % analyzing ONLY the data with the current index
            
            sprintf('Indent%d',i)
            name = strcat(sample_name,sprintf('Fibril%d indent%d',fib,i));

            plot_linear_fit(FibrilData(fib).Approach{i,1}(:,1),...
                            FibrilData(fib).Approach{i,1}(:,2),...
                            FibrilData(fib).Retract{i,1}(:,1),...
                            FibrilData(fib).Retract{i,1}(:,2),...
                            percent,figure_size,name,i,resultsFolder) 
    %%%%% NOTE %%%%% data are plotted in the positive quadrant although the...
    % height data is negative. This is done by placing a negative sign in ...
    % the above function.
        end
        
elseif (length(indices) > 4)   
     
     indents_to_plot = datasample(curves_to_ANALYSE(:,1),5,...
                                 'Replace',false);   
     for i = transpose(indents_to_plot);
    
            sprintf('Indent%d',i)
            name = strcat(sample_name,sprintf('Fibril%d indent%d',fib,i));

            plot_linear_fit(FibrilData(fib).Approach{i,1}(:,1),...
                            FibrilData(fib).Approach{i,1}(:,2),...
                            FibrilData(fib).Retract{i,1}(:,1),...
                            FibrilData(fib).Retract{i,1}(:,2),...
                            percent,figure_size,name,i,resultsFolder) 
      end   
end

% Selects randomly 10 unique observations from a list  




%% find DZ slope and
 results2 = struct('Filename',cell(length(curves_to_ANALYSE(:,1)),1),...
                  'Index',{zeros(1,1)},...                 
                  'Dmax',{zeros(1,1)},...
                  'Zmax',{zeros(1,1)},...
                  'DZslope',{zeros(1,1)},...
                  'Hmax',{zeros(1,1)},...
                  'Fmax',{zeros(1,1)},...
                  'Hc',{zeros(1,1)},...
                  'Stiffness',{zeros(1,1)},...
                  'Area',{zeros(1,1)},...
                  'Elastic_modulus',{zeros(1,1)}...
                  );         

k=1;    
for i = transpose(curves_to_ANALYSE(:,1)); 
        % here we select only the valid curves to be analyzed!

    % function: DZSLOPE - calculates the slope of deflection versus z.sensor,
    % the maximum deflection and maximum Z.sensor displacement.
        [DZslope(k,1), Dmax(k,1), Zmax(k,1)] = dzslope(...
                            FibrilData(fib).Approach{i,1}(:,1),...
                            FibrilData(fib).Approach{i,1}(:,2),...
                            FibrilData(fib).Retract{i,1}(:,1),...
                            FibrilData(fib).Retract{i,1}(:,2),percent); 
    % plot()

 
    %% preallocate a structure in which the results are stored
    
    results2(k).Filename = sprintf('Fibril%d_indent_%d',fib,indices(i));
    results2(k).Index = curves_to_ANALYSE(k,1);    
    results2(k).Dmax = Dmax(k,1);
    results2(k).Zmax = Zmax(k,1);
    results2(k).DZslope = DZslope(k,1);
       
    k=k+1;
end

%% data analysis - results
%     Hc =  cell(1,num_of_files);
%     Area =  cell(1,num_of_files);
%     Ereduced =  cell(1,num_of_files);
%     Esample =  cell(1,num_of_files);
%% scale data to kPa, MPa or GPa

% prompt = {'Elastic modulus in kPa, MPa or GPa'};
% dlg_title = 'Scaling';
% num_lines = 1;
% def = {'kPa or MPa or GPa'};
% answer = inputdlg(prompt,dlg_title,num_lines,def);  
% units = cell2mat(answer(1,1));
% clear prompt dlg_title num_lines def answer;

if all(size(units) == size('kPa')) && all(units == 'kPa')
    scale_value=1e-3; 
elseif all(size(units) == size('MPa')) && all(units == 'MPa')
    scale_value=1e-6;
elseif all(size(units) == size('GPa')) && all(units == 'GPa')
    scale_value=1e-9;
end

Hmax = zeros(length(curves_to_ANALYSE(:,1)),1);
stiffness = zeros(length(curves_to_ANALYSE(:,1)),1);
area = zeros(length(curves_to_ANALYSE(:,1)),1);
Hc = zeros(length(curves_to_ANALYSE(:,1)),1);
Ereduced = zeros(length(curves_to_ANALYSE(:,1)),1);
Esample = zeros(length(curves_to_ANALYSE(:,1)),1);
Fmax = zeros(length(curves_to_ANALYSE(:,1)),1);
Ref=1/reference(fib,1); % unitless


k=1;
for i = transpose(curves_to_ANALYSE(:,1));

    Hmax(k,1) = Zmax(k,1) - Dmax(k,1);
    dD = Dmax(k,1) - (1-percent)*Dmax(k,1); % in um
    dh = dD*(1./DZslope(k,1)-Ref); % in um
    df = dD*spring_constant; % in uN
    stiffness(k,1) = df/dh; % in uN/um or N/m
    Fmax(k,1) = Dmax(k,1).*spring_constant; %in uN
    Hc(k,1) = Hmax(k,1) - 0.73.*Fmax(k,1)/stiffness(k,1); % in um
    
   
    

    results2(k).Hmax = Hmax(k,1);
    results2(k).Fmax = Fmax(k,1);
    results2(k).Hc = Hc(k,1);
    results2(k).Stiffness = stiffness(k,1);
 
    results2(k).Elastic_modulus = Esample(k,1)*scale_value;
    k=k+1;
end

%% fit the correct amount of data in the projected area function

h_ulimit = max(Hc).*1000;
h_llimit = min(Hc).*1000;

[x_coeff, AreaFun, n_lower, n_upper] = fit_proj_area(Tip.HeightData(:,1),...
                                               Tip.ProjArea(:,1),...
                                               h_ulimit,h_llimit);
                                                   



%% Elastic modulus calculation

k=1;
for i = transpose(curves_to_ANALYSE(:,1));

    
    area(k,1) = AreaFun(x_coeff,Hc(k,1).*1000);   % in um^2
    
    Ereduced(k,1) = sqrt(pi./area(k,1))*1.02.*...
                                stiffness(k,1)/2*1e6; %in Pascals: SI
    Esample(k,1) = Ereduced(k,1).*(1-nu^2); %in Pascals: SI
    
    results2(k).Area = area(k,1);
    results2(k).Elastic_modulus = Esample(k,1)*scale_value;
    k=k+1;
end

[figure2]=setfigureoptions(8,8)
plot(Tip.HeightData(1:50,1),Tip.ProjArea(1:50,1).*10^12,'-')
scatter(Tip.HeightData(n_lower:n_upper,1),...
       Tip.ProjArea(n_lower:n_upper,1).*10^12,'o','MarkerFaceColor','flat')
plot(Hc(:,1).*1000,AreaFun(x_coeff,Hc(:,1).*1000),'.g','MarkerSize',12) 

plot(Tip.HeightData(n_lower:n_upper,1),...
    AreaFun(x_coeff,Tip.HeightData(n_lower:n_upper,1)),'-k')

legend('Proj. Area','Range of h_c','Measured','Fit','location','best')
xlabel('Height (nm)')
ylabel('Projected area (\mum^2)')
set(gca,'FontSize',8)
f = fullfile(resultsFolder,sprintf('ProjArea_Fibril%d',fib));
gui_saveFigures(gcf,f,handles.text14)


