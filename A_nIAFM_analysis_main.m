
%% Step 1: AFM tip reconstruction
system_chosen='L';
deconvolute_tip;


%% Step 2: Projected area calculation

[depth_num(:,1), projected_area(:,1)] = proj_area(...
                               probe_tip,Scansizex*10^-6);
% depth_num in NANOMETERS
% projected_area in METERS
% Store the tip data in a structure variable

Tip.data = probe_tip;
Tip.ProjArea = projected_area; % in METERS
Tip.HeightData = depth_num; % in NANOMETERS
Tip.XaxisSizeUM = Scansizex;
Tip.YaxisSizeUM = Scansizey;

tipdataname = sprintf('%s%s.mat',pathname,name);
save(tipdataname)
% Step 3: Read height image, find max position
datadir=uigetdir(cd,'Select the folder location of the data');
% Unzip data-image.force (height image file) of force map zip file
[flistforce,flistmap,Status] = UnzipForceIndices_v3(datadir,'L');
[units,nu, sample_name,percent, ...
          fdata_load, fdata_unload,...
          fdata_loadS, fdata_unloadS,...
          approach, retract, results_valid] = Preamble(flistmap);

mkdir(datadir,'Analysis');
mkdir(fullfile(datadir, 'Analysis'),'results');
% below create all the temporary folders at once. These folders are then
% used to export the .dat files from the *.jpk-force-map files for further
% analysis. The filedirectory of each temp folder is saved in the cell
% variable TEMPDIR. The TEMPDIR is called further below in the next for
% loop.
for pp=1:length(flistforce)
    
     %mkdir(datadir,sprintf('temp_f%d',pp)); %create a temporary folder to store the dat files for analysis.
    tempdir{pp,1} = fullfile(datadir,sprintf('temp_f%d',pp));
    
end
%  h = waitbar2(0,'Analyzin data...');
for fib=1:length(flistforce)
    reference(fib,1)=refSLOPE(fib,length(flistforce));
clear indices
B_Step3Analysis_v3;
%  waitbar(fib/length(flistforce),h)

if strcmp(system_chosen,'W')==1;
        system(['"C:\Program Files\7-Zip\7z.exe" x -o"',tempdir{fib,1},'" "',fullfile(datadir,fnamemap),'" ',...
            '"shared-data\header.properties"']);
elseif strcmp(system_chosen,'L')==1;
            system(['unzip -o ', fullfile(datadir,fnamemap), ' ''*shared-data/header.properties'' -d ', tempdir{fib,1}]);
elseif strcmp(system_chosen,'M')==1;
        system(['unzip -o ', fullfile(datadir,fnamemap), ' ''*shared-data/header.properties'' -d ', tempdir{fib,1}]);
end
%% Step 4: Export force curves for fibri N and analyze
% Find the contact indentation depth

C_Step4_Analysis_v2

%% valid data
KeepValidData;
run subplots_post_analysis.m
clear indices himage 
end
% 
for pp=1:length(flistforce)  
    rmdir(tempdir{pp,1},'s') 
end

clear f f2 f1 ax annot columns curves_curves_to_disregard

f1=fullfile(datadir,'Analysis');
% filename = sprintf('%s%sFibrils_%s.mat',f1,'\',sample_name);
% save(filename,'FibrilData','Tip','spring_constant',...
%               'reference','nu','results_valid','sample_name','AreaFun');
save (fullfile(f1,['Fibrils_',sample_name]),'Tip','spring_constant',...
              'reference','nu','results_valid','sample_name','AreaFun');

% clear all





