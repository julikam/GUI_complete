function [units,nu, sample_name,percent, ...
          fdata_load, fdata_unload,...
          fdata_loadS, fdata_unloadS,...
          approach, retract, results_valid] = Preamble(flistmap)

prompt = {
    'kPa, MPa or GPa',...
    'Poisson ratio of sample',...
    'Filename',...
    'Percent of upper portion to calculate slope'};
    dlg_title = 'Input data';
    num_lines = 1;
    def = {
        'MPa',...
        '0.5',...
        'name',...
        '0.5'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);  
    units = cell2mat(answer(1,1));
    nu = str2double(cell2mat(answer(2,1)));
    sample_name = cell2mat(answer(3,1));
    percent = str2double(cell2mat(answer(4,1)));
% Stores the reference slope, the radius
clear prompt dlg_title num_lines def answer;

%%

% prealocate variables FDATA_LOAD, FDATA_UNLOAD and SMOOTHED ONES.
fdata_load = cell(length(flistmap),1); 
fdata_unload = cell(length(flistmap),1);
fdata_loadS = cell(length(flistmap),1); 
fdata_unloadS = cell(length(flistmap),1);
approach = cell(length(flistmap),1);
retract = cell(length(flistmap),1);


       results_valid = struct('Fibril',cell(length(flistmap),1),...
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