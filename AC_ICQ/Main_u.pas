unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ICQClient, ICQWorks, StdCtrls, WinSock, ExtCtrls, XPman,
  Buttons, uCalcul;

type

  TResult = packed record
    _result:string;
    _help:boolean;
  end;

  TwndMain = class(TForm)
    gbHistory: TGroupBox;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnExit: TButton;
    memLog: TMemo;
    LiveTimer: TTimer;
    btnProxy: TButton;
    gbLogin: TGroupBox;
    lbUIN: TLabel;
    lbPass: TLabel;
    edUIN: TEdit;
    edPass: TEdit;
    lbResult: TLabel;
    edResult: TEdit;
    lbFunction: TLabel;
    memFunc: TMemo;
    btnCalculate: TSpeedButton;
    cbWork: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure LiveTimerTimer(Sender: TObject);
    procedure btnProxyClick(Sender: TObject);
    procedure btnCalculateClick(Sender: TObject);
  private
    procedure OnConnectionFailed(Sender:TObject);
    procedure OnError(Sender: TObject; ErrorType: TErrorType; ErrorMsg: String);
    procedure OnLogin(Sender:TObject);
    procedure OnLogOff(Sender:TObject);
    procedure OnMsgRecv(Sender: TObject; Msg, UIN: String);
    procedure OnMsgOffline(Sender: TObject; DateTime: TDateTime; Msg, UIN: String);
    function Compute(_Formule: string):TResult;
    procedure OnAutoMsgResponse(Sender: TObject; UIN: String;
             Granted: Boolean; Reason: String);
    { Private declarations }
  public
    { Public declarations }
  end;

  TProxy = packed record
    Host,
    Port:string;
    User,
    Pass:string;
    Auth:boolean;
    ProxyType:byte;
  end;



var
  wndMain: TwndMain;
  Client: TICQClient;
  ProxyConfig:TProxy;

//function Calculate(_func:string):string; external 'AC_Core.dll';
//function PrintHelp(Chapter:byte):string; external 'AC_Core.dll';
//function GetVersion:string; external 'AC_Core.dll';

const
  Q_HEADER:string='[Atomic Calculator] - "Bot version"'#13#10;
  Q_COPYRIGHT:string=#13#10+
                '-----------------------------'#13#10+
                'M.A.D.M.A.N. Software (c)2009';

const
  CORE_CONTENT:string=
      '������ ����������� ��� ���������� �������������� ��������.'#13#10+
      '***************'#13#10+
      ''#13#10+
      '�������� ����������� ���������:'#13#10+
      ' 1-��������� ������������������ �������'#13#10+
      ' 2-��������� ��������������� �������'#13#10+
      ' 3-��������� �������������� �������'#13#10+
      ' 4-��������� �������� �������'#13#10+
      ' 5-���������� ���������� ��������'#13#10+
      ' 6-���������� �������� ���������'#13#10+
      ' 7-���������� �������������� ��������'#13#10+
      ' 8-��������� ����������'#13#10+
      '***************'#13#10+
      '��� ��������� ������� �� ������� ������ �������� ������� ������� � ����� ������.'#13#10+
      '������: help 1';
  CORE_CH1:string=
      '-=������������������ �������=-'#13#10+
      '  Sin-������� ������ (sin(x))'#13#10+
      '  Cos-������� �������� (cos(x))'#13#10+
      '  Tg-������� �������� (tg(x))'#13#10+
      '  Sec-������� ������� (sec(x))'#13#10+
      '  ArcSin-������� ��������� (arcsin(x))'#13#10+
      '  ArcCos-������� ����������� (arccos(x))'#13#10+
      '  ArcTg-������� ����������� (arctg(x))'#13#10+
      '  ArcCtg-������� ������������� (arcctg(x))'#13#10+
      '  Cosec-������� ��������� (cosec(x))'#13#10+
      '  ArcSec-������� ���������� (arcsec(x))'#13#10+
      '  ArcCoSec-������� ������������ (arccosec(x))';
  CORE_CH2:string=
      '-=��������������� �������=-'#13#10+
      '  Sh-������� ���������������� ������ (sh(x))'#13#10+
      '  Ch-������� ���������������� �������� (ch(x))'#13#10+
      '  Th-������� ���������������� �������� (th(x))'#13#10+
      '  CTh-������� ���������������� ���������� (cth(x))'#13#10+
      '  SCh-������� ���������������� ������� (sch(x))'#13#10+
      '  CSh-������� ���������������� ��������� (csh(x))'#13#10+
      '  ArSh-������� ���������������� ��������� (arsh(x))'#13#10+
      '  ArCh-������� ���������������� ����������� (arch(x))'#13#10+
      '  ArTh-������� ���������������� ����������� (arth(x))'#13#10+
      '  ArCTh-������� ���������������� ������������� (arcth(x))'#13#10+
      '  ArSCh-������� ���������������� ���������� (arsch(x))'#13#10+
      '  ArCSCh-������� ���������������� ������������ (arcsch(x))';
  CORE_CH3:string=
      '-=�������������� �������=-'#13#10+
      '  Sqrt-������� ����������� ����� (sqrt(x))'#13#10+
      '  Ln-������� ������������ ��������� (ln(x))'#13#10+
      '  Log-������� ��������� �� ��������� (log(x,y))'#13#10+
      '  Sqr-������� ������� 2 (sqr(x))'#13#10+
      '  Exp-������� ���������� (exp(x))'#13#10+
      '  Abs-������� ����������� ��������, ������ (abs(x))';
  CORE_CH4:string=
      '-=�������� �������=-'#13#10+
      '  Int-������� ������ ����� ����� ����� (int(x))'#13#10+
      '  Round-������� ���������� ����� � ������� ������� (round(x))'#13#10+
      '  Sign-������� ��������� (sing(x))'#13#10+
      '  Random-������� ������������ ������� �� ��������� ������� (random(100))'#13#10+
      '  Factor-������� ���������� (factor(x))'#13#10+
      '  Integral-������� ���������� ������������� ��������� (integral(a,b,n,"sin(x)"))'#13#10+
      '  RowSumm-������� ���������� ��������� ����� ��������� ���� (rowsumm(a,b,n,"1/2^x"))';
  CORE_CH5:string=
      '-=���������� ��������=-'#13#10+
      '  And-���������� "�" a AND b'#13#10+
      '  Or-���������� "���" a OR b'#13#10+
      '  Not-���������� "���������" NOT(a) ';
  CORE_CH6:string=
      '-=�������� ���������=-'#13#10+
      '  >  ������ ������: "a > b"'#13#10+
      '  <  ������ ������: "a < b"'#13#10+
      '  >= ������ ��� ����� ������: "a >+ b"'#13#10+
      '  <= ������ ��� ����� ������: "a <= b"'#13#10+
      '  =  ����� ������: "a = b"'#13#10+
      '  <> �� ����� ������: "a <> b"';
  CORE_CH7:string=
      '-=�������������� ��������=-'#13#10+
      '  div ������������� ������� ������: "c:=a div b;"'#13#10+
      '  mod ������� �� ������� ������ ������: "c:=a mod b;"';
  CORE_CH8:string=
      '-=����������=-'#13#10+
      '��������� ��� �� ��������� ������������� ������������ ����������, ��� ����������� ��� �� ����� ����������� ��������� ��������.'#13#10+
      '��������� ��� ���� ����������:'#13#10+
      ' *�������� (����� � � ������)'#13#10+
      ' *��������� (������������ � ������� ��������)'#13#10+
      '���������� ����� ������������ ��� �������� �������, � ������� Sin(x)'#13#10+
      '��� ���������� �������� ���������� ������������ ���� ":=" (���������) ������: "X:=10;" ��� "Y:=Sin(X);"'#13#10+
      '����� ���� ���������� ������ ���� ������ �����������!';
  CORE_VER:string = '[Atomic Calculator] - "Bot version"'#13#10+
                'Core version 1.32'#13#10+
                'Copyright M.A.D.M.A.N. software (c) 2009';


implementation

uses Proxy_u;

{$R *.dfm}

  function Calculate(_func:string):string;
  var Calc:TCalcul;
      _tmp:string;
  begin
    Calc := TCalcul.Create;
    Calc.Formula := _func;
    _tmp := Calc.Calc;
    if Calc.CalcError then
    begin
      {Result := Calc.CalcErrorText;
      Calc.Free;
      Exit;  }
      _tmp:= Calc.CalcErrorText;
    end;
    Result := _tmp;
    Calc.Free;
  end;

  function PrintHelp(Chapter:byte):string;
  begin
    case Chapter of
      0: Result := CORE_CONTENT;
      1: Result := CORE_CH1;
      2: Result := CORE_CH2;
      3: Result := CORE_CH3;
      4: Result := CORE_CH4;
      5: Result := CORE_CH5;
      6: Result := CORE_CH6;
      7: Result := CORE_CH7;
      8: Result := CORE_CH8;
    end;
  end;

  function GetVersion:string;
  begin
    Result := CORE_VER;
  end;

function stringtointeger(s:string):integer;
var i:integer;
    s2:string;
begin
  s2:='';
  Result := 0;
  if s = '' then
    Exit;  
  for I := 1 to length(s) do
    if s[i] in ['0'..'9'] then
      s2:=s2+s[i];
  Result := StrToInt(s2);
end;

function TwndMain.Compute(_Formule: string):TResult;
var HalfResult:String;
    index:integer;
    s:string;
begin
  Result._result:='';
  Result._help := false;
  index:=0;
  If _Formule='' Then
  Begin
    Exit;
  End;
  s := trim(_formule);
  if s[1] = '?' then
  begin
    Delete(s,1,1);
    if Length(s)<> 0 then
    begin
      index := stringtointeger(trim(s));
      Result._result := PrintHelp(index);
      Result._help:=true;
      Exit;
    end;
    Result._result := PrintHelp(0);
    Result._help:=true;
    Exit;
  end;
  if lowercase(copy(s,1,4)) = 'help' then
  begin
    Delete(s,1,4);
    if Length(s)<> 0 then
    begin
      index := stringtointeger(trim(s));
      Result._result := PrintHelp(index);
      Result._help:=true;
      Exit;
    end;
    Result._result := PrintHelp(0);
    Result._help:=true;
    Exit;
  end;  
  Result._result := Calculate(_Formule);
  Result._help:=false;
end;

procedure TwndMain.FormCreate(Sender: TObject);
var Data:TWSAData;
begin
  edUIN.Text := '565825863';
  edPass.Text := 'A10c8RwZ';
  WSAStartup($101,Data);
  Client := TICQClient.Create(Self);
  Client.ICQPort := 5190;
  Client.ICQServerViaHTTP := '80';
  Client.ICQServer := 'login.icq.com';
  Client.ICQServerViaHTTP := 'http.proxy.icq.com';
  {Client.UIN := 565825863;
  Client.Password := 'A10c8RwZ';}
  Client.OnConnectionFailed := Self.OnConnectionFailed;
  Client.OnError := Self.OnError;
  Client.OnLogin := Self.OnLogin;
  Client.OnLogOff := Self.OnLogOff;
  Client.OnMessageRecv := Self.OnMsgRecv;
  Client.OnOfflineMsgRecv := Self.OnMsgOffline;
  Client.OnAuthResponse := OnAutoMsgResponse;
end;

procedure TwndMain.OnConnectionFailed(Sender:TObject);
begin
  btnConnectClick(Self);
end;

procedure TwndMain.OnError(Sender: TObject; ErrorType: TErrorType; ErrorMsg: String);
begin
  memLog.Lines.Add(ErrorMsg);
end;

procedure TwndMain.OnLogin(Sender:TObject);
begin
  btnConnect.Enabled := False;
  btnDisconnect.Enabled := True;
  LiveTimer.Enabled := True;
  //
  edUIN.Enabled := False;
  edPass.Enabled := False;
  lbPass.Enabled := False;
  lbUIN.Enabled := False;
  btnProxy.Enabled := False;
end;

procedure TwndMain.OnLogOff(Sender:TObject);
begin
  btnConnect.Enabled := True;
  btnDisconnect.Enabled := False;
  LiveTimer.Enabled := False;
  //
  edUIN.Enabled := True;
  edPass.Enabled := True;
  lbPass.Enabled := True;
  lbUIN.Enabled := True;
  btnProxy.Enabled := True;  
end;

procedure TwndMain.OnMsgRecv(Sender: TObject; Msg, UIN: String);
var _result:TResult;
begin
  if UIN = IntToStr(Client.UIN) then Exit;
  if Length(Msg)>512 then
    delete(Msg,512,Length(Msg));  
  memLog.Lines.Add(Format('%s (%s)'#13#10+'[%s]',[UIN,DateTimeToStr(Date+Time),Msg]));
  if cbWork.Checked then
    _result := Compute(Msg)
  else
  begin
    _result._result := '������ �������� ����������';
    _result._help := true;
  end;
  if not _result._help then
    Client.SendMessage(StrToInt(UIN),Q_HEADER+'�������:'+Msg+#13#10+'���������:'+_result._result+Q_COPYRIGHT)
  else
    Client.SendMessage(StrToInt(UIN),Q_HEADER+_result._result+Q_COPYRIGHT);
  memLog.Lines.Add(Format('[Atomic Calculator](%s)'#13#10+'%s',[DateTimeToStr(Date+Time),_result._result]));
end;

procedure TwndMain.OnMsgOffline(Sender: TObject; DateTime: TDateTime; Msg, UIN: String);
var _result:TResult;
begin
  if UIN = IntToStr(Client.UIN) then Exit;
  if Length(Msg)>512 then
    delete(Msg,512,Length(Msg));  
  memLog.Lines.Add(Format('%s (%s)'#13#10+'[%s]',[UIN,DateTimeToStr(Date+Time),Msg]));
  if cbWork.Checked then
    _result := Compute(Msg)
  else
  begin
    _result._result := '������ �������� ����������';
    _result._help := true;
  end;
  if not _result._help then
    Client.SendMessage(StrToInt(UIN),Q_HEADER+'�������:'+Msg+#13#10+'���������:'+_result._result+Q_COPYRIGHT)
  else
    Client.SendMessage(StrToInt(UIN),Q_HEADER+_result._result+Q_COPYRIGHT);
  memLog.Lines.Add(Format('[Atomic Calculator](%s)'#13#10+'%s',[DateTimeToStr(Date+Time),_result._result]));
end;

procedure TwndMain.btnConnectClick(Sender: TObject);
begin
  case ProxyConfig.ProxyType of
    0: Client.ProxyType := P_NONE;
    1: Client.ProxyType := P_HTTP;
    2: Client.ProxyType := P_HTTPS;
    3: Client.ProxyType := P_SOCKS4;
    4: Client.ProxyType := P_SOCKS5; 
  end;
  Client.ProxyResolve := (ProxyConfig.ProxyType)<>0;
  Client.ProxyHost := ProxyConfig.Host;
  Client.ProxyPort := StrToInt(ProxyConfig.Port);
  Client.ProxyAuth := ProxyConfig.Auth;
  Client.ProxyUserID := ProxyConfig.User;
  Client.ProxyPass := ProxyConfig.Pass;
  {Client.UIN := 565825863;
  Client.Password := 'A10c8RwZ';}
  Client.UIN := StrToInt(edUIN.Text);
  Client.Password := edPass.Text;
  Client.Login();
  Client.SetAuthorization(True,True);
end;

procedure TwndMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TwndMain.btnDisconnectClick(Sender: TObject);
begin
  Client.LogOff;
end;

procedure TwndMain.OnAutoMsgResponse(Sender: TObject; UIN: String;
  Granted: Boolean; Reason: String);
begin
{  Client.SendAuthRequest(StrToInt(UIN),'Please authorise.');
  Client.SendAuthResponse(StrToInt(UIN),True,':-)');
  Client.AddContact(StrToInt(UIN)); }
end;

procedure TwndMain.LiveTimerTimer(Sender: TObject);
begin
  Client.SendKeepAlive;
end;

procedure TwndMain.btnProxyClick(Sender: TObject);
begin
  Application.CreateForm(TdlgProxy, dlgProxy);
  dlgProxy.cbProxyType.ItemIndex := ProxyConfig.ProxyType;
  dlgProxy.edAddress.Text := ProxyConfig.Host;
  dlgProxy.edPort.Text := ProxyConfig.Port;
  dlgProxy.cbAuthentification.Checked := ProxyConfig.Auth;
  dlgProxy.edUserName.Text := ProxyConfig.User;
  dlgProxy.edUserPass.Text := ProxyConfig.Pass;
  if dlgProxy.ShowModal = mrOk then
  begin
     ProxyConfig.ProxyType := dlgProxy.cbProxyType.ItemIndex;
     ProxyConfig.Host := dlgProxy.edAddress.Text;
     ProxyConfig.Port := dlgProxy.edPort.Text;
     ProxyConfig.Auth := dlgProxy.cbAuthentification.Checked;
     ProxyConfig.User := dlgProxy.edUserName.Text;
     ProxyConfig.Pass := dlgProxy.edUserPass.Text;
  end;
  dlgProxy.Free;
end;

procedure TwndMain.btnCalculateClick(Sender: TObject);
var _result:TResult;
begin
  _result := Compute(memFunc.Text);
  edResult.Text := _result._result;
  memLog.Lines.Add(Format('[Atomic Calculator](%s)'#13#10+'%s',[DateTimeToStr(Date+Time),_result._result]));
end;

end.
