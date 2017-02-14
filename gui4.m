function varargout = gui4(varargin)
% GUI4 MATLAB code for gui4.fig
%      GUI4, by itself, creates a new GUI4 or raises the existing
%      singleton*.
%
%      H = GUI4 returns the handle to a new GUI4 or the handle to
%      the existing singleton*.
%
%      GUI4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI4.M with the given input arguments.
%
%      GUI4('Property','Value',...) creates a new GUI4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui4

% Last Modified by GUIDE v2.5 06-Jan-2017 17:51:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui4_OpeningFcn, ...
                   'gui_OutputFcn',  @gui4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui4 is made visible.
function gui4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui4 (see VARARGIN)

% Choose default command line output for gui4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
path_jpk_tip=get(hObject, 'String')
assignin('base','path_jpk_tip', path_jpk_tip)
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit2_scan_range_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_scan_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_scan_range as text
%        str2double(get(hObject,'String')) returns contents of edit2_scan_range as a double

% scan_range=get(hObject,'String')
% guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function edit2_scan_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_scan_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_tip_radius_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_tip_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_tip_radius as text
%        str2double(get(hObject,'String')) returns contents of edit3_tip_radius as a double
% tip_radius=get(hObject, 'String')
% assignin('base','tip_radius', tip_radius);
% guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit3_tip_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_tip_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.jpk','Filedirectory of AFM tip image');
path=cellstr(pathname);
[~,name,~] = fileparts(filename); 
varname=cell(1,1);
ImDir=fullfile(pathname,filename);
set(handles.edit1,'String',ImDir);
set(handles.text3,'String',filename);
% set(handles.edit1,'String', filename)
guidata(hObject, handles)


% --- Executes on button press in pushbutton2. START TIP DECONVOLUTION
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.popupmenu3_operating_system, 'Value');
str=get(handles.popupmenu3_operating_system, 'String');
switch (str{val})
    case 'Choose your operating system'
        msgbox('Please choose your operating system to start')
    case 'Windows'
        system_chosen='W'
    case 'Linux'
        system_chosen='L'
    case 'Mac'
        system_chosen='M'
end
% guidata(hObject, handles);

ImDir=get(handles.edit1, 'String');
[~,name,~] = fileparts(ImDir);
[pathname,~,~]=fileparts(ImDir);
gui_1_1_readjpk_single_file;

image = varname{1,1};
varname{1,1} = gui_planefit_tgt1(image);
filename=get(handles.text3, 'String');
answer1=get(handles.edit2_scan_range, 'string');
answer2=get(handles.edit3_tip_radius,'string');
answer1=str2num(answer1);
answer2=str2num(answer2);
for i = 1:length(name_list) %loop through all the ibw files
   
%     if size(varname,3)<4
%         disp(['Error! Channel 4 is missing in ' name_list{i} '.ibw']);
%         disp('Please ensure that the Z Sensor data is recorded on channel 4');
%         disp('Proceeding to next file');
%     else
        [z, height]=scalescan(varname{i,1}); %put the ZSensor scan image in the positive range
        pixelz_x=size(z,1);
        pixelz_y=size(z,2);
        [s,size_pixel_x,size_pixel_y] = gui_cone(pixelz_x, pixelz_y, height,filename, answer1, answer2) %generate the perfect cone of TGT1
        [max_x, max_y] = getpeak(s); %find location of the tip peak
        pixels_x=size(s,1);
        pixels_y=size(s,2);

        v = genvarname(['probe_tip']);
        g = strcat(name_list{i},'.jpk');
        eval([v ' = minimiseW(z,s,pixelz_x,pixelz_y,pixels_x,pixels_y,max_x, max_y);']); %calculate the tip geometry
%         writedata; %write the tip in a new ibw file
%     end
end



clear d fid g height i max_x max_y n name_list pixels pixelz probe_file...
    s tip type v varname wdata x y z pixels_x pixels_y pixelz_x pixelz_y

if (get(handles.checkbox1_save_workspace,'Value')==get(handles.checkbox1_save_workspace,'Max'))
    mat_filename=get(handles.edit6_mat_filename, 'String');
    path_mat_file=get(handles.edit5_path_to_save,'String');
    guidata(hObject, handles);
end

if exist ('mat_filename')==1
    dat_file=fullfile(path_mat_file,mat_filename);
    save(dat_file, 'filename','ImDir','name','pathname','probe_tip',...
        'Scansizex','Scansizey','size_pixel_x','size_pixel_y');
    save('tip.mat','filename','ImDir','name','pathname','probe_tip',...
        'Scansizex','Scansizey','size_pixel_x','size_pixel_y');
else
    save('tip.mat','filename','ImDir','name','pathname','probe_tip',...
        'Scansizex','Scansizey','size_pixel_x','size_pixel_y');
end
 %Saving to: /Users/Julia/Desktop/TBM_Project/IndividualFibrilForceAnalysis/matlab.mat
%load('matlab.mat')
    %clear temporary variables



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1_save_workspace.
function checkbox1_save_workspace_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1_save_workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1_save_workspace
    get(hObject,'Value');
    guidata(hObject,handles);


function edit5_path_to_save_Callback(hObject, eventdata, handles)
% hObject    handle to edit5_path_to_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5_path_to_save as text
%        str2double(get(hObject,'String')) returns contents of edit5_path_to_save as a double


% --- Executes during object creation, after setting all properties.
function edit5_path_to_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5_path_to_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3_search2.
function pushbutton3_search2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3_search2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
foldername=uigetdir(pwd,'Directory where workspace of deconvuluted tip should be saved');
set(handles.edit5_path_to_save,'String', foldername);
% set(handles.edit1,'String', filename)
guidata(hObject, handles);

%%%%%Projected area
%%%%%calculation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function edit6_mat_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit6_mat_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6_mat_filename as text
%        str2double(get(hObject,'String')) returns contents of edit6_mat_filename as a double


% --- Executes during object creation, after setting all properties.
function edit6_mat_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6_mat_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_step_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit8_step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8_step_size as text
%        str2double(get(hObject,'String')) returns contents of edit8_step_size as a double


% --- Executes during object creation, after setting all properties.
function edit8_step_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8_step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_patch_to_tip_Callback(hObject, eventdata, handles)
% hObject    handle to edit7_patch_to_tip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7_patch_to_tip as text
%        str2double(get(hObject,'String')) returns contents of edit7_patch_to_tip as a double


% --- Executes during object creation, after setting all properties.
function edit7_patch_to_tip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7_patch_to_tip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4_search.
function pushbutton4_search_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4_search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.mat','Filedirectory of deconvoluted tip .mat');
file=fullfile(pathname, filename);
set(handles.edit7_patch_to_tip,'String',file);
guidata(hObject, handles)



% --- Executes on button press in pushbutton5_start_area.
function pushbutton5_start_area_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5_start_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

val=get(handles.popupmenu3_operating_system, 'Value');
str=get(handles.popupmenu3_operating_system, 'String');
switch (str{val})
    case 'Choose your operating system'
        waitfor(msgbox('Please choose your operating system to start'))
        val=get(handles.popupmenu3_operating_system, 'Value');
        str=get(handles.popupmenu3_operating_system, 'String');
            switch (str{val})
                case 'Choose your operating system' 
                error
                case 'Windows'
                system_chosen='W'
                case 'Linux'
                system_chosen='L'
                case 'Mac'
                system_chosen='M'
            end

    case 'Windows'
        system_chosen='W'
    case 'Linux'
        system_chosen='L'
    case 'Mac'
        system_chosen='M'
end

e=get(handles.slsproc, 'SelectedObject');
whatever=get(e,'String');
if strcmp(whatever,'Use file that already exists ')==1
    
    load(get(handles.edit7_patch_to_tip,'String'))
else
    
 load tip.mat   
end

%% projected area calculation
answer4=get(handles.edit8_step_size,'String');
 [depth_num(:,1), projected_area(:,1)] = gui_proj_area(...
                     probe_tip,Scansizex*10^-6,answer4, (handles.axes5));


 
% depth_num in NANOMETERS
% projected_area in METERS
% Store the tip data in a structure variable
Tip.data = probe_tip;
Tip.ProjArea = projected_area; % in METERS
Tip.HeightData = depth_num; % in NANOMETERS
Tip.XaxisSizeUM = Scansizex;
Tip.YaxisSizeUM = Scansizey;


tipdataname = sprintf('%s%s.mat',pathname,name);
save(tipdataname, 'depth_num', 'filename','ImDir','name', 'pathname',...
    'probe_tip','projected_area',...
    'Scansizex', 'Scansizey', 'size_pixel_x', 'size_pixel_y', 'Tip', ...
    'tipdataname')



%% Step 3: Read height image, find max position
datadir=get(handles.edit9_folder_jpk_force_map,'String');
[flistforce,flistmap,Status] = gui_UnzipForceIndices_v3(datadir, system_chosen, handles.message);

units = get(handles.edit10_units, 'String');
poisson_ratio = get(handles.edit11_poisson_ratio, 'String') ;
thename = get(handles.edit12_filename,'String');
percentage_slope = get( handles.edit13_percentage_slope,'String')


[units,nu, sample_name,percent, ...
          fdata_load, fdata_unload,...
          fdata_loadS, fdata_unloadS,...
          approach, retract, results_valid] = gui_Preamble(flistmap,units,poisson_ratio, thename,...
                                                percentage_slope);

mkdir(datadir,'Analysis');
mkdir(fullfile(datadir, 'Analysis'),'results');

for pp=1:length(flistforce)
    
     %mkdir(datadir,sprintf('temp_f%d',pp)); %create a temporary folder to store the dat files for analysis.
    tempdir{pp,1} = fullfile(datadir,sprintf('temp_f%d',pp));
    
end
%  h = waitbar2(0,'Analyzin data...');
answer5=get(handles.edit14_reference_slope,'String');
for fib=1:length(flistforce)
    reference(fib,1)=str2double(answer5);
clear indices

fnameforce=flistforce(fib).name;
fnamemap=flistmap(fib).name;


end
% --- Executes on selection change in popupmenu3_operating_system.
function popupmenu3_operating_system_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3_operating_system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject, 'Value');
str=get(hObject, 'String');
switch (str{val})
    case 'Choose your operating system'
        msgbox('Please choose your operating system to start')
    case 'Windows'
        system_chosen='W'
    case 'Linux'
        system_chosen='L'
    case 'Mac'
        system_chosen='M'
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3_operating_system contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3_operating_system


% --- Executes during object creation, after setting all properties.
function popupmenu3_operating_system_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3_operating_system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_folder_jpk_force_map_Callback(hObject, eventdata, handles)
% hObject    handle to edit9_folder_jpk_force_map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9_folder_jpk_force_map as text
%        str2double(get(hObject,'String')) returns contents of edit9_folder_jpk_force_map as a double


% --- Executes during object creation, after setting all properties.
function edit9_folder_jpk_force_map_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9_folder_jpk_force_map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6_search_jpk_force_map.
function pushbutton6_search_jpk_force_map_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6_search_jpk_force_map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
foldername=uigetdir(pwd,'Folder where *.jpk-force-file is located');
set(handles.edit9_folder_jpk_force_map,'String', foldername);
% set(handles.edit1,'String', filename)
guidata(hObject, handles);



function edit10_units_Callback(hObject, eventdata, handles)
% hObject    handle to edit10_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10_units as text
%        str2double(get(hObject,'String')) returns contents of edit10_units as a double


% --- Executes during object creation, after setting all properties.
function edit10_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_poisson_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to edit11_poisson_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11_poisson_ratio as text
%        str2double(get(hObject,'String')) returns contents of edit11_poisson_ratio as a double


% --- Executes during object creation, after setting all properties.
function edit11_poisson_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11_poisson_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit12_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12_filename as text
%        str2double(get(hObject,'String')) returns contents of edit12_filename as a double


% --- Executes during object creation, after setting all properties.
function edit12_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_percentage_slope_Callback(hObject, eventdata, handles)
% hObject    handle to edit13_percentage_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13_percentage_slope as text
%        str2double(get(hObject,'String')) returns contents of edit13_percentage_slope as a double


% --- Executes during object creation, after setting all properties.
function edit13_percentage_slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13_percentage_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_reference_slope_Callback(hObject, eventdata, handles)
% hObject    handle to edit14_reference_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14_reference_slope as text
%        str2double(get(hObject,'String')) returns contents of edit14_reference_slope as a double


% --- Executes during object creation, after setting all properties.
function edit14_reference_slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14_reference_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
