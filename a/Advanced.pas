unit Advanced;

interface

uses OpenGL, Windows;

type
  tvect=packed record
    x,y,z:extended;
  end;

  procedure DrawGrids(a,b,c:Boolean);
  procedure DrawAxis(a,b,c:Boolean);
  function Cylinder(x,y,r:single):tvect;
  function Sphere(x,y,r:single):tvect;
  procedure SetDCPixelFormat(DC:HDC);

implementation

uses CombineMain_u;

(*
          glVertex3f((0+20*c/20*0.1)-0.1,(0+20*r/20*0.1),    Vals[c-1,r].Value);
          glVertex3f((0+20*c/20*0.1),    (0+20*r/20*0.1),    Vals[c,r].Value);
          glVertex3f((0+20*c/20*0.1),    (0+20*r/20*0.1)-0.1,Vals[c,r-1].Value);
          glVertex3f((0+20*c/20*0.1),    (0+20*r/20*0.1),    Vals[c,r].Value);
*)          

procedure DrawGrids(a,b,c:Boolean);
const
  GridAmp=10;
var
  i:Integer;
  _color,_x,_y,_z:TRGB;
begin
  _color:=ColorToRgb(ColorConfig._3DGridColor);
  _x:=ColorToRGB(ColorConfig._3DXaxisColor);
  _y:=ColorToRGB(ColorConfig._3DYaxisColor);
  _z:=ColorToRGB(ColorConfig._3DZaxisColor);
  if a then
  begin
    for i:=-GridAmp to GridAmp do
    begin
      if i<>0 then
        glColor3f(_color.R/$FF,_color.G/$FF,_color.B/$FF)
      else
        glColor3f(_x.R/$FF,_x.G/$FF,_x.B/$FF);
      glBegin(GL_LINES);
      glVertex3f(-GridAmp,i,0);
      glVertex3f(GridAmp,i,0);
      glEnd;
      if i<>0 then
        glColor3f(_color.R/$FF,_color.G/$FF,_color.B/$FF)
      else
        glColor3f(_y.R/$FF,_y.G/$FF,_y.B/$FF);
      glBegin(GL_LINES);
      glVertex3f(i,-GridAmp,0);
      glVertex3f(i,GridAmp,0);
      glEnd;
    end;
  end;

  if b then
  begin
    for i:=-GridAmp to GridAmp do
    begin
      if i<>0 then
        glColor3f(_color.R/$FF,_color.G/$FF,_color.B/$FF)
      else
        glColor3f(_y.R/$FF,_y.G/$FF,_y.B/$FF);
      glBegin(GL_LINES);
      glVertex3f(0,-GridAmp,i);
      glVertex3f(0,GridAmp,i);
      glEnd;
      if i<>0 then
        glColor3f(_color.R/$FF,_color.G/$FF,_color.B/$FF)
      else
        glColor3f(_z.R/$FF,_z.G/$FF,_z.B/$FF);
      glBegin(GL_LINES);
      glVertex3f(0,i,-GridAmp);
      glVertex3f(0,i,GridAmp);
      glEnd;
    end;
  end;

  if c then
  begin
    glBegin(GL_LINES);
    for i:=-GridAmp to GridAmp do
    begin
      if i<>0 then
        glColor3f(_color.R/$FF,_color.G/$FF,_color.B/$FF)
      else
        glColor3f(_x.R/$FF,_x.G/$FF,_x.B/$FF);
      glBegin(GL_LINES);
      glVertex3f(-GridAmp,0,i);
      glVertex3f(GridAmp,0,i);
      glEnd;
      if i<>0 then
        glColor3f(_color.R/$FF,_color.G/$FF,_color.B/$FF)
      else
        glColor3f(_z.R/$FF,_z.G/$FF,_z.B/$FF);
      glBegin(GL_LINES);
      glVertex3f(i,0,-GridAmp);
      glVertex3f(i,0,GridAmp);
      glEnd;
    end;
  end;
end;

procedure DrawAxis(a,b,c:Boolean);
const
  GridAmp=100;
var
  _x,_y,_z:TRGB;
begin
  _x:=ColorToRGB(ColorConfig._3DXaxisColor);
  _y:=ColorToRGB(ColorConfig._3DYaxisColor);
  _z:=ColorToRGB(ColorConfig._3DZaxisColor);
  if a then
  begin
    glColor3f(_x.R/$FF,_x.G/$FF,_x.B/$FF);
    glBegin(GL_LINES);
      glVertex3f(-GridAmp,0,0);
      glVertex3f(GridAmp,0,0);
    glEnd;
  end;

  if b then
  begin
    glColor3f(_y.R/$FF,_y.G/$FF,_y.B/$FF);
    glBegin(GL_LINES);
      glVertex3f(0,-GridAmp,0);
      glVertex3f(0,GridAmp,0);
    glEnd;
  end;

  if c then
  begin
    glColor3f(_z.R/$FF,_z.G/$FF,_z.B/$FF);
    glBegin(GL_LINES);
      glVertex3f(0,0,-GridAmp);
      glVertex3f(0,0,GridAmp);
    glEnd;
  end;
end;

function Cylinder(x,y,r:Single):tvect;
begin
  Cylinder.x:=r*cos(x);
  Cylinder.y:=r*sin(x);
  Cylinder.z:=y;
end;

function Sphere(x,y,r:Single):tvect;
begin
  Sphere.x:=r*cos(x)*cos(y);
  Sphere.y:=r*sin(x)*cos(y);
  Sphere.z:=r*sin(y);
end;

procedure SetDCPixelFormat(DC:HDC);
var
  pfd:TPixelFormatDescriptor;
  nPixelFormat:Integer;
begin
  FillChar(pfd,SizeOf(pfd),0);
  pfd.dwFlags:=PFD_DRAW_TO_WINDOW or
               PFD_DOUBLEBUFFER or
               PFD_SUPPORT_OPENGL;
  nPixelFormat:=ChoosePixelFormat(DC,@pfd);
  SetPixelFormat(DC,nPixelFormat,@pfd);
end;

end.
