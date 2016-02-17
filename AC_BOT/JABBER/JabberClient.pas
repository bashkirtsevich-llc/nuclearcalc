{*******************************************************}
{                                                       }
{       Jabber Client Module                            }
{                                                       }
{  	    Copyright (c) 2008-2009 Dmitriy Kuzan           }
{                                                       }
{       21 ������ 2009 �                                }
{                                                       }
{*******************************************************}
//� ���������� ������������ ��������� �� WinSock -
//                       Alex Demchenko(alex@ritlabs.com)

unit JabberClient;

interface

uses
   Classes,
   Dialogs,
   SysUtils,
   janXMLparser2,
   Variants,
   KDSocket.Proxy,
   KDSocket.Buffer,
   KDSocket.Custom,
   KDSocket.Types,
   KDSocket.HTTP,
   KDSocket.Servers,
   KDSocket.Utilites,
   JabberClient.Types,
   JabberClient.Rosters,
   JabberClient.Tools;

Const
  cClient = '[Atomic Calculator]';//'NotificationService'; // default KDBots
  cVer    = ' - "Bot version"';//'1.0.0.0'; // default 0.5.0.1

type
  // ����������� ���������� ������
  TKDJabberClient = class;

  // ��������� ������
  TProxyOptions = class(TPersistent)
  private
    FAuth: Boolean;
    FResolve: Boolean;
    FPort: Word;
    FPassword: String;
    FHost: String;
    FUser: String;
  published
    property Host: String read FHost write FHost;
    property Port: Word read FPort write FPort;
    property User: String read FUser write FUser;
    property Password: String read FPassword write FPassword;
    property Auth : Boolean read FAuth write FAuth default False;
    property Resolve: Boolean read FResolve write FResolve default False;
  end;

  TKDJabberClient = class(TObject)
  private
    FSocket    : TEventSocket; {������������ �����}
    FHTTPConnected: Boolean;   // ���� ����������
    XML: TjanXMLParser2;       // XML ������
    Root : TjanXMLNode2;       // Root Node
    JStatus : TJabberStatus;   // ������

    jbID     : string;         // ID ��� ��������
    jbNonce  : string;         // ���������� Nonce �� �������
    jbCNonce : string;         // ���������� CNONCE �� �������
    jbRsPauth : string;        // ���������� rspauth
    jbLastErrorStr : String;
    jbFullJID      : String;

    BufPacketStr : String;     // ���������������� ������
    PacketStr : string;        // ������ ��������� ��������� ����� � ���� ������
    IsSASL    : Boolean;       // �������� �� SASL ������������
    isMessageDiv : Boolean;    // ��������� ��������
    isSendAuthInitiation : Boolean;    // ��� ������ ��������� ����� �����������

    FPort: Word;
    FHost: String;
    FProxyType: TProxyType_;
    FProxy: TProxyOptions;

    FJIDNode: string;
    FJIDDomain: string;
    FJIDResource: string;
    FJIDPassword: string;
    FJIDPriority: byte;
    FJIDStatus: string;
    FJIDShow: TShow;
    FRosters: TRostersCollections;

    FOnError       : TOnError;
    FOnConnect     : TNotifyEvent;
    FOnPacketParse : TOnPacketParse;
    FOnDisconnect  : TNotifyEvent;
    FOnSocketThreadException: TOnSocketThreadException;
    FOnJabberSentMessage: TJabberSentMessage;
    FOnJabberUnsubscribed: TJabberUnsubscribed;
    FOnJabberSubscribe: TJabberSubscribe;
    FOnJabberLogin: TNotifyEvent;
    FOnJabberSubscribed: TJabberSubscribed;
    FOnJabberNotAuthorized: TNotifyEvent;
    FOnJabberUserOffline:  TJabberJIDEvent;
    FOnJabberUserOnline:  TJabberJIDEvent;
    FOnJabberChangeShow: TJabberChangeShow;
    FOnJabberUserPresence: TJabberJIDEvent;
    FOnJabberChangeStatus: TJabberChangeStatus;
    FOnJabberRosterListLoaded: TNotifyEvent;
    FOnJabberRosterListUpdate: TNotifyEvent;
    FOnJabberRosterDelete: TJabberJIDEvent;
    FOnJabberRosterAddOrUpdate: TJabberJIDEvent;

    Function IsError(Node : TjanXMLNode2) : TErrorTypes;
    // ������������ ��������� XML � �������� �����������
    function ProcessConnection : Boolean;
    // ������������ ��������� XML � �������� �������� ������, ����� �� ��������� �
    // �������
    function ProcessMain : Boolean;
    // ��������� ��������������
    procedure toMessage(Node : TjanXMLNode2);
    procedure toPresence(Node : TjanXMLNode2);
    procedure toNullTypesPresence(From : WideString; Node : TjanXMLNode2);
    procedure toIQ(Node : TjanXMLNode2);
    // ���������� XEP (���������� ���������)
    Function  toXEP_Software_Version(Node : TjanXMLNode2)  : Boolean;
    Function  toXEP_Service_Discovery(Node : TjanXMLNode2) : Boolean;
    // ������ ���� (�������)
    Function  toRosterListCreate(Node : TjanXMLNode2) : Boolean;
    // ������ ���� (��������)
    Function  toRosterListUpdate(Node : TjanXMLNode2) : Boolean;

    procedure FreeSockets;                             // ���������� ��� ������
    procedure SendData(var Data; DataLen: LongWord);   // ������� ������

    // ������� � ���������� �����
    procedure FreeSocket(var Socket: TEventSocket);
    // ���� �����������
    procedure _OnConnect(Sender: TObject);
    procedure _OnError(Sender: TObject; ErrorType: TErrorType_; ErrorMsg: String);
    procedure _OnDisconnect(Sender: TObject);
    procedure _OnDataSent(Sender: TObject);
    procedure _OnReceive(Sender: TObject; Buffer: Pointer; BufLen: LongWord);
    procedure _OnSocketThreadException(Sender: TObject; AExceptionStr: String);
    procedure SetJIDStatus(const Value: string);
    procedure SetJIDPriority(const Value: byte);
    procedure SetJIDShow(const Value: TShow);
  public
    constructor Create;
    destructor  Destroy; override;
    procedure SendStr(const Value: String);            { TODO : � Private }
    procedure Connect;                                 // ����������
    procedure Disconnect;                              // ������������
    Procedure StartLogged;
    // ���� XMPP ������� ����������� ��� ��� �� �� �����
    Procedure SendKeepAlive;
    // ������� ���������
    Procedure SendMessage(JID,From :String; Body : string);
    // ������� �� ��������
    Procedure JIDSubscribe(JID :String);
    // ������� ��������� �� �������
    Procedure JIDUnsubscribed(JID :String);
    // ���� ���������� ����������
    Function  IsConnected : Boolean;
    // �������� �����������
    Function  IsLoggedIn  : Boolean;
    // ������-����
    property  Rosters : TRostersCollections read FRosters;
    // ���������� ��������
    procedure RosterAddOrUpdate(JID : string; RosterInfo : TRosterInfo); overload;
    procedure RosterAddOrUpdate(JIDItem : TRosterItem; RosterInfo : TRosterInfo); overload;
    procedure RosterDelete(JID : string); overload;
    procedure RosterDelete(JIDItem : TRosterItem); overload;
  published
    // ���� � ���� �����������
    property Host: String read FHost write FHost;
    property Port: Word read FPort write FPort;
    // ������ ����������
    property ProxyType: TProxyType_ read FProxyType write FProxyType;
    // ��������� ������
    property Proxy : TProxyOptions read FProxy write FProxy;
    // ��������� Jabber
    property JIDNode : string read FJIDNode write FJIDNode;
    property JIDDomain : string read FJIDDomain write FJIDDomain;
    property JIDResource : string read FJIDResource write FJIDResource;
    property JIDPassword : string read FJIDPassword write FJIDPassword;
    // ������� � ��������
    property JIDShow   : TShow read FJIDShow write SetJIDShow;
    property JIDStatus : string read FJIDStatus write SetJIDStatus;
    property JIDPriority : byte read FJIDPriority write SetJIDPriority default 5;
    // ��������
    property OnSocketConnect : TNotifyEvent
                   read FOnConnect write FOnConnect;
    property OnSocketDisconnect: TNotifyEvent
                   read FOnDisconnect write FOnDisconnect;
    property OnSocketThreadException: TOnSocketThreadException
                   read FOnSocketThreadException write FOnSocketThreadException;
    property OnError : TOnError
                   read FOnError write FOnError;
    property OnPacketParse : TOnPacketParse
                   read FOnPacketParse write FOnPacketParse;      
    // -------------------------------------------------------------------------
    // JABBER ��������
    // -------------------------------------------------------------------------
    // ������������
    Property  OnJabberLogin   : TNotifyEvent read FOnJabberLogin write FOnJabberLogin;
    // ������ ��� �����������
    Property  OnJabberNotAuthorized : TNotifyEvent  read FOnJabberNotAuthorized
                                                    write FOnJabberNotAuthorized;
    // ������ ���������
    Property  OnJabberSentMessage : TJabberSentMessage read FOnJabberSentMessage
                                                      write FOnJabberSentMessage;
    // ������ ��������
    Property  OnJabberSubscribe : TJabberSubscribe      read FOnJabberSubscribe
                                                        write FOnJabberSubscribe;
    // ������ ���������� � ��� ��� ��� ���������
    Property  OnJabberSubscribed : TJabberSubscribed     read FOnJabberSubscribed
                                                        write FOnJabberSubscribed;
    // ������ ������ �� �������
    Property  OnJabberUnsubscribed : TJabberUnsubscribed read FOnJabberUnsubscribed
                                                        write FOnJabberUnsubscribed;
    // ����������� � �����������
    Property  OnJabberUserPresence :  TJabberJIDEvent read FOnJabberUserPresence
                                                        write FOnJabberUserPresence;
    // ������������ ������ show ���������
    Property  OnJabberChangeShow :  TJabberChangeShow read FOnJabberChangeShow
                                                        write FOnJabberChangeShow;
    // ������������ ������ ������ (�����)
    Property  OnJabberChangeStatus :  TJabberChangeStatus read FOnJabberChangeStatus
                                                        write FOnJabberChangeStatus;
    // ������������ � �������
    Property  OnJabberUserOffline :  TJabberJIDEvent read FOnJabberUserOffline
                                                        write FOnJabberUserOffline;
    // Roster ���� ������� � ��������
    Property  OnJabberRosterListLoaded : TNotifyEvent  read FOnJabberRosterListLoaded
                                                    write FOnJabberRosterListLoaded;
    // Roster ���� ��������
    Property  OnJabberRosterListUpdate : TNotifyEvent  read FOnJabberRosterListUpdate
                                                    write FOnJabberRosterListUpdate;
    // ������ ������ �� ������ ���������
    Property  OnJabberRosterAddOrUpdate :  TJabberJIDEvent read FOnJabberRosterAddOrUpdate
                                                        write FOnJabberRosterAddOrUpdate;
    // ������ ������ �� ������ ���������
    Property  OnJabberRosterDelete :  TJabberJIDEvent read FOnJabberRosterDelete
                                                        write FOnJabberRosterDelete;
  end;

implementation

{ TJabberNet }
constructor TKDJabberClient.Create;
begin
  inherited Create;
  FSocket     := nil;
  FProxy      := TProxyOptions.Create;
  XML         := TjanXMLParser2.Create;
  JStatus     := tjsDisconnect;
  FRosters    := TRostersCollections.Create(TRosterItem);
end;

destructor TKDJabberClient.Destroy;
begin
  FreeSocket(FSocket);
  FProxy.Free;
  XML.Free;
  FRosters.Free;
  inherited Destroy;
end;

procedure TKDJabberClient.FreeSocket(var Socket: TEventSocket);
begin
  if Assigned(Socket) then
  begin
     if Socket.Working then
     begin
         Socket.FreeOnTerminate := True;
         Socket.Terminate;
      end
      else
         Socket.Free;
     Socket := nil;
  end;
end;

procedure TKDJabberClient.FreeSockets;
begin
  FreeSocket(FSocket);
end;

function TKDJabberClient.IsConnected: Boolean;
begin
 IF Assigned(FSocket) Then
    Result := FSocket.Connected
 else
    Result := False;   
end;

function TKDJabberClient.IsError(Node: TjanXMLNode2): TErrorTypes;
var
  Child : TjanXMLNode2;
  I     : Integer;
begin
  Result := tetNoError;
  // Stream:Stream
  if AnsiCompareStr(Root.name, nodeStream)   = 0 then
  begin
     for I := 0 to Root.childCount - 1 do
     begin
         Child  := Root.childNode[I];
         if AnsiCompareStr(Child.name, nodeError) = 0 then // Stream:Error
         begin
            Child  := Child.childNode[0];
            Result := tetError;
            jbLastErrorStr := Child.name;
            Exit;
         end;
     end;
  end;
  if AnsiCompareStr(Root.name, nodeFailure) = 0 then // Failure
  begin
     Result := tetFailure;
     Child  := Root.childNode[0];
     // �� ������ �����������
     if AnsiCompareStr(Child.name, vNotAuthorized) = 0 then // Failure
     begin
        if Assigned(FOnJabberNotAuthorized) then
           FOnJabberNotAuthorized(Self);
     end;
  end;
end;

function TKDJabberClient.IsLoggedIn: Boolean;
begin
  if Assigned(FSocket) then
     Result := (JStatus = tjsConnect) and FSocket.Connected
  else
     Result := False;
end;

procedure TKDJabberClient.RosterAddOrUpdate(JID: string;
                                            RosterInfo: TRosterInfo);
var
 JIDItem : TRosterItem;
begin
 JIDItem := Rosters.FindItemJID(JID);
 IF Assigned(JIDItem) Then
 begin
    // ������� ������ � ������-�����, ���� ����� JID
    // ��������� ����� � ����������
    RosterAddOrUpdate(JIDItem, RosterInfo);
 end
 else
 begin
    // ����� JID
    // ������� � ��� ������ ����
    JIDItem := FRosters.AddRoster(JID, RosterInfo);
    // ��������� ����� � ����������
    RosterAddOrUpdate(JIDItem, RosterInfo);
 end;
end;

procedure TKDJabberClient.RosterAddOrUpdate(JIDItem: TRosterItem;
  RosterInfo: TRosterInfo);
var
  Packet : string;
begin
  Packet := Packet_Roster_AddOrUpdate(JIDItem.JID, RosterInfo, jbFullJID);
  SendStr(Packet);
end;

procedure TKDJabberClient.RosterDelete(JID: string);
var
 JIDItem : TRosterItem;
begin
 JIDItem := Rosters.FindItemJID(JID);
 IF Assigned(JIDItem) Then
    RosterDelete(JIDItem);
end;

procedure TKDJabberClient.RosterDelete(JIDItem: TRosterItem);
var
  Packet : string;
begin
  Packet := Packet_Roster_Delete(JIDItem.JID, jbFullJID);
  SendStr(Packet);
end;

procedure TKDJabberClient.Connect;
begin
  FreeSocket(FSocket);

  case FProxyType of
       P_NONE  : FSocket := TEventSocket.Create;     {������ ����������}
       P_HTTP  : FSocket := THTTPSocket.Create;      {������������ HTTP ������}
       P_HTTPS : FSocket := THTTPSSocket.Create;     {������������ HTTPS ������}
  else
       Exit;
  end;                         

  if FProxyType = P_NONE then
  begin
    FSocket.ProxyReady := True;
    FSocket.ProxyHost  := FHost;         {����� ������-�����
                                          ProxyHost - �� ����� ���� Host       }
    FSocket.ProxyPort  := FPort;
  end
  else
     if FProxyType = P_HTTP then
     begin
        { TODO : ���������� ������ host � ���� �� ������� }
        FSocket.ProxyHost  := FProxy.Host;
        FSocket.ProxyPort  := FProxy.Port;
        FSocket.ProxyReady := False;
     end
     else
     begin
        FSocket.Host := FHost;
        FSocket.Port := FPort;
        FSocket.ProxyHost  := FProxy.Host;
        FSocket.ProxyPort  := FProxy.Port;
        FSocket.ProxyReady := False;
     end;

  FSocket.ProxyUser    := FProxy.User;
  FSocket.ProxyPass    := FProxy.Password;
  FSocket.ProxyAuth    := FProxy.Auth;
  FSocket.ProxyResolve := FProxy.Resolve;

  FSocket._OnConnect      := _OnConnect;
  FSocket._OnDisconnect   := _OnDisconnect;
  FSocket._OnError        := _OnError;
  FSocket._OnReceive      := _OnReceive;
  FSocket._OnDataSent     := _OnDataSent;
  FSocket.OnSocketThreadException :=
                             _OnSocketThreadException;
  FSocket.Connect;
end;

procedure TKDJabberClient.Disconnect;
begin
  FreeSockets;
  JStatus := tjsDisconnect;
  if Assigned(FOnDisconnect) then
     FOnDisconnect(Self);
end;


procedure TKDJabberClient.SendData(var Data; DataLen: LongWord);
begin
  if FProxyType <> P_HTTP then
  begin
     if Assigned(FSocket) then
     begin
     if Assigned(FOnPacketParse) then
        FOnPacketParse(Self,  Self.FHost , Self.FPort, @Data, DataLen, False);
      FSocket.SendData(@Data, DataLen);
    end
  end
  else
  begin
    if Assigned(FOnPacketParse) then
       FOnPacketParse(Self,  Self.FHost , Self.FPort, @Data, DataLen, False);
  end;
end;

procedure TKDJabberClient.SendKeepAlive;
var
 Ping : array [0..2] of Byte;
begin
 if (IsLoggedIn) and (IsConnected) then
 begin
     Ping[0] := $20;
     Ping[1] := $09;
     Ping[2] := $20;
     SendData(Ping,3);
 end;
end;

procedure TKDJabberClient.SendMessage(JID,From, Body: string);
var
 Packet : String;
begin
 if (IsLoggedIn) and (IsConnected) then
 begin
     if From='' then
       Packet := Packet_SendMessage(JID, jbFullJID, Body)
     else
       Packet := Packet_SendMessage(JID, From, Body);
     SendStr(Packet);
 end;
end;

procedure TKDJabberClient.JIDSubscribe(JID: String);
var
 Packet : String;
begin
 if (IsLoggedIn) and (IsConnected) then
 begin
     Packet := Packet_SendSubscribe(JID, jbFullJID);
     SendStr(Packet);
 end;
end;

procedure TKDJabberClient.JIDUnsubscribed(JID: String);
var
 Packet : String;
begin
 if (IsLoggedIn) and (IsConnected) then
 begin
     Packet := Packet_SendUnsubscribed(JID, jbFullJID);
     SendStr(Packet);
 end;
end;

procedure TKDJabberClient.SetJIDPriority(const Value: byte);
begin
 FJIDPriority := Value;
 if (IsLoggedIn) and (IsConnected) then
 begin
    SendStr(Packet_Priority(FJIDPriority));
 end;
end;

procedure TKDJabberClient.SetJIDShow(const Value: TShow);
begin
 FJIDShow := Value;
 if (IsLoggedIn) and (IsConnected) then
 begin
    SendStr(Packet_Show(FJIDShow));
 end;
end;

procedure TKDJabberClient.SetJIDStatus(const Value: string);
begin
  FJIDStatus := Value;
 if (IsLoggedIn) and (IsConnected) then
 begin
    SendStr(Packet_Status(FJIDStatus));
 end;
end;

procedure TKDJabberClient.SendStr(const Value: String);
begin
 if Assigned(FOnPacketParse) then
    FOnPacketParse(Self,  Self.FHost , Self.FPort, @Value[1], Length(Value), False);
  // �������� ������
  FSocket.SendData(@Value[1], Length(Value));
end;



procedure TKDJabberClient._OnConnect(Sender: TObject);
begin
  if Assigned(FOnConnect) then
     FOnConnect(Self);
end;

procedure TKDJabberClient._OnDataSent(Sender: TObject);
begin
 // ��������           { TODO : ��������� ���������� }
end;

procedure TKDJabberClient._OnDisconnect(Sender: TObject);
begin
  JStatus := tjsDisconnect;
  if Assigned(FOnDisconnect) then
     FOnDisconnect(Self);
end;

procedure TKDJabberClient._OnError(Sender: TObject; ErrorType: TErrorType_;
  ErrorMsg: String);
begin
  FreeSocket(FSocket);
  if Assigned(OnError) then
     FOnError(Self, ErrorType, ErrorMsg);
end;

procedure TKDJabberClient._OnSocketThreadException(Sender: TObject;
  AExceptionStr: String);
begin
  FreeSocket(FSocket);
  if Assigned(FOnSocketThreadException) then
     FOnSocketThreadException(Self, AExceptionStr);
  if Assigned(FOnDisconnect) then
     FOnDisconnect(Self);
end;

procedure TKDJabberClient._OnReceive(Sender: TObject; Buffer: Pointer;
                                     BufLen: LongWord);
var
   FlagOk : Boolean;
begin
   if Assigned(FOnPacketParse) then
      FOnPacketParse(Self,  Self.FHost , Self.FPort, Buffer, BufLen, True);
   try
      PacketStr := Trim(PacketToSring(Buffer, BufLen));;
      XML.XML := PacketStr;
   Except
   end;
   Root := XML.rootNode;

   // ������ ���� ���������� ��� ����� �� XML
   if PacketStr[1] <> '<' then
   begin
      BufPacketStr := BufPacketStr + PacketStr;
      if isMessageDiv then
      begin
         // ������� ��� �� � �������� ������ ���� '</message>'
         if Pos('</message>', BufPacketStr) <> 0 then
         begin
            try
              XML.XML   := BufPacketStr;
              PacketStr := BufPacketStr;
              Root := XML.rootNode;
            Except
            end;
            BufPacketStr := '';
         end;
      end;
   end;

   // �������� ������������ ����
   if Root.namespace = nsStream then
   begin
      {TODO : ��������� XML �� ������ stream:error}
      case IsError(Root) of
           tetError :  begin
                        IF Assigned(FOnError) then
                        begin
                           FOnError(Self,ERR_PROTOCOL, jbLastErrorStr);
                        end;
                        Exit;
                       end;
           tetFailure :
                       begin
                         Disconnect;
                         Exit;
                       end;
      end;
      // ������ ���
      FlagOk := True;
      case JStatus of
           {�� � ������ �������� ����������, ������������ XML}
           tjsConnecting : FlagOk := ProcessConnection;
           {�� � ������ ��������, ������������ XML}
           tjsConnect    : FlagOk := ProcessMain;
      end;

      if Not FlagOk then
      begin
         IF Assigned(FOnError) then
         begin
            FOnError(Self,ERR_PROTOCOL, jbLastErrorStr);
         end;
      end;
   end
   else
   begin
      //{ TODO : ��������� ������ � �������� ������������ ���� }
   end;
end;

function TKDJabberClient.ProcessConnection : Boolean;
var
  TxtBase64Decode, Txt : string;
  Packet : string;
  Node   : TjanXMLNode2;
begin
  Result := True;
  // ������ ������� ������ �������
  if AnsiCompareStr(Root.name, nodeStream) = 0 then //stream:stream
  begin
     // ���������� ID
     jbID := Root.attribute[cID];
     if Trim(jbID) = '' then
     begin
        jbLastErrorStr := '������ ID';
        Result := False;
        Exit;
     end;
     // ------------------------------------------------------------------------
     // Resource Binding
     // ����� ���������� SASL ������������
     // ������ ������ ������� ����� � ���������� ��������
     // � ������� ������� JID
     // ------------------------------------------------------------------------
     if IsSASL then
     begin
        // �� �������� �������������� �� �������, ��� �� ����� �����������
        // ������������ JID
        // �������� ���� ������������� �������
        Packet := Packet_Bind(FJIDResource);
        SendStr(Packet);
     end;
  end;
  //������ ����������� ��� �� ���������� ������������� features
  if AnsiCompareStr(Root.name, nodeFeatures) = 0 then // stream:features
  begin
     // �������� �������� (features) �������, � ����� �� ��� �� ������ �������
     // ������ � ������ ������������
     { TODO : �������� �������� ������� }
     // �������� ������� ��������� � ������ ������������� �� MD5
     if Not isSendAuthInitiation then
     begin
         SendStr(Packet_Initiation);
         isSendAuthInitiation := True;
     end;
  end;
  // ������ ��� �������� � BASE 64 ������ �� challenge
  if AnsiCompareStr(Root.name, nodeChallenge) = 0 then  // challenge
  begin
     // �������� �������������� �����
     TxtBase64Decode := Root.Text;
     if Trim(TxtBase64Decode) = '' then
     begin
        jbLastErrorStr := '������ �������� Challenge';
        Result := False;
        Exit;
     end;
     // ����������
     Txt := DecodeBase64(TxtBase64Decode);
     // �������� ���������� Nonce �������� ��� ��������, ���� Nonce ���� � ������,
     // �� ������ �� ������� ��� ��������������� �����, �������� ����� ���
     // �������� 
     if Not ExtractFromKeys(Txt,'nonce', jbNonce) then
        SendStr(Packet_ResponseChallengeOk)
     else
     begin
        // ������� jbCNonce
        jbCNonce := GetRandomHexBytes(32);
        Packet := Packet_ResponseChallengeAuth(FJIDNode,FJIDDomain,FJIDPassword,jbNonce, jbCNonce);
        SendStr(Packet);
     end;
  end;
  // ���� ����������� �������� �������� welcom
  if AnsiCompareStr(Root.name, nodeSuccess) = 0 then // Success
  begin
     IsSASL := True;
     SendStr(Packet_Welcome(JIDDomain));
  end;
  // ������������
  if AnsiCompareStr(Root.name, nodeIQ) = 0 then
  begin
     // �������� ����������
     if Root.attribute[cType] = vResult then
     begin
        Node := Root.childNode[0];
        // ��������� �� Bind
        if Node.name = nodeBind then
           Node := Node.childNode[0];
           if Node.name = nodeJID then
           begin
              jbFullJID := Node.text;  // �������� �������� ��� Full JID
              SendStr(Packet_JIDOk);
           end;
        // ��������� ������
        if Node.name = nodeSession then
        begin
           // ������� ��������
           JStatus   := tjsConnect;
           if Assigned(FOnJabberLogin) then
              FOnJabberLogin(Self);
           // �������� ����� � ����������
           SendStr(Packet_Show(JIDShow));          // Show
           SendStr(Packet_Status(FJIDStatus));     // Status
           SendStr(Packet_Priority(FJIDPriority)); // Priority
           // ����������� ������
           SendStr(Packet_GetRosterList(jbFullJID));
        end;
     end;
     if Root.attribute[cType] = vError then
     begin
        jbLastErrorStr := 'id type error';    { TODO : �������� ���� �� ������� }
        Result := False;
        Exit;
     end;
  end;
end;

procedure TKDJabberClient.toMessage(Node : TjanXMLNode2);
var
 Types, From : WideString;
 Body        : UTF8String;
 BodyE       : string;
begin
 // <message type="chat" to="����" id="�� �������" from="�� ����">
 //    <body>���������</body>
 // </message>
 Types := VarToStr( Node.attribute[cType] );
 From  := UTF8Decode( Node.attribute[cFrom] );
 Body  := Node.childNode[0].text;

 BodyE := UTF8Decode(Body);
 BodyE := StringReplace(BodyE,'&lt;'  ,'<',[rfIgnoreCase]);
 BodyE := StringReplace(BodyE,'&gt;'  ,'>',[rfIgnoreCase]);
 BodyE := StringReplace(BodyE,'&amp;' ,'&',[rfIgnoreCase]);
 BodyE := StringReplace(BodyE,'&quot;','"',[rfIgnoreCase]);
 Body  := UTF8Encode(BodyE);

 // ��������� ����� ���������� ������� ����� ������������ ���� �������� �� ����������� XML
 // ���� XML ������ �� �������� ����� � ��� ��� ���������� ������ ������� ���
 // ���������
 if Pos('/message>', PacketStr) = 0 then
 begin
    isMessageDiv := True; // ������� ��� ��������� ���������
    BufPacketStr := PacketStr;
 end
 else
 begin
    isMessageDiv := False; // ������� ��� ��������� �� ���������
    IF Assigned(FOnJabberSentMessage) then
       FOnJabberSentMessage(Self, Types, From, Body);
 end;
end;

procedure TKDJabberClient.toNullTypesPresence(From: WideString;
  Node: TjanXMLNode2);
var
  I : Integer;
  vNode : TjanXMLNode2;
  vtShow : TShow;
  S : string;
begin
  if Assigned(FOnJabberUserPresence) then
     FOnJabberUserPresence(Self, From);

  for I := 0 to Node.childCount - 1 do
  begin
      vNode := Node.childNode[i];
      if (AnsiCompareStr(vNode.name, vShow) = 0)  then
      begin
         vtShow := Show_Str2Type(vNode.text);
         if Assigned(FOnJabberChangeShow) then
            FOnJabberChangeShow(Self, From, vtShow);
      end;
      if (AnsiCompareStr(vNode.name, vStatus) = 0)  then
      begin
         S := vNode.text;
         if Assigned(FOnJabberChangeStatus) then
            FOnJabberChangeStatus(Self, From, S);
      end;
  end;
end;

procedure TKDJabberClient.toPresence(Node: TjanXMLNode2);
var
 Types, From : WideString;
 fAction     : Boolean;
 Packet      : string;
begin
 fAction     := False;
 Types := VarToStr( Node.attribute[cType] );
 From  := UTF8Decode( Node.attribute[cFrom] );
 // ������������ ������� Presence (����������� � �����������)
 if (AnsiCompareStr(Types, '') = 0)  then
    toNullTypesPresence(From, Node);

 // ������������ ����� � �������
 if (AnsiCompareStr(Types, vUnavailable) = 0)  then
 begin
    if Assigned(FOnJabberUserOffline) then
       FOnJabberUserOffline(Self, From);
 end;   
 // ������ �� ��������
 if (AnsiCompareStr(Types, vSubscribe) = 0)  then
 begin
     // <presence to="����" type="subscribe"
     //    from="��"/>
     // <presence from="��" to="����">
     // <priority>0</priority><c xmlns="http://jabber.org/protocol/caps"
     // node="http://qip.ru/caps" ver="0.1.1.9"/></presence>
    if Assigned(FOnJabberSubscribe) then
       FOnJabberSubscribe(Self, From, fAction);
    if fAction then
    begin
       Packet := Packet_Subscribe(From);
       SendStr(Packet);
    end;
    Exit;
 end;
 // ���������� � ��� ��� ��� ��������� ����������
 if (AnsiCompareStr(Types, vSubscribed) = 0)  then
 begin
     // <presence to="����" type="subscribed"
     //    from="��"/>
     // <presence from="��" to="����">
     // <priority>0</priority><c xmlns="http://jabber.org/protocol/caps"
     // node="http://qip.ru/caps" ver="0.1.1.9"/></presence>
     if Assigned(FOnJabberSubscribed) then
        FOnJabberSubscribed(Self, From);
 end;
 // ��������� ��������
 if AnsiCompareStr(Types, vUnsubscribed) = 0 then
 begin
    // ��������� �����������
    // <presence to="����" type="unsubscribed"
    //           from="��"/>
    // <presence type="unavailable"
    //           from="��"
    //           to="����"/>
    if Assigned(FOnJabberUnsubscribed) then
       FOnJabberUnsubscribed(Self, From, fAction);
    if fAction then
    begin
       Packet := Packet_Unsubscribe(From);
       SendStr(Packet);
    end;
    Exit;
 end;
end;
                           
procedure TKDJabberClient.toIQ(Node: TjanXMLNode2);
var
 Types, NS   : WideString;
 Child       : TjanXMLNode2;
 fAction     : Boolean;
 Packet      : string;
begin
 Types := VarToStr( Node.attribute[cType]);
 // ������ ������ �� ���
 if AnsiCompareStr(Types, vGet) = 0 then
 begin
    Child := Node.childNode[0];
    if AnsiCompareStr(Child.name, nodeQuery) = 0 then
    begin
       NS :=  GetNS(Child);
       fAction := False;
       if AnsiCompareStr(NS, XEP_Software_Version) = 0 then
          fAction := toXEP_Software_Version(Node);
       if AnsiCompareStr(NS, XEP_Service_Discovery) = 0 then
          fAction := toXEP_Service_Discovery(Node);
       if Not fAction then
       begin
          { TODO : ������������ ����� �� ������������������ ����������� }
       end;  
    end;
 end;
 // ��������� �����������
 if AnsiCompareStr(Types, vResult) = 0 then
 begin
    Child :=  Node.childNode[0];
    if Assigned(Child) then
    begin
       NS    :=  GetNS(Child);
       if AnsiCompareStr(Child.name, nodeQuery) = 0 then
       begin
          // Roster List
          if AnsiCompareStr(NS, nsRoster) = 0 then
             toRosterListCreate(Child);
       end;
    end;
 end;
 // ���������� ��� ���
 if AnsiCompareStr(Types, vSet) = 0 then
 begin
    Child :=  Node.childNode[0];
    if Assigned(Child) then
    begin
       NS    :=  GetNS(Child);
       if AnsiCompareStr(Child.name, nodeQuery) = 0 then
       begin
          // Roster List
          if AnsiCompareStr(NS, nsRoster) = 0 then
             toRosterListUpdate(Child);
       end;
    end;
 end;
end;

function TKDJabberClient.toRosterListCreate(Node: TjanXMLNode2): Boolean;
var
 I : Integer;
 Child : TjanXMLNode2;
 RI    : TRosterItem;
 RosterInfo : TRosterInfo;
begin
 FRosters.Clear;
 for I := 0 to Node.childCount- 1 do
 begin
     Child := Node.childNode[i];
     if AnsiCompareStr(Child.name, vItem) = 0 then
     begin
        RosterInfo.Name :=   UTF8Decode( Child.attribute[cName]);
        RosterInfo.SubscriptionStates :=
                   SubscriptionStates_Str2Type( Child.attribute[cSubscription]);
        { TODO : �������� ������ }
        // ������� � ������ �������
        FRosters.AddRoster(Child.attribute[cJID], RosterInfo);
     end;
 end;
 // �������� ��� ������ ��������
 if Assigned(FOnJabberRosterListLoaded) then
    FOnJabberRosterListLoaded(Self);
end;

function TKDJabberClient.toRosterListUpdate(Node: TjanXMLNode2): Boolean;
var
 I : Integer;
 Child : TjanXMLNode2;
 RI    : TRosterItem;
 RosterInfo : TRosterInfo;
 RosterJID  : string;
begin
 for I := 0 to Node.childCount- 1 do
 begin
     Child := Node.childNode[i];
     if AnsiCompareStr(Child.name, vItem) = 0 then
     begin
        RosterJID := Child.attribute[cJID];
        // ������� ���� �� subscription
        if Child.attribute[cSubscription] = vRemove then
        begin
           FRosters.DeleteRoster(RosterJID);
           // �������������� �� �������� ����������� �������
           if Assigned(FOnJabberRosterDelete) then
              FOnJabberRosterDelete(Self, RosterJID);
        end
        else
        begin
           RosterInfo.Name :=   UTF8Decode( Child.attribute[cName] );
           RosterInfo.SubscriptionStates :=
                      SubscriptionStates_Str2Type( Child.attribute[cSubscription]);
           { TODO : �������� ������ }
           // ������� ������
           RI := FRosters.UpdateRoster(RosterJID, RosterInfo);
           if Assigned(RI) then
           begin
              { TODO : �������� ������ }
           end;
           // �������������� �� ���������� ��� ���������� ����������� �������
           if Assigned(FOnJabberRosterAddOrUpdate) then
              FOnJabberRosterAddOrUpdate(Self, RosterJID);
        end;
     end;
 end;
 // �������� ��� ������ ��������
 if Assigned(FOnJabberRosterListUpdate) then
             FOnJabberRosterListUpdate(Self);
end;

Function TKDJabberClient.toXEP_Software_Version(Node: TjanXMLNode2): Boolean;
var
  From, ID  : string;
  Packet: string;
begin
  Result:= True;
  ID    := Node.attribute[cID];
  From  := UTF8Decode( Node.attribute[cFrom] );
  Packet:= Packet_XEP_Jabber_IQ_Version(From,jbFullJID,ID,cClient, cVer);
  SendStr(Packet);
end;

Function TKDJabberClient.toXEP_Service_Discovery(Node: TjanXMLNode2): Boolean;
var
  From, ID  : string;
  Packet: string;
begin
  Result:= True;
  ID    := Node.attribute[cID];
  From  := UTF8Decode( Node.attribute[cFrom] );
  Packet:= Packet_XEP_Service_Discovery(From,jbFullJID,ID);
  SendStr(Packet);
end;

function TKDJabberClient.ProcessMain: Boolean;
var
  I : Integer;
  Node : TjanXMLNode2;
begin
  Result := True;
  try
    // ��������� � STREAM ��� ���������� ��������� �������� ����� ��������
    XML.XML := '<STREAM>' + PacketStr + '</STREAM>';
  Except
  end;

  // ������ �� �������� �����, ������� ��� ����, ��� ����� ��������� ������
  // ���������
  Node := XML.rootNode.FirstChild;
  repeat
     // Presence ������
     if AnsiCompareStr(Node.name, nodePresence) = 0 then
        toPresence(Node);
     // IQ ������
     if AnsiCompareStr(Node.name, nodeIQ) = 0 then
        toIQ(Node);
     // ������ ��������� - message
     if AnsiCompareStr(Node.name, nodeMessage) = 0 then //
        toMessage(Node);

     // ���� �������� ���� ���� ��� ���� �������   
     Node := Node.NextSibling;
  until not Assigned(Node) ;
end;

procedure TKDJabberClient.StartLogged;
begin
   // ������������� ���� ��� �� �������� ����������
  if (not IsLoggedIn) and (IsConnected) then
  begin
     IsSASL  := False;
     isSendAuthInitiation := False;
     JStatus := tjsConnecting;
     SendStr(Packet_Welcome(JIDDomain));
  end;
end;


end.
