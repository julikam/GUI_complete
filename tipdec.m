function varargout = tipdec(varargin)
% TIPDEC MATLAB code for tipdec.fig
%      TIPDEC, by itself, creates a new TIPDEC or raises the existing
%      singleton*.
%
%      H = TIPDEC returns the handle to a new TIPDEC or the handle to
%      the existing singleton*.
%
%      TIPDEC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIPDEC.M with the given input arguments.
%
%      TIPDEC('Property','Value',...) creates a new TIPDEC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tipdec_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tipdec_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tipdec

% Last Modified by GUIDE v2.5 14-Feb-2017 15:24:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tipdec_OpeningFcn, ...
                   'gui_OutputFcn',  @tipdec_OutputFcn, ...
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


% --- Executes just before tipdec is made visible.
function tipdec_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tipdec (see VARARGIN)

% Choose default command line output for tipdec
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.text8,'String','');
% UIWAIT makes tipdec wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tipdec_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text8,'String','');

e=get(handles.slsproc, 'SelectedObject');
whatever=get(e,'String');
if strcmp(whatever,'Use .mat file that already exists')==1
    
    load(get(handles.edit6,'String'))
else
    
 load tip.mat   
end

%% projected area calculation
answer4=get(handles.edit7,'String');
 [depth_num(:,1), projected_area(:,1)] = gui_proj_area(...
                     probe_tip,Scansizex*10^-6,answer4, (handles.axes1));


 
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
if (get(handles.checkbox3,'Value')==get(handles.checkbox3,'Max'))
    savedir=fullfile((get(handles.edit8,'String')),get(handles.edit9,'String'));
    guidata(hObject, handles);
    save(savedir, 'depth_num', 'filename','ImDir','name', 'pathname',...
    'probe_tip','projected_area',...
    'Scansizex', 'Scansizey', 'size_pixel_x', 'size_pixel_y', 'Tip', ...
    'tipdataname')
set(handles.text7,'String', ['Workspace was saved to ', name,'.mat and to ',savedir]);
else
set(handles.text7,'String', ['Workspace was saved to ', name,'.mat']);
end
save('tipareaconv.mat','depth_num', 'filename','ImDir','name', 'pathname',...
    'probe_tip','projected_area',...
    'Scansizex', 'Scansizey', 'size_pixel_x', 'size_pixel_y', 'Tip', ...
    'tipdataname')
set(handles.text8,'String','Done, you can now move on to fibril analysis')
function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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
set(handles.text5,'String',filename);
% set(handles.edit1,'String', filename)
guidata(hObject, handles)


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
  get(hObject,'Value');
    guidata(hObject,handles);



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.checkbox1, 'Value',1)
foldername=uigetdir(pwd,'Directory where workspace of deconvuluted tip should be saved');
set(handles.edit4,'String', foldername);
% set(handles.edit1,'String', filename)
guidata(hObject, handles);


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text8,'String','Please choose your tip and close by double click');
ImDir=get(handles.edit1, 'String');
[~,name,~] = fileparts(ImDir);
[pathname,~,~]=fileparts(ImDir);
gui_1_1_readjpk_single_file;

image = varname{1,1};
varname{1,1} = gui_planefit_tgt1(image);
filename=get(handles.text5, 'String');
answer1=get(handles.edit2, 'string');
answer2=get(handles.edit3,'string');
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
        set(handles.text8,'String','Processing, please wait');
        eval([v ' = minimiseW(z,s,pixelz_x,pixelz_y,pixels_x,pixels_y,max_x, max_y);']); %calculate the tip geometry
%         writedata; %write the tip in a new ibw file
%     end
end



clear d fid g height i max_x max_y n name_list pixels pixelz probe_file...
    s tip type v varname wdata x y z pixels_x pixels_y pixelz_x pixelz_y

if (get(handles.checkbox1,'Value')==get(handles.checkbox1,'Max'))
    mat_filename=get(handles.edit5, 'String');
    path_mat_file=get(handles.edit4,'String');
    guidata(hObject, handles);
end

if exist ('mat_filename')==1
    dat_file=fullfile(path_mat_file,mat_filename);
    save(dat_file, 'filename','ImDir','name','pathname','probe_tip',...
        'Scansizex','Scansizey','size_pixel_x','size_pixel_y');
    save('tip.mat','filename','ImDir','name','pathname','probe_tip',...
        'Scansizex','Scansizey','size_pixel_x','size_pixel_y');
        set(handles.text8,'String',['Tip deconvolution has finished, workspace saved to ',fullfile(path_mat_file,mat_filename)]);

else
    save('tip.mat','filename','ImDir','name','pathname','probe_tip',...
        'Scansizex','Scansizey','size_pixel_x','size_pixel_y');
        set(handles.text8,'String','Tip deconvolution has finished');

    
end
 %Saving to: /Users/Julia/Desktop/TBM_Project/IndividualFibrilForceAnalysis/matlab.mat
%load('matlab.mat')
    %clear temporary variables



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text8,'String','');
set(handles.radiobutton2, 'Value',1)
[filename,pathname]=uigetfile('*.mat','Filedirectory of deconvoluted tip .mat');
file=fullfile(pathname, filename);
set(handles.edit6,'String',file);
guidata(hObject, handles)


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text8,'String','');
set(handles.checkbox3, 'Value',1);
pathname=uigetdir(pwd,'Filedirectory where you want to save');
set(handles.edit8,'String',pathname);
guidata(hObject, handles)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
analysis



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
