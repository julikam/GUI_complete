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
% j
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
      
% save ('anna1.mat', 'indices','FibrilData','ImDir','MaiheaderDir','NumOfImages','Scansizex','Scansizey',...
%     'Status','Tip','X','boogy','channeldir','datadir','depth_num','fib','figname','flistforce','flistmap',...
%     'fnameforce','fnamemap','heightdata','himage','himage_filt','himage_filt2','himage_pfit',...
%     'i','indices','info','inl','ins','j','l','leng','linefit','linepos','llimit','name','nu',...
%     'pathname','percent','percentage_slope','poisson_ratio','pp','probe_tip','projected_area',...
%     'reference','resultsFolder','results_valid','sample_name','scaling', 'size_pixel_x','size_pixel_y',...
%     'spring_constant','str','system_chosen','tempdir','tf','thename','tipdataname','ulimit','units',...
%     'val','whatever','width','xscale','yscale','zipContents')
% save('anna1.mat', 'indices', 'sample_name','fib','FibrilData','resultsFolder')

% %% overview the data and deside which to disregard from analysis
% clear cell
% mkdir(resultsFolder,'overview')
% str = cell(length(indices),1);
% curves_to_disregard = zeros(1,1);
% curves_to_ANALYSE=zeros(1,1);
% % find the total number of figures to plot for the analysis of the
% % Synairgen project.
% 
% [rows,columns,num_of_figures,indent] = gui_SubplotSize(length(indices),sample_name);
