
close all
clc
prompt = {
    'Reference slope value:',...
    'Poisson ratio of the sample',...
    'Filename'};
    dlg_title = 'Input data';
    num_lines = 1;
    def = {
        '0.985',...
        '0.5',...
        'F1'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);  
    reference = str2double(cell2mat(answer(1,1)));
    nu = str2double(cell2mat(answer(2,1)));
    sample_name = cell2mat(answer(3,1));
% Stores the reference slope, the radius
clear prompt dlg_title num_lines def answer;
% Sets LATEX fonts as default fonts for all figures to be ploted.
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

%% fetch file directory
% YES! You can now analyze the data without copy pasting the scripts to the
% file directory of the data
dirName=uigetdir();

%% read the list of all force scan series in the current folder
FileDIR=sprintf('%s/*.jpk-force',dirName);
flist=dir(FileDIR);

%flist = dir('*.jpk-force'); % Lists directory informatoin in a structure.
[num_of_files, ~] = size(flist); % the number of force maps in the folder.
filename = cell(num_of_files,1);

% pixel_numberi = zeros(num_of_files,1);
% pixel_numberj = zeros(num_of_files,1);
% num_of_force_curves = zeros(num_of_files,1);
index(:,1) = 1:num_of_files;
%% Analysis over the force maps.
% prealocate variables FDATA_LOAD, FDATA_UNLOAD and SMOOTHED ONES.
fdata_load = cell(num_of_files,1); 
fdata_unload = cell(num_of_files,1);
fdata_loadS = cell(num_of_files,1); 
fdata_unloadS = cell(num_of_files,1);
f_loadS_OFF = cell(num_of_files,1); 
data_unload = cell(num_of_files,1);
approach = cell(num_of_files,1);
retract = cell(num_of_files,1);

H = waitbar2(0,'Go have some fun until I do the job for you ;)');
for i = 1:num_of_files;
    waitbar2(i/num_of_files,H)
    filename{i,1} = sprintf(flist(i,1).name); % takes first force curve
    zipContents = listzipcontents(sprintf('%s%s%s',dirName,'\',filename{i,1})); % lists contents of zip file 
% without unzipping it

%% unzip certain content from zipped Force Volume Map
    unzip(sprintf('%s%s%s',dirName,'\',filename{i,1})); % unzip files. Force scan series need to be unzipped before
% further data analysis.
% delete thumbnail.png; % only in force map
% delete data-image.force; % only in force map

headerDir = findheaderDirectory_FVM(zipContents);
% find the header.properties file in the zipContents.
% The findheaderDirectory function avoids
% stores string of main header in variable
MaiheaderDir = findMainHeader_FVM(zipContents);
% String variable of main header is used as input in function
% PIXEL_RESOLUTION to find the pixel resolution of the current force map.
% [pixel_numberi(i,1), pixel_numberj(i,1)] = pixel_resolution(MaiheaderDir);
% A force volume map with pixel number 4 has total numnber of force curves
% 4x4 = 16, i.e. pixel_number * pixel_number. 
% num_of_force_curves(i,1) = pixel_numberi(i,1)*pixel_numberj(i,1);

% Every index number corresponds to one force curve on the force map.
% index{i,1} = transpose(0:1:(num_of_force_curves(i,1) - 1));


% create a new waitbar, w with 0% progress
% w = waitbar(0,'progress');     

%% preallocate a structure
if i == 1;  
mapsData = struct('MapName',cell(i,1),...
                  'load_data',{cell(1,1)},...
                  'unload_data',{cell(1,1)},...
                  'SmoothedLoad_data',{cell(1,1)},...
                  'SmoothedUnload_data',{cell(1,1)},...
                  'Approach',{cell(1,1)},...
                  'Retract',{cell(1,1)}...
                  );
else

end

    % write the name of the i th map
    mapsData(i).MapName=sprintf('force-curve-%d',i);
    
    
%     for j = 1 : num_of_force_curves(i,1);
    
%        perc=ceil(100*j/num_of_force_curves);
%        isprime(perc)
%        w = waitbar(perc/100,w,sprintf(':) we are %d%% along...',perc));


%% loading data only

    [vDefldir ,segHeaderDir ,heightdir] = findloaddir_FVM(...
                                                   zipContents,index(i,1)); 
% findloaddir: function that automatically assigns the directories in which
% the loading data are located as well as the segment-header.properties.

% segHeaderDir: directory of header properties of segment.
% heightdir: directory of height measured raw data
% vDefldir: directory of vDeflection raw data
    fdata_load{i,1} = writedata(headerDir,segHeaderDir,heightdir,vDefldir);

%%%%%%%%%% HEIGHT DATA %%%%%%%%%%
% fdata_load(:,1)

%%%%%%%%%% DEFLECTION DATA %%%%%%%%%%
% fdata_load(:,2)
    clear segHeaderDir heightdir vDefldir;



%% unloading data only

    [vDefldir ,segHeaderDir ,heightdir] = findunloaddir_FVM(zipContents,...
                                                            index(i,1));
% segHeaderDir: directory of header properties of segment.
% heightdir: directory of height measured raw data
% vDefldir: directory of vDeflection raw data

    [fdata_unload{i,1}, spring_constant] = writedata(headerDir,...
                                                     segHeaderDir,...
                                                     heightdir,vDefldir);

%%%%%%%%%% HEIGHT DATA %%%%%%%%%%
% fdata_unload(:,1)

%%%%%%%%%% DEFLECTION DATA %%%%%%%%%%
% fdata_unload(:,2)
    clear segHeaderDir heightdir vDefldir;



%% smooth data and connect the loading with the unloading curve
% smooths data with sgolay and overlaps the maximum unloading and loading
% points.

    [fdata_loadS{i,1} ,fdata_unloadS{i,1}] = smooth_and_overlap(...
                                        fdata_load{i,1},fdata_unload{i,1});
%%%%%% AT THIS POINT DATA WERE SAVED TO VARIABLE "beforContactPoint.mat"

% plot(fdata_loadS{i,1}(:,1),fdata_loadS{i,1}(:,2),fdata_unloadS{i,1}(:,1),fdata_unloadS{i,1}(:,2))
%% find contact point 
% Reads loading and finds contact point
% The function also applies some tilting of the unloading data.

% Scaling to micrometers to improve numerical properties when finding the
% contact point.
    scaling=1e6;
    [f_loadS_OFF{i,1} ,data_unload{i,1}] = ContactPoint(...
                        fdata_loadS{i,1}*scaling, ...
                        fdata_unloadS{i,1}*scaling);

% The output data now are in MICROMETERS
%% connect unloading data to loading data 

% approach and retract variables are in MICROMETERS.
    [approach{i,1} ,retract{i,1}] = smooth_and_overlap(f_loadS_OFF{i,1},...
                                                         data_unload{i,1});

%% store all variables in the mapsData structure

mapsData(i).load_data{1,1} = fdata_load{i,1}; 
mapsData(i).unload_data{1,1} = fdata_unload{i,1};
mapsData(i).SmoothedLoad_data{1,1} = fdata_loadS{i,1};
mapsData(i).SmoothedUnload_data{1,1} = fdata_unloadS{i,1};
mapsData(i).Approach{1,1} = approach{i,1};
mapsData(i).Retract{1,1} = retract{i,1};

%     end 
    
    %% delete tmp files
% delete header.properties
% close(w)    uncomment this line if you are running the waitbar
    rmdir('segments','s');
    rmdir('shared-data','s');
    delete header.properties; % deletes file with filename=header.properties
    clear zipContents fdata_load data_unload fdata_loadS fdata_unload ...
          fdata_unloadS f_loadS_OFF approach retract
end