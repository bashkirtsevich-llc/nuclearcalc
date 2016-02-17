unit OGL_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Advanced, OpenGL, Math, AppEvnts;

type
  TwndOpenGL = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    procedure DrawScene;
    { Public declarations }
  end;

type
  TCam=packed record
      z,yx:Single;
  end;

var
  wndOpenGL: TwndOpenGL;
  DC:HDC;
  HRC:HGLRC;
  Cam:TCam;
  _draw:Boolean;
  xa,ya:Single;
  ViewerX,ViewerY,_Zoom:Single;
  mLeft:Boolean;

implementation

{$R *.dfm}

procedure TwndOpenGL.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  DrawScene;
end;

procedure TwndOpenGL.DrawScene;
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

procedure TwndOpenGL.FormCreate(Sender: TObject);
begin
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
  {glNewList(1,GL_COMPILE);
    DrawAxis(True,True,True);
    DrawGrids(True,False,False);
  glEndList;}
  //Self.Show;
end;

procedure TwndOpenGL.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(HRC);
  ReleaseDC(Handle,DC);
  DeleteDC(DC);
end;

procedure TwndOpenGL.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _draw:=true;
  mLeft:=Button=mbLeft;
  xa:=x;
  ya:=y;
end;

procedure TwndOpenGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
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

procedure TwndOpenGL.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _draw:=false;
  mLeft:=False;
  xa:=x;
  ya:=y;
end;

procedure TwndOpenGL.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta<0 then
    _Zoom:=_Zoom-1 else
    _Zoom:=_Zoom+1;
end;

procedure TwndOpenGL.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(50, (Clientwidth) / Clientheight, 0.1, 1000);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  DrawScene;
end;

end.
