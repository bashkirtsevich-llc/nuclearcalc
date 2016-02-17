unit Main_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCalcul, uInterpreter, StdCtrls, Console_u, Advanced, ComCtrls,
  ToolWin, ImgList, Menus, ExtCtrls, CommCtrl, GDI_u, OGL_u, NewFile_u,
  Editor_u, Setup_u, Vars_u, Icons_u, PEFiles, ChangeIco_u, Compress_u,
  ShellApi, IniFiles, ClipBrd, About_u, SZCRC32, project_struct_u;

type
  TPEConfig = packed record
    OutDir,
    ExeName,
    Icon,
    Modules,
    AppTitle,
    ModuleContent,
    Programm,
    Password,
    Variables,
    ProjName{,
    ScriptFile}:string;
    Protect:Boolean;
    Compress:Boolean;
    SelStart,SelLength:DWORD;
  end;  

type
  TfrmMain = class(TForm)
    ToolBarIcons: TImageList;
    mnuMain: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    N3: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N4: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N5: TMenuItem;
    Pastecodesegment1: TMenuItem;
    Variables1: TMenuItem;
    Clearvariables1: TMenuItem;
    Managevariables1: TMenuItem;
    Windows1: TMenuItem;
    Variablelist1: TMenuItem;
    Codewindows1: TMenuItem;
    N6: TMenuItem;
    N2DView1: TMenuItem;
    N3DView1: TMenuItem;
    Program1: TMenuItem;
    Emulate1: TMenuItem;
    N7: TMenuItem;
    CompiletoEXE1: TMenuItem;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    Help1: TMenuItem;
    Help2: TMenuItem;
    N9: TMenuItem;
    About1: TMenuItem;
    Configuration1: TMenuItem;
    Setup1: TMenuItem;
    N10: TMenuItem;
    Lightsyntax1: TMenuItem;
    Console1: TMenuItem;
    IFTHENELSE1: TMenuItem;
    WHILEDO1: TMenuItem;
    PROCEDUREProcedureName1: TMenuItem;
    EXECProcedureName1: TMenuItem;
    Cut1: TMenuItem;
    Delete1: TMenuItem;
    imglistMenu: TImageList;
    BarMain: TCoolBar;
    tbMain: TToolBar;
    btnNew: TToolButton;
    btnOpen: TToolButton;
    btnSave: TToolButton;
    sp1: TToolButton;
    btnEmule: TToolButton;
    btnDebug: TToolButton;
    btnStepOver: TToolButton;
    btnStop: TToolButton;
    mnuNewFile: TPopupMenu;
    Consloe1: TMenuItem;
    N1: TMenuItem;
    N2DMode1: TMenuItem;
    N3DMode1: TMenuItem;
    N2: TMenuItem;
    Emptyfile1: TMenuItem;
    mnuExec: TPopupMenu;
    Execute1: TMenuItem;
    N8: TMenuItem;
    CompiletoEXE2: TMenuItem;
    Debug1: TMenuItem;
    Debugrun1: TMenuItem;
    N11: TMenuItem;
    Stepover1: TMenuItem;
    Reset1: TMenuItem;
    Stepinto1: TMenuItem;
    Continue1: TMenuItem;
    N12: TMenuItem;
    Desctops1: TMenuItem;
    Default1: TMenuItem;
    N13: TMenuItem;
    Savedesctop1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Managevariables1Click(Sender: TObject);
    procedure btnEmuleClick(Sender: TObject);
    procedure N3DView1Click(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure mnuEmptyClick(Sender: TObject);
    procedure Clearvariables1Click(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure Lightsyntax1Click(Sender: TObject);
    procedure CompiletoEXE1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EXECProcedureName1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure btnDebugClick(Sender: TObject);
    procedure btnStepOverClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure CompiletoEXE2Click(Sender: TObject);
    procedure Stepinto1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Help2Click(Sender: TObject);
    procedure Continue1Click(Sender: TObject);
    procedure Default1Click(Sender: TObject);
    procedure Savedesctop1Click(Sender: TObject);
  private
    procedure SetWindowsPos;
    procedure InitConsole(Sender:TObject);
    procedure FreeConsole(Sender:TObject);
    procedure Init3D(Sender:TObject);
    procedure Free3D(Sender:TObject);
    procedure ConsoleWrite(Sender:TObject;var Text:String);
    procedure ConsoleWriteln(Sender:TObject;var Text:String);
    procedure ConsoleReadln(Sender:TObject;var Text:String);
    procedure ConsoleRead(Sender:TObject;var Text:String);
    procedure OnMoveToXY(Sender:TObject;X,Y:Single);
    procedure OnLineToXY(Sender:TObject;X,Y:Single);
    procedure OnInit2D(Sender:TObject);
    procedure OnFree2D(Sender:TObject);
    procedure OnSetAxisLength(Sender:TObject;X,Y:Single);
    procedure OnDraw2D(Sender:TObject);
    procedure OnSetBuffSize(Sender:TObject;Size:LongWord);
    procedure OnClearConsole(Sender:TObject);
    procedure OnUseModule(Sender:TObject; Module:string);
    procedure LoadIcons;
    procedure CompileEXE;
    procedure OnShowInterpreterPos(Sender:TObject; Code:String; Pos: integer);
    procedure OnShowCalculDebugInfo(Sender: TObject; Code:string);
    procedure CreateCalcul;
    procedure OpenFile(FileName:String);
    procedure OnApplyDesctop(Sender:TObject);
    { Private declarations }
  public
    _calcul:TCalcul;
    _interpreter:TInterpreter;
    OutPEConfig:TPEConfig;
    function SaveToFile:Boolean;
    procedure IncludeModules;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  Temp:array of T2Dpoint;
  TempIndex:integer;

implementation

uses Const_u, Debug_u;

{$R *.dfm}

procedure TfrmMain.IncludeModules;
var _index,_pos:integer;
    _text:String;
begin
  for _index:=0 to wndCode.reCode.Lines.Count-1 do
  begin
    _text:=LowerCase(Trim(wndCode.reCode.Lines[_index]));
    for _pos:=1 to length(_text) do
      if Copy(_text,_pos,8)='include(' then
      begin
        _calcul.Formula:=Copy(_text,_pos,Length(_text)-_pos);
        _calcul.Calc;
      end;
  end;
end;

function KillSpaces(Source:String):String;
  function GetItemCount(text:string):integer;
  var _temp:string;
  begin
    _temp:=text+#13#10;
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
    _temp:=text+#13#10;
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
  if Password='' then
    OutStream.CopyFrom(InStream,InStream.Size-StartPos);
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

function ExtractProjectName(_name:String):String;
var Index,_length:Integer;
    Half:String;
begin
  _length:=Length(_name);
  for Index:=_length downto 1 do
    if _name[Index]='\' then
    begin
      Half:=Copy(_name,Index+1,_length);
      Break;
    end;
  _length:=Length(Half);
  for Index:= _length downto 1 do
    if Half[Index]='.' then
      Begin
        Result:=Copy(Half,1,Index-1)+'.exe';
        Break;
      End;
end;

function SubStractString(S1,S2:String):String;
var Index:Word;
begin
  For Index:=1 To Length(S1) do
    if UpperCase(S1[Index])<>UpperCase(S2[Index]) then
      begin
        Result:=Copy(S1,Index,Length(S1));
        Exit;
      end;
end;

function SaveStringToFile(Text:String;FileName:String):Boolean;
var _index,_length:Integer;
    _stream:TFileStream;
begin
  Result:=False;
  try
    _stream:=TFileStream.Create(FileName,fmCreate);
    _length:=Length(Text);
    for _index:=1 to _length do
    begin
      _stream.Write(Byte(Text[_index]),1);
    end;
    _stream.Free;
  except
    Result:=False;
  end;
end;

function LoadStringFromFile(FileName:String):String;
var _stream:TFileStream;
    Data:Byte;
begin
  Result:='';
  if not FileExists(FileName) then Exit;
  try
    _stream:=TFileStream.Create(FileName,fmOpenRead);
    while _stream.Position<_stream.Size do
    begin
      _stream.Read(Data,1);
      Result:=Result+Char(Data);
    end;
    _stream.Free;
  except
    Result:='';
  end;
end;

procedure TfrmMain.CreateCalcul;
begin
  _calcul:=TCalcul.Create;
  _interpreter:=TInterpreter.Create;
  _calcul.OnInitConsole:=InitConsole;
  _calcul.OnFreeConsole:=FreeConsole;
  _calcul.OnInit3D:=Init3D;
  _calcul.OnFree3D:=Free3D;
  _calcul.OnColsoleWriteln:=ConsoleWriteln;
  _calcul.OnColsoleWrite:=ConsoleWrite;
  _calcul.OnColsoleRead:=ConsoleRead;
  _calcul.OnColsoleReadln:=ConsoleReadln;
  _calcul.OnMoveToXY:=OnMoveToXY;
  _calcul.OnLineToXY:=OnLineToXY;
  _calcul.OnInit2D:=OnInit2D;
  _calcul.OnFree2D:=OnFree2D;
  _calcul.OnSetAxisLength:=OnSetAxisLength;
  _calcul.OnDraw2D:=OnDraw2D;
  _calcul.OnSetBuffSize:=OnSetBuffSize;
  _calcul.OnClearConsole:=OnClearConsole;
  _calcul.Parent:=Self;
  _calcul.OnShowInterpreterPos:=OnShowCalculDebugInfo;
  _calcul.OnuseModule:=OnUseModule;
end;

procedure TfrmMain.OnUseModule(Sender: TObject; Module: string);
var Modules:String;
begin
  Modules:=ExtractFileDir(ParamStr(0))+'\..\MODULES\'+Module;
  if not FileExists(Modules) then
  begin
    Modules:=ExtractFileDir(OutPEConfig.ProjName)+'\'+Module;
    if not FileExists(Modules) then Exit;
  end;
  OutPEConfig.ModuleContent:=OutPEConfig.ModuleContent+#13#10+LoadStringFromFile(Modules);
end;

procedure TfrmMain.InitConsole(Sender:TObject);
begin
  wndConsole.Show;
end;

procedure TfrmMain.FreeConsole(Sender:TObject);
begin
  wndConsole.Close;
end;

procedure TfrmMain.Help2Click(Sender: TObject);
var HelpFile:String;
begin
  HelpFile:=ExtractFileDir(ParamStr(0))+'\..\HELP\Help.chm';
  if not FileExists(HelpFile) then
  begin
    MessageBox(Handle,'Help file not found','Attention',MB_OK+MB_ICONEXCLAMATION);
    Exit;
  end;
  ShellExecute(Handle,'open',PCHar(HelpFile),
               nil,PChar(ExtractFileDir(ParamStr(0))+'\..\HELP\'),SW_SHOW);
end;

procedure TfrmMain.Init3D(Sender:TObject);
begin
  wndOpenGL.Show;
end;

procedure TfrmMain.Free3D(Sender:TObject);
begin
  wndOpenGL.Close;
end;

procedure TfrmMain.ConsoleWrite(Sender: TObject; var Text: string);
begin
  wndConsole.memLog.Text:=wndConsole.memLog.Text+Text;
end;

procedure TfrmMain.ConsoleWriteln(Sender: TObject; var Text: string);
begin
  wndConsole.memLog.Lines.Add(Text);
end;

procedure TfrmMain.Continue1Click(Sender: TObject);
begin
  _interpreter.Debug:=False;
  _calcul.Debug:=False;
  _calcul.StepOver;
  _interpreter.StepOver;
end;

procedure TfrmMain.Copy1Click(Sender: TObject);
begin
  if wndCode.reCode.SelLength > 0 then
    wndCode.reCode.CopyToClipboard;
end;

procedure TfrmMain.Cut1Click(Sender: TObject);
begin
  wndCode.reCode.CutToClipboard;
end;

procedure TfrmMain.OnApplyDesctop(Sender: TObject);
var _desctop:TDesctop;
    _file:string;
    _index:integer;
    procedure ApplyDesctop(dt:TDesctop; Dest:TForm);
    begin
      Dest.Left:=dt.Left;
      Dest.Top:=dt.Top;
      Dest.Height:=dt.Height;
      Dest.Width:=dt.Width;
      Dest.WindowState:=TWindowState(dt.WindowState);
    end;
const Sections:array [0..7] of ShortString =
  ('Main','Editor','Variables','Structure','2D','3D','Debugger','Console');
begin
  _file:=ExtractFileDir(ParamStr(0))+'\..\DESCTOPS\'+(Sender as TMenuItem).Hint;
  for _index:=0 to High(Sections) do
  begin
    _desctop:=GetDesctopFromFile(_file,Sections[_index]);
    case _index of
      0:ApplyDesctop(_desctop,Self);
      1:ApplyDesctop(_desctop,wndCode);
      2:ApplyDesctop(_desctop,wndVariables);
      3:ApplyDesctop(_desctop,dlgProjectStruct);
      4:ApplyDesctop(_desctop,wnd2D);
      5:ApplyDesctop(_desctop,wndOpenGL);
      6:ApplyDesctop(_desctop,wndDebugger);
      7:ApplyDesctop(_desctop,wndConsole);
    end;
  end;
end;

procedure TfrmMain.Default1Click(Sender: TObject);
begin
  SetWindowsPos;
  with wndVariables do
  begin
    Left:=0;
    Top:=frmMain.Height+frmMain.Top;
    WindowState:=wsNormal;
  end;
  with dlgProjectStruct do
  begin
    Left:=wndVariables.Left;
    Top:=wndVariables.Top+wndVariables.Height;
    Width:=wndVariables.Width;
    Height:=Screen.WorkAreaHeight-Self.Top;
    WindowState:=wsNormal;
  end;
  with wndCode do
  begin
    Left:=wndVariables.Width+50;
    Top:=frmMain.Top+frmMain.Height+50;
    WindowState:=wsNormal;
  end;
  with wndOpenGL do
  begin
    Top:=frmMain.Top+frmMain.Height+50;
    Left:=wndVariables.Left+wndVariables.Width+50;
    WindowState:=wsNormal;
  end;
  with wndConsole do
  begin
    Top:=frmMain.Top+frmMain.Height+75;
    Left:=wndVariables.Left+wndVariables.Width+75;
    WindowState:=wsNormal;
  end;
  with wnd2D do
  begin
    Top:=frmMain.Top+frmMain.Height+80;
    Left:=wndVariables.Left+wndVariables.Width+80;
    WindowState:=wsNormal;
  end;
end;

procedure TfrmMain.Delete1Click(Sender: TObject);
begin
  wndCode.reCode.CutToClipboard;
  Clipboard.Clear;
end;

procedure TfrmMain.mnuEmptyClick(Sender: TObject);
var ParentNode,ChildNode:TTreeNode;
begin
  wndCode.Show;
  wndCode.AddTab('');
  wndVariables.TextAsVars('');
  case (Sender as TMenuItem).Tag of
    1:wndCode.reCode.Text:=ConsoleScript;
    2:wndCode.reCode.Text:=a2Dscript;
    3:wndCode.reCode.Text:=a3Dscript;
    4:wndCode.reCode.Text:='';
  end;
  OutPEConfig.ExeName:='Project1.exe';
  OutPEConfig.OutDir:=ExtractFileDir(ParamStr(0))+'\..\Projects\';
  OutPEConfig.Icon:='';
  {if (Sender as TMenuItem).Tag <>4 then
  begin}
    dlgProjectStruct.tvStruct.Items.Clear;
    ParentNode:=dlgProjectStruct.tvStruct.Items.Add(nil,'Project1.exe');
    ParentNode.ImageIndex:=0;
    ParentNode.SelectedIndex:=0;
    ParentNode.StateIndex:=0;
    ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,wndCode.tsProjects.Tabs[wndCode.tsProjects.TabIndex]);
    ChildNode.ImageIndex:=1;
    ChildNode.SelectedIndex:=1;
    ChildNode.StateIndex:=1;
    if OutPEConfig.Icon<>'' then
    begin
      ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,ExtractFileName(OutPEConfig.Icon));
      ChildNode.ImageIndex:=2;
      ChildNode.SelectedIndex:=2;
      ChildNode.StateIndex:=2;
    end;
  {end;}
end;

procedure TfrmMain.ConsoleReadln(Sender: TObject; var Text: string);
begin
  Text:=wndConsole.OnReadln;
end;

procedure TfrmMain.OnInit2D(Sender: TObject);
begin
  wnd2D.Show;
  wnd2D.PointList.Clear;
  TempIndex:=-1;
  SetLength(Temp,100);
end;

procedure TfrmMain.OnSetBuffSize(Sender: TObject; Size: Cardinal);
begin
  SetLength(Temp,Size);
end;

procedure TfrmMain.OnClearConsole(Sender: TObject);
begin
  wndConsole.memLog.Clear;
end;

procedure TfrmMain.Paste1Click(Sender: TObject);
begin
  wndCode.reCode.PasteFromClipboard;
end;

procedure TfrmMain.OnFree2D(Sender: TObject);
begin
  wnd2D.Close;
  SetLength(Temp,0);
end;

procedure TfrmMain.OnSetAxisLength(Sender: TObject; X: Single; Y: Single);
begin
  wnd2D._AxisX:=X;
  wnd2D._AxisY:=Y;
end;

procedure TfrmMain.OnMoveToXY(Sender: TObject; X: Single; Y: Single);
//var Temp:T2Dpoint;
begin
  Inc(TempIndex);
  //SetLength(Temp,TempIndex);
  Temp[TempIndex].X:=X;
  Temp[TempIndex].Y:=Y;
  Temp[TempIndex]._move:=True;
  wnd2D.PointList.Add(@Temp[TempIndex]);
  //wnd2D.DrawGraphic;
end;

procedure TfrmMain.OnLineToXY(Sender: TObject; X: Single; Y: Single);
//var Temp:T2Dpoint;
begin
  Inc(TempIndex);
  //SetLength(Temp,TempIndex);
  Temp[TempIndex].X:=X;
  Temp[TempIndex].Y:=Y;
  Temp[TempIndex]._move:=False;
  wnd2D.PointList.Add(@Temp[TempIndex]);
  //wnd2D.DrawGraphic;
end;

procedure TfrmMain.OnDraw2D(Sender: TObject);
begin
  wnd2D.DrawGraphic;
end;

procedure TfrmMain.Edit1Click(Sender: TObject);
begin
  Cut1.Enabled:=True;
  Copy1.Enabled:=True;
  Delete1.Enabled:=True;
  if wndCode.reCode.SelLength=0 then
  begin
    Cut1.Enabled:=False;
    Copy1.Enabled:=False;
    Delete1.Enabled:=False;
  end;
end;

procedure TfrmMain.EXECProcedureName1Click(Sender: TObject);
var _Temp1,_Temp2:String;
    _defPos:Integer;
begin
  _defPos:=wndCode.reCode.SelStart;
  _temp1:=Copy(wndCode.reCode.Text,1,_defPos);
  _temp2:=Copy(wndCode.reCode.Text,_defPos+1,Length(wndCode.reCode.Text));
  case (Sender as TMenuItem).Tag of
    1:_temp1:=_temp1+'if _TRUE then {}'#13+'else {}';//IF ... THEN {...} [ELSE{...}]
    2:_temp1:=_temp1+'while _TRUE do'#13+'{}';//WHILE .. DO DO {...}
    3:_temp1:=_temp1+'procedure __void'#13+'{'#13+'}';//PROCEDURE <ProcedureName> {...}
    4:_temp1:=_temp1+'exec __void;';//EXEC <ProcedureName>
  end;
  wndCode.reCode.Text:=_temp1+_temp2;
  wndCode.reCode.SelStart:=_defPos;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.Lightsyntax1Click(Sender: TObject);
var State:Boolean;
begin
  State:=(Sender as TMenuItem).Checked;
  (Sender as TMenuItem).Checked:=not state;
  wndCode.LightSyntax( 0, not state );
end;

procedure TfrmMain.LoadIcons;
var himlIconsBIG: HIMAGELIST;
    //hIconLib: HModule;
    Temp:TStream;
    Icon:TIcon;
    Index:Byte;
begin
  himlIconsBig := ImageList_Create(48, 48, ILC_COLOR32 or ILC_MASK, 0, 0);
  for Index:=0 to 6 do
    begin
      Temp:=TMemoryStream.Create;
      case Index of
        0:Temp.Write(icon_newdata,SizeOf(icon_newdata));
        1:Temp.Write(icon_opendata,SizeOf(icon_opendata));
        2:Temp.Write(icon_savedata,SizeOf(icon_savedata));
        3:Temp.Write(icon_rundata,SizeOf(icon_rundata));
        4:Temp.Write(icon_debugdata,SizeOf(icon_debugdata));
        5:Temp.Write(icon_stepoverdata,SizeOf(icon_stepoverdata));
        6:Temp.Write(icon_haltdata,SizeOf(icon_haltdata));
      end;
      Temp.Position:=0;
      Icon:=TIcon.Create;
      Icon.LoadFromStream(Temp);
      ImageList_AddIcon(himlIconsBIG,Icon.Handle);
      Icon.Free;
      Temp.Free;
    end;
  //
  ToolBarIcons.Handle:=himlIconsBIG;
end;

procedure TfrmMain.CompileEXE;    //Build
const _sign:LongWord = $494341;   //ACI
      _ver:LongWord  = $30302E31; //1.00
      _space:LongWord= $20;       //" "
      {$R ACI_PE.RES}             // ACI_PE File for compile *.exe project
var _res:TResourceStream;
    _modules,Module,_text:String;
    _encode:Boolean;
    _length,_index,CRC,Size:DWORD;
    Sections:Integer;
    Data:Char;
    DataStream,GeneralStream:TMemoryStream;
    TempStream:TStream;
    PE:TPEFile;
begin
  _encode:=OutPEConfig.Protect;
  try
  _res:=TResourceStream.Create(hInstance,'ACI','ACI_PE');
  except
    MessageBox(Handle,'Sorry, cant make .exe','Error',MB_OK+MB_ICONEXCLAMATION);
    Exit;
  end;
  PE:=TPEFile.Create(_res);
  _res.Free;

  DataStream:=TMemoryStream.Create;
  OutPEConfig.ModuleContent:='';
  OutPEConfig.Programm:=wndCode.reCode.Text;
  _modules:=OutPEConfig.Modules;
  while (Length(_modules)>1) do
  begin
    Module:=Copy(_modules,1,Pos(';',_modules)-1);
    Module:=LoadStringFromFile(ExtractFileDir(ParamStr(0))+'\..\MODULES\'+Module);
    OutPEConfig.Programm:=OutPEConfig.Programm+#13#13+Module;
    Delete(_modules,1,Pos(';',_modules));
  end;
  CreateCalcul;
  IncludeModules;
  OutPEConfig.Programm:=OutPEConfig.Programm+#13#10+OutPEConfig.ModuleContent;
  _text:=wndVariables.VarsAsText; // Convert program with variables to bit stream
  _length:=Length(_text);
  DataStream.Write(_length,4);
  for _index := 1 to _length do
  begin
    Data:=_text[_index];
    DataStream.Write(Data,1);
  end;
  _text:=OutPEConfig.Programm;
  _length:=Length(_text);
  DataStream.Write(_length,4);
  for _index := 1 to _length do
  begin
    Data:=_text[_index];
    DataStream.Write(Data,1);
  end;
  DataStream.Position:=0;
  CRC:=SZCRC32FullStream(DataStream);  // compute CRC-32
  DataStream.Position:=0;
  Size:=DataStream.Size;
  if _encode then   // protect program
  begin
    TempStream:=TMemoryStream.Create;
    EncodeStream(DataStream,TempStream,0,OutPEConfig.Password);
    TempStream.Position:=0;
    DataStream.Position:=0;
    DataStream.Size:=0;
    DataStream.CopyFrom(TempStream,TempStream.Size);
  end;
  DataStream.Position:=0;   // end of protect
  GeneralStream:=TMemoryStream.Create;
  GeneralStream.Write(_sign,3); // write signatire for detect section
  GeneralStream.Write(_space,1);
  GeneralStream.Write(_ver,4);
  GeneralStream.Write(_encode,1); // end of writing signature
  GeneralStream.Write(CRC,SizeOf(CRC));//Write CRC-32 and Size
  GeneralStream.Write(Size,Sizeof(Size));//end of writing CRC-32 and size
  GeneralStream.CopyFrom(DataStream,DataStream.Size);
  GeneralStream.Position:=0;
  DataStream.Free;
  PE.AddSection('.ac_code',GeneralStream.Size+1,PE.ObjectAlign,$40000000,False);//Create section into exe file
  DataStream:=TMemoryStream.Create;
  PE.F.Position:=0;
  DataStream.CopyFrom(PE.F,PE.F.Size);
  PE.Free;
  PE:=TPEFile.Create(DataStream);
  for Sections:=1 to PE.NumObject do
    if (PE.Section[Sections].ObjectNameStr='.ac_code') then
    begin
      DataStream.Position:=PE.Section[Sections].PhysicalOffset+1;
      DataStream.CopyFrom(GeneralStream,GeneralStream.Size);
    end;
  GeneralStream.Free;
  //showmessage(format('%s %s',[OutPEConfig.OutDir,OutPEConfig.ExeName]));
  DataStream.SaveToFile(OutPEConfig.OutDir+OutPEConfig.ExeName);
  if (OutPEConfig.Icon<>'')and(FileExists(OutPEConfig.OutDir+OutPEConfig.Icon)) then  //Change icon
    UpdateIcons(OutPEConfig.OutDir+OutPEConfig.ExeName,OutPEConfig.OutDir+OutPEConfig.Icon);
  if OutPEConfig.Compress then  // protect with UPX
    CompressEXE(OutPEConfig.OutDir+OutPEConfig.ExeName,9,False);//Attention
  if MessageBox(Handle,PChar(Format('Execute "%s" now?',[OutPEConfig.OutDir+
                OutPEConfig.ExeName])),'Question',MB_YESNO+MB_ICONQUESTION)=ID_YES then
    ShellExecute(Handle,'open',PChar(OutPEConfig.OutDir+OutPEConfig.ExeName),nil,nil,SW_SHOW);
end;

procedure TfrmMain.OnShowInterpreterPos(Sender: TObject; Code:string; Pos: integer);
procedure DeselectAll;
var _index:Integer;
begin
  for _index:=0 to wndDebugger.lbCode.Items.Count-1 do
    wndDebugger.lbCode.Selected[_index]:=false;
end;
{procedure SelectString(_startPos: Integer);
var _itemIndex:Integer;
    _count:Integer;
    _temp:String;
    _tempLength:Integer;
    _tempIndex:Integer;
    _total:Integer;
begin
  _count:=wndDebugger.lbCode.Items.Count;
  _total:=0;
  for _itemIndex:=0 to _count-1 do
  begin
    _temp:=wndDebugger.lbCode.Items[_itemIndex];
    _tempLength:=Length(_temp);
    for _tempIndex:=1 to _tempLength do
      if _startPos=_total+_tempIndex then
      begin
        DeselectAll;
        wndDebugger.lbCode.Selected[_itemIndex]:=True;
        Exit;
      end;
    inc(_total,_tempLength);
  end;
end; }
begin
  DeselectAll;
  wndDebugger.lbInterpreterDebug.Items.Add(Code);
  wndDebugger.lbCode.Selected[Pos]:=True;
  //SelectString(Pos-1);
end;

procedure TfrmMain.OnShowCalculDebugInfo(Sender: TObject; Code: string);
begin
 wndDebugger.lbCalcDebug.Items.Add(Code);
 wndDebugger.lbCalcVars.Items.Text:=_calcul.Variables;
end;

procedure TfrmMain.CompiletoEXE1Click(Sender: TObject);
begin
  CompileEXE;
end;

procedure TfrmMain.CompiletoEXE2Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:btnEmuleClick(Sender);
    2:CompileEXE;
  end;
end;

procedure TfrmMain.About1Click(Sender: TObject);
begin
  Application.CreateForm(TdlgAbout,dlgAbout);
  dlgAbout.ShowModal;
  dlgAbout.Free;
end;

procedure TfrmMain.btnDebugClick(Sender: TObject);
var Module:String;
    _temp:String;
begin
  CreateCalcul;
  OutPEConfig.ModuleContent:='';
  wndDebugger.Show;
  btnDebug.Enabled:=False;
  btnEmule.Enabled:=False;
  btnStepOver.Enabled:=True;
  btnStop.Enabled:=True;
  Stepinto1.Enabled:=True;
  Continue1.Enabled:=true;

  wndDebugger.btnStepInto.Enabled:=True;
  wndDebugger.btnStepOver.Enabled:=True;
  wndDebugger.btnStop.Enabled:=True;

  //
  Emulate1.Enabled:=False;
  CompiletoEXE1.Enabled:=False;
  Debugrun1.Enabled:=False;
  Stepover1.Enabled:=True;
  Reset1.Enabled:=True;

  wndCode.lbLog.Clear;
  _interpreter.OnShowDebugPos:=OnShowInterpreterPos;
  wndCode.sbStatus.Panels[0].Text:='Debug mode';
  wndCode.Update;
  _interpreter.Calcul:=_calcul;
  _interpreter.Debug:=True;
  _calcul.Debug:=True;
  OutPEConfig.Programm:=wndCode.reCode.Text;// And Addons
  //
  _temp:=OutPEConfig.Modules;
  while Length(_temp)>1 do
  begin
    Module:=Copy(_temp,1,Pos(';',_temp)-1);
    Module:=LoadStringFromFile(ExtractFileDir(ParamStr(0))+'\..\MODULES\'+Module);
    OutPEConfig.Programm:=OutPEConfig.Programm+#13#13+Module;
    Delete(_temp,1,Pos(';',_temp));
  end;
  //
  _calcul.Debug:=False;
  IncludeModules;
  OutPEConfig.Programm:=OutPEConfig.Programm+#13#10+OutPEConfig.ModuleContent;
  _interpreter.Prog:=KillSpaces(OutPEConfig.Programm);//Programm
  //SaveStringToFile(_interpreter.Prog,'123.txt');
  //
  wndDebugger.lbCode.Items.Text:=OutPEConfig.Programm;
  //
  _calcul.Variables:=wndVariables.VarsAsText;
  _interpreter.Execute;
  wndVariables.TextAsVars(_calcul.Variables);
  if _interpreter.Error then
    begin
      wndCode.lbLog.Items.Add(Format('Error: %d "%s"',[_interpreter.ErrorPos,_interpreter.ErrorText]));
      wndCode.sbStatus.Panels[0].Text:='Program has a trouble';
      wndCode.reCode.SelStart:=_interpreter.ErrorPos-1;
    end;
  wndCode.sbStatus.Panels[0].Text:='Ready';
  btnDebug.Enabled:=True;
  btnEmule.Enabled:=True;
  btnStepOver.Enabled:=False;
  btnStop.Enabled:=False;
  //
  Emulate1.Enabled:=True;
  CompiletoEXE1.Enabled:=True;
  Debugrun1.Enabled:=True;
  Stepover1.Enabled:=False;
  Reset1.Enabled:=False;
  Stepinto1.Enabled:=False;
  //
  wndDebugger.btnStepInto.Enabled:=False;
  wndDebugger.btnStepOver.Enabled:=False;
  wndDebugger.btnStop.Enabled:=False;
  Continue1.Enabled:=False;
  _interpreter.Free;
  _calcul.Free;
end;

procedure TfrmMain.btnEmuleClick(Sender: TObject);
var Module:String;
    _temp:String;
begin
  CreateCalcul;
  OutPEConfig.ModuleContent:='';
  btnDebug.Enabled:=False;
  btnEmule.Enabled:=False;
  Emulate1.Enabled:=False;
  CompiletoEXE1.Enabled:=False;
  Debugrun1.Enabled:=False;
  Stepover1.Enabled:=False;
  Reset1.Enabled:=False;
  _interpreter.OnShowDebugPos:=nil;
  wndCode.lbLog.Clear;
  wndCode.sbStatus.Panels[0].Text:='Emulation';
  wndCode.Update;
  _interpreter.Calcul:=_calcul;
  _calcul.Debug:=False;
  OutPEConfig.Programm:=wndCode.reCode.Text;// And Addons
  //
  _temp:=OutPEConfig.Modules;
  while Length(_temp)>1 do
  begin
    Module:=Copy(_temp,1,Pos(';',_temp)-1);
    Module:=LoadStringFromFile(ExtractFileDir(ParamStr(0))+'\..\MODULES\'+Module);
    OutPEConfig.Programm:=OutPEConfig.Programm+#13#10+Module;
    Delete(_temp,1,Pos(';',_temp));
  end;
  //
  IncludeModules;
  OutPEConfig.Programm:=OutPEConfig.Programm+#13#10+OutPEConfig.ModuleContent;
  _interpreter.Prog:=KillSpaces(OutPEConfig.Programm);//Programm
  _calcul.Variables:=wndVariables.VarsAsText;
  _interpreter.Execute;
  wndVariables.TextAsVars(_calcul.Variables);
  if _interpreter.Error then
    begin
      wndCode.lbLog.Items.Add(Format('Error: %d "%s"',[_interpreter.ErrorPos,_interpreter.ErrorText]));
      wndCode.sbStatus.Panels[0].Text:='Emulatiion failure';
      wndCode.reCode.SelStart:=_interpreter.ErrorPos-1;
    end;
  wndCode.sbStatus.Panels[0].Text:='Ready';
  btnDebug.Enabled:=True;
  btnEmule.Enabled:=True;

  Emulate1.Enabled:=True;
  CompiletoEXE1.Enabled:=True;
  Debugrun1.Enabled:=True;
  Stepover1.Enabled:=False;
  Reset1.Enabled:=False;
  _interpreter.Free;
  _calcul.Free;
end;

procedure TfrmMain.btnNewClick(Sender: TObject);
var ParentNode,ChildNode:TTreeNode;
begin
  Application.CreateForm(TdlgNewFile,dlgNewFile);
  if dlgNewFile.ShowModal=mrOk then
    begin
      wndCode.Show;
      wndCode.AddTab('');
      case dlgNewFile.lvNewFile.ItemIndex of
        0:wndCode.reCode.Text:=ConsoleScript;
        1:wndCode.reCode.Text:=a2Dscript;
        2:wndCode.reCode.Text:=a3Dscript;
        3:wndCode.reCode.Text:='';
      end;
    end;
  dlgNewFile.Free;
  OutPEConfig.ExeName:='Project1.exe';
  OutPEConfig.OutDir:=ExtractFileDir(ParamStr(0))+'\..\Projects\';
  OutPEConfig.Icon:='';
  dlgProjectStruct.tvStruct.Items.Add(nil,'1');
  {if dlgNewFile.lvNewFile.ItemIndex <>3 then
  begin }
    dlgProjectStruct.tvStruct.Items.Clear;
    ParentNode:=dlgProjectStruct.tvStruct.Items.Add(nil,'Project1.exe');
    ParentNode.ImageIndex:=0;
    ParentNode.SelectedIndex:=0;
    ParentNode.StateIndex:=0;
    ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,wndCode.tsProjects.Tabs[wndCode.tsProjects.TabIndex]);
    ChildNode.ImageIndex:=1;
    ChildNode.SelectedIndex:=1;
    ChildNode.StateIndex:=1;
    if OutPEConfig.Icon<>'' then
    begin
      ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,ExtractFileName(OutPEConfig.Icon));
      ChildNode.ImageIndex:=2;
      ChildNode.SelectedIndex:=2;
      ChildNode.StateIndex:=2;
    end;
  {end;}
end;

procedure TfrmMain.OpenFile(FileName: string);
var ProjIni:TIniFile;
    ParentNode,ChildNode:TTreeNode;
    _temp,module:string;
const _main='Main';
      _files='Files';
begin
  ProjIni:=TIniFile.Create(dlgOpen.FileName);
  OutPEConfig.ProjName:=(dlgOpen.FileName);
  OutPEConfig.ExeName:=ProjIni.ReadString(_main,'Project_name','');
  OutPEConfig.Icon:=ProjIni.ReadString(_files,'Icon','');
  OutPEConfig.Modules:=ProjIni.ReadString(_files,'Modules','');
  OutPEConfig.OutDir:=ExtractFileDir(dlgOpen.FileName);
  //OutPEConfig.DesctopFile:=ProjIni.ReadString(_files,'Desctop','');
  if OutPEConfig.OutDir[Length(OutPEConfig.OutDir)]<>'\' then
    OutPEConfig.OutDir:=OutPEConfig.OutDir+'\';
  Caption:=Format('[Atomic Calculator "Interpreter"]-"%s"',[OutPEConfig.ExeName]);
  //
  wndCode.AddTab(ExtractFileName(ExtractFileDir(dlgOpen.FileName)+'\'+ProjIni.ReadString(_files,'Script','')));
  //OutPEConfig.ScriptFile:=ExtractFileDir(dlgOpen.FileName)+'\'+ProjIni.ReadString(_files,'Script','');
  wndCode.reCode.Text:=LoadStringFromFile(ExtractFileDir(dlgOpen.FileName)+'\'+ProjIni.ReadString(_files,'Script',''));
  wndVariables.TextAsVars(LoadStringFromFile(ExtractFileDir(dlgOpen.FileName)+'\'+ProjIni.ReadString(_files,'Variables','')));
  //
  dlgProjectStruct.tvStruct.Items.Clear;
  ParentNode:=dlgProjectStruct.tvStruct.Items.Add(nil,OutPEConfig.ExeName);
  ParentNode.ImageIndex:=0;
  ParentNode.SelectedIndex:=0;
  ParentNode.StateIndex:=0;
  ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,ExtractFileName(ProjIni.ReadString(_files,'Script','')));
  ChildNode.ImageIndex:=1;
  ChildNode.SelectedIndex:=1;
  ChildNode.StateIndex:=1;
  if OutPEConfig.Modules<>'' then
  begin
  _temp:=OutPEConfig.Modules;
  while Length(_temp)>1 do
  begin
    Module:=Copy(_temp,1,Pos(';',_temp)-1);
    ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,Module);
    ChildNode.ImageIndex:=3;
    ChildNode.SelectedIndex:=3;
    ChildNode.StateIndex:=3;
    Delete(_temp,1,Pos(';',_temp));
  end;
  end;
  if OutPEConfig.Icon<>'' then
  begin
    ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,ExtractFileName(OutPEConfig.Icon));
    ChildNode.ImageIndex:=2;
    ChildNode.SelectedIndex:=2;
    ChildNode.StateIndex:=2;
  end;
end;

procedure TfrmMain.btnOpenClick(Sender: TObject);
begin
  if not dlgOpen.Execute(Handle) then Exit;
  OpenFile(dlgOpen.FileName);
end;

procedure TfrmMain.Savedesctop1Click(Sender: TObject);
var SaveIni:TIniFile;
    SaveName:String;
    dt:TDesctop;
    function ConvertToDesctop(Source:TForm):TDesctop;
    begin
      Result.Left:=Source.Left;
      Result.Top:=Source.Top;
      Result.Height:=Source.Height;
      Result.Width:=Source.Width;
      Result.WindowState:=Integer(Source.WindowState);
    end;
    procedure WriteDesctop(Section:String;dt:TDesctop);
    begin
      SaveIni.WriteInteger(Section,'Left',dt.Left);
      SaveIni.WriteInteger(Section,'Top',dt.Top);
      SaveIni.WriteInteger(Section,'Height',dt.Height);
      SaveIni.WriteInteger(Section,'Width',dt.Width);
      SaveIni.WriteInteger(Section,'State',dt.WindowState);
    end;
const Sections:array [0..7] of ShortString =
  ('Main','Editor','Variables','Structure','2D','3D','Debugger','Console');
begin
  SaveName:='Desctop1';
  if not InputQuery('Desctop','Save desctop as',SaveName) then Exit;
  Savename:=ExtractFileDir(ParamStr(0))+'\'+SaveName+'.acd';
  SaveIni:=TIniFile.Create(SaveName);
  WriteDesctop(Sections[0],ConvertToDesctop(Self));
  WriteDesctop(Sections[1],ConvertToDesctop(wndCode));
  WriteDesctop(Sections[2],ConvertToDesctop(wndVariables));
  WriteDesctop(Sections[3],ConvertToDesctop(dlgProjectStruct));
  WriteDesctop(Sections[4],ConvertToDesctop(wnd2D));
  WriteDesctop(Sections[5],ConvertToDesctop(wndOpenGL));
  WriteDesctop(Sections[6],ConvertToDesctop(wndDebugger));
  WriteDesctop(Sections[7],ConvertToDesctop(wndConsole));
  SaveIni.Free;
end;

function TfrmMain.SaveToFile:Boolean;
var ProjIni:TIniFIle;
    ScriptFName,Vars:String;
    //_index:Integer;
const _main='Main';
      _files='Files';
begin
  // Save project & Scripts files into dir by differ names.
  Result:=False;
  dlgSave.FileName:=wndCode.tsProjects.Tabs[wndCode.tsProjects.TabIndex];
  dlgSave.Filter:='[AC] Script (*.acs)|*.ACS|All files (*.*)|*.*';
  if not dlgSave.Execute(Handle) then Exit;
  if UpperCase(ExtractFileExt(dlgSave.FileName))<>'.ACS' then
    dlgSave.FileName:=dlgSave.FileName+'.acs';
  Vars:=ChangeFileExt(dlgSave.FileName,'.acv');
  ScriptFName:=dlgSave.FileName;
  dlgSave.FileName:='Project1';
  dlgSave.Filter:='[AC] Project (*.acp)|*.ACP|All files (*.*)|*.*';
  if not dlgSave.Execute(Handle) then Exit;
  if UpperCase(ExtractFileExt(dlgSave.FileName))<>'.ACP' then
    dlgSave.FileName:=dlgSave.FileName+'.acp';
  ProjIni:=TIniFile.Create(dlgSave.FileName);
  ProjIni.WriteString(_main,'Project_name',ExtractProjectName(dlgSave.FileName));
  OutPEConfig.ExeName:=ExtractProjectName(dlgSave.FileName);
  ProjIni.WriteDateTime(_main,'Create',Date+Time);
  ProjIni.WriteString(_main,'Copyright','[AC]');
  ProjIni.WriteString(_main,'Out_dir',extractFileDir(dlgSave.FileName)+'\');
  OutPEConfig.OutDir:=extractFileDir(dlgSave.FileName);
  ProjIni.WriteString(_files,'Script',SubStractString(ExtractFileDir(DlgSave.FileName),ExtractFileDir(ScriptFName))+ExtractFileName(ScriptFName));// Attention, in here needed relative name
  ProjIni.WriteString(_files,'Variables',SubStractString(ExtractFileDir(DlgSave.FileName),ExtractFileDir(Vars))+ExtractFileName(Vars));// Attention, in here needed relative name
  ProjIni.WriteString(_files,'Icon',OutPEConfig.Icon);
  ProjIni.WriteString(_files,'Modules',OutPEConfig.Modules);
  SaveStringToFile(wndCode.reCode.Lines.Text,ScriptFName);
  SaveStringToFile(wndVariables.VarsAsText,Vars);
  ProjIni.Free;
  Caption:=Format('[Atomic Calculator "Interpreter"]-"%s"',[OutPEConfig.ExeName]);
  Result:=True;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  SaveToFile;
end;

procedure TfrmMain.btnStepOverClick(Sender: TObject);
begin
  _calcul.Debug:=False;
  _interpreter.StepOver;
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  _interpreter.HaltInterpreter;
  _interpreter.StepOver;
  btnDebug.Enabled:=True;
  btnEmule.Enabled:=True;
  btnStepOver.Enabled:=False;
  btnStop.Enabled:=False;
  
end;

procedure TfrmMain.Clearvariables1Click(Sender: TObject);
begin
  wndVariables.lvVars.Clear;
  _calcul.Variables:='';
end;

procedure TfrmMain.ConsoleRead(Sender: TObject; var Text: string);
begin
  Text:=wndConsole.OnRead;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{  _interpreter.HaltInterpreter;
  _interpreter.StepOver; }
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{  case MessageBox(Handle,'Save changes to project?','Question',MB_YESNOCANCEL+MB_ICONQUESTION) of
    ID_YES:begin
      btnSaveClick(Sender);//Save
      Canclose:=True;
    end;
    ID_NO:Canclose:=True;
    ID_CANCEL:Canclose:=False;
  end;   }
  wndCode.CloseAllTabs;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var DesctopList:TStringList;
    _index:integer;
    _item:TMenuItem;
function FileMaskEquate(F, M: string): boolean;
var
  Fl, Ml: integer; // length of file name and mask
  Fp, Mp: integer; // pointers
begin
  F := UpperCase(F);
  M := UpperCase(M);
  result := true;
  Fl := length(F);
  Ml := length(M);
  Fp := 1;
  Mp := 1;
  while Mp <= Ml do
  begin // wildcard
    case M[Mp] of //
      '?':
        begin // if one any char
          inc(Mp); // next char of mask
          inc(Fp); // next char of file name
        end; //
      '*':
        begin // if any chars
          if Mp = Ml then
            exit; // if last char in mask then exit
          if M[Mp + 1] = F[Fp] then
          begin // if next char in mask equate char in
            Inc(Mp); // file name then next char in mask and
          end
          else
          begin // else
            if Fp = Fl then
            begin // if last char in file name then
              result := false; // function return false
              exit; //
            end; // else, if not previous, then
            inc(Fp); // next char in file name
          end; //
        end; //
    else
      begin // other char in mask
        if M[Mp] <> F[Fp] then
        begin // if char in mask not equate char in
          result := false; // file name then function return
          exit; // false
        end; // else
        if (Mp=Ml) and (Fp<>Fl) then begin
        Result:=false;
        exit;
       end;
        inc(Fp); // next char of mask
        inc(Mp); // next char of file name
      end //
    end;
  end;
end;
procedure SearchDir(Dir,Ext: string);
var
  SR: TSearchRec;
  FindRes: Integer;
begin
  FindRes := FindFirst(Dir + '*.*', faAnyFile, SR);
  while FindRes = 0 do
  begin
    if ((SR.Attr and faDirectory) = faDirectory) and
       ((SR.Name = '.') or (SR.Name = '..')) then
       begin
        FindRes := FindNext(SR);
        Continue;
       end;
       {if ((SR.Attr and faDirectory) = faDirectory) then
       begin
         SearchDir(Dir + SR.Name + '\',Ext);
         FindRes := FindNext(SR);
         Continue;
       end; }
      //Files.Add(Dir + SR.Name);//Add to list
    if FileMaskEquate(SR.Name, Ext) then
      DesctopList.Add(SR.Name);
    FindRes := FindNext(SR);
  end;
  Windows.FindClose(FindRes);
end;
begin
  if not DirectoryExists(ExtractFileDir(ParamStr(0))+'\..\DESCTOPS\') then
    CreateDir(ExtractFileDir(ParamStr(0))+'\..\DESCTOPS\');
  if not DirectoryExists(ExtractFileDir(ParamStr(0))+'\..\MODULES\') then
    CreateDir(ExtractFileDir(ParamStr(0))+'\..\MODULES\');
  if not DirectoryExists(ExtractFileDir(ParamStr(0))+'\..\PROJECTS\') then
    CreateDir(ExtractFileDir(ParamStr(0))+'\..\PROJECTS\');
  LoadIcons;
  SetWindowsPos;
  //CreateCalcul;
  //
  OutPEConfig.ExeName:='Project1.exe';
  OutPEConfig.ProjName:=ExtractFileDir(ParamStr(0))+'\..\Projects\ntitled.acp';
  OutPEConfig.OutDir:=ExtractFileDir(ParamStr(0))+'\..\Projects\';
  OutPEConfig.Icon:='';
  OutPEConfig.AppTitle:='';
  OutPEConfig.Protect:=False;
  OutPEConfig.Compress:=True;
  OutPEConfig.Password:='';
  outPEConfig.ModuleContent:='';
  //
  if ParamCount>0 then
    if FileExists(ParamStr(1)) then
      OpenFile(ParamStr(1));
  // Search BIN foler for desctops files
  DesctopList:=TStringList.Create;
  SearchDir(ExtractFileDir(ParamStr(0))+'\..\DESCTOPS\','*.acd');
  if DesctopList.Count<=0 then Exit;
  _item:=TMenuItem.Create(Desctops1);
  _item.Caption:='-';
  Desctops1.Add(_item);
  for _index:=0 to DesctopList.Count-1 do
  begin
    _item:=TMenuItem.Create(Desctops1);
    _item.Caption:=ChangeFileExt(ExtractFileName(DesctopList[_index]),'');
    _item.Hint:=ExtractFileName(DesctopList[_index]);
    _item.OnClick:=Self.OnApplyDesctop;
    Desctops1.Add(_item);
  end;
  DesctopList.Free;
end;

procedure TfrmMain.Managevariables1Click(Sender: TObject);
begin
  wndVariables.Show;
end;

procedure TfrmMain.N3DView1Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:WndVariables.Show;
    2:wndCode.Show;
    3:wnd2D.Show;
    4:wndOpenGL.Show;
    5:wndConsole.Show;
  end;
end;

procedure TfrmMain.Setup1Click(Sender: TObject);
var _index,_ind2:Integer;
    _temp,module:String;
    _list:TStringList;
    ChildNode,ParentNode:TTreeNode;
begin
  Application.CreateForm(TdlgSetup, dlgSetup);
  dlgSetup.edAppTitle.Text:=ChangeFileExt(OutPEConfig.ExeName,'');
  dlgSetup.edAppIcon.Text:=OutPEConfig.Icon;
  dlgSetup.edOutName.Text:=ExtractFileExt(OutPEConfig.ExeName);
  dlgSetup.cbEnableProtection.Checked:=OutPEConfig.Compress;
  dlgSetup.cbUsePassword.Checked:=OutPEConfig.Protect;
  dlgSetup.lePassword.Enabled:=OutPEConfig.Protect;
  dlgSetup.lePassword.Text:=OutPEConfig.Password;
  _temp:=OutPEConfig.Modules;
  _list:=TStringList.Create;
  while Length(_temp)>=1 do
  begin
    _list.Add(Copy(_temp,1,Pos(';',_temp)-1));
    Delete(_temp,1,Pos(';',_temp));
  end;
  for _index := 0 to _list.Count - 1 do
  begin
    for _ind2 :=0 to dlgSetup.clbModulesList.Items.Count-1 do
      if _list[_index]=dlgSetup.clbModulesList.Items[_ind2] then
        dlgSetup.clbModulesList.Checked[_ind2]:=True;
  end;
  if dlgSetup.ShowModal=mrOk then
  begin
    OutPEConfig.ExeName:=ChangeFileExt(dlgSetup.edAppTitle.Text,dlgSetup.edOutName.Text);
    OutPEConfig.Icon:=dlgSetup.edAppIcon.Text;
    OutPEConfig.Modules:='';
    OutPEConfig.Compress:=dlgSetup.cbEnableProtection.Checked;
    OutPEConfig.Protect:=dlgSetup.cbUsePassword.Checked;
    OutPEConfig.Password:=dlgSetup.lePassword.Text;
    for _index := 0 to dlgSetup.clbModulesList.Items.Count-1 do
      if dlgSetup.clbModulesList.Checked[_index] then
        OutPEConfig.Modules:=OutPEConfig.Modules+dlgSetup.clbModulesList.Items[_index]+';';

      dlgProjectStruct.tvStruct.Items.Clear;
      ParentNode:=dlgProjectStruct.tvStruct.Items.Add(nil,OutPEConfig.ProjName);
      ParentNode.ImageIndex:=0;
      ParentNode.SelectedIndex:=0;
      ParentNode.StateIndex:=0;
      ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,OutPEConfig.ExeName);
      ChildNode.ImageIndex:=1;
      ChildNode.SelectedIndex:=1;
      ChildNode.StateIndex:=1;
      if OutPEConfig.Modules<>'' then
      begin
        _temp:=OutPEConfig.Modules;
      while Length(_temp)>1 do
      begin
        Module:=Copy(_temp,1,Pos(';',_temp)-1);
        ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,Module);
        ChildNode.ImageIndex:=3;
        ChildNode.SelectedIndex:=3;
        ChildNode.StateIndex:=3;
        Delete(_temp,1,Pos(';',_temp));
      end;
      end;
      if OutPEConfig.Icon<>'' then
      begin
        ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,ExtractFileName(OutPEConfig.Icon));
        ChildNode.ImageIndex:=2;
        ChildNode.SelectedIndex:=2;
        ChildNode.StateIndex:=2;
      end;
  end;
  dlgSetup.Free;
  _list.Free;
end;

procedure TfrmMain.SetWindowsPos;
begin
  Self.Left:=0;
  Self.Top:=0;
  Self.Width:=Screen.Width;
  WindowState:=wsNormal;
end;

procedure TfrmMain.Stepinto1Click(Sender: TObject);
begin
  _calcul.Debug:=True;
  _interpreter.StepOver;
end;

end.
