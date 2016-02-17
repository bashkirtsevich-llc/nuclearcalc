unit Advanced;

interface

uses OpenGL, Windows;

type
  tvect=packed record
    x,y,z:extended;
  end;

  function Module(x:Extended):Extended;
  procedure DrawGrids(a,b,c:Boolean);
  procedure DrawAxis(a,b,c:Boolean; GridAmp: integer);
  function Cylinder(x,y,r:single):tvect;
  function Sphere(x,y,r:single):tvect;
  procedure SetDCPixelFormat(DC:HDC);
  function Thor(R,_r,phi,psi:Single):tvect;

implementation

(*
      glVertex3f((0+20*c/20*0.1)-0.1,(0+20*r/20*0.1),    Vals[c-1,r].Value);
          glVertex3f((0+20*c/20*0.1),    (0+20*r/20*0.1),    Vals[c,r].Value);
          glVertex3f((0+20*c/20*0.1),    (0+20*r/20*0.1)-0.1,Vals[c,r-1].Value);
          glVertex3f((0+20*c/20*0.1),    (0+20*r/20*0.1),    Vals[c,r].Value);
*)

procedure glDrawCursor(pX,pY,pZ:Single; _type:Byte);
begin
  glPushMatrix();
  glBegin(GL_LINES);
  case _type of
  0:begin // по иксу
      glColor3f(1.0,0.0,0.0);
      glVertex3f(px,py,pz);
      glVertex3f(px+2,py,pz);
      glVertex3f(px+2,py,pz);
      glVertex3f(px,py-0.3,pz);
      glVertex3f(px,py-0.3,pz);
      glVertex3f(px+0.5,py,pz);
      glVertex3f(px+0.5,py,pz);
      glVertex3f(px,py+0.3,pz);
      glVertex3f(px,py+0.3,pz);
      glVertex3f(px+2,py,pz);
      glVertex3f(px+2,py,pz);
      glVertex3f(pX,pY,pz-0.3);
      glVertex3f(pX,pY,pz-0.3);
      glVertex3f(pX+0.5,pY,pZ);
      glVertex3f(pX+0.5,pY,pZ);
      glVertex3f(pX,pY,pZ+0.3);
      glVertex3f(pX,pY,pZ+0.3);
      glVertex3f(px+2,py,pz);
    end;
  1:begin // по игрику
      glColor3f(0.0,1.0,0.0);
      glVertex3f(px,py,pz);
      glVertex3f(px,py+2,pz);
      glVertex3f(px,py+2,pz);
      glVertex3f(px-0.3,py,pz);
      glVertex3f(px-0.3,py,pz);
      glVertex3f(px,py+0.5,pz);
      glVertex3f(px,py+0.5,pz);
      glVertex3f(px+0.3,py,pz);
      glVertex3f(px+0.3,py,pz);
      glVertex3f(px,py+2,pz);
      glVertex3f(px,py+2,pz);
      glVertex3f(pX,pY,pz-0.3);
      glVertex3f(pX,pY,pz-0.3);
      glVertex3f(pX,pY+0.5,pZ);
      glVertex3f(pX,pY+0.5,pZ);
      glVertex3f(pX,pY,pZ+0.3);
      glVertex3f(pX,pY,pZ+0.3);
      glVertex3f(px,py+2,pz);
    end;
  2:begin // по зету
      glColor3f(0.0,0.0,1.0);
      glVertex3f(px,py,pz);
      glVertex3f(px,py,pz+2);
      glVertex3f(px,py,pz+2);
      glVertex3f(px,py-0.3,pz);
      glVertex3f(px,py-0.3,pz);
      glVertex3f(px,py,pz+0.5);
      glVertex3f(px,py,pz+0.5);
      glVertex3f(px,py+0.3,pz);
      glVertex3f(px,py+0.3,pz);
      glVertex3f(px,py,pz+2);
      glVertex3f(px,py,pz+2);
      glVertex3f(pX-0.3,pY,pz);
      glVertex3f(pX-0.3,pY,pz);
      glVertex3f(pX,pY,pZ+0.5);
      glVertex3f(pX,pY,pZ+0.5);
      glVertex3f(pX+0.3,pY,pZ);
      glVertex3f(pX+0.3,pY,pZ);
      glVertex3f(px,py,pz+2);
    end;
  end;
  glEnd();
  glPopMatrix();
end;         

function Module(x:Extended):Extended;
begin
  If x<0 Then
    Result:=x*-1
  else
    Result:=x;
end;

procedure DrawGrids(a,b,c:Boolean);
const
  GridAmp=10;
var
  i:Integer;
begin
//  glPushMatrix();
  if a then
  begin
    for i:=-GridAmp to GridAmp do
    begin
      if i<>0 then
        glColor3f(0.7,0.7,0.7)
      else
        glColor3f(1,0,0);
      glBegin(GL_LINES);
      glVertex3f(-GridAmp,i,0);
      glVertex3f(GridAmp,i,0);
      glEnd;
      if i<>0 then
        glColor3f(0.7,0.7,0.7)
      else
        glColor3f(0,1,0);
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
        glColor3f(0.7,0.7,0.7)
      else
        glColor3f(0,1,0);
      glBegin(GL_LINES);
      glVertex3f(0,-GridAmp,i);
      glVertex3f(0,GridAmp,i);
      glEnd;
      if i<>0 then
        glColor3f(0.7,0.7,0.7)
      else
        glColor3f(0,0,1);
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
        glColor3f(0.7,0.7,0.7)
      else
        glColor3f(1,0,0);
      glBegin(GL_LINES);
      glVertex3f(-GridAmp,0,i);
      glVertex3f(GridAmp,0,i);
      glEnd;
      if i<>0 then
        glColor3f(0.7,0.7,0.7)
      else
        glColor3f(0,0,1);
      glBegin(GL_LINES);
      glVertex3f(i,0,-GridAmp);
      glVertex3f(i,0,GridAmp);
      glEnd;
    end;
  end;
//  glPopMatrix();
end;

procedure DrawAxis(a,b,c:Boolean; GridAmp: integer);
var i:Integer;  
begin
//  glPushMatrix();
  glDrawCursor(GridAmp-2,0,0,0);
  glDrawCursor(0,GridAmp-2,0,1);
  glDrawCursor(0,0,GridAmp-2,2);
  if a then
  begin
    glColor3f(1,0,0);
    glBegin(GL_LINES);
      glVertex3f(-GridAmp,0,0);
      glVertex3f(GridAmp,0,0);
      for i := -GridAmp to GridAmp do
      begin
        glVertex3f(i,0.1,0);
        glVertex3f(i,-0.1,0);
        glVertex3f(i,0,0.1);
        glVertex3f(i,0,-0.1);
      end;  
    glEnd;
  end;

  if b then
  begin
    glColor3f(0,1,0);
    glBegin(GL_LINES);
      glVertex3f(0,-GridAmp,0);
      glVertex3f(0,GridAmp,0);
      for i := -GridAmp to GridAmp do
      begin
        glVertex3f(0.1,i,0);
        glVertex3f(-0.1,i,0);
        glVertex3f(0,i,0.1);
        glVertex3f(0,i,-0.1);
      end;
    glEnd;
  end;

  if c then
  begin
    glColor3f(0,0,1);
    glBegin(GL_LINES);
      glVertex3f(0,0,-GridAmp);
      glVertex3f(0,0,GridAmp);
      for i := -GridAmp to GridAmp do
      begin
        glVertex3f(0,0.1,i);
        glVertex3f(0,-0.1,i);
        glVertex3f(0.1,0,i);
        glVertex3f(-0.1,0,i);
      end;
    glEnd;
  end;
//  glPopMatrix();
end;

function Cylinder(x,y,r:Single):tvect;
begin
  Cylinder.x:=r*cos(x);
  Cylinder.y:=r*sin(x);
  Cylinder.z:=y;
end;

function Thor(R,_r,phi,psi:Single):tvect;
begin
  Thor.x := (R + _r * Cos(phi))*cos(psi);
  Thor.y := (R + _r * Cos(phi))*sin(psi);
  thor.z := _r*sin(phi);
end;

function Sphere(x,y,r:Single):tvect;
begin
  Sphere.x:=r*cos(x)*cos(y);
  Sphere.y:=r*sin(x)*cos(y);
  Sphere.z:=r*sin(y);
end;
////////
function Decart2D(x,y:Single):tvect;
begin
  Result.x := x;
  Result.y := y;
  Result.z := 0.0;
end;

function Decart3D(x,y,z:Single):tvect;
begin
  Result.x := x;
  Result.y := y;
  Result.z := z;
end;

function Polar2D(phi,rho:Single):tvect;
begin
  Result.x := rho * Cos(phi);
  result.y := rho * Sin(phi);
  result.z := 0;
end;

function Cylinder3D(phi,rho,z:Single):tvect;
begin
  Result.x := rho * Cos(phi);
  result.y := rho * Sin(phi);
  result.z := z;
end;

function Sphere3D(r,theta,phi:Single):tvect;
begin
  Result.x := r*sin(theta)*cos(phi);
  Result.y := r*sin(theta)*sin(phi);
  Result.z := r*cos(theta);
end;

function Thore3D(R,_r,phi,psi:Single):tvect;
begin
  Result.x := (R + _r * cos(phi)) * cos(psi);
  Result.y := (R + _r * cos(phi)) * sin(psi);
  Result.z := _r * sin(phi);
end;
/////
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
