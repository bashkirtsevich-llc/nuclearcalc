unit KDSocket.Servers;

interface

Uses Windows, WinSock, Classes,
     KDSocket.Proxy,
     KDSocket.Utilites,
     KDSocket.Types;

Type
  TMySocket = class; // упреждающее объявление класса

  TOnSrvSockConnected = procedure(Sender: TObject; Socket: TSocket) of object;
  TOnClientConnected  = procedure(Sender: TObject;  Socket: TMySocket) of object;
  TOnAdvPktParse      = procedure(Sender: TObject; Host: String; Port: Word;
                                  Buffer: Pointer; BufLen:
                                  LongWord; Incoming: Boolean) of object;
  TOnRecv             = procedure(Sender: TObject; Socket: TSocket;
                                  Buffer: Pointer;
                                  BufLen: LongWord) of object;

  TTCPServer = class(TThread)
  private
    FSocket: TSocket;
    FPort  : Word;
    FClient: TSocket;
    FLastError : Word;       {Храним последнии ошибки}
    FLastErrMsg: String;
    FOnError: TOnError;
    FOnClientConnected: TOnSrvSockConnected;
  protected
    procedure Execute; override;
    procedure WaitForConnection;
    procedure FreeSocket;
  public
    constructor Create;
    destructor  Destroy; override;
    function  Start: Boolean;
    procedure OnError;  virtual;
    procedure OnClientConnected;
    property  Port: Word read FPort write FPort;
    property _OnError: TOnError read FOnError write FOnError;
    property _OnClientConnected: TOnSrvSockConnected read FOnClientConnected write FOnClientConnected;
  end;

  TServerSocket = class(TTCPServer)
  private
     fOnCliConn:TOnSrvSockConnected;
     procedure DoConnEvent;
  public
      procedure OnClientConnected; virtual;
      property  OnConnected: TOnSrvSockConnected read fOnCliConn write fOnCliConn;
  End;

  TSrvSocket = class(TObject)
  private
    fSrv : TTCPServer; // наш класс TCP Сервер
    fPort:word;
    FOnError:TOnError;
    fIsListening:Boolean;
    FOnClientConnected: TOnClientConnected;
    procedure OnSrvConnProc(Sender: TObject; Socket: TSocket);
    procedure OnSrvErrProc(Sender: TObject; ErrorType: TErrorType_; ErrorMsg: String);
    function  GetPort:Word;
    procedure SetPort( aPort: Word);
  Public
    constructor Create;
    destructor  Destroy; override;
    // Запуск сервера на порту
    function StartServer(Port: Word): Boolean;
    // Остановка
    function StopServer: Boolean;
    // Порт
    property Port: Word read GetPort write SetPort;
  published
    property OnError:TOnError read fOnError write fOnError;
    property OnClientConnected: TOnClientConnected read FOnClientConnected write FOnClientConnected;
  End;

  // Базовый инкапсулирующий класс (можно сказать мега заготовка)
  TMySocket = class(TObject)
  private
    FHost:String;
    fPort:Word;
    // Потоковый Socket
    FEventSocket : TEventSocket;
    FSocket      : TSocket;
    //  События
    FOnConnectError: TNotifyEvent;
    FOnDisconnect  : TNotifyEvent;
    FOnPktParse    : TOnAdvPktParse;
    FOnError       : TOnError;
    FOnRecv        : TOnRecv;
    FOnConnectProc : TNotifyEvent;
    FOnDataSent    : TNotifyEvent;

    function  GetClientSocket: TSocket;
    procedure SetClientSocket(Socket: TSocket);
    function  IsConnected: Boolean;
    Procedure SetHost( aHost: String);
    Procedure SetPort( aPort: Word);
    Function  GetHost: String;
    Function  GetPort: Word;
    Procedure SetProxyType( aProxyType: TProxyType_);
    Procedure SetProxyHost( aProxyHost: String);
    Procedure SetProxyPort( aProxyPort: Word);
    Procedure SetProxyAuth( aProxyAuth: Boolean);
    Procedure SetProxyPass( aProxyPass: String);
    Procedure SetProxyUser( aProxyUser: String);
    Procedure SetProxyRslv( aProxyRslv: Boolean);
    Function  GetProxyType: TProxyType_;
    Function  GetProxyHost: String;
    Function  GetProxyPort: Word;
    Function  GetProxyAuth: Boolean;
    Function  GetProxyPass: String;
    Function  GetProxyUser: String;
    Function  GetProxyRslv: Boolean;
    // обработчики для событий TEventSocket
    Procedure OnConnectErrorProc(Sender: TObject);
    Procedure OnDisconnectProc(Sender: TObject);
    Procedure OnConnect(Sender: TObject);
    Procedure OnErrorProc(Sender: TObject; ErrorType: TErrorType_; ErrorMsg: String);
    Procedure OnReceive(Sender: TObject; Buffer: Pointer; BufLen: LongWord);
    Procedure OnDataSentProc(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Connect; dynamic;
    procedure Disconnect;
    procedure SendData(var Buf; BufLen: LongWord);
    property Host: String read fHost write fHost;
    property Port: Word read fPort write fPort;
    property ProxyType: TProxyType_ read GetProxyType write SetProxyType;
    property ProxyHost: String read GetProxyHost write SetProxyHost;
    property ProxyPort: Word read GetProxyPort write SetProxyPort;
    property ProxyUser: String read GetProxyUser write SetProxyUser;
    property ProxyAuth: Boolean read GetProxyAuth write SetProxyAuth;
    property ProxyPass: String read GetProxyPass write SetProxyPass;
    property ProxyResolve: Boolean read GetProxyRslv write SetProxyRslv default False;
  published
    // Соеденено ли
    property Connected : Boolean read IsConnected;
    // Доп.обработчики
    property OnConnectError: TNotifyEvent read FOnConnectError write FOnConnectError;
    property OnDisconnect  : TNotifyEvent read FOnDisconnect write FOnDisconnect;
    property OnPktParseA   : TOnAdvPktParse read FOnPktParse write FOnPktParse;
    property OnError       : TOnError read FOnError write FOnError;
    property OnReceiveProc : TOnRecv read FOnRecv write FOnRecv;
    property OnConnectProc : TNotifyEvent read FOnConnectProc write FOnConnectProc;
    property OnDataSent    : TNotifyEvent read FOnDataSent write FOnDataSent;
    property ClientSocket  : TSocket read GetClientSocket write SetClientSocket;
  End;

implementation

{ TTCPServer }

constructor TTCPServer.Create;
begin
  inherited Create(True);
  FSocket := INVALID_SOCKET;
end;

destructor TTCPServer.Destroy;
begin
  FreeSocket;
  inherited;
end;

procedure TTCPServer.FreeSocket;
begin
  if not Terminated then
     Terminate;
  if FSocket <> INVALID_SOCKET then
     closesocket(FSocket);
end;

procedure TTCPServer.WaitForConnection;
Var
  FD,FDW,FDE:TFDSet;
Begin
  // Инициализируем множество FD
  FD_ZERO(FD);
  // Добавляет сокет Socket в множество FD.
  FD_SET(fSocket, FD);

  // Инициализируем множество FDW
  FD_ZERO(FDW);
  // Добавляет сокет Socket в множество FDW.
  FD_SET(fSocket, FDW);

  // Инициализируем множество FDE
  FD_ZERO(FDE);
  // Добавляет сокет Socket в множество FDE.
  FD_SET(fSocket, FDE);

  // Определяем готов ли сокет  к немедленному (без блокирования)
  // выполнению той или иной операции
  // Первый параметр этой функции оставлен только для совместимости
  // со старыми версиями библиотеки сокетов; в существующих версиях
  // он игнорируется.
  select(fSocket + 1, @FD, @FDW, @FDE, nil); // Ожидаем
end;

procedure TTCPServer.Execute;
begin
  SetCurrentThreadName('TCPServer execute');

  while not Terminated do
  begin
     // Ждем коннекта.
     WaitForConnection;
     // Так как этот сокет находится в режиме ожидания соединения,
     // для него состояние готовности означает,
     // что в очереди соединений появились клиенты
     // Вызвов функции Accept служит для создания сокета
     // для взаимодействия с этими клиентами.
     FClient := accept(FSocket, nil, nil);
    if (FClient = INVALID_SOCKET) then
    begin
        if not Terminated then
        begin
           FLastError  := WSAGetLastError;
           FLastErrMsg := 'Невозможно выполнить функцию Accept';
           Synchronize(OnError);
        end;
        Exit;
    end
    else
        Synchronize(OnClientConnected);
  end;
end;

procedure TTCPServer.OnClientConnected;
begin
  if Assigned(_OnClientConnected) then
     FOnClientConnected(Self, FClient);
end;

procedure TTCPServer.OnError;
begin
  FreeSocket;
  if Assigned(_OnError) then
     FOnError(Self, ERR_SOCKET, FLastErrMsg);
end;

function TTCPServer.Start: Boolean;
var
  srv_addr: TSockAddrIn;
begin
  // Обычная последовательность действий по созданию сокета,
  // привязке его к адресу и установлению на прослушивание
  Result  := False;
  FSocket := socket(PF_INET, SOCK_STREAM, 0);
  srv_addr.sin_family := AF_INET;
  srv_addr.sin_port   := htons(FPort);
  srv_addr.sin_addr.S_addr := INADDR_ANY;
  // Привязка сокета к адресу и порту
  if bind(FSocket, srv_addr, sizeof(srv_addr)) = SOCKET_ERROR then
  begin
     FLastError  := WSAGetLastError;
     FLastErrMsg := 'Невозможно запустить сервер. Сокет не привязан к адресу';
     Synchronize(OnError);
     Exit;
  end;
  // Перевод в режим ожидания соединения
  if listen(FSocket, SOMAXCONN) = SOCKET_ERROR then begin
     FLastError  := WSAGetLastError;
     FLastErrMsg := 'Невозможно установить сокет в статус ожидания соединений';
     Synchronize(OnError);
     Exit;
  end;
  Result := True;
  Self.Resume;
end;

{ TServerSocket }
procedure TServerSocket.DoConnEvent;
begin
 fOnCliConn(Self, fClient);
end;

procedure TServerSocket.OnClientConnected;
begin
 If assigned(fOnCliConn) then
    Synchronize(DoConnEvent);
end;

{ TSrvSocket }
constructor TSrvSocket.Create;
begin
  inherited Create;
  fSrv := TServerSocket.Create;
  fSrv.FreeOnTerminate    := False;
  fSrv._OnClientConnected := OnSrvConnProc;
  fSrv._OnError           := OnSrvErrProc;
  fIsListening := False;
end;

destructor TSrvSocket.Destroy;
begin
  fSrv.FreeOnTerminate := True;
  StopServer;
  inherited Destroy;
end;

procedure TSrvSocket.OnSrvConnProc(Sender: TObject; Socket: TSocket);
Var
  aMS:TMySocket;
Begin
  If Assigned(fOnClientConnected) then
  Begin
     aMS := TMySocket.Create;
     aMS.ProxyType    := P_None;
     aMS.ClientSocket := Socket;
     fOnClientConnected(Self, aMS);
  End;
end;

procedure TSrvSocket.OnSrvErrProc(Sender: TObject; ErrorType: TErrorType_;
  ErrorMsg: String);
begin
  If assigned(fOnError) then
     fOnError(Sender, ErrorType, ErrorMsg);
end;

procedure TSrvSocket.SetPort(aPort: Word);
begin
  fSrv.Port := aPort;
  fPort     := aPort;
end;

function TSrvSocket.GetPort: Word;
begin
  Result := fSrv.Port;
end;

function TSrvSocket.StartServer(Port: Word): Boolean;
begin
  fSrv.Port := Port;
  fPort     := Port;
  Result    := fSrv.Start;      {стартуем TCP сервер}
  fIsListening := Result;
end;

function TSrvSocket.StopServer: Boolean;
begin
  fSrv.FreeSocket;
  fIsListening := False;
  Result := True;
end;

{ TMySocket }
constructor TMySocket.Create;
begin
  Inherited Create;
  FEventSocket := TEventSocket.Create;
  // Переопределяем обработчики
  FEventSocket._OnConnectError := OnConnectErrorProc;
  FEventSocket._OnConnect      := OnConnect;
  FEventSocket._OnDisconnect   := OnDisconnectProc;
  FEventSocket._OnError        := OnErrorProc;
  FEventSocket._OnReceive      := OnReceive;
  FEventSocket._OnDataSent     := OnDataSentProc;
  fSocket := INVALID_SOCKET;
end;

destructor TMySocket.Destroy;
begin
  FEventSocket.Free;
  inherited;
end;

procedure TMySocket.Connect;
begin
  If FEventSocket.Connected Then
     exit;

  FEventSocket.Host := fHost;
  FEventSocket.Port := fPort;
  {Прокся}
  FEventSocket.ProxyReady := True;
  FEventSocket.ProxyHost  := fHost;
  FEventSocket.ProxyPort  := fPort;
  {Коннект}
  FEventSocket.Connect;
end;

procedure TMySocket.Disconnect;
begin
  If Not FEventSocket.Connected then
     Exit;
  FEventSocket.FreeSocket;
end;

procedure TMySocket.SendData(var Buf; BufLen: LongWord);
begin
  // Посылаем даннные в сокет
  FEventSocket.SendData(@Buf, BufLen);
end;

procedure TMySocket.SetHost(aHost: String);
begin
  FEventSocket.Host := aHost;
end;

function TMySocket.GetHost: String;
begin
  Result := FEventSocket.Host;
end;

procedure TMySocket.SetPort(aPort: Word);
begin
  FEventSocket.Port := aPort
end;

function TMySocket.GetPort: Word;
begin
  Result := FEventSocket.Port;
end;

procedure TMySocket.SetClientSocket(Socket: TSocket);
begin
  fSocket  := Socket;
  fEventSocket.ProxyReady := True;
  FEventSocket.StartWork(fSocket); {стартовать поток с сокетом новым}
end;

function TMySocket.GetClientSocket: TSocket;
begin
  If FSocket = INVALID_SOCKET then
     Result := FEventSocket.GetSocket
  Else
     Result := FSocket;
end;

procedure TMySocket.SetProxyAuth(aProxyAuth: Boolean);
begin
  FEventSocket.ProxyAuth := aProxyAuth;
end;


function TMySocket.GetProxyAuth: Boolean;
begin
  Result := FEventSocket.ProxyAuth;
end;

procedure TMySocket.SetProxyRslv(aProxyRslv: Boolean);
begin
  FEventSocket.ProxyResolve := aProxyRslv;
end;

function TMySocket.GetProxyRslv: Boolean;
begin
  Result := FEventSocket.ProxyResolve;
end;

procedure TMySocket.SetProxyHost(aProxyHost: String);
begin
  FEventSocket.ProxyHost := aProxyHost;
end;

function TMySocket.GetProxyHost: String;
begin
  Result := FEventSocket.ProxyHost;
end;

procedure TMySocket.SetProxyPort(aProxyPort: Word);
begin
  FEventSocket.ProxyPort := aProxyPort;
end;

function TMySocket.GetProxyPort: Word;
begin
  Result := FEventSocket.ProxyPort;
end;

procedure TMySocket.SetProxyUser(aProxyUser: String);
begin
  FEventSocket.ProxyUser := aProxyUser;
end;

function TMySocket.GetProxyUser: String;
begin
  Result := FEventSocket.ProxyUser;
end;

procedure TMySocket.SetProxyPass(aProxyPass: String);
begin
  FEventSocket.ProxyPass := aProxyPass;
end;
 
function TMySocket.GetProxyPass: String;
begin
  Result := FEventSocket.ProxyPass;
end;

procedure TMySocket.SetProxyType(aProxyType: TProxyType_);
begin
 // Заглушка
end;

function TMySocket.GetProxyType: TProxyType_;
begin
  Result := P_NONE;
end;

function TMySocket.IsConnected: Boolean;
begin
 Result := FEventSocket.Connected;
end;

// - - - О Б Р А Б О Т Ч И К И - - - -
procedure TMySocket.OnConnect(Sender: TObject);
begin
  If Assigned(FOnConnectProc) then
     fOnConnectProc(Self);
end;

procedure TMySocket.OnDisconnectProc(Sender: TObject);
begin
  If Assigned(fOnDisconnect) then
     fOnDisconnect(Self);
  fEventSocket.FreeSocket;
end;

procedure TMySocket.OnConnectErrorProc(Sender: TObject);
begin
  If Assigned(fOnConnectError) then
     fOnConnectError(Self);
end;

procedure TMySocket.OnDataSentProc(Sender: TObject);
begin
  If Assigned(FOnDataSent) then
     FOnDataSent(Self);
end;

procedure TMySocket.OnErrorProc(Sender: TObject;
                                ErrorType: TErrorType_;
                                ErrorMsg: String);
begin
  If Assigned(fOnError) then
     fOnError(Self, ErrorType, ErrorMsg);
end;

procedure TMySocket.OnReceive(Sender: TObject; Buffer: Pointer;
  BufLen: LongWord);
begin
  If Assigned(fOnRecv) then
     fOnRecv(Self, ClientSocket, Buffer, BufLen);
end;


end.
