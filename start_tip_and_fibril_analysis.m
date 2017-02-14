function varargout = start_tip_and_fibril_analysis(varargin)
% START_TIP_AND_FIBRIL_ANALYSIS MATLAB code for start_tip_and_fibril_analysis.fig
%      START_TIP_AND_FIBRIL_ANALYSIS, by itself, creates a new START_TIP_AND_FIBRIL_ANALYSIS or raises the existing
%      singleton*.
%
%      H = START_TIP_AND_FIBRIL_ANALYSIS returns the handle to a new START_TIP_AND_FIBRIL_ANALYSIS or the handle to
%      the existing singleton*.
%
%      START_TIP_AND_FIBRIL_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in START_TIP_AND_FIBRIL_ANALYSIS.M with the given input arguments.
%
%      START_TIP_AND_FIBRIL_ANALYSIS('Property','Value',...) creates a new START_TIP_AND_FIBRIL_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before start_tip_and_fibril_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to start_tip_and_fibril_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help start_tip_and_fibril_analysis

% Last Modified by GUIDE v2.5 14-Feb-2017 15:22:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_tip_and_fibril_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @start_tip_and_fibril_analysis_OutputFcn, ...
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


% --- Executes just before start_tip_and_fibril_analysis is made visible.
function start_tip_and_fibril_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to start_tip_and_fibril_analysis (see VARARGIN)

% Choose default command line output for start_tip_and_fibril_analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes start_tip_and_fibril_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = start_tip_and_fibril_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tipdec

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
analysis


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
