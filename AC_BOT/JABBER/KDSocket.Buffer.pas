unit KDSocket.Buffer;

interface

Uses  Windows, Dialogs,
      KDSocket.Utilites, Classes;

const
  CNetPktLen = $FFFF; {Сетевой пакет}

type
  PNetPacket = ^TNetPacket;
  TNetPacket = record
    Buf: array[0..CNetPktLen - 1] of Byte;   {Буфер}
    BufLen: Word;                            {Длина данных}
    Offset: Word;                            {Смещение}
    Next: PNetPacket;                        {След.пакет если он есть конечно}
  end;

  {Потоко-независимый буффер, реализующий хранение пакетов в виде цепочки}
  TNetBuffer = class(TObject)
  private
    FPkt  : PNetPacket;
    Shared: Integer;
    CS    : TRTLCriticalSection; {критическая секция}
  public
    constructor Create;
    destructor  Destroy; override;
    // Потоко-защита
    procedure Enter;
    procedure Leave;
    // Управление буфером
    procedure Clear;
    procedure AddPacket(Buffer: Pointer; BufLen: LongWord);
    procedure DelPacket;
    function  GetPacket(Buffer: Pointer): LongWord;
    function  SkipData(Len: Word): Boolean;
    procedure AddStr(const Value: String);
    function  GetStr: String;
    function  GetLength: LongWord;
  end;

implementation

{ TNetBuffer }
constructor TNetBuffer.Create;
begin
  inherited Create;
  FPkt := nil;
  Shared := 0;
end;

destructor TNetBuffer.Destroy;
begin
  Clear;
  if Shared = 1 then
     DeleteCriticalSection(CS);
  inherited;
end;

procedure  TNetBuffer.Clear;
var
  p: Pointer;
begin
  // Пробегаем по цепочке, трем данные
  while FPkt <> nil do
  begin
        p := FPkt^.Next;
        FreeMem(FPkt);
        FPkt := p;
  end;
end;

procedure TNetBuffer.AddPacket(Buffer: Pointer; BufLen: LongWord);
var
  p: PNetPacket;
begin
  Try
  if BufLen > CNetPktLen then
     BufLen := CNetPktLen;

  if FPkt = nil then
  begin
     GetMem(FPkt, SizeOf(TNetPacket));
     p := FPkt;
  end
  else
  begin
     p := FPkt;
     while p <> nil do
     begin
       if p^.Next = nil then Break;
       p := p^.Next;
     end;
     GetMem(p^.Next, SizeOf(TNetPacket));
     p := p^.Next;
  end;

  p^.BufLen := BufLen;
  p^.Offset := 0;
  p^.Next := nil;
  Move(Buffer^, p^.Buf, BufLen);
  Except
    ShowMessage('AddPacket Error');
  End;
end;

procedure TNetBuffer.AddStr(const Value: String);
begin
  AddPacket(@Value[1], Length(Value));
end;

procedure TNetBuffer.DelPacket;
var
  p: PNetPacket;
begin
  if (FPkt = nil) then
      Exit;
  if FPkt^.Next <> nil then
  begin
     p := FPkt^.Next;
     FreeMem(FPkt);
     FPkt := p;
  end
  else
  begin
     FreeMem(FPkt);
     FPkt := nil;
  end;
end;

procedure TNetBuffer.Enter;
var
  j: Integer;
begin
  j := 1; XChg(Shared, j);
  if j = 0 then
     InitializeCriticalSection(CS);
  EnterCriticalSection(CS);
end;

procedure TNetBuffer.Leave;
begin
  LeaveCriticalSection(CS);
end;

function TNetBuffer.GetLength: LongWord;
var
  p: PNetPacket;
begin
  Result := 0;
  p := FPkt;
  while p <> nil do
  begin
       Inc(Result, p^.BufLen);
       p := p^.Next;
  end;
end;

function TNetBuffer.GetPacket(Buffer: Pointer): LongWord;
begin
  if (FPkt = nil) or (FPkt^.Offset >= FPkt^.BufLen)
  then
     Result := 0
  else
  begin
     Move(Ptr(LongWord(@FPkt^.Buf) + FPkt^.Offset)^, Buffer^, FPkt^.BufLen - FPkt^.Offset);
     Result := FPkt^.BufLen - FPkt^.Offset;
  end;
end;

function TNetBuffer.GetStr: String;
var
  p: array[0..CNetPktLen] of Char;
begin
  p[GetPacket(@p)] := #0;
  Result := PChar(@p);
end;

function TNetBuffer.SkipData(Len: Word): Boolean;
begin
  if FPkt = nil
  then
     Result := True
  else
  begin
     Inc(FPkt^.Offset, Len);
     Result := FPkt^.Offset >= FPkt^.BufLen;
  end;
end;

end.
