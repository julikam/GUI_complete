function varargout = analysis2(varargin)
% ANALYSIS2 MATLAB code for analysis2.fig
%      ANALYSIS2, by itself, creates a new ANALYSIS2 or raises the existing
%      singleton*.
%
%      H = ANALYSIS2 returns the handle to a new ANALYSIS2 or the handle to
%      the existing singleton*.
%
%      ANALYSIS2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSIS2.M with the given input arguments.
%
%      ANALYSIS2('Property','Value',...) creates a new ANALYSIS2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before analysis2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to analysis2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help analysis2

% Last Modified by GUIDE v2.5 08-Jan-2017 18:57:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analysis2_OpeningFcn, ...
                   'gui_OutputFcn',  @analysis2_OutputFcn, ...
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


% --- Executes just before analysis2 is made visible.
function analysis2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analysis2 (see VARARGIN)

% Choose default command line output for analysis2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load anna1.mat

set(handles.text3,'String', length(indices));
if length(indices)>16
   set(handles.text3,'ForegroundColor','r')
end
guidata(hObject, handles);
% UIWAIT makes analysis2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = analysis2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load anna1.mat

clear cell
mkdir(resultsFolder,'overview')
str = cell(length(indices),1);
curves_to_disregard = zeros(1,1);
curves_to_ANALYSE=zeros(1,1);


num_of_files=length(indices)

if (get(handles.checkbox1,'Value')==get(handles.checkbox1,'Max'))
       rows = 4;
        columns = 4;
        % preallocate the variable indent    
        indent(:,1) = zeros(16,1);
        % total number of curves
        indent(:,1) = 1:16;        
        num_of_figures=HowManyFiguresToPlot(num_of_files);
        guidata(hObject, handles);
    
else
            rows = str2double(get(handles.edit1,'String'));
            columns = str2double(get(handles.edit2,'String'));  
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



guidata(hObject, handles);
