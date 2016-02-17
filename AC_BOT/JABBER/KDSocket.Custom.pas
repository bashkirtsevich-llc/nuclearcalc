unit KDSocket.Custom;

interface

Uses  Windows, WinSock,
      KDSocket.Buffer,
      KDSocket.Utilites,
      KDSocket.Types,
      Classes,
      SysUtils;

const
  DefaultSockType = True; // True = ������������� �� ����������� �������,
                          // False - ������������� �����������

Type
  TOnSocketThreadException = procedure (Sender: TObject;
                                        AExceptionStr: String) of object;

  // ������� ����� �������
  TCustomSocket = class(TThread)
  private
    FSocket :{array of }TSocket;
    D:WSAData;
    FIp: Integer;
    FDoConnect: Boolean;
    FWorking: Boolean;
    FConnected: Boolean;
    FAssync: Boolean;
    FBuffer: TNetBuffer;
    FDataSentEvent: Boolean;
    FOnSocketThreadException: TOnSocketThreadException;
    procedure ProcessBuffer;
  protected
    FHost: String;
    FPort: Word;
    FLastError: Word;
    FLastErrMsg: String;
    Buffer: Pointer;
    BufLen: LongWord;
    // �������� IP �� ������
    function  Resolve(const Host: String): Integer;

    procedure Execute; override;

    procedure OnConnect; virtual;
    procedure OnDisconnect; virtual;
    procedure OnError; virtual;
    procedure OnReceive; virtual;
    procedure OnDataSent; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure StartWork(Socket: TSocket);
    procedure Connect;
    procedure SendData(Buffer: Pointer; Len: LongWord);
    procedure SendStr(const Value: String);
    procedure FreeSocket; // ���������� � Protected
    property Host: String read FHost write FHost;
    property Port: Word read FPort write FPort;
    property Working: Boolean read FWorking write FWorking;
    property Connected: Boolean read FConnected write FConnected;
    property Assync: Boolean read FAssync write FAssync;
    Function GetSocket : TSocket;
    // ����������
    property OnSocketThreadException: TOnSocketThreadException read FOnSocketThreadException write FOnSocketThreadException;
  end;

implementation

{ TCustomSocket }
constructor TCustomSocket.Create;
begin
  inherited Create(True);
  FConnected := False;
  FWorking   := False;
  FAssync    := DefaultSockType;
  FBuffer    := TNetBuffer.Create;
  //SetLength(FSockets,1);
  WSAStartup($0101,D);
end;

destructor TCustomSocket.Destroy;
begin
  FreeSocket;
  WSACleanup;
  if Assigned(FBuffer) then
     FBuffer.Free;
  inherited Destroy;
end;

procedure TCustomSocket.Connect;
begin
  if FWorking then
     Exit
  else
     FWorking := True;

  FDoConnect := True;
  FConnected := False;
  FSocket:= WinSock.Socket(PF_INET,SOCK_STREAM,0);
  if FSocket = INVALID_SOCKET then
  begin
     FLastError  := WSAGetLastError;
     FLastErrMsg := ERR_SOCKET_CREATE;
     Synchronize(OnError);
     Exit;
  end;
  Resume; // ���������� �����
end;

// ����� ����������
procedure TCustomSocket.Execute;
var
  sin: sockaddr_in;
  buf: array[0..CNetPktLen - 1] of Char;
  rc: Integer;
begin
  try
    SetCurrentThreadName('Custom Socket execute');
    
    if (FDoConnect) and (not Terminated) then
    begin
       {Resolving Host}
       FIp := Resolve(FHost);
       if DWord(FIp) = DWord(INADDR_NONE) then
       begin
          if (not Terminated) then
          begin
              FLastError  := WSAGetLastError;
              FLastErrMsg := ERR_SOCKET_RESOLVE;
              Synchronize(OnError);
          end;
          Exit;
       end
       else
       begin
        sin.sin_family      := PF_INET;
        sin.sin_addr.S_addr := FIp;
        sin.sin_port        := htons(FPort);
        {�����������...}
        if WinSock.connect(FSocket, sin, SizeOf(sin)) = SOCKET_ERROR then
        begin
          FLastError  := WSAGetLastError;
          FLastErrMsg := Format(ERR_SOCKET_CONNECT, [FHost, FPort]);
          if (not Terminated) then
              Synchronize(OnError);
          Exit;
        end;
      end;
    end;
    {���������� �����������}
    FConnected := True;
    Synchronize(OnConnect);

    {�������� ������}
    // ����
    while not Terminated do begin
    {
       ���� ������ �� ������ � ������� 100 ms �� �� �������� ������, ����� ������ ��
       ������� ������ ��������, �� ������ ��������� ����������
    }
      if Assync and (not WaitForRead(FSocket, 10)) then
      begin
         ProcessBuffer;
      end
      else
      begin
          // ��������� ������
          rc := recv(FSocket, buf, SizeOf(buf), 0);
          if (rc = 0) and (not Terminated) then
          begin
              Synchronize(OnDisconnect);
              Break;
          end;
          if (rc = SOCKET_ERROR) then
          begin
             rc := WSAGetLastError;
             if ((rc = WSAECONNRESET) or (rc = WSAECONNABORTED)) and (not Terminated) then
             begin
                 Synchronize(OnDisconnect);
                 Break;
             end;
             if (not Terminated) then
             begin
                FLastError  := rc;
                FLastErrMsg := ERR_SOCKET_RECV;
                Synchronize(OnError);
             end;
             Break;
          end;

          Buffer := @buf;
          BufLen := rc;
          if rc > 0 then
             if Assync then
                Synchronize(OnReceive)
             else
                OnReceive;
      end;
    end;
  except on E:Exception do
    begin
      if Assigned(OnSocketThreadException) then
         OnSocketThreadException(Self, E.Message);
    end;
  end;
end;

procedure TCustomSocket.FreeSocket;
begin
  // ������ �����
  if not Terminated then
     Terminate;
  if FSocket <> INVALID_SOCKET then
  begin
     Closesocket(FSocket);
     FSocket := INVALID_SOCKET;
  end;
  FWorking := False;
end;

function TCustomSocket.GetSocket: TSocket;
begin
  Result := FSocket;
end;

procedure TCustomSocket.OnConnect;
begin
 // ��������
end;

procedure TCustomSocket.OnDisconnect;
begin
  FreeSocket; {���������� �����}
end;

procedure TCustomSocket.OnError;
begin
  FreeSocket; {���������� �����}
end;

procedure TCustomSocket.OnReceive;
begin
 // ��������
end;

procedure TCustomSocket.OnDataSent;
begin
 // ��������
end;

procedure TCustomSocket.ProcessBuffer;
var
  ret: Integer;
  Buf: array[0..CNetPktLen- 1] of Byte;
begin
  if FSocket <> INVALID_SOCKET then
     while True do
     begin
         FBuffer.Enter;
         ret := FBuffer.GetPacket(@Buf);
         FBuffer.Leave;
         if (ret < 1) then
         begin {��� ������ ���� �������}
            if (not FDataSentEvent) then
                Synchronize(OnDataSent);
            FDataSentEvent := True; // ���� ����������� �� �� ��� ����������
                                    // ��������
            Exit;
         end;

        if send(FSocket, Buf, ret, 0) = SOCKET_ERROR then
        begin
           FLastError := WSAGetLastError;
           FLastErrMsg := ERR_SOCKET_SEND;
           Synchronize(OnError);
           Break;
        end
        else
          FBuffer.Enter;
          if FBuffer.SkipData(ret) then
             FBuffer.DelPacket;
          FBuffer.Leave;
    end;
end;

function TCustomSocket.Resolve(const Host: String): Integer;
var
  he: PHostEnt;
begin
  Result := inet_addr(PChar(Host));
  if DWord(Result) = DWord(INADDR_NONE) then
  begin
      he := gethostbyname(PChar(Host));
      if he = nil then Exit;
         Result := PInteger(he^.h_addr_list^)^;
  end;
end;

procedure TCustomSocket.SendData(Buffer: Pointer; Len: LongWord);
begin
  if Len = 0 then Exit;
  if (Assync) and (FBuffer <> nil) then
  begin
     FDataSentEvent := False;
     FBuffer.Enter;
     FBuffer.AddPacket(Buffer, Len);
     FBuffer.Leave;
  end
  else
     if send(FSocket, Buffer^, Len, 0) = SOCKET_ERROR then
     begin
        FLastError  :=  WSAGetLastError;
        FLastErrMsg :=  ERR_SOCKET_SEND;
        Synchronize(OnError);
        Exit;
    end;
end;

procedure TCustomSocket.SendStr(const Value: String);
begin
  // �������� ������
  SendData(@Value[1], Length(Value));
end;

procedure TCustomSocket.StartWork(Socket: TSocket);
begin
  if FWorking then
     Exit
  else
     FWorking := True;

  FDoConnect := False;
  FConnected := False;
  FSocket   := Socket;
  Resume; // ��������� �����
end;

end.
