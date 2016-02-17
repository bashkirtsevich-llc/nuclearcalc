unit Graph_3D_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, MathematicsFunc, ExtCtrls, StdCtrls, math, Advanced, AppEvnts,
  Buttons;

type
  Twnd3D = class(TForm)
    pnlMenu: TPanel;
    lbFunctionName: TLabel;
    lbXmin: TLabel;
    lbYmin: TLabel;
    lbXmax: TLabel;
    lbYmax: TLabel;
    lbXstep: TLabel;
    lbYdiv: TLabel;
    edFunction: TEdit;
    edXmin: TEdit;
    edYmin: TEdit;
    edXmax: TEdit;
    edYmax: TEdit;
    edXdiv: TEdit;
    edYdiv: TEdit;
    btnDraw: TButton;
    gbAxis: TGroupBox;
    cbDrawXaxis: TCheckBox;
    cbDrawYaxis: TCheckBox;
    cbDrawZaxis: TCheckBox;
    gbGrids: TGroupBox;
    cbDrawXgrid: TCheckBox;
    cbDrawYgrid: TCheckBox;
    cbDrawZgrid: TCheckBox;
    cbOutOfTheLimit: TCheckBox;
    cbMode: TComboBox;
    sbZoomIn: TSpeedButton;
    sbZoomOut: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDrawClick(Sender: TObject);
    procedure cbModeChange(Sender: TObject);
    procedure appEv1Idle(Sender: TObject; var Done: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbZoomInClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DrawScene;
    procedure DrawGraphic;
    procedure Calculate;
    { Public declarations }
  end;

type
  TExtendValue=packed record
    Value:Extended;
    _IsValueExist:Boolean;
  end;

  TVals1=array [-3000..3000] of TExtendValue;
  TVals=array [-3000..3000] of TVals1;
  PVals=^TVals;


type
  TCam=packed record
      z,yx:Single;
  end;  

var
  wnd3D: Twnd3D;
  DC:HDC;
  HRC:HGLRC;
  Cam:TCam;
  _draw:Boolean;
  xa,ya:Single;
  Vals:{Array[-2000..2000,-2000..2000] of TExtendValue;}TVals;
  //---Variables for calculate graphic---//
  _Xmin,_Xmax,_Ymin,_Ymax,_Xstep,_Ystep,_Xdiv,_Ydiv:Single;
  _Zoom:Single;                                         
  ViewerX,ViewerY:Single;
  mLeft:Boolean;
  Mode:Byte;
  
implementation
uses CombineMain_u;

{$R *.dfm}

function GetArrayValue(A:PVals;C,R:Integer):TExtendValue;
var Temp:TExtendValue;
begin
  Temp:=A^[C,R];
  Result:=Temp;
end;

{procedure SetArrayValue(A:PVals;C,R:Integer;Val:TExtendValue);
var Temp:TExtendValue;
begin
  A[c,r]:=val
end;}

Function Compute(Func:String;X,Y,Z:Extended;var _IsFunctionExist:Boolean):Extended;
Var FuncResult:Extended;
    WorkFunc:TE;
begin
  if Parse_Line(Func,WorkFunc) then
    begin
      _IsFunctionExist:=Count_Func(true,WorkFunc,X,Y,Z,FuncResult);
      if _IsFunctionExist then
        Result:=FuncResult else
      Result:=0;
    end else
      Result:=0;
end;

procedure Twnd3D.cbModeChange(Sender: TObject);
begin
  Mode:=cbMode.ItemIndex;
end;

procedure Twnd3D.DrawScene;
var
  ps:TPaintStruct;
begin
  BeginPaint(Handle,ps);
  glClear(GL_COLOR_BUFFER_BIT or
          GL_DEPTH_BUFFER_BIT);

  glLoadIdentity;
  glTranslatef(ViewerX,ViewerY,_Zoom);
  glRotatef(Cam.yx,Abs(cos(DegToRad(Cam.z))),0,0);
  glRotatef(Cam.z,0,0,1);

  glCallList(1);

  EndPaint(Handle,ps);
  SwapBuffers(DC);
end;

procedure Twnd3D.Calculate;
var c,r:Integer;
    X,Y:Extended;
    b:boolean;
    cmin,cmax,rmin,rmax:Integer;
begin
  //Caption:='Calculating values';
  x:=_Xmin-_Xstep;
  y:=_Ymin-_Ystep;
  cmin:=Round(_Xmin*_Xdiv);
  cmax:=Round(_Xmax*_Xdiv);
  rmin:=Round(_Ymin*_Ydiv);
  rmax:=Round(_Ymax*_Ydiv);
  for c:=cmin to cmax Do
  begin
    y:=_Ymin-_Ystep;
    for r:=rmin to rmax Do
      begin
        Vals[c,r].Value:=Compute(edFunction.Text,x,y,0,b);
        Vals[c,r]._IsValueExist:=b;
        y:=y+_Ystep;
      end;
    x:=x+_Xstep;
  end;
end;

procedure Twnd3D.DrawGraphic;
var
  i:Integer;
  _x,_y:Single;
  c,r:Integer;
  vect:tvect;
  cmin,cmax,rmin,rmax:Integer;
  _OutOfTheLimit,_cbState:Boolean;
  _color:TRGB;
begin
  //Caption:='Prepare to draw';
  glDeleteLists(1,1000);
  glClearColor(0.0,0.0,0.0,1.0);
  glEnable(GL_DEPTH_TEST);
  glNewList(1,GL_COMPILE);
  DrawAxis(cbDrawXaxis.Checked,
           cbDrawYaxis.Checked,
           cbDrawZaxis.Checked);
  DrawGrids(cbDrawXgrid.Checked,
            cbDrawYgrid.Checked,
            cbDrawZgrid.Checked);
  Calculate;
  _color:=ColorToRGB(ColorConfig._3DGraphColor);
  glColor3f(_color.R/$FF,_color.G/$FF,_color.B/$FF);
  _x:=_Xmin;
  _y:=_Ymin;

  cmin:=Round(_Xmin*_Xdiv);
  cmax:=Round(_Xmax*_Xdiv);
  rmin:=Round(_Ymin*_Ydiv);
  rmax:=Round(_Ymax*_Ydiv);
  
  _cbState:=cbOutOfTheLimit.Checked;
  //Caption:='Drawing';
  For c:=cmin+1 to cmax do
  begin
    _y:=_Ymin;
    for r:=rmin+1 to rmax do
      begin
        _OutOfTheLimit:=(GetArrayValue(@Vals,c,r).Value>Max(_Xmax,_Ymax))or(GetArrayValue(@Vals,c,r).Value<Min(_Xmin,_Ymin))or
        (GetArrayValue(@vals,c-1,r).Value>Max(_Xmax,_Ymax))or(GetArrayValue(@Vals,c,r-1).Value>Max(_Xmax,_Ymax))or
        (GetArrayValue(@Vals,c-1,r-1).Value>Max(_Xmax,_Ymax))or(GetArrayValue(@Vals,c-1,r).Value<Min(_Xmin,_Ymin))or
        (GetArrayValue(@Vals,c,r-1).Value<Min(_Xmin,_Ymin))or(GetArrayValue(@Vals,c-1,r-1).Value<Min(_Xmin,_Ymin));
        
        If ((Not GetArrayValue(@Vals,c,r)._IsValueExist)or(Not GetArrayValue(@Vals,c-1,r)._IsValueExist)or
        (Not GetArrayValue(@Vals,c,r-1)._IsValueExist)or(Not GetArrayValue(@Vals,c-1,r-1)._IsValueExist))or
        (_OutOfTheLimit and (not _cbState)) Then
          begin                                      
            _y:=_y+_Ystep;
            Continue;
          end;
        case Mode of
          0:Begin
              glBegin(GL_LINES);
                glVertex3f(_x-_xstep,_y,GetArrayValue(@Vals,c-1,r).Value);
                glVertex3f(_x,_y,GetArrayValue(@Vals,c,r).Value);
                glVertex3f(_x,_y-_ystep,GetArrayValue(@Vals,c,r-1).Value);
                glVertex3f(_x,_y,GetArrayValue(@Vals,c,r).Value);
              glEnd();
          End;
          1:Begin
              glBegin(GL_LINES);
                vect:=Cylinder(_x,_y,GetArrayValue(@Vals,c,r).Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect:=Cylinder(_x-_xstep,_y,GetArrayValue(@Vals,c-1,r).Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect:=Cylinder(_x,_y,GetArrayValue(@Vals,c,r).Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect:=Cylinder(_x,_y-_ystep,GetArrayValue(@Vals,c,r-1).Value);
                glVertex3f(vect.x,vect.y,vect.z);
              glEnd();
          End;
          2:Begin
              glBegin(GL_LINES);
                vect:=Sphere(_x,_y,GetArrayValue(@Vals,c,r).Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect:=Sphere(_x-_xstep,_y,GetArrayValue(@Vals,c-1,r).Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect:=Sphere(_x,_y,GetArrayValue(@Vals,c,r).Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect:=Sphere(_x,_y-_ystep,GetArrayValue(@Vals,c,r-1).Value);
                glVertex3f(vect.x,vect.y,vect.z);
              glEnd();
          End;
        end;
        _y:=_y+_Ystep;
      end;
    _x:=_x+_Xstep;
  end;
  glEndList;
  //Caption:='Drawing done';
end;

procedure Twnd3D.appEv1Idle(Sender: TObject; var Done: Boolean);
begin
//  DrawScene;
end;

procedure Twnd3D.btnDrawClick(Sender: TObject);
var a:boolean;
begin
  _Xmin:=Compute(edXmin.Text,0,0,0,a);
  _Xmax:=Compute(edXmax.Text,0,0,0,a);
  _Ymin:=Compute(edYmin.Text,0,0,0,a);
  _Ymax:=Compute(edYmax.Text,0,0,0,a);
  _Xdiv:=strtofloat(edXdiv.Text);
  _Ydiv:=strtofloat(edYdiv.Text);
  _Xstep:=((Module(_xmin)+module(_xmax))/_Xdiv)/(Module(_xmin)+module(_xmax));
  _Ystep:=((Module(_ymin)+module(_ymax))/_Ydiv)/(Module(_ymin)+module(_ymax));
  //_Zoom:=-tbZoom.Position/2;
  Mode:=cbMode.ItemIndex;
  //Caption:='Saving variables';
  DrawGraphic;
  DrawScene;
end;

procedure Twnd3D.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure Twnd3D.FormCreate(Sender: TObject);
begin
  Tag:=1;
  with Cam do
    begin
      z:=228;
      yx:=-68;                    
    end;
  ViewerX:=0;
  ViewerY:=0;                     
  DC:=GetDC(Handle);
  _Zoom:=-25;
  SetDCPixelFormat(DC);
  HRC:=wglCreateContext(DC);
  wglMakeCurrent(DC,HRC);
  //
  glClearColor(0.0,0.0,0.0,1.0);
  glEnable(GL_DEPTH_TEST);
  glNewList(1,GL_COMPILE);
    DrawAxis(True,True,True);
    DrawGrids(True,False,False);
  glEndList;
  glViewport(0, 0, ClientWidth+pnlMenu.Width, ClientHeight);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(50, (Clientwidth+pnlMenu.Width) / Clientheight, 0.1, 1000);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  DrawScene;
end;

procedure Twnd3D.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(HRC);
  ReleaseDC(Handle,DC);
  DeleteDC(DC);
end;

procedure Twnd3D.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _draw:=true;
  mLeft:=Button=mbLeft;
  xa:=x;
  ya:=y;
end;

procedure Twnd3D.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if _draw then
    If mLeft Then
      Begin
        Cam.z:=Cam.z+(x-xa)*2*pi/10;
        Cam.yx:=Cam.yx+(y-ya)*2*pi/10;
      end else
      begin
        ViewerX:=ViewerX+(X-xa)/10;
        ViewerY:=ViewerY-(Y-ya)/10;
      end
    else Exit;
  xa:=x; ya:=y;
  DrawScene;
end;

procedure Twnd3D.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _draw:=false;
  mLeft:=False;
  xa:=x;
  ya:=y;
end;

procedure Twnd3D.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth+pnlMenu.Width, ClientHeight);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(50, (Clientwidth+pnlMenu.Width) / Clientheight, 0.1, 1000);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  DrawScene;
end;

procedure Twnd3D.sbZoomInClick(Sender: TObject);
begin
  _Zoom:=_Zoom+(Sender as TSpeedButton).Tag;
  DrawScene;
end;

end.
