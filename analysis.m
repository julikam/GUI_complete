function varargout = analysis(varargin)
% ANALYSIS MATLAB code for analysis.fig
%      ANALYSIS, by itself, creates a new ANALYSIS or raises the existing
%      singleton*.
%
%      H = ANALYSIS returns the handle to a new ANALYSIS or the handle to
%      the existing singleton*.
%
%      ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSIS.M with the given input arguments.
%
%      ANALYSIS('Property','Value',...) creates a new ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help analysis

% Last Modified by GUIDE v2.5 11-Jan-2017 20:57:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @analysis_OutputFcn, ...
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


% --- Executes just before analysis is made visible.
function analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analysis (see VARARGIN)

% Choose default command line output for analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = analysis_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.popupmenu1, 'Value');
str=get(handles.popupmenu1, 'String');
switch (str{val})
    case 'Choose your operating system'
        waitfor(msgbox('Please choose your operating system to start'))
        val=get(handles.popupmenu1, 'Value');
        str=get(handles.popupmenu1, 'String');
            switch (str{val})
                case 'Windows'
                system_chosen='W';
                case 'Linux'
                system_chosen='L';
                case 'Mac'
                system_chosen='M';
            end

    case 'Windows'
        system_chosen='W';
    case 'Linux'
        system_chosen='L';
    case 'Mac'
        system_chosen='M';
end
if strcmp(system_chosen,'M')
    system_chosen='L'
end
e=get(handles.chooseprcd, 'SelectedObject');
whatever=get(e,'String');
if strcmp(whatever,'Use latest deconvoluted tip')==1
   load tipareaconv.mat    
   
else
     load(get(handles.edit5,'String'))
end
datadir=get(handles.edit6,'String');
[flistforce,flistmap,Status] = gui_UnzipForceIndices_v3(datadir,system_chosen,handles.text7);

units = get(handles.edit1, 'String');
poisson_ratio = get(handles.edit2, 'String') ;
thename = get(handles.edit3,'String');
percentage_slope = get( handles.edit4,'String');

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

for fib=1:length(flistforce)
    
%     reference(fib,1)=str2double(get(handles.edit7,'String'));
    reference(fib,1)=refSLOPE(fib,length(flistforce));
clear indices

fnameforce=flistforce(fib).name;  %%%
fnamemap=flistmap(fib).name;    %%%

gui_ReadHeightImage_v3


%% pos of max points
set(handles.text22,'FontSize',14)
set(handles.text22,'String','Processing')

gui_MaxPixelIndeces_v3

 gui_B_Step3Analysis_v3
 
 
 if strcmp(system_chosen,'W')==1;
        system(['"C:\Program Files\7-Zip\7z.exe" x -o"',tempdir{fib,1},'" "',fullfile(datadir,fnamemap),'" ',...
            '"shared-data\header.properties"']);
elseif strcmp(system_chosen,'L')==1;
            system(['unzip -o ', fullfile(datadir,fnamemap), ' ''*shared-data/header.properties'' -d ', tempdir{fib,1}]);
elseif strcmp(system_chosen,'M')==1;
        system(['unzip -o ', fullfile(datadir,fnamemap), ' ''*shared-data/header.properties'' -d ', tempdir{fib,1}]);
 end

gui_C_Step4_Analysis_v2

set(handles.text21,'FontSize',16);
set(handles.text14,'String', 'Now please review your forcecurves and choose the ones you want to analyse!');
set(handles.text22,'FontSize',10)
set(handles.text22,'String', 'Number of force curves to review: ');
set(handles.text21,'String', length(indices));
if length(indices)>16
   set(handles.text21,'ForegroundColor','r')
end
guidata(hObject,handles)
clear cell
mkdir(resultsFolder,'overview')
str = cell(length(indices),1);
curves_to_disregard = zeros(1,1);
curves_to_ANALYSE=zeros(1,1);

num_of_files=length(indices)

if length(indices)>16.1
     rows = 4;
        columns = 4;
        % preallocate the variable indent    
        indent(:,1) = zeros(16,1);
        % total number of curves
        indent(:,1) = 1:16;        
        num_of_figures=HowManyFiguresToPlot(num_of_files);
        guidata(hObject, handles);
else
%           rows = str2double(get(handles.edit9,'String'));
%             columns = str2double(get(handles.edit10,'String'));  
%         % preallocate the variable indent    
%         indent(:,1) = zeros(num_of_files,1);
%         % total number of curves
%         indent(:,1) = 1:num_of_files; 
%         % Set figure properties
%         set(groot, 'defaultAxesTickLabelInterpreter','latex');
%         set(groot, 'defaultLegendInterpreter','latex');
%         figure('Visible','on') 
%         figure1=gcf;
%         figure1.Units='centimeters';
%         figure1.PaperOrientation = 'landscape';
%         figure1.Position = [5 1.5 29 19];
%         figure1.PaperPositionMode = 'auto';
%         axes('Parent',figure1,'FontSize',9);
        % add annotation to figure
%         annot = annotation('textbox');
%         annot.Position = [0.45,0.95,0.3,0.03];
%         annot.Interpreter = 'latex';
%         annot.EdgeColor = 'none';
%         annot.FitBoxToText = 'on';
%         annot.String = sprintf('%s',sample_name);  
 prompt = {...
            'Enter number of rows (integer):',...
            'Enter number of columns (integer):'};
            dlg_title = sprintf('%d Curves to review',num_of_files);
            num_lines = [1 50];
            def = {...
                '4',...
                '4'};
            answer = inputdlg(prompt,dlg_title,num_lines,def);  
            rows = str2double(cell2mat(answer(1,1)));
            columns = str2double(cell2mat(answer(2,1)));  
        % preallocate the variable indent    
        indent(:,1) = zeros(num_of_files,1);
        % total number of curves
        indent(:,1) = 1:num_of_files; 
        % Set figure properties
        set(groot, 'defaultAxesTickLabelInterpreter','latex');
        set(groot, 'defaultLegendInterpreter','latex');
%         figure('Visible','on') 
%         figure1=gcf;
%         figure1.Units='centimeters';
%         figure1.PaperOrientation = 'landscape';
%         figure1.Position = [5 1.5 29 19];
%         figure1.PaperPositionMode = 'auto';
%         axes('Parent',figure1,'FontSize',9);
        % add annotation to figure
%         annot = annotation('textbox');
%         annot.Position = [0.45,0.95,0.3,0.03];
%         annot.Interpreter = 'latex';
%         annot.EdgeColor = 'none';
%         annot.FitBoxToText = 'on';
%         annot.String = sprintf('%s',sample_name);    
        num_of_figures=1;
clear prompt dlg_title num_lines def answer choise;
end

if isequal(fix(length(indices)/16),length(indices)/16)
    reviewSynairgen_case2
else
    reviewSynairgenGraphs; % this is only if the total number of files devided
% by 16 is NOT an integer
end
gui_C_part_2_Step4_Analysis_v2

%% valid data
KeepValidData;
run gui_subplots_post_analysis.m
clear indices himage 
close(figure2)
set(handles.text22,'String','');
set(handles.text21,'String','');
set(handles.text14,'String','');
set(handles.text15,'String','');
set(handles.text16,'String','');
set(handles.text17,'String','');
set(handles.text18,'String','');
set(handles.text19,'String','');
set(handles.text14,'FontSize',12);
set(handles.text14,'String',['For results, please see ',f1]);
end
% 
for pp=1:length(flistforce)  
    rmdir(tempdir{pp,1},'s') 
end

clear f f2 f1 ax annot columns curves_curves_to_disregard

f1=fullfile(datadir,'Analysis');
filename = sprintf('%s%sFibrils_%s.mat',f1,'\',sample_name);
save (fullfile(f1,['Fibrils_',sample_name]),'Tip','spring_constant',...
              'reference','nu','results_valid','sample_name','AreaFun');
set(handles.text19,'String',['Save Variables Tip, spring_constant, reference, nu,results_valid,sample_name and AreaFun to',char(10),...
    fullfile(f1,['Fibrils_',sample_name],'.mat')]);
% clear all
% clear all
set(handles.text14,'String','');
set(handles.text15,'String','');
set(handles.text16,'String','');
set(handles.text17,'String','');
set(handles.text18,'String','');
set(handles.text19,'String','');
set(handles.text14,'FontSize',12);
set(handles.text14,'String',['For results, please see ',f1]);
set(handles.text17,'FontSize',16);
set(handles.text17,'String','The End');

% C_Step4_Analysis_v2
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton2, 'Value',1)
[filename,pathname]=uigetfile('*.mat','Filedirectory of calculated tip .mat');
file=fullfile(pathname, filename);
set(handles.edit5,'String',file);
guidata(hObject, handles);



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=uigetdir(pwd,'Folder of .jpk-force-map');
set(handles.edit6,'String',path);



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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load anna1.mat
set(handles.text14,'FontSize',10)
for fib=1:length(flistforce)
clear cell
mkdir(resultsFolder,'overview')
str = cell(length(indices),1);
curves_to_disregard = zeros(1,1);
curves_to_ANALYSE=zeros(1,1);


num_of_files=length(indices)

if (get(handles.checkbox2,'Value')==get(handles.checkbox2,'Max'))
       rows = 4;
        columns = 4;
        % preallocate the variable indent    
        indent(:,1) = zeros(16,1);
        % total number of curves
        indent(:,1) = 1:16;        
        num_of_figures=HowManyFiguresToPlot(num_of_files);
        guidata(hObject, handles);
    
else
            rows = str2double(get(handles.edit9,'String'));
            columns = str2double(get(handles.edit10,'String'));  
        % preallocate the variable indent    
        indent(:,1) = zeros(num_of_files,1);
        % total number of curves
        indent(:,1) = 1:num_of_files; 
        % Set figure properties
        set(groot, 'defaultAxesTickLabelInterpreter','latex');
        set(groot, 'defaultLegendInterpreter','latex');
%         figure('Visible','on') 
%         figure1=gcf;
%         figure1.Units='centimeters';
%         figure1.PaperOrientation = 'landscape';
%         figure1.Position = [5 1.5 29 19];
%         figure1.PaperPositionMode = 'auto';
%         axes('Parent',figure1,'FontSize',9);
        % add annotation to figure
%         annot = annotation('textbox');
%         annot.Position = [0.45,0.95,0.3,0.03];
%         annot.Interpreter = 'latex';
%         annot.EdgeColor = 'none';
%         annot.FitBoxToText = 'on';
%         annot.String = sprintf('%s',sample_name);    
        num_of_figures=1;
clear prompt dlg_title num_lines def answer choise;
    
end

if isequal(fix(length(indices)/16),length(indices)/16)
    reviewSynairgen_case2
else
    reviewSynairgenGraphs; % this is only if the total number of files devided
% by 16 is NOT an integer
end
gui_C_part_2_Step4_Analysis_v2
set(handles.text22,'String','');
%% valid data
KeepValidData;
run gui_subplots_post_analysis.m
clear indices himage 
end
% 
for pp=1:length(flistforce)  
    rmdir(tempdir{pp,1},'s') 
end

clear f f2 f1 ax annot columns curves_curves_to_disregard

f1=fullfile(datadir,'Analysis');
filename = sprintf('%s%sFibrils_%s.mat',f1,'\',sample_name);
% save (fullfile(f1,['Fibrils_',sample_name]),'Tip','spring_constant',...
%               'reference','nu','results_valid','sample_name','AreaFun');
% set(handles.text19,'String',['Save Variables Tip, spring_constant, reference, nu,results_valid,sample_name and AreaFun to',char(10),...
%     fullfile(f1,['Fibrils_',sample_name],'.mat')]);
% clear all

delete figure12 figure13 figure14 figure15 
% clear all
set(handles.text14,'String','');
set(handles.text15,'String','');
set(handles.text16,'String','');
set(handles.text17,'String','');
set(handles.text18,'String','');
set(handles.text19,'String','');
set(handles.text14,'FontSize',12);
set(handles.text14,'String',['For results, please see ',f1]);
set(handles.text17,'FontSize',16);
set(handles.text17,'String','The End');
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2



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



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
