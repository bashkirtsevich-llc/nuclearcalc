program ACI_PE;

//{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  Classes,
  TlHelp32,
  uCalcul,
  uInterpreter,
  Dialogs,
  Forms,
  Console_u,
  OGL_u,
  GDI_u,
  SZCRC32,
  XPman;

type TCore=object
    Code,
    Variables:String;
    procedure Create;
    procedure Emulate;
    procedure Free;
  private
    Calcul:TCalcul;
    Interpreter:TInterpreter;
    procedure Error(_msg:String);
    procedure InitConsole(Sender:TObject);
    procedure FreeConsole(Sender:TObject);
    procedure ConsoleWrite(Sender:TObject;var Text:String);
    procedure ConsoleWriteln(Sender:TObject;var Text:String);
    procedure ConsoleReadln(Sender:TObject;var Text:String);
    procedure ConsoleRead(Sender:TObject;var Text:String);
    procedure Init3D(Sender:TObject);
    procedure Free3D(Sender:TObject);
    procedure Init2D(Sender:TObject);
    procedure Free2D(Sender:TObject);
    procedure OnSetBuffSize(Sender: TObject; Size: Cardinal);
    procedure OnSetAxisLength(Sender: TObject; X: Single; Y: Single);
    procedure OnMoveToXY(Sender: TObject; X: Single; Y: Single);
    procedure OnLineToXY(Sender: TObject; X: Single; Y: Single);
    procedure OnDraw2D(Sender: TObject);
    procedure OnClearConsole(Sender:TObject);
  public
end;  

var Stream,Temp,_temp:TMemoryStream;
    _encode:Boolean;
    H_PID,H_PROC,Handle:THandle;
    Read:Cardinal;
    ModuleEntry:ModuleEntry32;
    data:array[0..255] of byte;
    Size,Head:Int64;
    I:LongWord;
    Text:String;
    A:Char;
    Core:TCore;
    Points:array of T2Dpoint;
    Point:Integer;
    _password:String;
    CRC,StreamSize,_length:DWORD;
    //BoC,PoC,ImB:DWORD;

const //_sign:Int64 = $30302E3120494341; //"ACI 1.00" = 8 Byte(s)
      _sign1:Int64 = $3030000000000000;
      _sign2:Int64 = $00002E3100000000;
      _sign3:Int64 = $0000000020490000;
      _sign4:Int64 = $0000000000004341;

{$R MainIcon.res}

label IfCanRead,CantRead;

function KillSpaces(Source:String):String;
  function GetItemCount(text:string):integer;
  var _temp:string;
  begin
    _temp:=text+#13;
    Result:=0;
    while Pos(#13,_temp)<>0 do
    begin
      Inc(result);
      Delete(_temp,1,Pos(#13,_temp)+1);
    end;
  end;

  function GetItemAtString(text:string;index:integer):String;
  var _index:integer;
      _temp:string;
  begin
    _temp:=text+#13;
    _index:=0;
    while Pos(#13,_temp)<>0 do
    begin
      if (_index=index) then
      begin
        Result:=Copy(_temp,1,Pos(#13,_temp)-1);
        Exit;
      end;
      Delete(_temp,1,Pos(#13,_temp)+1);
      Inc(_index);
    end;
  end;
var _itemIndex,_itemCount:Integer;
begin
  Result:='';
  _itemCount:=GetItemCount(Source);
  for _itemIndex:=0 to _itemCount-1 do
    Result:=Result+Trim(GetItemAtString(Source,_itemIndex))+#13#10;
end;

function EncodeStream(InStream,OutStream:TStream; StartPos:Integer; Password:string):boolean;
var _data   :array [0..7] of Byte;
    _index  :Integer;
    _pos    :Integer;
    _passPos:Integer;
begin
  InStream.Seek(StartPos,soFromBeginning);
  _index:=InStream.Read(_data,SizeOf(_data));
  _passPos:=0;
  while _index<>0 do
  begin
    for _pos := 0 to _index-1 do
    begin
      inc(_passPos);
      if _passPos>Length(Password) then
      begin
        _passPos:=0;
        Continue;
      end;
      _data[_pos]:=_data[_pos] xor (Byte(Password[_passPos]) xor _passPos);
    end;
    OutStream.Write(_data,_index);
    _index:=InStream.Read(_data,SizeOf(_data));
  end;
  Result:=True;
end;

procedure TCore.Create;
begin
  Calcul:=TCalcul.Create;
  Interpreter:=TInterpreter.Create;
  Interpreter.Calcul:=Calcul;
  Calcul.OnInitConsole:=Self.InitConsole;
  Calcul.OnFreeConsole:=Self.FreeConsole;
  Calcul.OnInit3D:=Self.Init3D;
  Calcul.OnFree3D:=Self.Free3D;
  Calcul.OnInit2D:=Self.Init2D;
  Calcul.OnFree3D:=Self.Free2D;
  Calcul.OnMoveToXY:=Self.OnMoveToXY;
  Calcul.OnLineToXY:=Self.OnLineToXY;
  Calcul.OnColsoleReadln:=Self.ConsoleReadln;
  Calcul.OnColsoleRead:=Self.ConsoleRead;
  Calcul.OnColsoleWriteln:=Self.ConsoleWriteln;
  Calcul.OnColsoleWrite:=Self.ConsoleWrite;
  Calcul.OnSetAxisLength:=Self.OnSetAxisLength;
  Calcul.OnDraw2D:=Self.OnDraw2D;
  Calcul.OnSetBuffSize:=Self.OnSetBuffSize;
  Calcul.OnClearConsole:=Self.OnClearConsole;
end;

procedure TCore.Emulate;
begin
  Interpreter.Prog:=KillSpaces(Self.Code);
  Calcul.Variables:=Self.Variables;
  Interpreter.Execute;
  if Interpreter.Error then
    Self.Error(Format('%d "%s"',[Interpreter.ErrorPos,Interpreter.ErrorText]));
end;

procedure TCore.Free;
begin
  Calcul.Free;
  Interpreter.Free;
end;

procedure TCore.Error(_msg:String);
begin
  MessageBox(Application.Handle,PChar(_msg),'Critical error',MB_OK+MB_ICONSTOP);
  Halt;
end;

procedure TCore.InitConsole(Sender: TObject);
begin
  Application.CreateForm(TwndConsole,wndConsole);
  wndConsole.Show;
end;

procedure TCore.FreeConsole(Sender: TObject);
begin
  wndConsole.Close;
end;

procedure TCore.Init3D(Sender: TObject);
begin
  Application.CreateForm(TwndOpenGL,wndOpenGL);
  wndOpenGL.Show;
end;

procedure TCore.Free3D(Sender: TObject);
begin
  wndOpenGL.Close;
end;

procedure TCore.Init2D(Sender: TObject);
begin
  Application.CreateForm(Twnd2D,wnd2D);
  wnd2D.Show;
  wnd2D.PointList.Clear;
  Point:=-1;
  SetLength(Points,100);
end;

procedure TCore.Free2D(Sender: TObject);
begin
  wnd2D.Close;
  SetLength(Points,0);
end;

procedure TCore.OnSetBuffSize(Sender: TObject; Size: Cardinal);
begin
  SetLength(Points,Size);
end;

procedure TCore.OnSetAxisLength(Sender: TObject; X: Single; Y: Single);
begin
  wnd2D._AxisX:=X;
  wnd2D._AxisY:=Y;
end;

procedure TCore.OnMoveToXY(Sender: TObject; X: Single; Y: Single);
begin
  Inc(Point);
  Points[Point].X:=X;
  Points[Point].Y:=Y;
  Points[Point]._move:=True;
  wnd2D.PointList.Add(@Points[Point]);
end;

procedure TCore.OnLineToXY(Sender: TObject; X: Single; Y: Single);
begin
  Inc(Point);
  Points[Point].X:=X;
  Points[Point].Y:=Y;
  Points[Point]._move:=False;
  wnd2D.PointList.Add(@Points[Point]);
end;

procedure TCore.OnDraw2D(Sender: TObject);
begin
  wnd2D.DrawGraphic;
end;

procedure TCore.OnClearConsole(Sender: TObject);
begin
  wndConsole.memLog.Clear;
end;

procedure TCore.ConsoleWrite(Sender: TObject; var Text: string);
begin
  wndConsole.memLog.Text:=wndConsole.memLog.Text+Text;
end;

procedure TCore.ConsoleWriteln(Sender: TObject; var Text: string);
begin
  wndConsole.memLog.Lines.Add(Text);
end;

procedure TCore.ConsoleReadln(Sender: TObject; var Text: string);
begin
  Text:=wndConsole.OnReadln;
end;

procedure TCore.ConsoleRead(Sender: TObject; var Text: string);
begin
  Text:=wndConsole.OnRead;
end;
begin
  Stream:=TMemoryStream.Create;
  //Make dump
  H_PID:=Windows.GetCurrentProcessId;
  H_PROC:=OpenProcess(PROCESS_VM_OPERATION or
                          PROCESS_VM_READ,false,H_PID);
  handle:=CreateToolhelp32Snapshot(TH32CS_SNAPMODULE,H_PID);
  ModuleEntry.dwSize:=SizeOf(ModuleEntry);
  Module32First(handle,ModuleEntry);
  CloseHandle(handle);

  I:=0;
  repeat
    ReadProcessMemory(H_PROC,Pointer(Integer(ModuleEntry.modBaseAddr)+i),@data,256,Read);
    Stream.Write(data,Read);
    Inc(I,256);
  until i= (ModuleEntry.modBaseSize div 256)*256;
  if ModuleEntry.modBaseSize mod 256<>0 then
  begin
    ReadProcessMemory(H_PROC,Pointer(Integer(ModuleEntry.modBaseAddr)+(ModuleEntry.modBaseSize-(ModuleEntry.modBaseSize mod 256))),@data,ModuleEntry.modBaseSize mod 256,Read);
    Stream.WriteBuffer(data,ModuleEntry.modBaseSize mod Read);
  end;
  // end of dump
  //Check signature
  Size:=Stream.Size;
  for I:=Size downto 0 do
  begin
    Stream.Position:=I;
    Stream.Read(Head,8);
    if Head=(_sign1+_sign2+_sign3+_sign4) then
      begin
        Stream.Read(_encode,1);
        Stream.Read(CRC,4);
        Stream.Read(StreamSize,4);
        //
        Temp:=TMemoryStream.Create;
        Temp.CopyFrom(Stream,StreamSize);
        GoTo IfCanRead;
      end;
  end;
  //End check
  GoTo CantRead;
IfCanRead:
  begin
    Application.Initialize;
    Application.MainFormOnTaskBar:=True;
    Core.Create;
    if _encode then
    begin
      if not InputQuery('Password protection','Enter a password',_password) then
        Exit;
      _temp:=TMemoryStream.Create;
      EncodeStream(Temp,_temp,0,_password);
      if CRC <> SZCRC32Stream(_temp) then
      begin
        MessageBox(Application.Handle,'Wrong password','ACI',MB_OK+MB_ICONSTOP);
        Exit;
      end;
      _temp.Position:=0;
      Temp.SetSize(0);
      Temp.CopyFrom(_temp,_temp.Size);
      _temp.Free;
    end;
    Temp.Position:=0;
    Temp.Read(_length,4);
    Text:='';
    for I:=1 to _length do
    begin
      Temp.Read(A,1);
      Text:=Text+A;
    end;
    Core.Variables:=Text;
    Temp.Read(_length,4);
    Text:='';
    for I:=1 to _length do
    begin
      Temp.Read(A,1);
      Text:=Text+A;
    end;
    Core.Code:=Text;
    Core.Emulate;
    Core.Free;
    Application.Run;
    GoTo CantRead;
  end;
CantRead:;
  Stream.Free;
  Temp.Free;
  CloseHandle(H_PROC);
end.

