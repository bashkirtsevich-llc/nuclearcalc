unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, ExtCtrls, Math, AppEvnts, MathematicsFunc, StdCtrls, ComCtrls,
  Advanced;

type
  TForm1 = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    pnlMenu: TPanel;
    lbFunctionName: TLabel;
    edFunction: TEdit;
    lbXmin: TLabel;
    lbYmin: TLabel;
    lbXmax: TLabel;
    lbYmax: TLabel;
    edXmin: TEdit;
    edYmin: TEdit;
    edXmax: TEdit;
    edYmax: TEdit;
    lbXstep: TLabel;
    lbYdiv: TLabel;
    edXdiv: TEdit;
    edYdiv: TEdit;
    lbZoomFactor: TLabel;
    tbZoom: TTrackBar;
    btnDraw: TButton;
    gbAxis: TGroupBox;
    cbDrawXaxis: TCheckBox;
    cbDrawYaxis: TCheckBox;
    cbDrawZaxis: TCheckBox;
    gbGrids: TGroupBox;
    cbDrawXgrid: TCheckBox;
    cbDrawYgrid: TCheckBox;
    cbDrawZgrid: TCheckBox;
    rgMode: TRadioGroup;
    cbOutOfTheLimit: TCheckBox;
    tmrResetCursor: TTimer;
    btn1: TButton;
    btn2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure Calculate;
    procedure DrawGraphic;
    procedure DrawScene;
    procedure btnDrawClick(Sender: TObject);
    procedure tbZoomChange(Sender: TObject);
    procedure tmrResetCursorTimer(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TExtendArray=packed record
    Value:Extended;
    _IsValueExist:Boolean;
  end;

type
  TCam=packed record
      z,yx:Single;
  end;

  TFontSize       = record
                      fBoxX, fBoxY : single;
                    end;

var
  Form1: TForm1;
  DC:HDC;
  HRC:HGLRC;
  Cam:TCam;
  _draw:Boolean;
  xa,ya:Single;
  Vals:Array[-2000..2000,-2000..2000] of TExtendArray;
  //---Variables for calculate graphic---//
  _Xmin,_Xmax,_Ymin,_Ymax,_Xstep,_Ystep,_Xdiv,_Ydiv:Single;
  _Zoom:Single;                                         
  ViewerX,ViewerY:Single;
  mLeft:Boolean;
  Mode:Byte;
  gFontSizes      : array[0..1023] of TFontSize;    // Buffer for character size information
  gFontList : Integer;
  DefPos:TPoint;

  //
  gGlobalAmbient  : array[0..3] of glFloat = (1.0, 1.0, 1.0, 1.0); // Set Ambient Lighting

  gLight0Pos      : array[0..3] of glFloat = (0.0, 5.0, 0.0, 1.0); // Position for Light0
  gLight0Ambient  : array[0..3] of glFloat = (0.5, 0.5, 0.5, 1.0); // Ambient setting for light0
  gLight0Diffuse  : array[0..3] of glFloat = (0.5, 0.5, 0.5, 1.0); // Diffuse setting for Light0
  gLight0Specular : array[0..3] of glFloat = (0.8, 0.8, 0.8, 1.0); // Specular lighting for Light0

  gLModelAmbient  : array[0..3] of glFloat = (1.0, 1.0, 1.0, 1.0); // And More Ambient Light

implementation

{$R *.dfm}
{$R WindowsXP.res}

procedure Centre;
var xstep,ystep,zstep:Single;
begin
  xstep := Abs(ViewerX / 50);
  ystep := Abs(ViewerY / 50);
  if (ViewerX > 0)then xstep := -xstep;
  if (ViewerY > 0)then ystep := -ystep;
  while (true) do
  begin
    if (Round(ViewerX)<>0)then ViewerX := ViewerX + xstep;
    if (Round(ViewerY)<>0)then ViewerY := ViewerY + ystep;
    if ((Round(ViewerY) = 0) and (Round(ViewerX) = 0)) then
    begin
      ViewerX := 0.0;
      ViewerY := 0.0;
      Form1.DrawScene;
      Break;
    end;
    Sleep(5);
    Form1.DrawScene;
  end;
end;

procedure MoveToOXY;
var yxstep,zstep:Single;
begin
  yxstep := Abs(Cam.yx / 50);
  zstep := Abs(cam.z / 50);
  if Cam.yx > 0 then yxstep := -yxstep;
  if Cam.z > 0 then zstep := -zstep;
  while (true)do
  begin
    if Abs(cam.z)>360 then cam.z := 0;
    if Abs(cam.yx)>360 then cam.yx := 0;

    if (Abs(Int(cam.z)) <> 0) then Cam.z := cam.z + zstep;
    if (Abs(Int(Cam.yx)) <> 360 ) then cam.yx := Cam.yx + yxstep;
    
    if(Abs(Int(Cam.z)) = 0)and(Abs(Int(cam.yx)) = 0)then
    begin
      Cam.yx := 0.0;
      Cam.z := 360.0;
      form1.DrawScene;
      Break;
    end;
    Sleep(5);
    form1.DrawScene;
  end;
end;

procedure MoveToXYZ;
var yxstep,zstep:Single;
    yx_end,z_end:Single;
begin
  MoveToOXY;
  yxstep := -1;
  zstep := -3;
  while True do
  begin
    if (cam.yx > -45.0 ) then Cam.yx := Cam.yx + yxstep;
    if (Cam.z > -135) then Cam.z := cam.z + zstep;
    if (cam.yx = - 45.0) and (abs(Cam.z) = 225) then
    begin
      Cam.yx := -45.0;
      Cam.z := 225.0;
      form1.drawscene;
      break;
    end;
    form1.drawscene;
  end;
end;

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

procedure glWrite3D(pText: string; pX, pY, pZ:single; _type:byte);
begin
  if (pText = '') then Exit;
  glPushMatrix();
  glListBase(gFontList);
  case _type of
  0:begin
      glTranslatef(pX, pY, pZ);
      glCallLists(Length(pText),GL_UNSIGNED_BYTE,@pText[1]);
      glRotatef(90,1.0,0.0,0.0);
      glRotatef(180,0.0,1.0,0.0);
      glCallLists(Length(pText),GL_UNSIGNED_BYTE,@pText[1]);
    end;
  1:begin
      glTranslatef(pX, pY, pZ);
      glCallLists(Length(pText),GL_UNSIGNED_BYTE,@pText[1]);
      glRotatef(90,0.0,1.0,0.0);
      glRotatef(90,0.0,0.0,1.0);
      glTranslatef(pX, pY, pZ-0.5);
      glCallLists(Length(pText),GL_UNSIGNED_BYTE,@pText[1]);
    end;
  2:begin

  end;
  end;
  glPopMatrix();
end;

procedure TForm1.DrawScene;
var
  ps:TPaintStruct;
const font1:integer = 1000;
begin
  BeginPaint(Handle,ps);
  glClear(GL_COLOR_BUFFER_BIT or
          GL_DEPTH_BUFFER_BIT);

  glLoadIdentity;
  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @gGlobalAmbient);
  glLightfv(GL_LIGHT0, GL_POSITION, @gLight0Pos);               // Set The Lights Position
  glLightfv(GL_LIGHT0, GL_AMBIENT,  @gLight0Ambient);           // Set The Ambient Light
  glLightfv(GL_LIGHT0, GL_DIFFUSE,  @gLight0Diffuse);           // Set The Diffuse Light
  glLightfv(GL_LIGHT0, GL_SPECULAR, @gLight0Specular);          // Set Up Specular Lighting

  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @gLModelAmbient);      // Set The Ambient Light Model

  glTranslatef(ViewerX,ViewerY,_Zoom);
  glRotatef(Cam.yx,Abs(cos(DegToRad(Cam.z))),0,0);
  glRotatef(Cam.z,0,0,1);
  
  glCallList(1);

  EndPaint(Handle,ps);
  SwapBuffers(DC);
end;

procedure TForm1.btnDrawClick(Sender: TObject);
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
  _Zoom:=-tbZoom.Position/2;
  Mode:=rgMode.ItemIndex;
  Caption:='Saving variables';
  DrawGraphic;
  DrawScene;
end;

procedure TForm1.Calculate;
var c,r:Integer;
    X,Y:Extended;
    b:boolean;
    cmin,cmax,rmin,rmax:Integer;
begin
  Caption:='Calculating values';
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

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  ps:TPaintStruct;
begin
  //Done:=False;
  If Not _draw Then Exit;
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

procedure TForm1.DrawGraphic;
var
  _x,_y:Single;
  c,r:Integer;
  vect:tvect;
  cmin,cmax,rmin,rmax:Integer;
  _OutOfTheLimit,_cbState:Boolean;
begin
  Caption:='Prepare to draw';
  glDeleteLists(1,1000);
  glClearColor(0.0,0.0,0.0,1.0);
  glEnable(GL_DEPTH_TEST);
  glNewList(1,GL_COMPILE);
  DrawAxis(cbDrawXaxis.Checked,
           cbDrawYaxis.Checked,
           cbDrawZaxis.Checked,10);
  DrawGrids(cbDrawXgrid.Checked,
            cbDrawYgrid.Checked,
            cbDrawZgrid.Checked);
  Calculate;
  glColor3f(0.5,0.5,0.5);
  _x:=_Xmin;
  _y:=_Ymin;

  cmin:=Round(_Xmin*_Xdiv);
  cmax:=Round(_Xmax*_Xdiv);
  rmin:=Round(_Ymin*_Ydiv);
  rmax:=Round(_Ymax*_Ydiv);
  
  _cbState:=cbOutOfTheLimit.Checked;
  Caption:='Drawing';

  //glEnable(GL_LIGHTING);
  //glEnable(GL_LIGHT0);

  For c:=cmin+1 to cmax do
  begin
    _y:=_Ymin;
    for r:=rmin+1 to rmax do
      begin
        _OutOfTheLimit:=(vals[c,r].Value>Max(_Xmax,_Ymax))or(vals[c,r].Value<Min(_Xmin,_Ymin))or
        (vals[c-1,r].Value>Max(_Xmax,_Ymax))or(vals[c,r-1].Value>Max(_Xmax,_Ymax))or
        (vals[c-1,r-1].Value>Max(_Xmax,_Ymax))or(vals[c-1,r].Value<Min(_Xmin,_Ymin))or
        (vals[c,r-1].Value<Min(_Xmin,_Ymin))or(vals[c-1,r-1].Value<Min(_Xmin,_Ymin));
        
        If ((Not vals[c,r]._IsValueExist)or(Not vals[c-1,r]._IsValueExist)or
        (Not vals[c,r-1]._IsValueExist)or(Not vals[c-1,r-1]._IsValueExist))or
        (_OutOfTheLimit and (not _cbState)) Then
          begin                                      
            _y:=_y+_Ystep;
            Continue;
          end;
        case Mode of
          0:Begin
              glBegin(GL_LINES);

                glVertex3f(_x,_y,vals[c,r].Value);
                glVertex3f(_x-_xstep,_y,vals[c-1,r].Value);

                glVertex3f(_x-_xstep,_y,vals[c-1,r].Value);
                glVertex3f(_x-_xstep,_y-_ystep,vals[c-1,r-1].Value);

                glVertex3f(_x-_xstep,_y-_ystep,vals[c-1,r-1].Value);
                glVertex3f(_x,_y-_ystep,vals[c,r-1].Value);

                glVertex3f(_x,_y-_ystep,vals[c,r-1].Value);
                glVertex3f(_x,_y,vals[c,r].Value);

              glEnd();
          End;
          1:Begin
              glBegin(GL_LINES);
                vect := Cylinder(_x,_y,vals[c,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Cylinder(_x-_xstep,_y,vals[c-1,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);

                vect := Cylinder(_x-_xstep,_y,vals[c-1,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Cylinder(_x-_xstep,_y-_ystep,vals[c-1,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);

                vect := Cylinder(_x-_xstep,_y-_ystep,vals[c-1,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Cylinder(_x,_y-_ystep,vals[c,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);

                vect:= Cylinder(_x,_y-_ystep,vals[c,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Cylinder(_x,_y,vals[c,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);

              glEnd();
          End;
          2:Begin
              glBegin(GL_LINES);
                vect := Sphere(_x,_y,vals[c,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Sphere(_x-_xstep,_y,vals[c-1,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);

                vect := Sphere(_x-_xstep,_y,vals[c-1,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Sphere(_x-_xstep,_y-_ystep,vals[c-1,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);

                vect := Sphere(_x-_xstep,_y-_ystep,vals[c-1,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Sphere(_x,_y-_ystep,vals[c,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);

                vect:= Sphere(_x,_y-_ystep,vals[c,r-1].Value);
                glVertex3f(vect.x,vect.y,vect.z);
                vect := Sphere(_x,_y,vals[c,r].Value);
                glVertex3f(vect.x,vect.y,vect.z);
              glEnd();
          End;
        end;
        _y:=_y+_Ystep;
      end;
    _x:=_x+_Xstep;
  end;
  glEndList;
  Caption:='Drawing done';
end;

procedure TForm1.FormCreate(Sender: TObject);
var lFont:TFont;
    vect1,vect2,vect3,vect4:tvect;
    quadObj :GLUquadricObj;
    fi,psi:Integer;
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
  lFont:= TFont.Create();

  lFont.Name:= 'Lucida Console';         // Set the font name for the windows font

  SelectObject(DC, lFont.Handle);        // Select font device context

  // Create display lists for each character in the font:
  gFontList:= glGenLists(256);
  wglUseFontOutlines(DC,                 // Device context of font -source-
                     0,                  // First character
                     256,                // Number of characters
                     gFontList,          // Handle of font display lists
                     0.0,                // This is the sampling tolerance. Higher values create less detailed outlines.
                     0.0,                // This is the extrusion depth.
                     WGL_FONT_LINES,     // What kind of output? You can also use WGL_FONT_LINES
                     @gFontSizes);       // Array to store info about character sizes

  lFont.Free();
  //
  glClearColor(0.0,0.0,0.0,1.0);
  glEnable(GL_DEPTH_TEST);
  glNewList(1,GL_COMPILE);

    //DrawGrids(True,False,False);
    DrawAxis(True,True,True,10);

    glColor3f(0.3,0.3,0.3);  {
      quadObj:=gluNewQuadric;
      gluQuadricDrawStyle(quadObj, GLU_LINE);
      for i := 1 to 10 do
        gluDisk(quadObj,i,i,100,2);  }

    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glBegin(GL_LINES);
    for psi := 0 to 15 do
    begin
      for fi := 0 to 62 do
      begin
        vect1 := thor(10,3,(fi)/10,(psi)/10);
        vect2 := thor(10,3,(fi+1)/10,(psi)/10);
        vect3 := thor(10,3,(fi)/10,(psi+1)/10);
        vect4 := thor(10,3,(fi+1)/10,(psi+1)/10);

        glVertex3f(vect1.x,vect1.y,vect1.z);
        glVertex3f(vect2.x,vect2.y,vect2.z);

        glVertex3f(vect2.x,vect2.y,vect2.z);
        glVertex3f(vect4.x,vect4.y,vect4.z);

        glVertex3f(vect4.x,vect4.y,vect4.z);
        glVertex3f(vect3.x,vect3.y,vect3.z);

        glVertex3f(vect3.x,vect3.y,vect3.z);
        glVertex3f(vect1.x,vect1.y,vect1.z);
      end;
    end; 
    glend;

    glBegin(GL_LINES);
    for psi := 0 to 64 do
      for fi := 0 to 15 do
      begin
        vect1 := Sphere((fi)/10,(psi)/10,4);
        vect2 := Sphere((fi+1)/10,(psi)/10,4);
        vect3 := Sphere((fi)/10,(psi+1)/10,4);
        vect4 := Sphere((fi+1)/10,(psi+1)/10,4);

        glVertex3f(vect1.x,vect1.y,vect1.z);
        glVertex3f(vect2.x,vect2.y,vect2.z);

        glVertex3f(vect2.x,vect2.y,vect2.z);
        glVertex3f(vect4.x,vect4.y,vect4.z);

        glVertex3f(vect4.x,vect4.y,vect4.z);
        glVertex3f(vect3.x,vect3.y,vect3.z);

        glVertex3f(vect3.x,vect3.y,vect3.z);
        glVertex3f(vect1.x,vect1.y,vect1.z);
      end;
    glEnd;
    glDisable(GL_LIGHTING);
    glDisable(GL_LIGHT0);

    glPushMatrix;
    glPopMatrix;
  glEndList;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(HRC);
  ReleaseDC(Handle,DC);
  DeleteDC(DC);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth+pnlMenu.Width, ClientHeight);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(50, (Clientwidth+pnlMenu.Width) / Clientheight, 0.1, 5000);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  DrawScene;
end;

procedure TForm1.tbZoomChange(Sender: TObject);
begin
  _Zoom:=-tbZoom.Position/2;
  DrawScene;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetCursorPos(DefPos);
  tmrResetCursor.Enabled := True;
  _draw:=true;
  mLeft:=Button=mbLeft;
  xa:=x;
  ya:=y;
  ShowCursor(False);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if _draw then
    If mLeft Then
      Begin
        Cam.z:=Cam.z+(x-xa)*2*pi/10;
        Cam.yx:=Cam.yx+(y-ya)*2*pi/10;
        if Abs(Cam.z)>=360 then Cam.z := 0;
        if Abs(Cam.yx)>=360 then Cam.yx := 0;
      end else
      begin
        ViewerX:=ViewerX+(X-xa)/10;
        ViewerY:=ViewerY-(Y-ya)/10;
      end
    else Exit;
  xa:=x; ya:=y;
  DrawScene;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  tmrResetCursor.Enabled := false;
  _draw:=false;
  mLeft:=False;
  xa:=x;
  ya:=y;
  ShowCursor(True);
end;

procedure TForm1.tmrResetCursorTimer(Sender: TObject);
var p:TPoint;
begin
  _draw := False;
  GetCursorPos(p);
  SetCursorPos(DefPos.X,DefPos.Y);
  xa := xa + (defpos.X-p.X);
  ya := ya + (defpos.y-p.y);
  _draw := True;
  Caption := Format('Simply Engine - Camera[ x = %f y = %f z = %f] Camera rotation[ yx = %f z = %f]',[ViewerX, ViewerY, _Zoom, cam.yx, Cam.z]);
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  centre;
  MoveToOXY;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  centre;
  MoveToXYZ;
{  ViewerX := 0.0;
  ViewerY := 0.0;
  Cam.yx := -45.0;
  Cam.z := 225.0;
  DrawScene; }
end;

end.
