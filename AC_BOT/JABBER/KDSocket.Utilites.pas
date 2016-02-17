unit KDSocket.Utilites;

interface

Uses  Windows, WinSock, Classes, SysUtils;

 // Ќазвание потока
 procedure SetCurrentThreadName(const Name: string);
 // BASE-64
 function EncodeBase64(Value: String): String;
 function DecodeBase64(Value: String): String;
 // ¬спомогательные
 function WSockAddrToIp(Value: LongWord): String;
 function GetHTTPStatus(List: TStringList): String;
 procedure XChg(var Critical, Normal); assembler;
 function WaitForRead(Sock: TSocket; Timeout: DWord): Boolean;
 // ќтобразить пакет в виде дампа
 function PacketToDumpString(Buffer: Pointer; BufLen: Word): String;
 function PacketToSring(Buffer: Pointer; BufLen: Word): String;
 function PacketToHex(Buffer: Pointer; BufLen: Word): String;


implementation

const
  b64alphabet: PChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

  procedure SetCurrentThreadName(const Name: string);
  type
    TThreadNameInfo = record
      RecType: LongWord;
      Name: PChar;
      ThreadID: LongWord;
      Flags: LongWord;
    end;
  var
     info:TThreadNameInfo;
  begin
     info.RecType:=$1000;
     info.Name:=PChar(Name);
     info.ThreadID:=$FFFFFFFF;
     info.Flags:=0;
     try
       RaiseException($406D1388, 0,  SizeOf(info) div SizeOf(LongWord), PDWord(@info));
     except
     end;
  end;


  function EncodeBase64(Value: String): String;
  const
    pad: PChar = '====';

    function EncodeChunk(const Chunk: String): String;
    var
      W: LongWord;
      i, n: Byte;
    begin
      n := Length(Chunk); W := 0;
      for i := 0 to n - 1 do
        W := W + Ord(Chunk[i + 1]) shl ((2 - i) * 8);
      Result := b64alphabet[(W shr 18) and $3f] +
                b64alphabet[(W shr 12) and $3f] +
                b64alphabet[(W shr 06) and $3f] +
                b64alphabet[(W shr 00) and $3f];
      if n <> 3 then
        Result := Copy(Result, 0, n + 1) + Copy(pad, 0, 3 - n);   //add padding when out len isn't 24 bits
    end;

  begin
    Result := '';
    while Length(Value) > 0 do
    begin
      Result := Result + EncodeChunk(Copy(Value, 0, 3));
      Delete(Value, 1, 3);
    end;
  end;

  function DecodeBase64(Value: String): String;
    function DecodeChunk(const Chunk: String): String;
    var
      W: LongWord;
      i: Byte;
    begin
      W := 0; Result := '';
      for i := 1 to 4 do
        if Pos(Chunk[i], b64alphabet) <> 0 then
          W := W + Word((Pos(Chunk[i], b64alphabet) - 1)) shl ((4 - i) * 6);
      for i := 1 to 3 do
        Result := Result + Chr(W shr ((3 - i) * 8) and $ff);
    end;
  begin
    Result := '';
    if Length(Value) mod 4 <> 0 then Exit;
    while Length(Value) > 0 do
    begin
      Result := Result + DecodeChunk(Copy(Value, 0, 4));
      Delete(Value, 1, 4);
    end;
  end;

  function WSockAddrToIp(Value: LongWord): String;
  var
    ia: in_addr;
  begin
    ia.S_addr := Value;
    Result := inet_ntoa(ia);
  end;

  function GetHTTPStatus(List: TStringList): String;
  var
    i, c: Word;
    S: String;
  begin
    Result := '';
    if List.Count < 1 then Exit;
    S := List.Strings[0]; c := 0;
    for i := 1 to Length(S) do
      if c = 1 then
        Result := Result + S[i]
      else
        if S[i] = ' ' then Inc(c);
  end;
  {Swap pointers}
  procedure XChg(var Critical, Normal); assembler;
  asm
    mov  ecx, [edx]
    xchg [eax], ecx
    mov  [edx], ecx
  end;

 function WaitForRead(Sock: TSocket; Timeout: DWord): Boolean;
 var
    readfd: TFDSet;
    tv    : TimeVal;
 begin
    tv.tv_sec := 0; tv.tv_usec := Timeout;
    FD_ZERO(readfd); FD_SET(Sock, readfd);
    {“ак как многие функции библиотеки сокетов блокируют вызвавшую их нить,
     если соответствующа€ операци€ не может быть выполнена немедленно,
     часто бывает полезно заранее знать, готов ли сокет к немедленному
     (без блокировани€) выполнению той или иной операции. ќсновным
     средством определени€ этого в библиотеке сокетов служит функци€ Select}
    if select(0, @readfd, nil, nil, @tv) < 1 then
       Result := False
    else
       Result := True;
 end;

 function PacketToDumpString(Buffer: Pointer; BufLen: Word): String;
 var
    S: String;
    i, n: Word;
 begin
    for i := 1 to BufLen do
    begin
      S := S + IntToHex(PByte(LongWord(Buffer) + i - 1)^, 2) + ' ';
      if i mod 16 = 0 then
      begin
        S := S + '  ';
        for n := i - 15 to i do
        begin
          if (PByte(LongWord(Buffer) + n - 1)^ < $20) or (PByte(LongWord(Buffer) + n - 1)^ > $7F) then
            S := S + '.'
          else
            S := S + PChar(Buffer)[n - 1];
        end;
        S := S + #13#10;
      end;
    end;

    if BufLen mod 16 <> 0 then
    begin
      for i := 0 to 15 - (BufLen mod 16)
      do
          S := S + '   ';
          S := S + '  ';
          for i := BufLen mod 16 downto 1 do
          begin
           if (PByte(LongWord(Buffer) + BufLen - i)^ < $20) or
              (PByte(LongWord(Buffer) + BufLen - i)^ > $7F) then
              S := S + '.'
           else
              S := S + PChar(Buffer)[BufLen - i];
          end;
    end;
    Result := S;
 end;

 function PacketToSring(Buffer: Pointer; BufLen: Word): String;
 var
    S: String;
    i : Integer;
 begin
    for i := 1 to BufLen do
    begin
        if PByte(LongWord(Buffer) + i - 1)^ <> 0 then
           S := S + PChar(Buffer)[I-1]
        else
           S := S + '';  // ¬озможно и неверно
    end;                    
    Result := S;
 end;

 function PacketToHex(Buffer: Pointer; BufLen: Word): String;
 var
    S: String;
    i : Integer;
 begin
    for i := 1 to BufLen do
    begin
        S := S + IntToHex(PByte(LongWord(Buffer) + i - 1)^, 2);
    end;
    Result := S;
 end;

end.
