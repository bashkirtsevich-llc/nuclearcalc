{*******************************************************}
{                                                       }
{       Jabber Client Module                            }
{                                                       }
{  	    Copyright (c) 2008-2009 Dmitriy Kuzan           }
{                                                       }
{       21 января 2009 г                                }
{                                                       }
{*******************************************************}
//В компоненте используются наработки по WinSock -
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
  // Упреждающее объявление класса
  TKDJabberClient = class;

  // Параметры прокси
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
    FSocket    : TEventSocket; {Родительский кдасс}
    FHTTPConnected: Boolean;   // Флаг соединения
    XML: TjanXMLParser2;       // XML парсер
    Root : TjanXMLNode2;       // Root Node
    JStatus : TJabberStatus;   // Статус

    jbID     : string;         // ID при коннекте
    jbNonce  : string;         // Уникальный Nonce от сервера
    jbCNonce : string;         // Уникальный CNONCE от клиента
    jbRsPauth : string;        // Уникальный rspauth
    jbLastErrorStr : String;
    jbFullJID      : String;

    BufPacketStr : String;     // Буферизированная строка
    PacketStr : string;        // Хранит последний пришедший пакет в виде строки
    IsSASL    : Boolean;       // Пройдена ли SASL аутенфикация
    isMessageDiv : Boolean;    // Сообщение нарезано
    isSendAuthInitiation : Boolean;    // Был послан начальный пакет авторизации

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
    // Обрабатываем полученый XML в процессе подключения
    function ProcessConnection : Boolean;
    // Обрабатываем полученый XML в процессе основной работы, когда мы находимся в
    // онлайне
    function ProcessMain : Boolean;
    // Обработка дополнительная
    procedure toMessage(Node : TjanXMLNode2);
    procedure toPresence(Node : TjanXMLNode2);
    procedure toNullTypesPresence(From : WideString; Node : TjanXMLNode2);
    procedure toIQ(Node : TjanXMLNode2);
    // Реализация XEP (расширений протокола)
    Function  toXEP_Software_Version(Node : TjanXMLNode2)  : Boolean;
    Function  toXEP_Service_Discovery(Node : TjanXMLNode2) : Boolean;
    // Ростер лист (создать)
    Function  toRosterListCreate(Node : TjanXMLNode2) : Boolean;
    // Ростер лист (обновить)
    Function  toRosterListUpdate(Node : TjanXMLNode2) : Boolean;

    procedure FreeSockets;                             // Освободить все сокеты
    procedure SendData(var Data; DataLen: LongWord);   // Послать данные

    // Удалить и освободить сокет
    procedure FreeSocket(var Socket: TEventSocket);
    // Свои обработчики
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
    procedure SendStr(const Value: String);            { TODO : в Private }
    procedure Connect;                                 // Соеденится
    procedure Disconnect;                              // Отсоеденится
    Procedure StartLogged;
    // Пинг XMPP сервера извещающего его что мы на связи
    Procedure SendKeepAlive;
    // Посылка сообщения
    Procedure SendMessage(JID,From :String; Body : string);
    // Посылка об подписке
    Procedure JIDSubscribe(JID :String);
    // Посылка сообщения об отписке
    Procedure JIDUnsubscribed(JID :String);
    // Есть физическое соединение
    Function  IsConnected : Boolean;
    // Пройдена авторизация
    Function  IsLoggedIn  : Boolean;
    // Ростер-лист
    property  Rosters : TRostersCollections read FRosters;
    // Управление ростером
    procedure RosterAddOrUpdate(JID : string; RosterInfo : TRosterInfo); overload;
    procedure RosterAddOrUpdate(JIDItem : TRosterItem; RosterInfo : TRosterInfo); overload;
    procedure RosterDelete(JID : string); overload;
    procedure RosterDelete(JIDItem : TRosterItem); overload;
  published
    // Хост и Порт подключения
    property Host: String read FHost write FHost;
    property Port: Word read FPort write FPort;
    // Способ соединения
    property ProxyType: TProxyType_ read FProxyType write FProxyType;
    // Настройки прокси
    property Proxy : TProxyOptions read FProxy write FProxy;
    // Настройки Jabber
    property JIDNode : string read FJIDNode write FJIDNode;
    property JIDDomain : string read FJIDDomain write FJIDDomain;
    property JIDResource : string read FJIDResource write FJIDResource;
    property JIDPassword : string read FJIDPassword write FJIDPassword;
    // статусы и свойства
    property JIDShow   : TShow read FJIDShow write SetJIDShow;
    property JIDStatus : string read FJIDStatus write SetJIDStatus;
    property JIDPriority : byte read FJIDPriority write SetJIDPriority default 5;
    // Свойства
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
    // JABBER свойства
    // -------------------------------------------------------------------------
    // Авторизованы
    Property  OnJabberLogin   : TNotifyEvent read FOnJabberLogin write FOnJabberLogin;
    // Ошибка при авторизации
    Property  OnJabberNotAuthorized : TNotifyEvent  read FOnJabberNotAuthorized
                                                    write FOnJabberNotAuthorized;
    // Пришло сообщение
    Property  OnJabberSentMessage : TJabberSentMessage read FOnJabberSentMessage
                                                      write FOnJabberSentMessage;
    // Пришла подписка
    Property  OnJabberSubscribe : TJabberSubscribe      read FOnJabberSubscribe
                                                        write FOnJabberSubscribe;
    // Пришла информация о том что нас подписали
    Property  OnJabberSubscribed : TJabberSubscribed     read FOnJabberSubscribed
                                                        write FOnJabberSubscribed;
    // Пришел запрос на отписку
    Property  OnJabberUnsubscribed : TJabberUnsubscribed read FOnJabberUnsubscribed
                                                        write FOnJabberUnsubscribed;
    // Уведомление о присутствии
    Property  OnJabberUserPresence :  TJabberJIDEvent read FOnJabberUserPresence
                                                        write FOnJabberUserPresence;
    // Пользователь сменил show состояние
    Property  OnJabberChangeShow :  TJabberChangeShow read FOnJabberChangeShow
                                                        write FOnJabberChangeShow;
    // Пользователь сменил статус (текст)
    Property  OnJabberChangeStatus :  TJabberChangeStatus read FOnJabberChangeStatus
                                                        write FOnJabberChangeStatus;
    // Пользователь в оффлайн
    Property  OnJabberUserOffline :  TJabberJIDEvent read FOnJabberUserOffline
                                                        write FOnJabberUserOffline;
    // Roster лист получен и загружен
    Property  OnJabberRosterListLoaded : TNotifyEvent  read FOnJabberRosterListLoaded
                                                    write FOnJabberRosterListLoaded;
    // Roster лист обновлен
    Property  OnJabberRosterListUpdate : TNotifyEvent  read FOnJabberRosterListUpdate
                                                    write FOnJabberRosterListUpdate;
    // Ростер удален из списка контактов
    Property  OnJabberRosterAddOrUpdate :  TJabberJIDEvent read FOnJabberRosterAddOrUpdate
                                                        write FOnJabberRosterAddOrUpdate;
    // Ростер удален из списка контактов
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
     // Не прошли авторизацию
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
    // Найдена запись в ростер-листе, есть такой JID
    // формируем пакет и отправляем
    RosterAddOrUpdate(JIDItem, RosterInfo);
 end
 else
 begin
    // новый JID
    // добавим в наш ростер лист
    JIDItem := FRosters.AddRoster(JID, RosterInfo);
    // формируем пакет и отправляем
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
       P_NONE  : FSocket := TEventSocket.Create;     {Прямое соединение}
       P_HTTP  : FSocket := THTTPSocket.Create;      {Использовать HTTP прокси}
       P_HTTPS : FSocket := THTTPSSocket.Create;     {Использовать HTTPS прокси}
  else
       Exit;
  end;                         

  if FProxyType = P_NONE then
  begin
    FSocket.ProxyReady := True;
    FSocket.ProxyHost  := FHost;         {через прокси-класс
                                          ProxyHost - на самом деле Host       }
    FSocket.ProxyPort  := FPort;
  end
  else
     if FProxyType = P_HTTP then
     begin
        { TODO : разобратся почему host и порт не указаны }
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
  // Посылаем строку
  FSocket.SendData(@Value[1], Length(Value));
end;



procedure TKDJabberClient._OnConnect(Sender: TObject);
begin
  if Assigned(FOnConnect) then
     FOnConnect(Self);
end;

procedure TKDJabberClient._OnDataSent(Sender: TObject);
begin
 // Заглушка           { TODO : проверить обработчик }
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

   // Данный факт показывает что пакет не XML
   if PacketStr[1] <> '<' then
   begin
      BufPacketStr := BufPacketStr + PacketStr;
      if isMessageDiv then
      begin
         // смотрим нет ли в буферной строке тега '</message>'
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

   // Прверяем пространство имен
   if Root.namespace = nsStream then
   begin
      {TODO : Проверяем XML на ошибку stream:error}
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
      // ошибок нет
      FlagOk := True;
      case JStatus of
           {Мы в режиме ожидания соединения, обрабатываем XML}
           tjsConnecting : FlagOk := ProcessConnection;
           {Мы в режиме коннекта, обрабатываем XML}
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
      //{ TODO : Сгенерить ошибку о неверном пространстве имен }
   end;
end;

function TKDJabberClient.ProcessConnection : Boolean;
var
  TxtBase64Decode, Txt : string;
  Packet : string;
  Node   : TjanXMLNode2;
begin
  Result := True;
  // Сервер отвечат нашему запросу
  if AnsiCompareStr(Root.name, nodeStream) = 0 then //stream:stream
  begin
     // Запоминаем ID
     jbID := Root.attribute[cID];
     if Trim(jbID) = '' then
     begin
        jbLastErrorStr := 'Пустое ID';
        Result := False;
        Exit;
     end;
     // ------------------------------------------------------------------------
     // Resource Binding
     // После проходения SASL аутенфикации
     // клиент должен связать поток с конкретным ресурсом
     // в формате полного JID
     // ------------------------------------------------------------------------
     if IsSASL then
     begin
        // Мы получили информирование от сервера, что мы дожны обязательно
        // сформировать JID
        // посылаем свой идентификатор ресурса
        Packet := Packet_Bind(FJIDResource);
        SendStr(Packet);
     end;
  end;
  //Сервер информирует нас об механизмах идентификации features
  if AnsiCompareStr(Root.name, nodeFeatures) = 0 then // stream:features
  begin
     // Получаем свойства (features) сервера, в ответ на это мы должны послать
     // сигнал о начале аутенфикации
     { TODO : получить свойства сервера }
     // Посылаем серверу сообщение о начале идентификации по MD5
     if Not isSendAuthInitiation then
     begin
         SendStr(Packet_Initiation);
         isSendAuthInitiation := True;
     end;
  end;
  // Сервер нам посылает в BASE 64 данные по challenge
  if AnsiCompareStr(Root.name, nodeChallenge) = 0 then  // challenge
  begin
     // Получаем закодированный текст
     TxtBase64Decode := Root.Text;
     if Trim(TxtBase64Decode) = '' then
     begin
        jbLastErrorStr := 'Пустое значение Challenge';
        Result := False;
        Exit;
     end;
     // Декодируем
     Txt := DecodeBase64(TxtBase64Decode);
     // Получаем уникальный Nonce выданный нам сервером, если Nonce нету в ответе,
     // то значит мы послали уже авторизационный пакет, посылаем ответ что
     // получили 
     if Not ExtractFromKeys(Txt,'nonce', jbNonce) then
        SendStr(Packet_ResponseChallengeOk)
     else
     begin
        // Генерим jbCNonce
        jbCNonce := GetRandomHexBytes(32);
        Packet := Packet_ResponseChallengeAuth(FJIDNode,FJIDDomain,FJIDPassword,jbNonce, jbCNonce);
        SendStr(Packet);
     end;
  end;
  // Если авторизация пройдена посылаем welcom
  if AnsiCompareStr(Root.name, nodeSuccess) = 0 then // Success
  begin
     IsSASL := True;
     SendStr(Packet_Welcome(JIDDomain));
  end;
  // Обрабатываем
  if AnsiCompareStr(Root.name, nodeIQ) = 0 then
  begin
     // получили результаты
     if Root.attribute[cType] = vResult then
     begin
        Node := Root.childNode[0];
        // результат по Bind
        if Node.name = nodeBind then
           Node := Node.childNode[0];
           if Node.name = nodeJID then
           begin
              jbFullJID := Node.text;  // получаем выданный нам Full JID
              SendStr(Packet_JIDOk);
           end;
        // Окончание сессии
        if Node.name = nodeSession then
        begin
           // КОННЕКТ ЗАВЕРШЕН
           JStatus   := tjsConnect;
           if Assigned(FOnJabberLogin) then
              FOnJabberLogin(Self);
           // Посылаем пакет о готовности
           SendStr(Packet_Show(JIDShow));          // Show
           SendStr(Packet_Status(FJIDStatus));     // Status
           SendStr(Packet_Priority(FJIDPriority)); // Priority
           // Запрашиваем ростер
           SendStr(Packet_GetRosterList(jbFullJID));
        end;
     end;
     if Root.attribute[cType] = vError then
     begin
        jbLastErrorStr := 'id type error';    { TODO : Доделать инфу об ошибках }
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
 // <message type="chat" to="кому" id="ид клиента" from="от кого">
 //    <body>Сообщение</body>
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

 // Сообщение может разбиватся поэтому перед обработчиком идет проверка на целостность XML
 // если XML полный то посылаем сразу а нет так дожидаемся друних пакетов для
 // обработки
 if Pos('/message>', PacketStr) = 0 then
 begin
    isMessageDiv := True; // Говорим что сообщение разрывное
    BufPacketStr := PacketStr;
 end
 else
 begin
    isMessageDiv := False; // Говорим что сообщение НЕ разрывное
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
 // Пользователь прислал Presence (уведомление о присутствии)
 if (AnsiCompareStr(Types, '') = 0)  then
    toNullTypesPresence(From, Node);

 // Пользователь вышел в оффлайн
 if (AnsiCompareStr(Types, vUnavailable) = 0)  then
 begin
    if Assigned(FOnJabberUserOffline) then
       FOnJabberUserOffline(Self, From);
 end;   
 // Запрос на подписку
 if (AnsiCompareStr(Types, vSubscribe) = 0)  then
 begin
     // <presence to="кому" type="subscribe"
     //    from="от"/>
     // <presence from="от" to="кому">
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
 // Информация о том что вам разрешили авториацию
 if (AnsiCompareStr(Types, vSubscribed) = 0)  then
 begin
     // <presence to="кому" type="subscribed"
     //    from="от"/>
     // <presence from="от" to="кому">
     // <priority>0</priority><c xmlns="http://jabber.org/protocol/caps"
     // node="http://qip.ru/caps" ver="0.1.1.9"/></presence>
     if Assigned(FOnJabberSubscribed) then
        FOnJabberSubscribed(Self, From);
 end;
 // Отозвание подписки
 if AnsiCompareStr(Types, vUnsubscribed) = 0 then
 begin
    // Отозвание авторизации
    // <presence to="кому" type="unsubscribed"
    //           from="от"/>
    // <presence type="unavailable"
    //           from="от"
    //           to="кому"/>
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
 // Запрос данных от нас
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
          { TODO : Сформировать ответ об неподдерживающейся возможности }
       end;  
    end;
 end;
 // Получение результатов
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
 // Информация для нас
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
        { TODO : доделать группы }
        // Добавим в список ростера
        FRosters.AddRoster(Child.attribute[cJID], RosterInfo);
     end;
 end;
 // Сообщаем что ростер загружен
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
        // Смотрим есть ли subscription
        if Child.attribute[cSubscription] = vRemove then
        begin
           FRosters.DeleteRoster(RosterJID);
           // Проинформируем об удалении конкретного ростера
           if Assigned(FOnJabberRosterDelete) then
              FOnJabberRosterDelete(Self, RosterJID);
        end
        else
        begin
           RosterInfo.Name :=   UTF8Decode( Child.attribute[cName] );
           RosterInfo.SubscriptionStates :=
                      SubscriptionStates_Str2Type( Child.attribute[cSubscription]);
           { TODO : доделать группы }
           // Обновим ростер
           RI := FRosters.UpdateRoster(RosterJID, RosterInfo);
           if Assigned(RI) then
           begin
              { TODO : Возможно индекс }
           end;
           // Проинформируем об обновлении или добавлении конкретного ростера
           if Assigned(FOnJabberRosterAddOrUpdate) then
              FOnJabberRosterAddOrUpdate(Self, RosterJID);
        end;
     end;
 end;
 // Сообщаем что ростер обновлен
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
    // Обрамляем в STREAM для корректной обработки братских узлов парсером
    XML.XML := '<STREAM>' + PacketStr + '</STREAM>';
  Except
  end;

  // Пробег по братским нодам, сделано для того, что могут приходить пакеты
  // склеенные
  Node := XML.rootNode.FirstChild;
  repeat
     // Presence пакеты
     if AnsiCompareStr(Node.name, nodePresence) = 0 then
        toPresence(Node);
     // IQ пакеты
     if AnsiCompareStr(Node.name, nodeIQ) = 0 then
        toIQ(Node);
     // пакеты сообщений - message
     if AnsiCompareStr(Node.name, nodeMessage) = 0 then //
        toMessage(Node);

     // след братскую ноду если она есть конечно   
     Node := Node.NextSibling;
  until not Assigned(Node) ;
end;

procedure TKDJabberClient.StartLogged;
begin
   // Устанавливаем флаг что мы начинаем соединение
  if (not IsLoggedIn) and (IsConnected) then
  begin
     IsSASL  := False;
     isSendAuthInitiation := False;
     JStatus := tjsConnecting;
     SendStr(Packet_Welcome(JIDDomain));
  end;
end;


end.
