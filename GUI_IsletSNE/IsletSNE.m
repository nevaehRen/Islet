function varargout = IsletSNE(varargin)

%IsletSNE MATLAB code file for IsletSNE.fig
%      IsletSNE, by itself, creates a new IsletSNE or raises the existing
%      singleton*.
%
%      H = IsletSNE returns the handle to a new IsletSNE or the handle to
%      the existing singleton*.
%
%      IsletSNE('Property','Value',...) creates a new IsletSNE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to IsletSNE_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      IsletSNE('CALLBACK') and IsletSNE('CALLBACK',hObject,...) call the%      local function named CALLBACK in IsletSNE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IsletSNE

% Last Modified by GUIDE v2.5 29-Jul-2020 02:57:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IsletSNE_OpeningFcn, ...
                   'gui_OutputFcn',  @IsletSNE_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before IsletSNE is made visible.
function IsletSNE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for IsletSNE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IsletSNE wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%% Step 0 ~~~
%% jump back to add functions
MainPath = mfilename('fullpath');
s = regexp(MainPath,'GUI_IsletSNE','split');
addpath([s{1} 'GUI_IsletSNE/']);
addpath([s{1} 'GUI_IsletSNE/Functions/']);

 clear global; 
 axes(handles.axes_Islet);
 box on;
 set(gca,'ytick',[]);
 set(gca,'xtick',[]);
%  set(handles.state_done,'str','...') ;  % Set the 'answer' editbox to display result.
 
 axes(handles.axes_Corr);
 box on;
 set(gca,'ytick',[]);
 set(gca,'xtick',[]);
 
 axes(handles.axes_Type_Map);
 box on;
 set(gca,'ytick',[]);
 set(gca,'xtick',[]);
 
 axes(handles.axes_ori_trace);
 box on;
 set(gca,'ytick',[]);
 set(gca,'xtick',[]);

axes(handles.axes_heatmap);
 box on;
 set(gca,'ytick',[]);
 set(gca,'xtick',[]);
 
 axes(handles.axes_tSNE);
 box on;
 set(gca,'ytick',[]);
 set(gca,'xtick',[]);
 
 axes(handles.axes_Type_Map);
 box on;
 set(gca,'ytick',[]);
 set(gca,'xtick',[]);
 
clc;


% --- Outputs from this function are returned to the command line.
function varargout = IsletSNE_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Read_Ca_Image.
function Read_Ca_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Read_Ca_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% step1: load data ~~~~~~~
global Islet pathname filename

[filename, pathname] = uigetfile('*.mat','pick islet ...');

cd(pathname);
load(filename);

Islet = fresh_ca_signals(Islet);

set(handles.Islet_Name,'String',Islet(1).Name) ;  % Set the 'answer' editbox to display result.

axes(handles.axes_Islet);
Updata_axes_Islet(Islet);
axes(handles.axes_ori_trace);
Updata_axes_ori_trace(Islet);


% --- Executes on button press in Generate_ROIs.
function Generate_ROIs_Callback(hObject, eventdata, handles)
% hObject    handle to Generate_ROIs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% step3: get time ~~~~~~~~~~~~

global Islet pathname filename

% reload Islet
load([pathname filename]);
Islet = fresh_ca_signals(Islet);
%% step1: get point number
S      = get(handles.Index,{'str'});  % Users choice from popup.
eval(['I =' char(S) ';']);

set(handles.Index,'str',char(S)) ;  % Set the 'answer' editbox to display result.
axes(handles.axes_ori_trace);
Updata_axes_ori_trace(Islet,I);

% cut Islet
Islet = Clip_Islet(Islet,I,'0');


function Generate_ROIs_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in Oscillation_Type.
function Oscillation_Type_Callback(hObject, eventdata, handles)
% hObject    handle to Oscillation_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Oscillation_Type

global Islet

methods = [1 0 0];
n_CLA   =  str2num(char(get(handles.n_CLA,{'str'}))); 
Islet   = Fresh_tSNE(Islet,methods,n_CLA);


%%%% Fresh all plot %%%%
%----------------------%
axes(handles.axes_tSNE);
Update_axes_tSNE(Islet);
axis off ;

axes(handles.axes_Corr);
Updata_axes_Corr(Islet)

axes(handles.axes_Islet);
% save temp.mat
Updata_axes_Islet(Islet);

axes(handles.axes_heatmap);
Updata_axes_heatmap(Islet);
%---
axes(handles.axes_Type_Map);
Updata_axes_Type_Map(Islet);



function Index_Callback(hObject, eventdata, handles)
% hObject    handle to Index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Index as text
%        str2double(get(hObject,'String')) returns contents of Index as a double


% --- Executes during object creation, after setting all properties.
function Index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function n_CLA_Callback(hObject, eventdata, handles)
% hObject    handle to n_CLA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_CLA as text
%        str2double(get(hObject,'String')) returns contents of n_CLA as a double


% --- Executes during object creation, after setting all properties.
function n_CLA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_CLA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Type_Mat_Name_Callback(hObject, eventdata, handles)
% hObject    handle to Type_Mat_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type_Mat_Name as text
%        str2double(get(hObject,'String')) returns contents of Type_Mat_Name as a double
global Islet

S      = get(handles.Type_Mat_Name,{'str'});  % Users choice from popup.
Islet(1).Name = [char(S)];

% --- Executes during object creation, after setting all properties.
function Type_Mat_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Type_Mat_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save_Data_Mat.
function Save_Data_Mat_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Data_Mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Islet

if exist(['Result/' Islet(1).Name  '_Summary/'])~=0; rmdir(['Result/' Islet(1).Name '_Summary/'],'s'); end;
mkdir(['Result/' Islet(1).Name  '_Summary/']);

axes(handles.axes_Corr);
saveas(gca,['Result/' Islet(1).Name '_Summary/' Islet(1).Name  '_type.png'], 'png' );

save(['Result/' Islet(1).Name '_Summary/' Islet(1).Name '_type.mat'], 'Islet' );

% --- Executes during object creation, after setting all properties.
function axes_tSNE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_tSNE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_tSNE


% --- Executes during object deletion, before destroying properties.
function axes_tSNE_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes_tSNE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 

% --- Executes during object creation, after setting all properties.
function Islet_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Islet_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Islet_Name.
function Islet_Name_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Islet_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
