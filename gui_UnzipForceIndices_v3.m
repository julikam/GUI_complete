% This function either unzips the .force file located in the JPK-force-map
% or just the indices of the Jpk-force-map file which were derived
% from the MaxPixelIndeces script
% Input: Directory where JPK-force-map.zip/.force files are located
%   optional (later in analysis steps): vector which includes indices which 
%   have to be unziped from the JPK-foce-map

function [flistforce,flistmap,Status] = UnzipForceIndices_v3(datadir,System,a,indices,fnamemap,tempdir)
N=nargin;
%direct=cd;

%For just unpacking the .force file from the JPK-force-map file if (for old
%version structures. Old version has .force file already unziped whereas
%the new 5.0.82 version has the .force file in the jpk-force-map file.
if N==3;   
   if strcmp(System,'W')==1;
        system(['for %a in ','(',datadir,...
        '\*.jpk-force-map) do @("C:\Program Files\7-Zip\7z.exe" l "%~a" -ir!data-image.force |findstr data-image.force) && "C:\Program Files\7-Zip\7z.exe" e "%~a" -ir!data-image.force -so >"',...
        datadir,'\%~na.force"']);
    
    
   elseif strcmp(System,'L')==1;
         
% sed = 'sed ''s/^.\///'' | sed ''s/.*\///\'''
% files = dir([datadir,'/*.jpk-force-map' ])
% for i = 1:size(files,1)
%     fl = [datadir, '/', files(i).name];
%     outfl = [datadir, '/', files(i).name, '_na_force'];
% %     cmd = ['BLA=$(unzip -Zl ', fl, '| find . -iname *data-image.force | ', sed,')  && unzip -p ', fl, ' $BLA > ', outfl ]
%     cmd = ['unzip -p ', fl, ' data-image.force > ', outfl ];
%     system(cmd)
% end

% @author: Simon Dirmeier <mail@simon-dirmeier.net>

% datadir = '~/Downloads';

files = dir([datadir,'/*.jpk-force-map' ]);
for i = 1:size(files,1)
    fl = [datadir, '/', files(i).name];
    % name of the folder where files are unpacked to
    outfl = [datadir,'/']
    % unzip command
    % -o: force overwrite if files already exist
    % fl: file we want to extract from
    % *data-image.force: wildcard to extract all files with this suffixes
    % -d: name of output director
    cmd = ['unzip -o ', fl, ' ''*data-image.force'' -d ', outfl ];
    disp(['Executing:', cmd])
    cmd1=['mv ',strrep(datadir,files(i).name,''),'/data-image.force ',strrep(datadir,files(i).name,''), '/',strrep(files(i).name,'jpk-force-map','force')];
    % call to shell
    system(cmd);
    system(cmd1);
    
end


    elseif strcmp(System,'M')==1;
     
% files = dir([datadir,'/*.jpk-force-map' ]);
% for i = 1:size(files,1)
%     fl = [datadir, '/', files(i).name];
%     % name of the folder where files are unpacked to
%     outfl = strrep(fl, '.jpk-force-map', '_unpacked');
%     % unzip command
%     % -o: force overwrite if files already exist
%     % fl: file we want to extract from
%     % *data-image.force: wildcard to extract all files with this suffixes
%     % -d: name of output directory
%     cmd = ['unzip -o ', fl, ' ''*data-image.force'' -d ', outfl ];
%     disp(['Executing:', cmd])
%     % call to shell
%      system(cmd);
%      
% 
% end
files = dir([datadir,'/*.jpk-force-map' ]);
for i = 1:size(files,1)
    fl = [datadir, '/', files(i).name];
    % name of the folder where files are unpacked to
    outfl = [datadir,'/']
    % unzip command
    % -o: force overwrite if files already exist
    % fl: file we want to extract from
    % *data-image.force: wildcard to extract all files with this suffixes
    % -d: name of output director
    cmd = ['unzip -o ', fl, ' ''*data-image.force'' -d ', outfl ];
    disp(['Executing:', cmd])
    cmd1=['mv ',strrep(datadir,files(i).name,''),'/data-image.force ',strrep(datadir,files(i).name,''), '/',strrep(files(i).name,'jpk-force-map','force')];
    % call to shell
    system(cmd);
    system(cmd1);
    
end

   end

flistforce=dir(fullfile(datadir,'*.force'));
flistmap=dir(fullfile(datadir,'*.jpk-force-map'));

% FOR loop below checks if the name of each .force file is the same as the
% one of the respective jpk-force-map file. If that is the case then there
% is a message indicating unziping was successful.
    count=0;
    for i=1:length(flistmap)
        count=count+strncmpi(flistforce(i).name,...
            flistmap(i).name,(length(flistforce(i).name)-6)); %compare first n charcter of strings 
    end
    
    if count==length(flistmap)
        Status='OK';
        set(a, 'String','Unziping of .jpk-force-map files is OK');
    else
        Status='FAIL';
        set(a, 'String','There is something wrong with the amount of .force files');
    end
end    
%For unpacking the specific indices from the JPK-force-map file (part of
%the fibril analysis
if N==5
    for i=1:length(indices);
        if strcmp(System,'W')==1;
            
            system(['"C:\Program Files\7-Zip\7z.exe" x -o"',tempdir,'" "',fullfile(datadir,fnamemap),'" ',...
                    '"index\',num2str(indices(i)),'"']);
        elseif strcmp(System,'L')==1;
        
                zipfile = fullfile(datadir,fnamemap);
                outfolder = tempdir;
                match = fullfile('index', num2str(indices(i)));
                cmd = ['unzip ',zipfile, ' ',match, ' -d ' tempdir]
                system(cmd);
       
       elseif strcmp(System,'M')==1;
        
                zipfile = fullfile(datadir,fnamemap);
                outfolder = tempdir;
                match = fullfile('index', num2str(indices(i)));
                cmd = ['unzip ',zipfile, ' ',match, ' -d ' tempdir]
                system(cmd);
        
    end    
end
end

