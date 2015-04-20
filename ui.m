function varargout = ui(varargin)
% UI MATLAB code for ui.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ui

% Last Modified by GUIDE v2.5 25-Feb-2015 23:49:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_OutputFcn, ...
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
% --- Executes just before ui is made visible.
function ui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ui (see VARARGIN)

% Choose default command line output for ui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using ui.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

plot(0:25,ones(26)*22.5, 'm--');
hold on;
drawParkedCars(3.5,1.7);
x=0.5; y=1;
[xp, yp] = computeCarPoints(x, y, radtodeg(0));
xp(end+1) = xp(1);
yp(end+1) = yp(1);
plot(xp,yp);
plot(x, y, 'ro');

hold off;
xlim([0 25]);
ylim([0 25]);
grid on;
drawnow;

% UIWAIT makes ui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ui_OutputFcn(hObject, eventdata, handles)
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
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
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

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});



function xtext_Callback(hObject, eventdata, handles)
% hObject    handle to xtext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xtext as text
%        str2double(get(hObject,'String')) returns contents of xtext as a double


% --- Executes during object creation, after setting all properties.
function xtext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xtext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ytext_Callback(hObject, eventdata, handles)
% hObject    handle to ytext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ytext as text
%        str2double(get(hObject,'String')) returns contents of ytext as a double


% --- Executes during object creation, after setting all properties.
function ytext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ytext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function angletext_Callback(hObject, eventdata, handles)
% hObject    handle to angletext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angletext as text
%        str2double(get(hObject,'String')) returns contents of angletext as a double


% --- Executes during object creation, after setting all properties.
function angletext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angletext (see GCBO)
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


% --- Executes on button press in pushbuttonRun.
function pushbuttonRun_Callback(hObject, eventdata, handles)
checkbox = get(handles.checkbox1,'Value');
x = str2double(get(handles.xtext,'String'));
y = str2double(get(handles.ytext,'String'));
angle = str2double(get(handles.angletext,'String'));
[xp, yp] = computeCarPoints(x, y, radtodeg(angle));
for i=1:4
   if xp(i) > 25 || xp(i)<0 || yp(i) > 22.5 || yp(i) <0
       msgbox('Invalid car location.');
       return;
   end
end
carParking(x,y,angle, checkbox);
%main;
% hObject    handle to pushbuttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonSet.
function pushbuttonSet_Callback(hObject, eventdata, handles)
x = str2double(get(handles.xtext,'String'));
y = str2double(get(handles.ytext,'String'));
angle = str2double(get(handles.angletext,'String'));
[xp, yp] = computeCarPoints(x, y, radtodeg(angle));
for i=1:4
   if xp(i) > 25 || xp(i)<0 || yp(i) > 22.5 || yp(i) <0
       msgbox('Invalid car location.');
       xp
       yp
       return;
   end
end
[xp, yp] = computeCarPoints(x, y, angle);
xp(end+1) = xp(1);
yp(end+1) = yp(1);
plot(xp,yp);
hold on;
plot(x, y, 'ro');

plot(0:25,ones(26)*22.5, 'm--');
drawParkedCars(3.5,1.7);
xT1 = 7.25; yT1 = 20.7;
[xp, yp] = computeCarPoints(xT1, yT1, 180);
xp(end+1) = xp(1);
yp(end+1) = yp(1);
plot(xp,yp, 'r+');
hold on;
plot(xT1, yT1, 'bo');
xlim([0 25]);
ylim([0 25]);

grid on;
drawnow;
hold off;
% hObject    handle to pushbuttonSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbuttonpparking.
function pushbuttonpparking_Callback(hObject, eventdata, handles)
set(handles.xtext,'String', '7.25');
set(handles.ytext,'String','20.7');
set(handles.angletext,'String', '180');
xT1 = 7.25; yT1 = 20.7;

[xp, yp] = computeCarPoints(xT1, yT1, 180);
xp(end+1) = xp(1);
yp(end+1) = yp(1);
plot(xp,yp);
hold on;
plot(xT1, yT1, 'ro');

plot(0:25,ones(26)*22.5, 'm--');
drawParkedCars(3.5,1.7);
xT2 = 14.25; yT2 = 23.5;
[xp, yp] = computeCarPoints(xT2, yT2, 180);
xp(end+1) = xp(1);
yp(end+1) = yp(1);
plot(xp,yp, 'r+');
hold on;
plot(xT2, yT2, 'bo');
xlim([0 25]);
ylim([0 25]);

grid on;
drawnow;
hold off;
% hObject    handle to pushbuttonpparking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
