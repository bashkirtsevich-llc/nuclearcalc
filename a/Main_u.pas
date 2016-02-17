unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Additional, uCalcul, Tabs, Menus, ClipBrd,
  About_u, Log_u, Setup_u, Registry, ComCtrls, PlatformDefaultStyleActnCtrls,
  ActnList, ActnMan, AppEvnts, ShellApi;

type
  TKeyBoard=(kbTrigonometric,kbHyperbolic,kbMath,kbNumeric,kbConstants,kbFunctions1,
             kbFunctions2,kbFunctions3,kbLogic);

type
  TfrmMain = class(TForm)
    gbAriphmetic: TGroupBox;
    sb7: TSpeedButton;
    sb8: TSpeedButton;
    sb9: TSpeedButton;
    sb4: TSpeedButton;
    sb5: TSpeedButton;
    sb6: TSpeedButton;
    sb1: TSpeedButton;
    sb2: TSpeedButton;
    sb3: TSpeedButton;
    sb0: TSpeedButton;
    sbZap: TSpeedButton;
    sbPoint: TSpeedButton;
    edResult: TEdit;
    btnClear: TSpeedButton;
    lbFuncResult: TLabel;
    lbEnterFunction: TLabel;
    sbAdd: TSpeedButton;
    sbSub: TSpeedButton;
    sbMul: TSpeedButton;
    sbDiv: TSpeedButton;
    sbEquals: TSpeedButton;
    gbKeyBoard: TGroupBox;
    tsKeyboards: TTabSet;
    _sb1: TSpeedButton;
    _sb2: TSpeedButton;
    _sb3: TSpeedButton;
    _sb4: TSpeedButton;
    _sb5: TSpeedButton;
    _sb6: TSpeedButton;
    _sb7: TSpeedButton;
    _sb8: TSpeedButton;
    _sb9: TSpeedButton;
    _sb10: TSpeedButton;
    _sb11: TSpeedButton;
    _sb12: TSpeedButton;
    sbPow: TSpeedButton;
    sbLeftBrckt: TSpeedButton;
    sbRightBrckt: TSpeedButton;
    mnuMain: TMainMenu;
    File1: TMenuItem;
    Clear1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Memory1: TMenuItem;
    Addtomemory1: TMenuItem;
    Memorylist1: TMenuItem;
    Clearvariables1: TMenuItem;
    Variablelist1: TMenuItem;
    Mode1: TMenuItem;
    N2D3Dplotter1: TMenuItem;
    IntegralComputer1: TMenuItem;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenDialog;
    Help1: TMenuItem;
    Help2: TMenuItem;
    About1: TMenuItem;
    N3: TMenuItem;
    Tray: TTrayIcon;
    TrayMenu: TPopupMenu;
    Restore1: TMenuItem;
    N4: TMenuItem;
    Exit2: TMenuItem;
    N5: TMenuItem;
    ShowHidelog1: TMenuItem;
    N6: TMenuItem;
    Cofiguration1: TMenuItem;
    Setup1: TMenuItem;
    N7: TMenuItem;
    Language1: TMenuItem;
    memFunc: TMemo;
    pmMemFunc: TPopupMenu;
    Cut1: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Delete1: TMenuItem;
    N8: TMenuItem;
    Selectall1: TMenuItem;
    amHotKeys: TActionManager;
    CalculateAction: TAction;
    ReturnAction: TAction;
    Numercialrowcomputer1: TMenuItem;
    procedure OnKeyClick(Sender:TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure sbEqualsClick(Sender: TObject);
    procedure _sb1Click(Sender: TObject);
    procedure tsKeyboardsChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure Variablelist1Click(Sender: TObject);
    procedure Clearvariables1Click(Sender: TObject);
    procedure Addtomemory1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure N2D3Dplotter1Click(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure TrayDblClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure IntegralComputer1Click(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure ShowHidelog1Click(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure Selectall1Click(Sender: TObject);
    procedure pmMemFuncPopup(Sender: TObject);
    procedure ReturnActionExecute(Sender: TObject);
    procedure CalculateActionExecute(Sender: TObject);
    procedure memFuncKeyPress(Sender: TObject; var Key: Char);
    procedure Numercialrowcomputer1Click(Sender: TObject);
  private
    _Calcul:TCalcul;
    procedure MyVariable(sender:Tobject;const VariableName:string;var VariableValue: variant; var Handled:boolean; Index:integer=0);
    function Calculate(_Formule:String):string;
    procedure ShowVariables;
    procedure SetKeyBoard(KeyBrd:TKeyBoard);
    procedure OnMemoryLoad(Sender:TObject);
    procedure SaveToFile(FileName:String; _SaveBuff:Boolean);
    procedure LoadFromFile(FileName:String);
    procedure WMMINIMIZE(var msg:TMessage); message WM_SYSCOMMAND;
    procedure ReadWindowPos;
    procedure WriteWindowPos;
    procedure WMMOVE(var msg:TMessage); message WM_NCMOUSEMOVE;
    procedure WMHOTKEY(var msg:TMessage); message WM_HOTKEY;
    procedure LoadSkin(SkinName:string);
    procedure LoadLanguage(_fileName:string);
    procedure OnLanguageSelect(Sender:TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

{type
  TResult=packed record
    Value:Extended;
    _isFunctionExists:Boolean;
  end; }

{type
  TInputMode=(imCalculate,imClear,imReturn); }

type
  TFunction=packed record
    _Function:ShortString;
    _Variables:ShortString;
  end;

type
  TFileHead=packed record
    _Sign:Array [0..2] of Char;
    _Version:Array [0..3] of Char;
    _SaveMemoryBuff:Boolean;
    _BuffCount:Byte;
    _Data:TFunction;
  end;

type
  TConfig=packed record
    _startupMode:byte;
    _ShowSplash,
    _ShowLogMemo,
    _RememberPos,
    _SaveLogData,
    _MoveLogWithMain,
    _UseAliases:boolean;
    _LogDir:string;
    _Aliase:string;
    _CalculateReturn,
    _return:integer;
    _AutoClear,
    _CalculateAndReturn:boolean;
    _language:string;
  end;

const
  Trigononetric:array [0..10] of ShortString=
  ('Sin','Cos','Tg','Sec',
   'ArcSin','ArcCos','ArcTg','ArcCtg',
   'CoSec','ArcSec','ArcCoSec'
  );

  Hiperbolic:array [0..11] of ShortString=
  ('Sh','Ch','Th','CTh',
   'SCh','CSh','ArSh','ArCh',
   'ArTh','ArCTh','ArSCh','ArCSCh'
  );

  Mathematic:array [0..5] of ShortString=
  ('Sqrt','Ln','Log','Sqr',
   'Exp', 'Abs'
  );

  Numercial:array [0..6] of ShortString=
  ('Int','Round','Sign','Random',
   'Factor','Integral','RowSumm'
  );

  Constants:array [0..6] of SHortString=
  ('_LF','_TB','_PI','_E',
   '_NOW','_TIME','_DATE'
  );

  Functions1:array [0..11] of ShortString=
  ('Replace','Pos','Prefix','Frac',
   'FreeVar','String','StampToDateStr','StampToTimeStr',
   'StampToStr','StrToStamp','Trunc','Trim'
  );

  Functions2:array [0..11] of ShortString=
  ('TrimLeft','TrimRight','Ascii','AvgVal',
   'Lower','Logic','Length','LastDay',
   'Eval','ExistVar','Upper','Delete'
  );

  Functions3:array [0..4] of ShortString=
  ('MaxVal','MinVal','Iff','Insert',
   'BaseNum'
  );

  Logic:array [0..7] of ShortString=
  ('And','Not','Div',
   'Mod','Or','In','Like',
   'Lf'
  );

  HK_HIDE_RESTORE : integer = 1;
  HK_CHANGE_MODE  : integer = 2;
  
  function ReadConfig:TConfig;
  procedure WriteConfig(Config_info:TConfig);

var
  frmMain: TfrmMain;
  Buff:Array [0..100] of TFunction;
  Index:Byte;
  Variables:String;
  _mode:Byte;
  Config:TConfig;
  Mask:TBitmap;
  ForeGround:TBitmap;
  _num:boolean;

  _msgBoxCaptions : array [0..3] of string;
  _messages : array [0..3] of string;
  _buttons : array [0..2] of string;
  _captions : array [0..33] of string;

const
  ConfigKey='Software\MADMAN Software\AC';
  _error=0;
  _alert=1;
  _warning=2;
  _question=3;

implementation

uses Variables_u, CombineMain_u, Integral_u, Num_row_u;

{$R *.dfm}

function NumLockState:boolean;
var keyState: TKeyboardState;
begin
  GetKeyboardState(keyState);
  Result  :=  ((keyState[VK_NUMLOCK] and 1)=1);
end;

procedure SetNumLock(bState: boolean);
var keyState: TKeyboardState;
begin
  GetKeyboardState(keyState);
  if (bState and ((keyState[VK_NUMLOCK] and 1)=0)) or
     (not bState and ((keyState[VK_NUMLOCK] and 1)=1)) then
    begin
      keybd_event( VK_NUMLOCK, 0, KEYEVENTF_EXTENDEDKEY, 0 );
      keybd_event( VK_NUMLOCK, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
    end;
end;

function PointInRect(P:Tpoint; Rect:TRect):boolean;
begin
  Result:=((P.X >= Rect.Left)and(P.X <= Rect.Right))and((P.Y >= Rect.Top)and(P.Y <= Rect.Bottom));
end;

function ReadConfig:TConfig;
var reg:TRegistry;
    function ReadInteger(Section:string;Default:integer):integer;
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CURRENT_USER;
      Reg.OpenKey('Software\MADMAN Software\AC',True);
      try
        Result:=Reg.ReadInteger(Section);
      except
        Reg.WriteInteger(Section,Default);
        Result:=Default;
      end;
      Reg.Free;
    end;
    function ReadBool(Section:string;Default:Boolean):Boolean;
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CURRENT_USER;
      Reg.OpenKey('Software\MADMAN Software\AC',True);
      try
        Result:=Reg.ReadBool(Section);
      except
        Reg.WriteBool(Section,Default);
        Result:=Default;
      end;
      Reg.Free;
    end;
    function ReadString(Section:string;Default:String):string;
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CURRENT_USER;
      Reg.OpenKey('Software\MADMAN Software\AC',True);
      try
        Result:=Reg.ReadString(Section);
        if Result='' then
        begin
          Reg.WriteString(Section,Default);
          Result:=Default;
        end;
      except
        Reg.WriteString(Section,Default);
        Result:=Default;
      end;
      Reg.Free;
    end;
begin
  Result._startupMode:=0;
  Result._ShowSplash:=True;
  Result._ShowLogMemo:=True;
  Result._RememberPos:=False;
  Result._SaveLogData:=False;
  Result._MoveLogWithMain:=True;
  Result._UseAliases:=False;
  Result._LogDir:=ExtractFileDir(ParamStr(0))+'\..\HISTORY\';
  Result._Aliase:='Result';
  Result._CalculateReturn:=16397;
  Result._return:=13;
  Result._AutoClear:=False;
  Result._CalculateAndReturn:=False;

  Result._startupMode   :=ReadInteger('Run_Mode',Result._startupMode);
  Result._ShowSplash    :=ReadBool('Splash_show',Result._ShowSplash);
  Result._ShowLogMemo   :=ReadBool('Show_Log',Result._ShowLogMemo);
  Result._RememberPos   :=ReadBool('Remember_Pos',Result._RememberPos);
  Result._SaveLogData   :=ReadBool('Save_LogData',Result._SaveLogData);
  Result._LogDir        :=ReadString('Log_Path',Result._LogDir);
  Result._MoveLogWithMain:=ReadBool('Move_Log',Result._MoveLogWithMain);
  Result._UseAliases    :=ReadBool('Use_Aliasaes',Result._UseAliases);
  Result._Aliase        :=ReadString('Aliase',Result._Aliase);
  Result._CalculateReturn:=ReadInteger('Calculate_return',Result._CalculateReturn);
  Result._return        :=ReadInteger('Return',Result._return);
  Result._AutoClear     :=ReadBool('Auto_Clear',Result._AutoClear);
  Result._CalculateAndReturn:=ReadBool('Return_Compute',Result._CalculateAndReturn);
  Result._language      := ReadString('Language','English.dll');
end;

procedure WriteConfig(Config_info:TConfig);
var reg:TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.OpenKey(ConfigKey,True);
  reg.WriteInteger('Run_Mode',Config_info._startupMode);
  reg.WriteBool('Splash_show',Config_info._ShowSplash);
  reg.WriteBool('Show_Log',Config_info._ShowLogMemo);
  reg.WriteBool('Remember_Pos',Config_info._RememberPos);
  reg.WriteBool('Save_LogData',Config_info._SaveLogData);
  reg.WriteBool('Move_Log',Config_info._MoveLogWithMain);
  reg.WriteString('Log_Path',Config_info._LogDir);
  reg.WriteString('Aliase',Config_info._Aliase);
  reg.WriteBool('Use_Aliasaes',Config_info._UseAliases);
  reg.WriteInteger('Calculate_return',Config_info._CalculateReturn);
  reg.WriteInteger('Return',Config_info._return);
  reg.WriteBool('Auto_Clear',Config_info._AutoClear);
  reg.WriteBool('Return_Compute',Config_info._CalculateAndReturn);
  reg.WriteString('Language',Config_info._language);
  reg.CloseKey;
  reg.Free;
end;

procedure TfrmMain.WMMINIMIZE(var msg: TMessage);
begin
  if msg.WParam = SC_MINIMIZE then
  begin
    Tray.Visible:=True;
    Self.Hide;
    wndLog.Hide;
    Exit;
  end;
  inherited;
end;

procedure TfrmMain.ReadWindowPos;
var reg:TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.OpenKey(ConfigKey,True);
  try
    if reg.ReadBool('Remember_Pos') then
    begin
      Self.Left:=reg.ReadInteger('Left');
      Self.Top:=reg.ReadInteger('Top');
    end else
    begin
      Self.Left:=(Screen.Width div 2)-(Self.Width div 2);
      Self.Top:=(Screen.Height div 2)-(Self.Height div 2);
    end;
  except
    Self.Left:=(Screen.Width div 2)-(Self.Width div 2);
    Self.Top:=(Screen.Height div 2)-(Self.Height div 2);
  end;
  reg.CloseKey;
  reg.Free;
end;

procedure TfrmMain.ReturnActionExecute(Sender: TObject);
var TextBefore, TextAfter:string;
    _ss,_sl:integer;
begin
  _ss := memFunc.SelStart;
  _sl := memFunc.SelLength;
  TextBefore := Copy(memFunc.Text,1,_ss);
  TextAfter  := Copy(memFunc.Text,_ss+_sl+1,Length(memFunc.Text));
  memFunc.Text:=TextBefore+#13#10+TextAfter;
  memFunc.SelStart:=_ss+2;
{  memFunc.Text:=memFunc.Text+#13#10;
  memFunc.SelStart:=Length(memFunc.Text); }
end;

procedure TfrmMain.WriteWindowPos;
var reg:TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.OpenKey(ConfigKey,True);
  reg.WriteInteger('Left',Self.Left);
  reg.WriteInteger('Top',Self.Top);
  reg.CloseKey;
  reg.Free;
end;

procedure TfrmMain.WMMOVE(var msg: TMessage);
begin
  if msg.WParam = HTCAPTION then
  begin
    if not Config._MoveLogWithMain then
      Exit;
    wndLog.Left:=Self.Left;
    wndLog.Top:=Self.Top+Self.Height; //FUCK
  end;
  inherited;
end;

procedure TfrmMain.WMHOTKEY(var msg: TMessage);
begin
  case msg.WParam of
    1:begin
      if (visible)and(NumLockState) then perform(WM_SYSCOMMAND, SC_MINIMIZE, 0)
      else TrayDblClick(Self);
    end;
    2: if Active then N2D3Dplotter1Click(Self);
  end;
  if Config._ShowLogMemo then
  begin
    wndLog.Left:=Self.Left;
    wndLog.Width:=Self.Width;
    wndLog.Top:=Self.Top+Self.Height;
  end;
end;

procedure TfrmMain.LoadSkin(SkinName: string);
{type TSkinHead = packed record
    _signature:array [0..2] of Char;
    _version:array [0..4] of Char;
    _hideMenu,
    _hideControls,
    _hideFuncMemo,
    _hideResultEd,
    _hideFuncPad:boolean;
    _formStyle:TFormStyle;
    _maskSize,
    _foreGroundSize:DWORD;
  end;
const Sign = 'ACS';
      Ver  = 'v1.0.';
var SkinStream:TFileStream;
    Temp:TStream;
    Head:TSkinHead;
label _quit; }
begin
{  if (not FileExists(SkinName)) then Exit;
  SkinStream:=TFileStream.Create(SkinName,fmOpenRead);
  SkinStream.Read(Head,SizeOf(TSkinHead));
  if (Head._signature<>Sign)or(Head._version<>Ver) then goto _quit;
  Self.FormStyle := Head._formStyle;
  //
  Temp := TMemoryStream.Create;
  Temp.CopyFrom(SkinStream,Head._maskSize);
  Temp.Position:=0;
  if Temp.Size > 0 then
  begin
    Mask := TBitmap.Create;
    Mask.LoadFromStream(Temp);
  end;
  Temp.Free;
  //
  Temp := TMemoryStream.Create;
  Temp.CopyFrom(SkinStream,Head._foreGroundSize);
  Temp.Position:=0;
  if Temp.Size > 0 then
  begin
    ForeGround := TBitmap.Create;
    ForeGround.LoadFromStream(Temp);
  end;
  Temp.Free;
  gbKeyBoard.Visible      := not Head._hideFuncPad;
  tsKeyboards.Visible     := not Head._hideFuncPad;
  gbAriphmetic.Visible    := not Head._hideControls;
  memFunc.Visible         := not Head._hideFuncMemo;
  edResult.Visible        := not Head._hideResultEd;
  btnClear.Visible        := not Head._hideControls;
  lbFuncResult.Visible    := not Head._hideResultEd;
  lbEnterFunction.Visible := not Head._hideFuncMemo;
  //
_quit:;
  SkinStream.Free; }
end;

procedure TfrmMain.Save1Click(Sender: TObject);
var SaveBuff:Boolean;
begin
  if not dlgSave.Execute(Handle) then Exit;
  if ExtractFileExt(UpperCase(dlgSave.FileName))<>'.ACM' then
    dlgSave.FileName:=dlgSave.FileName+'.acm';
  SaveBuff:=MessageBox(Handle,PChar(_messages[0]),PChar(_msgBoxCaptions[_question]),MB_YESNO+MB_ICONQUESTION)=ID_YES;
  SaveToFile(dlgSave.FileName,SaveBuff);
end;

procedure TfrmMain.SaveToFile(FileName:String; _SaveBuff:Boolean);
var SaveStream:TMemoryStream;
    Temp:TFileHead;
    _Index:Byte;
const
  _Signature:Array [0..2] of Char = ('A','C','M');
  _Version:Array [0..3] of Char = ('1','.','0','0');
  procedure CopyArray(_in:array of char; var _out:array of char);
  var c:integer;
  begin
    for c:=0 to SizeOf(_in) do
      _out[c]:=_in[c];
  end;
begin
  CopyArray(_Signature,Temp._Sign);
  CopyArray(_Version,Temp._Version);
  Temp._SaveMemoryBuff:=_SaveBuff;
  Temp._Data._Function:=memFunc.Text;
  Temp._Data._Variables:=_Calcul.Variables;
  Temp._BuffCount:=Index;
  SaveStream:=TMemoryStream.Create;
  SaveStream.Write(Temp,SizeOf(TFileHead));
  if Temp._SaveMemoryBuff then
    for _Index:=0 to Temp._BuffCount do
      SaveStream.Write(Buff[_Index],SizeOf(TFunction));
  SaveStream.SaveToFile(FileName);
  SaveStream.Free;
end;

procedure TfrmMain.LoadFromFile(FileName:String);
var FileStream:TFileStream;
    Temp:TFileHead;
    _Index:Byte;
begin
  FileStream:=TFileStream.Create(FileName,fmOpenRead);
  try
    FileStream.Read(Temp,SizeOf(TFileHead));
    if (Temp._Sign <> 'ACM') or (Temp._Version <> '1.00') then
      raise Exception.Create('Cant open file');
    if Temp._SaveMemoryBuff then
    begin
      for _Index:=0 to Temp._BuffCount do
        FileStream.Read(Buff[_Index],SizeOf(TFunction));
      Index:=Temp._BuffCount;
    end;
    MemFunc.Text:=Temp._Data._Function;
    _Calcul.Variables:=Temp._Data._Variables;
  except
    MessageBox(Handle,PChar(_messages[1]),PChar(_msgBoxCaptions[_error]),MB_OK+MB_ICONSTOP);
  end;
  FileStream.Free;
end;

procedure TfrmMain.memFuncKeyPress(Sender: TObject; var Key: Char);
begin
  if (Integer(Key) = Config._return) then Key:=#0;
end;

procedure TfrmMain.MyVariable(sender:Tobject;const VariableName:string;var VariableValue: variant; var Handled:boolean; Index:integer=0);
begin
  if LowerCase(VariableName)='pi' then
    VariableValue := Pi;
  if LowerCase(VariableName)='e' then
    VariableValue := Exp(1);
  Handled:=true;
end;

procedure TfrmMain.N2D3Dplotter1Click(Sender: TObject);
begin
  application.Tag:=2;
  Close;
end;

procedure TfrmMain.Numercialrowcomputer1Click(Sender: TObject);
begin
  if dlgRow = nil then
    Application.CreateForm(TdlgRow,dlgRow);
  dlgRow.Show{Modal};
  //dlgRow
end;

procedure TfrmMain.ShowHidelog1Click(Sender: TObject);
begin
  wndLog.Visible := not wndLog.Visible;
end;

procedure TfrmMain.ShowVariables;
var _temp:string;
    Index:Word;
begin
  Application.CreateForm(TwndVariables,wndVariables);
  wndVariables.btnOk.Caption := _buttons[0];
  wndVariables.btnCancel.Caption := _buttons[1];
  wndVariables.btnAdd.Caption := _buttons[2];

  wndVariables.Caption := _captions[0];
  wndVariables.lvVars.Column[0].Caption := _captions[1];
  wndVariables.lvVars.Column[1].Caption := _captions[2];
  wndVariables.Addvariable1.Caption := _captions[3];
  wndVariables.Deletevariable1.Caption := _captions[4];
  wndVariables._s1 := _captions[5];
  wndVariables._s2 := _captions[6];
  wndVariables._s3 := _captions[7];
  wndVariables._s4 := _captions[8];
  wndVariables._s5 := _captions[9];

  wndVariables.Variables:=_Calcul.Variables;
  wndVariables.parse;
  If wndVariables.ShowModal = mrOk Then
    begin
      _temp:='';
      for Index:=0 to wndVariables.lvVars.Items.Count-1 do
        _temp:=_temp+wndVariables.lvVars.Items[Index].Caption+'='+
                     wndVariables.lvVars.Items[Index].SubItems[0]+
                     #13#10;
      _Calcul.Variables:=_temp;
    end;
  wndVariables.Free;
end;

procedure TfrmMain.IntegralComputer1Click(Sender: TObject);
begin
  if dlgIntegral = nil then
    Application.CreateForm(TdlgIntegral,dlgIntegral);
  dlgIntegral.Show{Modal};
  //dlgIntegral.Free;
end;

procedure TfrmMain.TrayDblClick(Sender: TObject);
begin
  Show;
  wndLog.Show;
  Tray.Visible:=False;
end;

procedure TfrmMain.tsKeyboardsChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  SetKeyBoard(TKeyBoard(NewTab));
end;

procedure TfrmMain.Variablelist1Click(Sender: TObject);
begin
  ShowVariables;
end;

procedure TfrmMain._sb1Click(Sender: TObject);
var Symbol:String;
    _cursorpos:Integer;
    Temp,temp2:String;
    StepBack:Byte;
    function IsLogic(s:string):Boolean;
    var Temp:String;
    begin
      Temp:=UpperCase(s);
      Result:=(Temp='AND')or(Temp='NOT')or(Temp='OR')or(Temp='DIV')or(Temp='MOD')
        or(Temp='IN')or(Temp='LIKE')or(Temp='LF');
    end;
begin
  Symbol:=(Sender as TSpeedButton).Caption;
  if (Symbol[1]<>'_') and (not IsLogic(Symbol)) then
    begin
      Symbol:=Symbol+'()';
      StepBack:=1;
    end else
      StepBack:=0;
  SendMessage(memFunc.Handle, EM_GETSEL, LongInt(@_cursorpos), 0);
  Try
    Temp:=Copy(memFunc.Text,1,_cursorpos);
    Temp2:=Copy(memFunc.Text,_cursorpos+1,Length(memFunc.Text));
    memFunc.Clear;
  Finally
    memFunc.Text:=Temp+Symbol+Temp2;
  End;
  SendMessage(memFunc.Handle, EM_SETSEL, _cursorpos+Length(Symbol)-StepBack, _cursorpos+Length(Symbol)-StepBack);
end;

procedure TfrmMain.About1Click(Sender: TObject);
begin
  Application.CreateForm(TdlgAbout,dlgAbout);
  dlgAbout.btnOk.Caption := _buttons[0];
  dlgAbout.ShowModal;
  dlgAbout.Free;
end;

procedure TfrmMain.Addtomemory1Click(Sender: TObject);
var SubItem:TMenuItem;
begin
  SubItem:=TMenuItem.Create(Memorylist1);
  Memorylist1.Add(SubItem);
  SubItem.Tag:=Index;
  SubItem.Caption:=Format('%d. "%s"...',[Index+1,Copy(memFunc.Text,1,5)]);
  SubItem.OnClick:=OnMemoryLoad;
  Buff[Index]._Function:=MemFunc.Text;
  Buff[Index]._Variables:=_calcul.Variables;
  Inc(Index);
end;

procedure TfrmMain.OnMemoryLoad(Sender:TObject);
var _i:byte;
begin
  _i:=(Sender as TMenuItem).Tag;
  MemFunc.Text:=Buff[_i]._Function;
  _calcul.Variables:=Buff[_i]._Variables;
end;

procedure TfrmMain.Open1Click(Sender: TObject);
begin
  if not dlgOpen.Execute(Handle) then Exit;
  LoadFromFile(dlgOpen.FileName);
  Caption:=Format('[Atomic Calculator] - "%s"',[ExtractFileName(dlgOpen.FileName)]);
end;

procedure TfrmMain.Paste1Click(Sender: TObject);
var _tempText:String;
begin
  case (Sender as TMenuItem).Tag of
    1:Clipboard.AsText:=memFunc.Text+'|'+_Calcul.Variables;
    2:begin
        _tempText:=Clipboard.AsText;
        _Calcul.Variables:=(Copy(_tempText,Pos('|',_tempText)+1,Length(_tempText)));
        memFunc.Text:=(Copy(_tempText,1,Pos('|',_tempText)-1));
      end;
  end;
end;

procedure TfrmMain.pmMemFuncPopup(Sender: TObject);
begin
  Selectall1.Enabled:=(Length(memFunc.Text)>0);
  Cut1.Enabled:=(memFunc.SelLength>0);
  Copy2.Enabled:=(memFunc.SelLength>0);
  Delete1.Enabled:=(memFunc.SelLength>0);
end;

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  //showmessage(self.Components[41].name);
  memFunc.Clear;
  edResult.Clear;
end;

procedure TfrmMain.Selectall1Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:memFunc.CutToClipboard;
    2:memFunc.CopyToClipboard;
    3:memFunc.PasteFromClipboard;
    4:memFunc.SelText:='';
    5:memFunc.SelectAll;
  end;
end;

procedure TfrmMain.SetKeyBoard(KeyBrd: TKeyBoard);
var TempKeyBrd:Array[0..11]of ShortString;
    Count:Byte;
    //_max:Byte;
    function CopyArray(_in:array of shortstring;var _out:array of shortstring):Byte;
    var _i:Byte;
    begin
      for _i:=0 to High(_in) do
        _out[_i]:=_in[_i];
      Result:=High(_in);
    end;
const _stepBack=26;
begin
  for Count:=Low(TempKeyBrd) to High(TempKeyBrd) do
    TempKeyBrd[Count]:='';
  case KeyBrd of
    kbTrigonometric: {_max:=}CopyArray(Trigononetric,TempKeyBrd);
    kbHyperbolic: {_max:=}CopyArray(Hiperbolic,TempKeyBrd);
    kbMath: {_max:=}CopyArray(Mathematic,TempKeyBrd);
    kbNumeric: {_max:=}CopyArray(Numercial,TempKeyBrd);
    kbConstants: {_max:=}CopyArray(Constants,TempKeyBrd);
    kbFunctions1: {_max:=}CopyArray(Functions1,TempKeyBrd);
    kbFunctions2: {_max:=}CopyArray(Functions2,TempKeyBrd);
    kbFunctions3: {_max:=}CopyArray(Functions3,TempKeyBrd);
    kbLogic: {_max:=}CopyArray(Logic,TempKeyBrd);        
  end;
  for Count := 0 to 11 do
    begin
      (Self.Components[Count+_stepBack] as TSpeedButton).Enabled:=True;
      (Self.Components[Count+_stepBack] as TSpeedButton).Caption:=TempKeyBrd[Count];
      if TempKeyBrd[Count]='' then
        (Self.Components[Count+_stepBack] as TSpeedButton).Enabled:=False;
    end;
    
end;

procedure TfrmMain.Setup1Click(Sender: TObject);
begin
  Application.CreateForm(TdlgSetup,dlgSetup);
  dlgSetup.btnOk.Caption := _buttons[0];
  dlgSetup.btnCancel.Caption := _buttons[1];
  //
  dlgSetup.Caption := _captions[10];
  dlgSetup.tsStartup.Caption := _captions[11];
  dlgSetup.tsLog.Caption := _captions[12];
  dlgSetup.tsKeys.Caption := _captions[13];
  dlgSetup.tsAliases.Caption := _captions[14];
  dlgSetup.gbStartupMode.Caption := _captions[15];
  dlgSetup.lbMode.Caption := _captions[16];
  dlgSetup.cbRunMode.Items[0] := _captions[17];
  dlgSetup.cbRunMode.Items[1] := _captions[18];
  dlgSetup.cbSplash.Caption := _captions[19];
  dlgSetup.cbDisplayLogMemo.Caption := _captions[20];
  dlgSetup.cbRememberRestoreWindowsPos.Caption := _captions[21];
  dlgSetup.gbLogConfig.Caption := _captions[22];
  dlgSetup.cbSaveLogData.Caption := _captions[23];
  dlgSetup.lbSaveDir.Caption := _captions[24];
  dlgSetup.cbMoveLog.Caption := _captions[25];
  dlgSetup.gbKeys.Caption := _captions[26];
  dlgSetup.lbCalculate.Caption := _captions[27];
  dlgSetup.lbReturnAction.Caption := _captions[28];
  dlgSetup.cbClearAfterCompute.Caption := _captions[29];
  dlgSetup.cbReturnAfterCompute.Caption := _captions[30];
  dlgSetup.gbAliases.Caption := _captions[31];
  dlgSetup.cbEnableAliases.Caption := _captions[32];
  dlgSetup.lbAliaseName.Caption := _captions[33];
  //
  Config:=ReadConfig;
  dlgSetup.cbRunMode.ItemIndex:=Config._startupMode;
  dlgSetup.cbSplash.Checked:=Config._ShowSplash;
  dlgSetup.cbDisplayLogMemo.Checked:=Config._ShowLogMemo;
  dlgSetup.cbRememberRestoreWindowsPos.Checked:=Config._RememberPos;
  dlgSetup.cbSaveLogData.Checked:=Config._SaveLogData;
  dlgSetup.edSaveFolder.Text:=Config._LogDir;
  dlgSetup.cbMoveLog.Checked:=Config._MoveLogWithMain;
  dlgSetup.cbEnableAliases.Checked:=Config._UseAliases;
  dlgSetup.edAliaseName.Text:=Config._Aliase;
  dlgSetup.hkCalculate.HotKey:=Config._CalculateReturn;
  dlgSetup.hkReturn.HotKey:=Config._return;
  dlgSetup.cbClearAfterCompute.Checked:=Config._AutoClear;
  dlgSetup.cbReturnAfterCompute.Checked:=Config._CalculateAndReturn;
  if dlgSetup.ShowModal=mrOk then
  begin
    Config._startupMode:=dlgSetup.cbRunMode.ItemIndex;
    Config._ShowSplash:=dlgSetup.cbSplash.Checked;
    Config._ShowLogMemo:=dlgSetup.cbDisplayLogMemo.Checked;
    Config._RememberPos:=dlgSetup.cbRememberRestoreWindowsPos.Checked;
    Config._SaveLogData:=dlgSetup.cbSaveLogData.Checked;
    Config._LogDir:=dlgSetup.edSaveFolder.Text;
    Config._MoveLogWithMain:=dlgSetup.cbMoveLog.Checked;
    Config._UseAliases:=dlgSetup.cbEnableAliases.Checked;
    Config._Aliase:=dlgSetup.edAliaseName.Text;
    Config._CalculateReturn:=dlgSetup.hkCalculate.HotKey;
    Config._return:=dlgSetup.hkReturn.HotKey;
    CalculateAction.ShortCut:=Config._CalculateReturn;
    ReturnAction.ShortCut:=Config._return;
    Config._AutoClear:=dlgSetup.cbClearAfterCompute.Checked; //Addon
    Config._CalculateAndReturn:=dlgSetup.cbReturnAfterCompute.Checked;
    WriteConfig(Config);
    if Config._MoveLogWithMain then
      wndLog.HideTitleBar
    else
      wndLog.ShowTitleBar;
  end;
  dlgSetup.Free;
  Config:=ReadConfig;
end;

function TfrmMain.Calculate(_Formule: string):string;
var HalfResult:String;
begin
  If _Formule='' Then
    Begin
      Result:='';
      Exit;
    End;
  _Calcul.Formula:=_Formule;
  HalfResult:=_Calcul.Calc();
  Result:=HalfResult;
  Variables:=_Calcul.Variables;
  If _Calcul.CalcError Then
    Begin
      Result:=_messages[2]+ ':' + _Calcul.CalcErrorText;
    End;
end;

procedure TfrmMain.CalculateActionExecute(Sender: TObject);
begin
  sbEqualsClick(Sender);
  if Config._CalculateAndReturn then
    ReturnActionExecute(Sender);
  if Config._AutoClear then
    memFunc.Clear;
end;

procedure TfrmMain.Clearvariables1Click(Sender: TObject);
begin
  _calcul.Variables:='';
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.Exit2Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:begin
        Show;
        Tray.Visible:=False;
    end;
    2:Close;
  end;
end;

procedure TfrmMain.OnKeyClick(Sender: TObject);
var Symbol:String;
    _cursorpos:Integer;
    Temp,temp2:String;
begin
  Symbol:=(Sender as TSpeedButton).Caption;
  SendMessage(memFunc.Handle, EM_GETSEL, LongInt(@_cursorpos), 0);
  Try
    Temp:=Copy(memFunc.Text,1,_cursorpos);
    Temp2:=Copy(memFunc.Text,_cursorpos+1,Length(memFunc.Text));
    memFunc.Clear;
  Finally
    memFunc.Text:=Temp+Symbol+Temp2;
  End;
  SendMessage(memFunc.Handle, EM_SETSEL, _cursorpos+Length(Symbol), _cursorpos+Length(Symbol));
end;

procedure TfrmMain.sbEqualsClick(Sender: TObject);
var index,max:integer;
    temp:string;
    aliases:string;
begin
  max:=memFunc.Lines.Count;
  for index := 0 to max-1  do
  begin
    temp := memFunc.Lines[index];
    while Pos(';',temp)<>0 do
      Delete(temp,Pos(';',temp),1);
    if ((Config._UseAliases) and (Config._Aliase<>'')) then
    begin
      aliases:=Config._Aliase;
      if aliases[Length(aliases)]<>';' then aliases:=aliases+';';
      while aliases[1]=';' do Delete(aliases,1,1);
      edResult.Text:=Calculate(Format('%s:=(%s)',[Copy(aliases,1,Pos(';',aliases)-1),temp]));
      Delete(aliases,1,Pos(';',aliases));
      while Pos(';',aliases)<>0 do
      begin
        Calculate(Format('%s:=(%s)',[Copy(aliases,1,Pos(';',aliases)-1),edResult.Text]));
        Delete(aliases,1,Pos(';',aliases));
      end;
    end
    else
      edResult.Text:=Calculate(temp);
    wndLog.memLog.Lines.Add(Format(_messages[3],[temp,edResult.Text]));
  end;
  if Config._AutoClear then memFunc.Clear;
end;

procedure TfrmMain.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
{  NewWidth := 529;
  Resize := true; }
  if wndLog=nil then exit;
  if not Config._MoveLogWithMain then
      Exit;
  wndLog.Left:=Self.Left;
  wndLog.Width:=Self.Width;
  wndLog.Top:=Self.Top+Self.Height; //FUCK
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  function DateFormatToFileFormat(s:string):string;
  var s1:string;
      index:integer;
  begin
    s1:=s;
    for index:=1 to length(s1) do
      if s1[index]<>':' then
        Result:=Result+s[index];
  end;
var SaveDir:String;
begin
  if (Config._SaveLogData)and(wndLog.memLog.Lines.Count<>0) then
  begin
    SaveDir:=Config._LogDir;
    if SaveDir[Length(SaveDir)]<>'\' then
      SaveDir:=SaveDir+'\';
    SaveDir:=SaveDir+DateFormatToFileFormat(DateTimeToStr(Date+Time))+'.txt';
    wndLog.memLog.Lines.SaveToFile(SaveDir);
  end;
  if Config._RememberPos then
    WriteWindowPos;
end;

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
  _item:TMenuItem;
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
    if FileMaskEquate(SR.Name, Ext) then
    begin
      _item := TMenuItem.Create(frmMain.Language1);
      _item.Caption := ChangeFileExt(SR.Name,'');
      _item.Hint := SR.Name;
      _item.OnClick := frmMain.OnLanguageSelect;
      frmMain.Language1.Add(_item);
    end;
    FindRes := FindNext(SR);
  end;
  Windows.FindClose(FindRes);
end;


procedure TfrmMain.FormCreate(Sender: TObject);
begin
  _num := NumLockState;
  SetNumLock(true);
  RegisterHotKey(Handle, HK_HIDE_RESTORE, 0, VK_NUMLOCK);
  Self.Constraints.MinHeight:=305;
  Self.Constraints.MinWidth:=Width;
  Self.ScreenSnap := true;
  Self.SnapBuffer := 20;
  Config:=ReadConfig;
  CalculateAction.ShortCut:=Config._CalculateReturn;
  ReturnAction.ShortCut:=Config._return;
  SetKeyBoard(TKeyBoard(0));
  _Calcul:=TCalcul.Create;                    
  _Calcul.OnGetVariable:=MyVariable;
  SendMessage(edResult.Handle, EM_SETREADONLY, 1, 0);
  Index:=0;
  Tray.Icon.Handle:=Application.Icon.Handle;
  if not DirectoryExists(ExtractFileDir(ParamStr(0))+'\..\HISTORY\') then
    CreateDir(ExtractFileDir(ParamStr(0))+'\..\HISTORY\');
  LoadLanguage(Config._language);
  SearchDir(ExtractFileDir(ParamStr(0))+'\','*.DLL');
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  UnregisterHotKey(Handle, HK_HIDE_RESTORE);
  _Calcul.Free;
  wndLog.Free;
  SetNumLock(_num);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ReadWindowPos;
  if Config._ShowLogMemo then
    wndLog.FormShow(Self);
end;

procedure TfrmMain.Help2Click(Sender: TObject);
var HelpFolder:string;
begin
  HelpFolder := ExtractFileDir(ParamStr(0))+'\..\Help\';
  ShellExecute(Handle,'open',PChar(HelpFolder+'Help.chm'),nil,PChar(HelpFolder),SW_SHOW);
end;

procedure TfrmMain.LoadLanguage(_fileName: string);
var index:integer;
    _dllHandle:THandle;

    function GetCaption(ID:cardinal):string;
    var buff:array [0..$FF] of Char;
    begin
      Result := '';
      if LoadString(_dllHandle,ID,@buff,$FF) >0 then
        Result := buff;
    end;

begin
  if not FileExists(_fileName) then
    Exit;
  _dllHandle := LoadLibrary(PWideChar(_fileName));
  if _dllHandle = 0 then
    Exit;
  lbFuncResult.Caption := GetCaption(4);
  lbEnterFunction.Caption := GetCaption(3);
  for index := 41 to 70 do
    (Self.Components[index] as TMenuItem).Caption := GetCaption(index + 4-40) ;
  tsKeyboards.Tabs.Clear;
  for index := 35 to 43 do
    tsKeyboards.Tabs.Add(GetCaption(index));
  tsKeyboards.TabIndex  := 0;
  Restore1.Caption := GetCaption(44);
  Exit2.Caption := GetCaption(45);
  Cut1.Caption := GetCaption(46);
  Copy2.Caption := GetCaption(47);
  Paste2.Caption := GetCaption(48);
  Delete1.Caption := GetCaption(49);
  SelectAll1.Caption := GetCaption(50);
  for index := 51 to 54 do
    _msgBoxCaptions[index-51] := GetCaption(index);
  for index := 55 to 58 do
    _messages[index - 55] := GetCaption(index);
  for index := 59 to 61 do
    _buttons[index - 59] := GetCaption(index);
  for index := 62 to 95 do
    _captions[index-62] := GetCaption(index);
  FreeLibrary(_dllHandle);
end;

procedure TfrmMain.OnLanguageSelect(Sender: TObject);
begin
  Config._language := (Sender as TMenuItem).Hint;
  WriteConfig(Config);
end;

end.
