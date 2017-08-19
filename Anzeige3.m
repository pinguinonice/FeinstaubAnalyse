function varargout = Anzeige3(varargin)
% ANZEIGE3 MATLAB code for Anzeige3.fig
%      ANZEIGE3, by itself, creates a new ANZEIGE3 or raises the existing
%      singleton*.
%
%      H = ANZEIGE3 returns the handle to a new ANZEIGE3 or the handle to
%      the existing singleton*.
%
%      ANZEIGE3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANZEIGE3.M with the given input arguments.
%
%      ANZEIGE3('Property','Value',...) creates a new ANZEIGE3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Anzeige3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Anzeige3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Anzeige3

% Last Modified by GUIDE v2.5 07-Aug-2017 11:14:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Anzeige3_OpeningFcn, ...
                   'gui_OutputFcn',  @Anzeige3_OutputFcn, ...
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


% --- Executes just before Anzeige3 is made visible.
function Anzeige3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Anzeige3 (see VARARGIN)

% Choose default command line output for Anzeige3
handles.output = hObject;
set(handles.Panel,'selectedobject',handles.Alles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Anzeige3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Anzeige3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.output;



function Starte_Callback(hObject, eventdata, handles)
% hObject    handle to Starte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Starte as text
%        str2double(get(hObject,'String')) returns contents of Starte as a double


% --- Executes during object creation, after setting all properties.
function Starte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Starte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ende_Callback(hObject, eventdata, handles)
% hObject    handle to Ende (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ende as text
%        str2double(get(hObject,'String')) returns contents of Ende as a double


% --- Executes during object creation, after setting all properties.
function Ende_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ende (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% --- Executes when selected object is changed in Panel.
function Panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global z1;
global z2;
global z3;
global z4;
global Time
    

      switch get(get(handles.Panel,'SelectedObject'),'Tag')

      case 'Alles',  set(z1,'YLimMode', 'Auto');
                     filterung( Time(1), Time(end));
                     set(z1,'XLimMode', 'Auto');               
                     set(z2,'XLimMode', 'Auto');                     
                     set(z3,'XLimMode', 'Auto');                     
                     set(z4,'XLimMode', 'Auto');
                     
                     
      case 'h24',    set(z1,'YLimMode', 'Auto');
                     filterung( datetime('now')-1, datetime('now') );
                     if verLessThan('matlab','9.2')
                     set(z1,'xlim',[datenum(datetime('now')-1), datenum(datetime('now'))]);                               
                     set(z2,'xlim',[datenum(datetime('now')-1), datenum(datetime('now'))]);                    
                     set(z3,'xlim',[datenum(datetime('now')-1), datenum(datetime('now'))]);
                     set(z4,'xlim',[datenum(datetime('now')-1), datenum(datetime('now'))]);
                     else                 
                     set(z1,'xlim',[datetime('now')-1, datetime('now')]);                               
                     set(z2,'xlim',[datetime('now')-1, datetime('now')]);                    
                     set(z3,'xlim',[datetime('now')-1, datetime('now')]); 
                     set(z4,'xlim',[datetime('now')-1, datetime('now')]);
                     end
                     
                     
      case 'Woche',  set(z1,'YLimMode', 'Auto');
                     filterung( datetime('now')-7, datetime('now') );
                     if verLessThan('matlab','9.2')
                     set(z1,'xlim',[datenum(datetime('now')-7), datenum(datetime('now'))]);                               
                     set(z2,'xlim',[datenum(datetime('now')-7), datenum(datetime('now'))]);                    
                     set(z3,'xlim',[datenum(datetime('now')-7), datenum(datetime('now'))]);
                     set(z4,'xlim',[datenum(datetime('now')-7), datenum(datetime('now'))]);
                     else                 
                     set(z1,'xlim',[datetime('now')-7, datetime('now')]);                               
                     set(z2,'xlim',[datetime('now')-7, datetime('now')]);                    
                     set(z3,'xlim',[datetime('now')-7, datetime('now')]); 
                     set(z4,'xlim',[datetime('now')-7, datetime('now')]);
                     end 
                     
      case 'VonBis', set(z1,'YLimMode', 'Auto');
                     filterung( datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd'), datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd') );
                     if verLessThan('matlab','9.2')   
                     set(z1,'xlim',[datenum(datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd')), datenum(datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd'))]);           
                     set(z2,'xlim',[datenum(datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd')), datenum(datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd'))]);                      
                     set(z3,'xlim',[datenum(datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd')), datenum(datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd'))]);                    
                     set(z4,'xlim',[datenum(datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd')), datenum(datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd'))]);   
                     else
                     set(z1,'xlim',[datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd'), datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd')]);           
                     set(z2,'xlim',[datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd'), datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd')]);                      
                     set(z3,'xlim',[datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd'), datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd')]);                    
                     set(z4,'xlim',[datetime(get(handles.Starte,'String'),'InputFormat','yyyy-MM-dd'), datetime(get(handles.Ende,'String'),'InputFormat','yyyy-MM-dd')]);   
                     end
                     
      end
