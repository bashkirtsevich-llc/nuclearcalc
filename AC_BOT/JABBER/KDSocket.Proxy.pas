unit KDSocket.Proxy;

interface

Uses KDSocket.Custom,
     KDSocket.Types,
     Classes;

type                  
  TProxySocket = class(TCustomSocket)
  protected
    FDestHost  : String;
    FDestIp    : Integer;
    FDestPort  : Word;
    FProxyUser : String;
    FProxyPass   : String;
    FProxyAuth   : Boolean;
    FProxyReady  : Boolean;
    FProxyResolve: Boolean;
    procedure Execute; override;                   // Переопределение с родителя
  public
    property Host: String read FDestHost write FDestHost;   {Реальный Хост}
    property Port: Word   read FDestPort write FDestPort;   {Реальный Порт}
    {Переопределение с родителя}
    property ProxyHost: String read FHost write FHost;
    property ProxyPort: Word read FPort write FPort;
    {Пользователь/пароль}
    property ProxyUser: String read FProxyUser write FProxyUser;
    property ProxyPass: String read FProxyPass write FProxyPass;
    {Требуется ли авторизация}
    property ProxyAuth: Boolean read FProxyAuth write FProxyAuth default False;
    property ProxyResolve: Boolean read FProxyResolve write FProxyResolve default False;
    property ProxyReady: Boolean read FProxyReady write FProxyReady default False;
  end;

  {Расширенный TProxySocket c поддержкой событий}
  TEventSocket = class(TProxySocket)
  private
    FOnConnect : TNotifyEvent;
    FOnError   : TOnError;
    FOnDisconnect : TNotifyEvent;
    FOnConnectError: TNotifyEvent;
    FOnReceive : TOnRecveive;
    FOnDataSent: TNotifyEvent;
  protected
    {Переопределяем Custom}
    procedure OnConnect; override;
    procedure OnDisconnect; override;
    procedure OnError; override;
    procedure OnReceive; override;
    procedure OnDataSent; override;
  published
    {Расширяем события}
    property _OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
    property _OnError: TOnError read FOnError write FOnError;
    property _OnConnectError: TNotifyEvent read FOnConnectError write FOnConnectError;
    property _OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
    property _OnReceive: TOnRecveive read FOnReceive write FOnReceive;
    property _OnDataSent: TNotifyEvent read FOnDataSent write FOnDataSent;
  end;

implementation

{ TProxySocket }
procedure TProxySocket.Execute;
begin
  if FProxyResolve then
     FDestIp := Resolve(FDestHost); {Получить по хосту IP}
  inherited;
end;

{ TEventSocket }

procedure TEventSocket.OnConnect;
begin
  if Assigned(_OnConnect) then
     FOnConnect(Self);
  inherited;
end;

procedure TEventSocket.OnDisconnect;
begin
  inherited;
  if Assigned(_OnDisconnect) then
     FOnDisconnect(Self);
end;

procedure TEventSocket.OnReceive;
begin
  if ProxyReady then
  begin
     if Assigned(_OnReceive) then
        FOnReceive(Self, Buffer, BufLen);
  end
  else
     inherited;
end;

procedure TEventSocket.OnDataSent;
begin
  if Assigned(_OnDataSent) then
     FOnDataSent(Self);
end;

procedure TEventSocket.OnError;
begin
  inherited;
  if Assigned(_OnError) then
     FOnError(Self, ERR_SOCKET, FLastErrMsg);
end;


end.
