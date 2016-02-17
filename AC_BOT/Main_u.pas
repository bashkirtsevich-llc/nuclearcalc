unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ImgList, WinSock,
  KDSocket.Types,
  KDSocket.Utilites,
  JabberClient,
  JabberClient.Types,
  JabberClient.Tools,
  JabberClient.Rosters,
  ICQClient,
  ICQWorks, Buttons,
  Add_u, Menus;
  //uCalcul;

type
  TwndMain = class(TForm)
    tvMenu: TTreeView;
    spl1: TSplitter;
    pcMain: TPageControl;
    sbStatus: TStatusBar;
    tsMain: TTabSheet;
    tsConnection: TTabSheet;
    tsICQ: TTabSheet;
    tsJabber: TTabSheet;
    tsProxy: TTabSheet;
    tsMsgSending: TTabSheet;
    tsConfig: TTabSheet;
    tsHistory: TTabSheet;
    tsContactList: TTabSheet;
    tsRoster: TTabSheet;
    tsMessageLog: TTabSheet;
    ICQ_bunner: TShape;
    gbICQlogin: TGroupBox;
    cbUIN: TComboBox;
    edPassword: TEdit;
    lbUIN: TLabel;
    lbICQpassword: TLabel;
    btnICQConnect: TButton;
    btnICQDisconnect: TButton;
    btnICQApply: TButton;
    Jabber_bunner: TShape;
    gbJabberLogin: TGroupBox;
    cbDomain: TComboBox;
    edJabberPassword: TEdit;
    lbJID: TLabel;
    lbDomain: TLabel;
    lbJabberPass: TLabel;
    btnJabberConnect: TButton;
    btnJabberDisconnect: TButton;
    btnJabberApply: TButton;
    s: TShape;
    gbProxy: TGroupBox;
    cbProxyType: TComboBox;
    edAddress: TEdit;
    edPort: TEdit;
    cbAuthentificate: TCheckBox;
    edUserName: TEdit;
    edUserPassword: TEdit;
    lbProxyType: TLabel;
    lbProxyAddress: TLabel;
    lbProxyPort: TLabel;
    lbUserName: TLabel;
    lbUserPassword: TLabel;
    btnProxyApply: TButton;
    Connection_bunner: TShape;
    lvConnection: TListView;
    icons: TImageList;
    bev1: TBevel;
    Main_bunner: TShape;
    bevMain: TBevel;
    lvMain: TListView;
    imgMain: TImage;
    lbMainPage: TLabel;
    imgConnection: TImage;
    lbConnection: TLabel;
    imgICQ: TImage;
    lbICQ: TLabel;
    lbICQ2: TLabel;
    imgJabber: TImage;
    lbJabber: TLabel;
    lbJabber2: TLabel;
    imgProxy: TImage;
    lbProxy: TLabel;
    Label2: TLabel;
    MsgBunner: TShape;
    imgMsgSending: TImage;
    lbMessage: TLabel;
    lbMessage2: TLabel;
    gbMessage: TGroupBox;
    edDestination: TEdit;
    cbDeliveryType: TComboBox;
    memMsg: TMemo;
    lbHost: TLabel;
    lbMessageText: TLabel;
    btnSend: TButton;
    cbEnableProxy: TCheckBox;
    JabberTimer: TTimer;
    ICQTimer: TTimer;
    Config_bunner: TShape;
    imgConfig: TImage;
    lbConfig: TLabel;
    lbConfig2: TLabel;
    Roster_bunner: TShape;
    imgRoster: TImage;
    lbRoster: TLabel;
    lbRoster2: TLabel;
    bev2: TBevel;
    lvRoster: TListView;
    memLog: TMemo;
    Shape4: TShape;
    imgHistory: TImage;
    lbHistory: TLabel;
    lbHistory2: TLabel;
    bev3: TBevel;
    ContactList_bunner: TShape;
    imgContact: TImage;
    ICQcontact: TLabel;
    ICQcontact2: TLabel;
    bev4: TBevel;
    lvContact: TListView;
    lvHistoryMenu: TListView;
    pcConfig: TPageControl;
    tsICQconfig: TTabSheet;
    tsJabberConfig: TTabSheet;
    tsServiceConfig: TTabSheet;
    cbBotAvailable: TCheckBox;
    cbAutoClear: TCheckBox;
    cbAccount: TComboBox;
    gbAccount: TGroupBox;
    lbICQAccount: TLabel;
    lbAccUIN: TLabel;
    lbAccPass: TLabel;
    edAccUIN: TEdit;
    edAccPass: TEdit;
    btnAddUIN: TButton;
    btnAccSave: TButton;
    cbJabberAccount: TComboBox;
    gbJabber: TGroupBox;
    edAccJid: TEdit;
    edAccJabberPass: TEdit;
    lbJabberAcc: TLabel;
    lbAccJID: TLabel;
    edAccPassJabber: TLabel;
    btnSaveAcc: TButton;
    btnAddJabber: TButton;
    gbGeneral: TGroupBox;
    edCorePath: TEdit;
    btnOpenCore: TSpeedButton;
    lbCorePath: TLabel;
    dlgOpen: TOpenDialog;
    lbCoreInfo: TLabel;
    gbHistory: TGroupBox;
    cbSaveHistory: TCheckBox;
    cbSaveLoadContactList: TCheckBox;
    cbSaveLoadRoster: TCheckBox;
    edJID: TComboBox;
    Tray: TTrayIcon;
    mnuMain: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    procedure About1Click(Sender: TObject);
    procedure btnAccSaveClick(Sender: TObject);
    procedure btnAddJabberClick(Sender: TObject);
    procedure btnAddUINClick(Sender: TObject);
    procedure btnICQConnectClick(Sender: TObject);
    procedure btnICQDisconnectClick(Sender: TObject);
    procedure btnJabberConnectClick(Sender: TObject);
    procedure btnJabberDisconnectClick(Sender: TObject);
    procedure btnOpenCoreClick(Sender: TObject);
    procedure btnProxyApplyClick(Sender: TObject);
    procedure btnSaveAccClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure cbAccountChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbAuthentificateClick(Sender: TObject);
    procedure cbBotAvailableClick(Sender: TObject);
    procedure cbEnableProxyClick(Sender: TObject);
    procedure cbJabberAccountChange(Sender: TObject);
    procedure cbSaveHistoryClick(Sender: TObject);
    procedure cbSaveLoadContactListClick(Sender: TObject);
    procedure cbSaveLoadRosterClick(Sender: TObject);
    procedure cbUINSelect(Sender: TObject);
    procedure edCorePathKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edJIDSelect(Sender: TObject);
    procedure edPortKeyPress(Sender: TObject; var Key: Char);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ICQTimerTimer(Sender: TObject);
    procedure JabberTimerTimer(Sender: TObject);
    procedure lvConnectionDblClick(Sender: TObject);
    procedure lvConnectionKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure lvContactKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvHistoryMenuDblClick(Sender: TObject);
    procedure lvHistoryMenuKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure lvMainDblClick(Sender: TObject);
    procedure lvMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TrayDblClick(Sender: TObject);
    procedure tvMenuChange(Sender: TObject; Node: TTreeNode);
    procedure tvMenuClick(Sender: TObject);
  private
    CoreHandle:THandle;
    procedure _JabberConnect(Sender: TObject);
    procedure _JabberDisConnect(Sender: TObject);
    procedure _JabberConnectionError(Sender: TObject);
    procedure _JabberError(Sender: TObject; ErrorType: TErrorType_; ErrorMsg: String);
    procedure OnJabberSentMessage(Sender: TObject;
                                  Types : WideString;
                                  From : WideString;
                                  Body : UTF8String);             
    Procedure OnJabberSubscribe(Sender: TObject;
                                 From : WideString;
                                 var Action : Boolean);
    Procedure OnJabberUnsubscribed(Sender: TObject;
                                 From : WideString;
                                 var Action : Boolean);
    Procedure OnJabberRosterListLoaded(Sender: TObject);
    procedure OnICQConnectionFailed(Sender:TObject);
    procedure OnICQError(Sender: TObject; ErrorType: TErrorType; ErrorMsg: String);
    procedure OnICQLogin(Sender:TObject);
    procedure OnICQLogOff(Sender:TObject);
    procedure OnICQMsgRecv(Sender: TObject; Msg, UIN: String);
    procedure OnICQMsgOffline(Sender: TObject; DateTime: TDateTime; Msg, UIN: String);
    procedure AddIntoLog(From, Text:string);
    procedure OnGetContactList(Sender: TObject; SrvContactList: TList);
    procedure WMSYSCOMMAND(var Msg:TMessage); message WM_SYSCOMMAND;
    { Private declarations }
  public
    JABBER:TKDJabberClient;
    ICQ:TICQClient;
    { Public declarations }
  end;

  TJabb = packed record
    JID,
    Domain:ShortString;
  end;

  TProxy = packed record
    _enable:boolean;
    _type:byte;
    _address:ShortString;
    _port:integer;
    _authentification:boolean;
    _userName,                   
    _userPass:ShortString;
  end;

  TICQAcc = packed record
    UIN:LongWord;
    Pass:string[8];
  end;

  TJabberAcc = packed record
    JID:TJabb;
    Pass:string;
  end;

  TConfig = packed record
    CoreFName:string;
    ICQCount,
    JabberCount:integer;
    ICQs:array of TICQAcc;
    JABs:array of TJabberAcc;
    Proxy:TProxy;
    Available,
    SaveLoadHistory,
    SaveLoadContactList,
    SaveLoadRoster:boolean;    
  end;

var
  wndMain: TwndMain;
  ProxyConfig:TProxy;
  Calculate:function (_func:PChar):PChar; stdcall;
  PrintHelp:function (Chapter:byte):PChar; stdcall;
  GetVersion:function:PChar; stdcall;
  Parse:function(Msg: PChar; Available:boolean):PChar; stdcall;
  GlobalConfig:TConfig;

const
  MSG_MAX_LENGTH = 512;  
{Q_HEADER
 Q_COPYRIGHT
 B_FUNCTION
 B_RESULT
 B_ERROR
 CORE_CONTENT
 CORE_CH1
 CORE_CH2
 CORE_CH3
 CORE_CH4
 CORE_CH5
 CORE_CH6
 CORE_CH7
 CORE_CH8
 CORE_VER
 BOT_NOT_ACCESSIBLE}
implementation

uses About_u;

{$R *.dfm}

procedure SetStatus(_status:string);
begin
  wndMain.sbStatus.Panels[1].Text := _status;
end;

procedure SaveRosterAndContactList(_Contacts,_Roster:boolean);
var i:integer;
    s:TStringList;
begin
  s := TStringList.Create;
  if _Contacts then
  begin
    for i := 0 to wndMain.lvContact.Items.Count -1 do
    begin
      s.Add(wndMain.lvContact.Items[i].Caption);
      s.Add(wndMain.lvContact.Items[i].SubItems[0]);
    end;
    s.SaveToFile('Contacts.txt');
  end;
  s.Clear;
  if _Roster then
  begin
    for I := 0 to wndMain.lvRoster.Items.Count -1 do
      s.Add(wndMain.lvRoster.Items[i].Caption);
    s.SaveToFile('Roster.txt');
  end;
  s.Free;
end;

procedure LoadRosterAndContactList(_Contacts,_Roster:boolean);
var s:TStringList;
    i:integer;
    _item:TListItem;
begin
  s:=TStringList.Create;
  if _Contacts then
  begin
    s.LoadFromFile('Contacts.txt');
    i := 0;
    while i < s.Count-1 do
    begin
      _item := wndMain.lvContact.Items.Add;
      _item.Caption := s[i];
      _item.SubItems.Add(s[i+1]);
      inc(i,2);
    end;
  end;
  if _Roster then
  begin
    s.LoadFromFile('Roster.txt');
    for i := 0 to s.Count -1 do
      wndMain.lvRoster.Items.Add.Caption := s[i];
  end;
  s.Free;
end;

procedure LoadConfig(fName:string);
var Sign:array [0..2] of Char;
    _file:TFileStream;
    _proxy:TProxy;
    _count:integer;
    function ReadString:string;
    var l,i:byte;
        c:char;
    begin
      _file.Read(l,1);
      Result := '';
      for i := 1 to l do
      begin
        _file.Read(c,1);
        Result := Result + c;
      end;
    end;
    function ReadBool:boolean;
    var b:boolean;
    begin
      _file.Read(b,1);
      Result := b;
    end;
    function ReadInteger:integer;
    var i:word;
    begin
      _file.Read(i,2);
      Result := i;
    end;
    function ReadLongWord:longword;
    var i:LongWord;
    begin
      _file.Read(i,4);
    end;
begin
  if not FileExists(fName) then Exit;
  _file := TFileStream.Create(fName,fmOpenRead);
  _file.ReadBuffer(Sign,3);
  if Sign <> 'ACB' then
  begin
    MessageBox(wndMain.Handle,'Coud not read config file.','Error',MB_OK+MB_ICONSTOP);
    _file.Free;
    Exit;
  end;
  GlobalConfig.CoreFName := ReadString;
  _file.Read(_proxy,SizeOf(TProxy));
  GlobalConfig.Proxy := _proxy;
  GlobalConfig.Available := ReadBool;
  GlobalConfig.SaveLoadHistory := ReadBool;
  GlobalConfig.SaveLoadContactList := ReadBool;
  GlobalConfig.SaveLoadRoster := ReadBool;
  GlobalConfig.ICQCount := ReadInteger;
  SetLength(GlobalConfig.ICQs, 100);
  for _count := 0 to GlobalConfig.ICQCount -1 do
  begin
    //_file.Read(GlobalConfig.ICQs[_count],SizeOf(TICQAcc));
    GlobalConfig.ICQs[_count].UIN := ReadLongWord;
    GlobalConfig.ICQs[_count].Pass := ReadString;
    wndMain.cbAccount.Items.Add(IntToStr(GlobalConfig.ICQs[_count].UIN));
    wndMain.cbUIN.Items.Add(IntToStr(GlobalConfig.ICQs[_count].UIN));
  end;
  //
  GlobalConfig.JabberCount := ReadInteger;
  SetLength(GlobalConfig.JABs, 100);
  for _count := 0 to GlobalConfig.JabberCount -1 do
  begin
    //_file.Read(GlobalConfig.JABs[_count],SizeOf(TJabberAcc));
    GlobalConfig.JABs[_count].JID.JID := ReadString;
    GlobalConfig.JABs[_count].JID.Domain := ReadString;
    GlobalConfig.JABs[_count].Pass := ReadString;
    wndMain.cbJabberAccount.Items.Add(GlobalConfig.JABs[_count].JID.JID+'@'+GlobalConfig.JABs[_count].JID.Domain);
    wndMain.edJID.Items.Add(GlobalConfig.JABs[_count].JID.JID);
  end;
  _file.Free;
  //
  wndMain.cbBotAvailable.Checked := GlobalConfig.Available;
  wndMain.edCorePath.Text := GlobalConfig.CoreFName;
  wndMain.cbSaveHistory.Checked := GlobalConfig.SaveLoadHistory;
  wndMain.cbSaveLoadContactList.Checked := GlobalConfig.SaveLoadContactList;
  wndMain.cbSaveLoadRoster.Checked := GlobalConfig.SaveLoadRoster;
  wndMain.cbBotAvailable.Checked := GlobalConfig.Available;
  ProxyConfig := GlobalConfig.Proxy;
end;

procedure WriteConfig(fName:string);
var _file:TFileStream;
    _count:integer;
const Sign:array [0..2] of char = ('A','C','B');
    procedure WriteBool(b:boolean);
    begin
      _file.WriteBuffer(b,1);
    end;
    procedure WriteString(s:String);
    var i:Byte;
        c:char;
    begin
      i := Length(s);
      _file.WriteBuffer(i,1);
      for i := 1 to Length(s) do
      begin
        c := s[i];
        _file.WriteBuffer(c,1);
      end;
    end;
    procedure WriteInteger(i:word);
    begin
      _file.WriteBuffer(i,2);
    end;
    procedure WriteLongWord(i:longword);
    begin
      _file.Write(i,4);
    end;

begin
  _file := TFileStream.Create(fName,fmCreate);
  _file.Write(Sign,3);
  WriteString(GlobalConfig.CoreFName);
  _file.WriteBuffer(GlobalConfig.Proxy,SizeOf(TProxy));

  WriteBool(GlobalConfig.Available);
  WriteBool(GlobalConfig.SaveLoadHistory);
  WriteBool(GlobalConfig.SaveLoadContactList);
  WriteBool(GlobalConfig.SaveLoadRoster);
  //
  WriteInteger(GlobalConfig.ICQCount);
  for _count := 0 to GlobalConfig.ICQCount -1 do
  begin
    //_file.Write(GlobalConfig.ICQs[_count],SizeOf(TICQAcc));
    WriteLongWord(GlobalConfig.ICQs[_count].UIN);
    WriteString(GlobalConfig.ICQs[_count].Pass);
  end;
  WriteInteger(GlobalConfig.JabberCount);
  for _count := 0 to GlobalConfig.ICQCount -1 do
  begin
    //_file.Write(GlobalConfig.JABs[_count],SizeOf(TJabberAcc));
    WriteString(GlobalConfig.JABs[_count].JID.JID);
    WriteString(GlobalConfig.JABs[_count].JID.Domain);
    WriteString(GlobalConfig.JABs[_count].Pass);
  end;
  _file.Free;
end;

function ParseJabber(_jabb:string):TJabb;
begin
  Result.JID := Copy(_jabb,1,Pos('@',_jabb)-1);
  Result.Domain := Copy(_jabb,Pos('@',_jabb)+1,Length(_jabb));
end;

function GetCoreVersion(fName:string):string;
var _getVer:function:PChar; stdcall;
    _core:THandle;
begin
  Result := 'File not found!';
  @_getVer := nil;
  if not FileExists(fName) then Exit;
  _core := LoadLibrary(PChar(fName));
  if _core < 32 then Exit; //Error
  @_getVer := GetProcAddress(_core, 'GetVersion');
  Result := _getVer;
  @_getVer := nil;
  FreeLibrary(_core);
end;

function ParseTagChar(text:string):string;
var i:integer;
    s:string;
    c:char;
begin
  s := '';
  i := 1;
  while i <= Length(text) do
  begin
    case text[i] of
      '&':begin
        if copy(text,i,5) = '&quot' then
        begin
          c := '"';
          inc(i,5);
        end;
        if copy(text,i,4) = '&amp' then
        begin
          c := '&';
          inc(i,4);
        end;
        if copy(text,i,3) = '&lt' then
        begin
          c := '<';
          inc(i,3);
        end;
        if copy(text,i,3) = '&gt' then
        begin
          c := '>';
          inc(i,3);
        end;
        if copy(text,i,5) = '&circ' then
        begin
          c := '^';
          inc(i,5);
        end;
        if copy(text,i,6) = '&tilde' then
        begin
          c := '~';
          inc(i,6);
        end;
      end;
      else
        c := text[i];
    end;
    s:=s+c;
    inc(i);
  end;
  result := s;
end;

function StringToInteger(s:string):integer;
var _tmp:string;
    _index:integer;
begin
  Result := 0;
  if s = '' then Exit;
  _tmp := '';
  for _index := 1 to Length(s) do
    if (s[_index] in ['0'..'9']) then
      _tmp := _tmp + s[_index];
  Result := StrToInt(_tmp);
end;

procedure TwndMain.About1Click(Sender: TObject);
begin
  Application.CreateForm(TdlgAbout, dlgAbout);
  dlgAbout.ShowModal;
  dlgAbout.Free;
end;

procedure TwndMain.btnICQConnectClick(Sender: TObject);
begin
  SetStatus('ICQ: Trying to connect');
  if ProxyConfig._enable then
  begin
    ICQ.ProxyResolve := ProxyConfig._enable;
    ICQ.ProxyHost := ProxyConfig._address;
    ICQ.ProxyPort := ProxyConfig._port;
    ICQ.ProxyAuth := ProxyConfig._authentification;
    ICQ.ProxyUserID := ProxyConfig._userName;
    ICQ.ProxyPass := ProxyConfig._userPass;
    case ProxyConfig._type of
      0:ICQ.ProxyType := P_NONE;
      1:ICQ.ProxyType := P_HTTP;
      2:ICQ.ProxyType := P_HTTPS;
      3:ICQ.ProxyType := P_SOCKS4;
      4:ICQ.ProxyType := P_SOCKS5;
    end;
  end;
  ICQ.UIN := StrToInt(cbUIN.Text);
  ICQ.Password := edPassword.Text;
  ICQ.Login(S_ONLINE,False);
end;

procedure TwndMain.btnICQDisconnectClick(Sender: TObject);
begin
  ICQ.LogOff;
end;

procedure TwndMain.btnJabberConnectClick(Sender: TObject);
begin
  SetStatus('Jabber: Trying to connect');
  if ProxyConfig._enable then
  begin
    JABBER.Proxy.Resolve := ProxyConfig._enable;
    JABBER.Proxy.Host := ProxyConfig._address;
    JABBER.Proxy.Port := ProxyConfig._port;
    JABBER.Proxy.Auth := ProxyConfig._authentification;
    JABBER.Proxy.User := ProxyConfig._userName;
    JABBER.Proxy.Password := ProxyConfig._userPass;
    case ProxyConfig._type of
      0:JABBER.ProxyType := TProxyType_(0);
      1:JABBER.ProxyType := TProxyType_(2);
      2:JABBER.ProxyType := TProxyType_(1);
      3:JABBER.ProxyType := TProxyType_(0);
      4:JABBER.ProxyType := TProxyType_(0);
    end;
  end;
  JABBER.JIDNode       := edJID.Text;
  JABBER.JIDDomain     := cbDomain.Text;
  JABBER.JIDResource   := 'Standby';
  JABBER.JIDPassword   := edJabberPassword.Text;
  JABBER.JIDPriority   := 30;
  JABBER.JIDStatus     := 'Standby';
  JABBER.Connect;
end;

procedure TwndMain.btnJabberDisconnectClick(Sender: TObject);
begin
  JABBER.Disconnect;
end;

procedure TwndMain.btnProxyApplyClick(Sender: TObject);
begin
  ProxyConfig._enable := cbEnableProxy.Checked;
  ProxyConfig._type := cbProxyType.ItemIndex;
  ProxyConfig._address := edAddress.Text;
  ProxyConfig._port := StrToInt(edPort.Text);
  ProxyConfig._authentification := cbAuthentificate.Checked;
  ProxyConfig._userName := edUserName.Text;
  ProxyConfig._userPass := edUserPassword.Text;
  GlobalConfig.Proxy := ProxyConfig;
  SetStatus('Applying proxy config');
end;

procedure TwndMain.btnSendClick(Sender: TObject);
var UIN:integer;
    JID:string;
    Msg:string;
begin
  Msg := memMsg.Text;
  case cbDeliveryType.ItemIndex of
    0:begin
      if not ICQ.LoggedIn then
      begin
        AddIntoLog('Service message','ICQ is not logging in.');
        Exit;
      end;
      UIN := StringToInteger(edDestination.Text);
      SetStatus('ICQ: Trying to send message');
      ICQ.SendMessage(UIN,Msg);
      SetStatus('ICQ: Message was send');
    end;//ICQ
    1:begin
      if not JABBER.IsLoggedIn then
      begin
        AddIntoLog('Service message','Jabber is not logging in.');
        Exit;
      end;
      JID := edDestination.Text;
      SetStatus('Jabber: Trying to send message');
      JABBER.SendMessage(JID,'',Msg);
      SetStatus('Jabber: Message was send');
    end;//Jabber
  end;
  if cbAutoClear.Checked then memMsg.Clear;
end;

procedure TwndMain.FormDestroy(Sender: TObject);
begin
  JABBER.Free;
  ICQ.Free;
  FreeLibrary(CoreHandle);
  WriteConfig('Config.cfg');
end;

procedure TwndMain.cbAuthentificateClick(Sender: TObject);
var _b:boolean;
begin
  _b := (Sender as TCheckBox).Checked;
  edUserName.Enabled := _b;
  edUserPassword.Enabled := _b;
  lbUserName.Enabled := _b;
  lbUserPassword.Enabled := _b;
end;

procedure TwndMain.cbEnableProxyClick(Sender: TObject);
var _b:boolean;
begin
  _b := (Sender as TCheckBox).Checked;
  gbProxy.Enabled := _b;
  lbProxyType.Enabled := _b;
  lbProxyAddress.Enabled := _b;
  lbProxyPort.Enabled := _b;
  cbProxyType.Enabled := _b;
  edAddress.Enabled := _b;
  edPort.Enabled := _b;                        
  cbAuthentificate.Enabled := _b;
  //
  lbUserName.Enabled := cbAuthentificate.Checked and _b;
  lbUserPassword.Enabled := cbAuthentificate.Checked and _b;
  edUserName.Enabled := cbAuthentificate.Checked and _b;
  edUserPassword.Enabled := cbAuthentificate.Checked and _b;
end;

procedure TwndMain.edPortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9']) then
    Key := #0;
end;

procedure TwndMain.FormCreate(Sender: TObject);
var Data:TWSAData;
    _core : string;
    _item:TListItem;
begin
  WSAStartup($101,Data);
  tvMenu.FullExpand;
  icons.Draw(imgMain.Canvas,0,0,0);
  icons.Draw(imgConnection.Canvas,0,0,1);
  icons.Draw(imgICQ.Canvas,0,0,2);
  icons.Draw(imgJabber.Canvas,0,0,3);
  icons.Draw(imgProxy.Canvas,0,0,4);
  icons.Draw(imgMsgSending.Canvas,0,0,5);
  icons.Draw(imgConfig.Canvas,0,0,6);
  icons.Draw(imgRoster.Canvas,0,0,9);
  icons.Draw(imgContact.Canvas,0,0,9);
  icons.Draw(imgHistory.Canvas,0,0,7);
  //
  LoadConfig('Config.cfg');
  if GlobalConfig.SaveLoadHistory then
    if FileExists('History.txt') then
      memLog.Lines.LoadFromFile('History.txt');
  LoadRosterAndContactList(GlobalConfig.SaveLoadContactList,GlobalConfig.SaveLoadRoster);
  if not FileExists(GlobalConfig.CoreFName) then
    _core := ExtractFileDir(ParamStr(0))+'\AC_Core.dll'
  else
    _core := GlobalConfig.CoreFName;
  @Calculate := nil;
  @PrintHelp := nil;
  @GetVersion := nil;
  @Parse := nil;
  CoreHandle := LoadLibrary(PChar(_core));
  if CoreHandle =0 then
  begin
    MessageBox(Handle,'Coud not load core.','Error',MB_OK+MB_ICONEXCLAMATION);
    Halt;
  end;
  @Calculate := GetProcAddress(CoreHandle,'Calculate');
  @PrintHelp := GetProcAddress(CoreHandle,'PrintHelp');
  @GetVersion := GetProcAddress(CoreHandle,'GetVersion');
  @Parse := GetProcAddress(CoreHandle,'Parse');
  lbCoreInfo.Caption := GetVersion;
  edCorePath.Text := _core;
  if (@Calculate = nil)or(@PrintHelp = nil)or(@GetVersion = nil) then
  begin
    MessageBox(Handle,'Coud not connetct with core.','Error',MB_OK+MB_ICONEXCLAMATION);
    Halt;
  end;
  //
  _item := lvMain.Items.Add;
  _item.Caption := 'Connection';
  _item.ImageIndex := 1;
  _item := lvMain.Items.Add;
  _item.Caption := 'Message sending';
  _item.ImageIndex := 5;
  _item := lvMain.Items.Add;
  _item.Caption := 'Opeions';
  _item.ImageIndex := 6;
  _item := lvMain.Items.Add;
  _item.Caption := 'History';
  _item.ImageIndex := 7;
  //
  _item := lvConnection.Items.Add;
  _item.Caption := 'ICQ';
  _item.ImageIndex := 2;
  _item := lvConnection.Items.Add;
  _item.Caption := 'Jabber';
  _item.ImageIndex := 3;
  _item := lvConnection.Items.Add;
  _item.Caption := 'Proxy config';
  _item.ImageIndex := 4;
  //
  _item := lvHistoryMenu.Items.Add;
  _item.Caption := 'Contacts';
  _item.ImageIndex := 8;
  _item := lvHistoryMenu.Items.Add;
  _item.Caption := 'Roster';
  _item.ImageIndex := 9;
  _item := lvHistoryMenu.Items.Add;
  _item.Caption := 'Message log';
  _item.ImageIndex := 10;
  //
  ProxyConfig._enable := False;
  ProxyConfig._type := 0;
  ProxyConfig._address := '';
  ProxyConfig._port := 0;
  ProxyConfig._authentification := False;
  ProxyConfig._userName := '';
  ProxyConfig._userPass := '';
  //
  JABBER:=TKDJabberClient.Create;
  JABBER.Host:='jabber.ru';
  JABBER.Port:=5222;
  JABBER.OnSocketConnect    := _JabberConnect;
  JABBER.OnSocketDisconnect := _JabberDisConnect;
  JABBER.OnError := _JabberError;
  JABBER.OnJabberSentMessage := OnJabberSentMessage;
  JABBER.OnJabberSubscribe   := OnJabberSubscribe;
  JABBER.OnJabberUnsubscribed:= OnJabberUnsubscribed;
  JABBER.OnJabberRosterListLoaded := OnJabberRosterListLoaded;
  JABBER.OnJabberRosterListUpdate := OnJabberRosterListLoaded;
  //
  ICQ := TICQClient.Create(Self);
  ICQ.ICQPort := 5190;
  ICQ.ICQServerViaHTTP := '80';
  ICQ.ICQServer := 'login.icq.com';
  ICQ.ICQServerViaHTTP := 'http.proxy.icq.com';
  //
  ICQ.OnConnectionFailed := OnICQConnectionFailed;
  ICQ.OnError := OnICQError;
  ICQ.OnLogin := OnICQLogin;
  ICQ.OnLogOff := OnICQLogOff;
  ICQ.OnMessageRecv := OnICQMsgRecv;
  ICQ.OnOfflineMsgRecv := OnICQMsgOffline;
  ICQ.OnServerListRecv := OnGetContactList;
end;

procedure TwndMain.ICQTimerTimer(Sender: TObject);
begin
  if (ICQ.LoggedIn) then
    ICQ.SendKeepAlive;
end;

procedure TwndMain.JabberTimerTimer(Sender: TObject);
begin
  if (JABBER.IsLoggedIn) and (JABBER.IsConnected) then
    JABBER.SendKeepAlive;
end;

procedure TwndMain.lvConnectionDblClick(Sender: TObject);
begin
  if lvConnection.Selected <> nil then
    pcMain.TabIndex := lvConnection.Selected.ImageIndex;
end;

procedure TwndMain.lvConnectionKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_RETURN then
    lvConnectionDblClick(Sender);
end;

procedure TwndMain.lvMainDblClick(Sender: TObject);
begin
  if lvMain.Selected <> nil then
    pcMain.TabIndex := lvMain.Selected.ImageIndex;
end;

procedure TwndMain.lvMainKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_RETURN then
    lvMainDblClick(Sender);
end;

procedure TwndMain.tvMenuChange(Sender: TObject; Node: TTreeNode);
begin
  if tvMenu.Selected <> nil then
    pcMain.TabIndex := tvMenu.Selected.ImageIndex;
end;

procedure TwndMain._JabberConnect(Sender:TObject);
begin
  JABBER.StartLogged;
  btnJabberConnect.Enabled := False;
  btnJabberDisconnect.Enabled := True;
  JabberTimer.Enabled := True;
  edJID.Enabled := False;
  cbDomain.Enabled := False;
  edJabberPassword.Enabled := False;
  lbJabberPass.Enabled := False;
  lbDomain.Enabled := False;
  lbJID.Enabled := False;
  gbJabberLogin.Enabled := False;
  JABBER.SendKeepAlive;
end;

procedure TwndMain._JabberDisConnect(Sender: TObject);
begin
  btnJabberConnect.Enabled := True;
  btnJabberDisconnect.Enabled := False;
  JabberTimer.Enabled := False;
  edJID.Enabled := True;
  cbDomain.Enabled := True;
  edJabberPassword.Enabled := True;
  lbJabberPass.Enabled := True;
  lbDomain.Enabled := True;
  lbJID.Enabled := True;
  gbJabberLogin.Enabled := True;
end;

procedure TwndMain._JabberConnectionError(Sender: TObject);
begin
  AddIntoLog('Jabber error', 'Coud not connect to server.');
  SetStatus('Jabber: Coud not connect to server');
end;

procedure TwndMain._JabberError(Sender: TObject; ErrorType: TErrorType_; ErrorMsg: string);
begin
   AddIntoLog('Jabber error', ErrorMsg);
   SetStatus('Jabber: '+ErrorMsg);
end;

procedure TwndMain.OnJabberSentMessage(Sender: TObject; Types: WideString; From: WideString; Body: UTF8String);
var InputMsg,OutputMsg:string;
begin
  SetStatus('Jabber: Input message');
  //if LowerCase(JABBER.JIDNode+'@'+JABBER.JIDDomain+'\'+JABBER.JIDResource) = LowerCase(From) then Exit;
  InputMsg := ParseTagChar(Utf8Decode(Body));
  if Length(InputMsg) > MSG_MAX_LENGTH then
  begin
    Delete(InputMsg, MSG_MAX_LENGTH, Length(InputMsg));
  end;
  OutputMsg := PChar(Parse(PChar(InputMsg),cbBotAvailable.Checked));
  AddIntoLog(From, InputMsg);
  JABBER.SendMessage(From,'',OutputMsg);
  SetStatus('Ready');
end;

procedure TwndMain.OnJabberSubscribe(Sender: TObject; From: WideString; var Action: Boolean);
begin
  Action:=True;
  SetStatus('Jabber: Authorisation');
end;

procedure TwndMain.OnJabberUnsubscribed(Sender: TObject; From: WideString; var Action: Boolean);
begin
  Action:=True;
  SetStatus('Jabber: Unauthorise');
end;

procedure TwndMain.OnJabberRosterListLoaded(Sender: TObject);
var _item:TListItem;
    count,index:integer;
begin
  SetStatus('Jabber: Loading roster');
  lvRoster.Clear;
  count := JABBER.Rosters.Count;
  for index := 0 to Count - 1 do
  begin
    _item := lvRoster.Items.Add;
    _item.Caption := JABBER.Rosters[index].JID;
  end;
  SetStatus('Jabber: Roster loaded');
end;

procedure TwndMain.OnICQConnectionFailed(Sender:TObject);
begin
  btnICQConnectClick(Sender);
  SetStatus('ICQ: Reconnecting');
end;

procedure TwndMain.OnICQError(Sender: TObject; ErrorType: TErrorType; ErrorMsg: String);
begin
  AddIntoLog('ICQ error', ErrorMsg);
  SetStatus('ICQ: '+ErrorMsg);
end;

procedure TwndMain.OnICQLogin(Sender:TObject);
begin
  SetStatus('ICQ: Logging in');
  btnICQDisconnect.Enabled := True;
  btnICQConnect.Enabled := False;
  gbICQlogin.Enabled := False;
  lbICQpassword.Enabled := False;
  lbUIN.Enabled := False;
  cbUIN.Enabled := False;
  edPassword.Enabled := False;
  ICQTimer.Enabled := True;
  //
end;

procedure TwndMain.OnICQLogOff(Sender:TObject);
begin
  SetStatus('ICQ: Logging off');
  btnICQDisconnect.Enabled := False;
  btnICQConnect.Enabled := True;
  gbICQlogin.Enabled := True;
  lbICQpassword.Enabled := True;
  lbUIN.Enabled := True;
  cbUIN.Enabled := True;
  edPassword.Enabled := True;
  ICQTimer.Enabled := False;
end;

procedure TwndMain.OnICQMsgRecv(Sender: TObject; Msg, UIN: String);
var InputMsg:string;
begin
  SetStatus('ICQ: Input message');
  if StrToInt(UIN) = ICQ.UIN then Exit;
  InputMsg := Msg;
  if Length(InputMsg) > MSG_MAX_LENGTH then
  begin
    Delete(InputMsg, MSG_MAX_LENGTH, Length(InputMsg));
  end;
  AddIntoLog(UIN, InputMsg);
  ICQ.SendMessage(StrToInt(UIN),PChar(Parse(PChar(InputMsg),cbBotAvailable.Checked)));
  SetStatus('Ready');
end;

procedure TwndMain.OnICQMsgOffline(Sender: TObject; DateTime: TDateTime; Msg, UIN: String);
var InputMsg:string;
begin
  SetStatus('ICQ: Offline message');
  if StrToInt(UIN) = ICQ.UIN then Exit;
  InputMsg := Msg;
  if Length(InputMsg) > MSG_MAX_LENGTH then
  begin
    Delete(InputMsg, MSG_MAX_LENGTH, Length(InputMsg));
  end;
  AddIntoLog(UIN, InputMsg);
  ICQ.SendMessage(StrToInt(UIN),PChar(Parse(PChar(InputMsg),cbBotAvailable.Checked)));
  SetStatus('Ready');
end;

procedure TwndMain.tvMenuClick(Sender: TObject);
begin
  if tvMenu.Selected <> nil then
    pcMain.TabIndex := tvMenu.Selected.ImageIndex;
end;

procedure TwndMain.AddIntoLog(From, Text:string);
var _time:String;
begin
  _time := DateTimeToStr(Date+Time);
  memLog.Lines.Add(Format('[%s](%s)'+#13#10+'%s',[From, _time, Text]));
end;

procedure TwndMain.btnAccSaveClick(Sender: TObject);
var i:integer;
begin
  i := cbAccount.ItemIndex;
  GlobalConfig.ICQs[i].UIN := StrToInt(edAccUIN.Text);
  GlobalConfig.ICQs[i].Pass := edAccPass.Text;
end;

procedure TwndMain.btnAddJabberClick(Sender: TObject);
begin
  Application.CreateForm(TdlgAdd, dlgAdd);
  dlgAdd.leJIDorUIN.EditLabel.Caption := 'Jabber:';
  if dlgAdd.ShowModal = mrOk then
  begin
    inc(GlobalConfig.JabberCount);
    GlobalConfig.JABs[GlobalConfig.JabberCount].JID := ParseJabber(dlgAdd.leJIDorUIN.Text);
    GlobalConfig.JABs[GlobalConfig.JabberCount].Pass := dlgAdd.lePass.Text;
    cbJabberAccount.Items.Add(dlgAdd.leJIDorUIN.Text);
  end;
  dlgAdd.Free;
end;

procedure TwndMain.btnAddUINClick(Sender: TObject);
begin
  Application.CreateForm(TdlgAdd, dlgAdd);
  dlgAdd.leJIDorUIN.EditLabel.Caption := 'UIN:';
  if dlgAdd.ShowModal = mrOk then
  begin
    inc(GlobalConfig.ICQCount);
    GlobalConfig.ICQs[GlobalConfig.ICQCount].UIN := StrToInt(dlgAdd.leJIDorUIN.Text);
    GlobalConfig.ICQs[GlobalConfig.ICQCount].Pass := dlgAdd.lePass.Text;
    cbAccount.Items.Add(dlgAdd.leJIDorUIN.Text);
  end;
  dlgAdd.Free;
end;

procedure TwndMain.btnOpenCoreClick(Sender: TObject);
begin
  if not dlgOpen.Execute(Handle) then Exit;
  edCorePath.Text := dlgOpen.FileName;
  GlobalConfig.CoreFName := dlgOpen.FileName;
//  MessageBox(Handle,PChar(GetCoreVersion(dlgOpen.FileName)),'Warning',MB_OK+MB_ICONEXCLAMATION);
end;

procedure TwndMain.btnSaveAccClick(Sender: TObject);
var i:integer;
begin
  i := cbJabberAccount.ItemIndex;
  GlobalConfig.JABs[i].JID := ParseJabber(edAccJid.Text);
  GlobalConfig.JABs[i].Pass := edAccJabberPass.Text;
end;

procedure TwndMain.cbAccountChange(Sender: TObject);
var i:integer;
begin
  i := cbAccount.ItemIndex;
  edAccUIN.Text := IntToStr(GlobalConfig.ICQs[i].UIN);
  edAccPass.Text := GlobalConfig.ICQs[i].Pass;
end;

procedure TwndMain.cbBotAvailableClick(Sender: TObject);
begin
  GlobalConfig.Available := (Sender as TCheckBox).Checked;
end;

procedure TwndMain.cbJabberAccountChange(Sender: TObject);
var i:integer;
begin
  i := cbJabberAccount.ItemIndex;
  edAccJid.Text := GlobalConfig.JABs[i].JID.JID+'@'+GlobalConfig.JABs[i].JID.Domain;
  edAccJabberPass.Text := GlobalConfig.JABs[i].Pass;
end;

procedure TwndMain.cbSaveHistoryClick(Sender: TObject);
begin
  GlobalConfig.SaveLoadHistory := (Sender as TCheckBox).Checked;
end;

procedure TwndMain.cbSaveLoadContactListClick(Sender: TObject);
begin
  GlobalConfig.SaveLoadContactList := (Sender as TCheckBox).Checked;
end;

procedure TwndMain.cbSaveLoadRosterClick(Sender: TObject);
begin
  GlobalConfig.SaveLoadRoster := (Sender as TCheckBox).Checked;
end;

procedure TwndMain.cbUINSelect(Sender: TObject);
var i:integer;
begin
  i := cbUIN.ItemIndex;
  edPassword.Text := GlobalConfig.ICQs[i].Pass;
end;

procedure TwndMain.edCorePathKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_RETURN then
    GlobalConfig.CoreFName := edCorePath.Text;  
end;

procedure TwndMain.edJIDSelect(Sender: TObject);
var i:integer;
begin
  i := edJID.ItemIndex;
  cbDomain.Text := GlobalConfig.JABs[i].JID.Domain;
end;

procedure TwndMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TwndMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if GlobalConfig.SaveLoadHistory then
    memLog.Lines.SaveToFile('History.txt');
  SaveRosterAndContactList(GlobalConfig.SaveLoadContactList,GlobalConfig.SaveLoadRoster);
end;

procedure TwndMain.lvContactKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_F5 then
    ICQ.RequestContactList;  
end;

procedure TwndMain.lvHistoryMenuDblClick(Sender: TObject);
begin
  if lvHistoryMenu.Selected <> nil then
    pcMain.TabIndex := lvHistoryMenu.Selected.ImageIndex;
end;

procedure TwndMain.lvHistoryMenuKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_RETURN then
    lvHistoryMenuDblClick(Sender);
end;

procedure TwndMain.OnGetContactList(Sender: TObject; SrvContactList: TList);
var i:integer;
    user:TUINEntry;
    _item:TListItem;
begin
  lvContact.Clear;
  for i := 0 to SrvContactList.Count-1 do
  begin
    user := PUINEntry(SrvContactList.Items[i])^;
    _item := lvContact.Items.Add;
    _item.Caption := IntToStr(user.UIN);
    _item.SubItems.Add(user.Nick);
  end;
end;

procedure TwndMain.TrayDblClick(Sender: TObject);
begin
  Self.Show;
  Tray.Visible := False;
end;

procedure TwndMain.WMSYSCOMMAND(var Msg:TMessage);
begin
  if Msg.WParam = SC_MINIMIZE then
  begin
    Tray.Visible := True;
    Self.Hide;
    Exit;
  end;
  inherited;
end;

end.
