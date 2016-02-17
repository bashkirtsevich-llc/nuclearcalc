unit Const_u;

interface

uses Classes, IniFiles, SysUtils;

type TDesctop=packed record
  Left,Top,Height,Width,WindowState:integer;
end;

function GetDesctopFromFile(FileName,Section:string):TDesctop;

const ConsoleScript=
  'x:=10;'#13+
  'initconsole(_CREATE);'#13+
  'while x<=50 do'#13+
  '{'#13+
  '  writeln(format("x=%s",x));'#13+
  '  sleep(50);'#13+
  '  call next_x;'#13+
  '  beep;'#13+
  '}'#13+
  'end.'#13+
  'VOID Next_x'#13+
  '{'#13+
  '  x:=x+1;'#13+
  '  return;'#13+
  '  x:=0;'#13+
  '}';

const a3Dscript=
  '  X:=-10;'#13+
  '  y:=-10;'#13+
  '  Init3D(_CREATE);'#13+  ''#13+
  '  glLinewidth(1);'#13+
  '  glNewList("Simply");'#13+
  '  DrawAxis(1,1,1);'#13+
  '  DrawGrids(1,0,0);'#13+
  '  glBegin(_GL_LINES);'#13+
  '    glColor3f(0.7,0.7,0.7);'#13+
  '    While X<=10 Do'#13+
  '    {'#13+
  '      call Next_x;'#13+
  '      while y<=10 do'#13+
  '      {'#13+
  '        call next_y;'#13+
  '        glVertex3f(X-0.1,y,Sin(x-0.1));'#13+
  '        glVertex3f(X,y,sin(x));'#13+
  '        glVertex3f(X,y-0.1,Sin(x));'#13+
  '        glVertex3f(X,y,sin(x));'#13+
  '      }'#13+
  '      y:=-10;'#13+  ''#13+
  '    }'#13+
  '  glEnd(_GL_LINES);'#13+
  '  glEndList("Simply");'#13+
  ''#13+  'End.'#13+  ''#13+
  'void Next_x'#13+
  '{'#13+
  ' X:=X+0.1;'#13+
  '}'#13+
  ''#13+
  'void next_y'#13+
  '{'#13+
  ' y:=y+0.1;'#13+
  '}';

const a2Dscript=
  ' init2d(_CREATE);'#13+
  ' SetBuffSize(2048);'#13+
  ' x:=-10;'#13+
  ' movetoxy(x-0.1,sin(x-0.1));'#13+
  ' while x<=10 do'#13+
  '  {'#13+
  '    movetoxy(x-0.1,sin(x-0.1));'#13+
  '    linetoxy(x,sin(x));'#13+
  '    call next_x;'#13+
  '  }'#13+
  ''#13+
  ' draw2d(void);'#13+
  'end.'#13+
  ''#13+
  'void Next_x'#13+
  ' {'#13+
  '  x:=x+0.1;'#13+
  ' }';

implementation

function GetDesctopFromFile(FileName,Section:string):TDesctop;
var DescIni:TIniFile;
    _temp:TDesctop;
begin
  //if not FileExists(FileName) then Exit;
  DescIni:=TIniFile.Create(FileName);
  _temp.Left:=DescIni.Readinteger(Section,'Left',0);
  _temp.Top:=DescIni.ReadInteger(Section,'Top',0);
  _temp.Height:=DescIni.ReadInteger(Section,'Height',0);
  _temp.Width:=DescIni.ReadInteger(Section,'Width',0);
  _temp.WindowState:=DescIni.ReadInteger(Section,'State',0); {0-normal,1-minimized,2-maximized}
  Result:=_temp;
end;

end.
