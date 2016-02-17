unit KDSocket.HTTP;

interface

Uses KDSocket.Proxy,
     KDSocket.Types,
     KDSocket.Utilites,
     Windows,
     SysUtils,
     Classes;

type
  THTTPSocket = class(TEventSocket)
  private
    FBuf: array[0..$FFFE] of Byte;
    FCurLen, FLen : LongWord;
  protected
    procedure OnConnect; override;
    procedure OnReceive; override;
  end;

  THTTPSSocket = class(TEventSocket)
  private
    FBuf: array[0..8191] of Byte;
    FCurLen: Word;
  protected
    procedure OnConnect; override;
    procedure OnReceive; override;
  end;

implementation

{ THTTPSocket }

procedure THTTPSocket.OnConnect;
begin
  inherited;
  FLen := 0;
  FCurLen := 0;
end;

procedure THTTPSocket.OnReceive;
    // Получаем длину HTTP пакета
    function GetHTTPLength(List: TStringList): Integer;
    var
      i: Word;
    begin
      Result := 0;
      if List.Count < 1 then Exit;
      for i := 0 to List.Count - 1 do
        if Copy(List.Strings[i], 0, 16) = 'Content-Length: ' then
        begin
          Result := StrToInt(Copy(List.Strings[i], 16, $FF));
          Exit;
        end;
    end;
var
  i: LongWord;
  List: TStringList;
  S: String;
begin
  if not ProxyReady then
  begin
    if BufLen < 1 then Exit;

    for i := 0 to BufLen - 1 do
    begin
        FBuf[FCurLen] := PByte(LongWord(Buffer) + i)^;
        Inc(FCurLen);
        if FLen = 0 then
           if FCurLen > 3 then
              if Copy(PChar(@FBuf), FCurLen - 3, 4) = #13#10#13#10 then
              begin
                List := TStringList.Create;
                List.Text := PChar(@FBuf);
                S    := GetHTTPStatus(List);
                FLen := GetHTTPLength(List);
                List.Free;
                if S <> '200 OK' then
                begin
                  FLastError := 0;
                  FLastErrMsg := ERR_HTTP_STATUS + S;
                  Synchronize(OnError);
                  Exit;
                end;
                if FLen + FCurLen > SizeOf(FBuf) then begin
                  FLastError := 0;
                  FLastErrMsg := ERR_HTTP_OVERSIZE_BUFFER;
                  Synchronize(OnError);
                  Exit;
                end;
                FCurLen := 0;
              end;
              if (FCurLen = FLen) then
              begin
                  {Предполагаем, что только одна страница данных может быть получена}
                  ProxyReady := True;
                  Buffer := @FBuf;
                  BufLen := FCurLen;
                  Synchronize(OnReceive);
                  Exit;
              end;
    end;
  end
  else
    inherited;
end;

{ THTTPSSocket }

procedure THTTPSSocket.OnConnect;
begin
  inherited;
  if not ProxyReady then
  begin
    FCurLen := 0;
    if FProxyResolve then
       // Формируем пакет
       SendStr('CONNECT ' + FDestHost + ':' + IntToStr(FDestPort) + ' HTTP/1.0' + #13#10)
    else
       SendStr('CONNECT ' + WSockAddrToIp(FDestIp) + ':' + IntToStr(FDestPort) + ' HTTP/1.0' + #13#10);

    SendStr('User-Agent: Mozilla/4.08 [en] (WinNT; U ;Nav)' + #13#10);
    if FProxyAuth then
       SendStr('Proxy-Authorization: Basic ' + EncodeBase64(ProxyUser + ':' + ProxyPass) + #13#10);

    SendStr(#13#10);
  end;
end;

procedure THTTPSSocket.OnReceive;
var
  i: LongWord;
  List: TStringList;
  S: String;
begin
  if not ProxyReady then
  begin
     if BufLen < 1 then Exit;
     for i := 0 to BufLen - 1 do
     begin
         FBuf[FCurLen] := PByte(LongWord(Buffer) + i)^;
         Inc(FCurLen);
         if FCurLen > 3 then
            if Copy(PChar(@FBuf), FCurLen - 3, 4) = #13#10#13#10 then
            begin
               List := TStringList.Create;
               List.Text := PChar(@FBuf);
               S := GetHTTPStatus(List);
               List.Free;
               CharLowerBuff(@S[1], Length(S));
               if S <> '200 connection established' then
               begin
                  FLastError := 0;
                  FLastErrMsg := ERR_HTTP_STATUS + S;
                  Synchronize(OnError);
                  Exit;
               end;

               ProxyReady := True;
               {Получаем данные}
               if i < BufLen - 1 then
               begin
                  Buffer := Ptr(LongWord(Buffer) + i);
                  BufLen := BufLen - i;
                  Synchronize(OnReceive);
                  Exit;
               end;
        end;
    end;
  end
  else
    inherited;
end;

end.
