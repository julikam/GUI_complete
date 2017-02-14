

if fib == 1;  
FibrilData = struct('FibrilName',cell(fib,1),...
                  'load_data',{cell(length(flistforce),1)},...
                  'unload_data',{cell(length(flistforce),1)},...
                  'Approach',{cell(length(flistforce),1)},...
                  'Retract',{cell(length(flistforce),1)}...
                  );
else

end

    % write the name of the i th map
    FibrilData(fib).FibrilName=sprintf('%s_f%d',sample_name,fib);
    
%     dir(fullfile(tempdir{fib,1},'shared-data'));

for j = 1 : length(indices);  
    %% loading data only
    
    % file directory of where all the .dat files are of the loading part of 
% the curve. 
    channeldir = fullfile(tempdir{fib,1},'index',num2str(indices(j,1)),...
                 'segments','0','channels');
% FILES are the .dat files. The directory content are stored in FILES.             
%     Files=dir(channeldir); 
    if strcmp(system_chosen,'W')==1;
            Files = cell(System.IO.Directory.GetFiles(channeldir));
    elseif strcmp(system_chosen,'L')==1;
            Files = struct2cell(dir([channeldir,'/*dat']));
            Files=Files(1,:);
                for i=1:length(Files);
                    Files{1,i}=[channeldir,'/', Files{1,i}];
                end
    elseif strcmp(system_chosen,'L')==1;
            Files = struct2cell(dir([channeldir,'/*dat']));
            Files=Files(1,:);
                for i=1:length(Files);
                    Files{1,i}=[channeldir,'/', Files{1,i}];
                end
    end
% Now check if the capasitiveSensorHeight.dat file is in there by looking
% at the name of each file. If the guys from JPK do not change the name of
% the file the next lines will work perfectly otherwise - piase to augo kai
% koureuto (greek quote meaning: you've got some work to do).
    for boogy = 1:length(Files); 
    
        tf(boogy,1)=strcmp(Files{1,boogy}(end-25:end),'capacitiveSensorHeight.dat');
        % compare every name in the FILES variable and store the result in 
        % TF. TF will be 0 if the comparison is FALSE and 1 if it is TRUE.
    end
    
    if (sum(tf)==0) % If the capasitiveSensorHeight.dat is not there then the
        % SUM of TF must equal 0. 
        [vDefldir ,segHeaderDir ,heightdir] = findloaddir_FVM_v2(...
                                          zipContents,indices(j,1),...
                                          length(zipContents)); 
    
    elseif (sum(tf)==1)
         [vDefldir ,segHeaderDir ,heightdir] = findloaddir_FVM(...
                                          zipContents,indices(j,1),...
                                          length(zipContents)); 
    else
        myicon=imread('beer.jpg');
        msgbox(...
        'You are scrwed because I did not find the capasitiveSensorHeight.dat file :)!',...
        'Error message - Better go for a beer','custom',myicon)
    end

    
    vDefldir = fullfile(tempdir{fib,1},vDefldir);                           
    segHeaderDir = fullfile(tempdir{fib,1},segHeaderDir);
    heightdir = fullfile(tempdir{fib,1},heightdir);
    headerDir = fullfile('shared-data','header.properties');
    headerDir = fullfile(tempdir{fib,1},headerDir);

    if (sum(tf)==0) % If the capasitiveSensorHeight.dat is not there then the
        % SUM of TF must equal 0. 
        [fdata_load{j,1}, spring_constant] = writedata_v2(headerDir,...
                                               segHeaderDir,...
                                               heightdir,vDefldir);    
    elseif (sum(tf)==1)
        [fdata_load{j,1}, spring_constant] = writedata(headerDir,...
                                               segHeaderDir,...
                                               heightdir,vDefldir);
    else
        myicon=imread('beer.jpg');
        msgbox(...
        'You are scrwed because I did not find the capasitiveSensorHeight.dat file :)!',...
        'Error message - Better go for a beer','custom',myicon)
    end
    
    clear segHeaderDir heightdir vDefldir;
    
    %% unloading data only
% file directory of where all the .dat files are of the loading part of 
% the curve. 
    channeldir = fullfile(tempdir{fib,1},'index',num2str(indices(j,1)),...
                 'segments','1','channels');
% FILES are the .dat files. The directory content are stored in FILES.             
    clear Files
%     Files=dir(channeldir);
     if strcmp(system_chosen,'W')==1;
            Files = cell(System.IO.Directory.GetFiles(channeldir));
    elseif strcmp(system_chosen,'L')==1;
            Files = struct2cell(dir([channeldir,'/*dat']));
            Files=Files(1,:);
                for i=1:length(Files);
                    Files{1,i}=[channeldir,'/', Files{1,i}];
                end
    elseif strcmp(system_chosen,'L')==1;
            Files = struct2cell(dir([channeldir,'/*dat']));
            Files=Files(1,:);
                for i=1:length(Files);
                    Files{1,i}=[channeldir,'/', Files{1,i}];
                end
    end

% Now check if the capasitiveSensorHeight.dat file is in there by looking
% at the name of each file. If the guys from JPK do not change the name of
% the file the next lines will work perfectly otherwise - piase to augo kai
% koureuto (greek quote meaning: you've got some work to do).
    for boogy = 1:length(Files); 
    
        tf(boogy,1)=strcmp(Files{1,boogy}(end-25:end),'capacitiveSensorHeight.dat');
        % compare every name in the FILES variable and store the result in 
        % TF. TF will be 0 if the comparison is FALSE and 1 if it is TRUE.
    end

    if (sum(tf)==0) % If the capasitiveSensorHeight.dat is not there then the
        % SUM of TF must equal 0. 
        [vDefldir ,segHeaderDir ,heightdir] = findunloaddir_FVM_v2(...
                                          zipContents,indices(j,1),...
                                          length(zipContents)); 
    
    elseif (sum(tf)==1)
         [vDefldir ,segHeaderDir ,heightdir] = findunloaddir_FVM(...
                                          zipContents,indices(j,1),...
                                          length(zipContents)); 
    else
        myicon=imread('beer.jpg');
        msgbox(...
        'You are scrwed because I did not find the capasitiveSensorHeight.dat file :)!',...
        'Error message - Better go for a beer','custom',myicon)
    end
    
                                      
    vDefldir = fullfile(tempdir{fib,1},vDefldir);                           
    segHeaderDir = fullfile(tempdir{fib,1},segHeaderDir);
    heightdir = fullfile(tempdir{fib,1},heightdir);

    if (sum(tf)==0) % If the capasitiveSensorHeight.dat is not there then the
        % SUM of TF must equal 0. 
        [fdata_unload{j,1}, spring_constant] = writedata_v2(headerDir,...
                                               segHeaderDir,...
                                               heightdir,vDefldir);
    elseif (sum(tf)==1)
        [fdata_unload{j,1}, spring_constant] = writedata(headerDir,...
                                               segHeaderDir,...
                                               heightdir,vDefldir);
    else
        myicon=imread('beer.jpg');
        msgbox(...
        'You are scrwed because I did not find the capasitiveSensorHeight.dat file :)!',...
        'Error message - Better go for a beer','custom',myicon)
    end
    
    
    % this is the bloody file directory of the location of the .dat files.
    % if the bugs will ever stop appearing then we might not have so many
    % inputs. 
    
    
    clear segHeaderDir heightdir vDefldir;
    
%% smooth data and connect the loading with the unloading curve
% smooths data with sgolay and overlaps the maximum unloading and loading
% points.

%  [fdata_loadS{j,1} ,fdata_unloadS{j,1}] = smooth_and_overlap(...
%                                      fdata_load{j,1},fdata_unload{j,1});
%%%%%% AT THIS POINT DATA WERE SAVED TO VARIABLE "beforContactPoint.mat"

%% find contact point
% A. Y-Tilt
% B. Y-Offset
% C. X-Offset by media-filtering and finding 0 of 1st derivative
% Reads loading and finds contact point
% The function also applies some tilting of the unloading data.
j
% Scaling to nanometers to improve numerical properties when finding the
% contact point.
    scaling=1e6;
    [approach{j,1} ,retract{j,1}] = ContactPoint_sort(...
                        fdata_load{j,1}*scaling, ...
                        fdata_unload{j,1}*scaling);

%% store all variables in the mapsData structure

FibrilData(fib).load_data{j,1}=fdata_load{j,1}; 
FibrilData(fib).unload_data{j,1}=fdata_unload{j,1};

FibrilData(fib).Approach{j,1}=approach{j,1};
FibrilData(fib).Retract{j,1}=retract{j,1};

clear headerDir Files fdata_load fdata_unload
end

clear choise ans fdata_load data_unload fdata_loadS fdata_unload ...
          fdata_unloadS f_loadS_OFF approach retract


%% overview the data and deside which to disregard from analysis
clear cell
mkdir(resultsFolder,'overview')
str = cell(length(indices),1);
curves_to_disregard = zeros(1,1);
curves_to_ANALYSE=zeros(1,1);
% find the total number of figures to plot for the analysis of the
% Synairgen project.

[rows,columns,num_of_figures,indent] = SubplotSize(length(indices),sample_name);


if isequal(fix(length(indices)/16),length(indices)/16)
    reviewSynairgen_case2
else
    reviewSynairgenGraphs; % this is only if the total number of files devided
% by 16 is NOT an integer
end


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
close;
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

close all;


close all;
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

setfigureoptions(8,8)
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
saveFigures(gcf,f)








