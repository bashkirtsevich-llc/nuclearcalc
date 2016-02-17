//------------------------------------------------------------------------------
//
// ������� ������ �� ��������           01.11.2007
//
//------------------------------------------------------------------------------
unit _myFunctions.Strings;

interface

Uses Windows,Dialogs,SysUtils;

type
  TSepArr = array of string;  // ������ "�������"
  TPosArr = array of Integer; // ������ "�������"

  TSepRec = record
    Rec : TSepArr; // ���� "������"
    Max : integer; // ���������� ���������� "�������"
  end;

  TPosRec = record
    Rec : TPosArr; // ���� "������"
    Max : integer; // ���������� ���������� "�������"
  end;

  // ������� �������� ������� ������ ����� �������� �����, ������ LengthNumber �
  // ���� ������
  // 99, 9   -> 000000099
  // 1234, 9 -> 000001234
  // 1234, 3 -> 1234
  // 1234, 4 -> 1234
  // 1234, 5 -> 01234
  Function GenerateFullNumber(Number, LengthNumber : Integer): String;
  // ������ ��� �����
  Function IsInt(Str : String): Boolean;
  // ���������� � ��������� �����
  Function LowerCaseOneUpperStr(Value : String) : String;
  // � �������� �� ���������
  Function RusToLat(Value : String) : String;
  // ������� ������ � ������ ���� ��������� ����� ��������� �� ������
  function ReplaceSub(str, sub1, sub2: String): String;
  // ����������� ������ � ������������� �� ������ �����
  function GetSeparatorRec(const sRows: string;
                                 cSeparator: char = ','): TSepRec;
  // ������� ������ �������� XOR ��� �������
  // ����� ���������� ��� �������� ���������� ������
  Function StringXOR(const Str :String; Value : Byte)  : String;
  // ���������� ��������� ��������� � ������
  function CountPos(const subtext: string; Text: string): Integer;
  // ������� ������� ��� ��������� ������ SubStr � ������ Str
  // � ���������� ������ ������� ������ ��������� ��������
  function FindSub(SubStr , Str: String): TPosRec;
  // ������� ���������� ���������� ������ �� �������� ���� ������
  // ������� ������� �� ���������������� � ����� ��������  ChRepl
  function GenCorrectFileName(Str: String; ChRepl : Char): String;
  // ��������������� ���������
  function  WinToDos(Str :String) :String;
  function  DosToWin(Str : String) :String;

implementation
   //----------------------------------------------------------------------------
   Function GenerateFullNumber(Number, LengthNumber : Integer): String;
   var
     I: Integer;
     Tmp,Str   : String;
     LengthStr : Integer;
   begin
     try
       Str       := IntToStr(Number);
       LengthStr := Length(Str);
       if LengthStr >= LengthNumber  then
       begin
          Result := Str;
          Exit;
       end
       else
       begin
          Tmp := '';
          LengthStr := LengthNumber - LengthStr;
          for I := 0 to LengthStr-1 do
              Tmp := Tmp + '0';
          Str := Tmp  + Str;
          Result := Str;
       end;
     except
     end;
   end;
   //----------------------------------------------------------------------------
   Function IsInt(Str : String): Boolean;
   var
     Pos : Integer;
   begin
     Result := True;
     Str := Trim(Str);
     For Pos := 1 To Length(Str) do
     begin
        IF (Str[Pos] <> '0') and (Str[Pos] <> '1') and
           (Str[Pos] <> '2') and (Str[Pos] <> '3') and
           (Str[Pos] <> '4') and (Str[Pos] <> '5') and
           (Str[Pos] <> '6') and (Str[Pos] <> '7') and
           (Str[Pos] <> '8') and (Str[Pos] <> '9') and
           (Str[Pos] <> '.') Then
        Begin
           Result := False;
           Exit;
        end;
     end;
   end;
  //----------------------------------------------------------------------------
  Function LowerCaseOneUpperStr(Value : String) : String;
  var
    Ch   : String[1];
    Only : String;
  Begin
    IF Value <> '' Then
    begin
       Ch   := Value[1];
       Only := Copy(Value,2,Length(Value)-1);
       Ch   := AnsiUpperCase(Ch);
       Only := AnsiLowerCase(Only);
       Result := Ch + Only;
    end;
  end;
  //----------------------------------------------------------------------------
  Function RusToLat(Value : String) : String;
  var
      Pos    : integer;
      OutChar: String;
      CH     : char;
      Stroka: String;
  begin
      Stroka := '';
      for Pos := 1 to Length(Value) do
      begin
          Ch := Value[Pos];
          case Ch of
              '�': OutChar:= 'A';
              '�': OutChar:= 'a';
              '�': OutChar:= 'B';
              '�': OutChar:= 'b';
              '�': OutChar:= 'V';
              '�': OutChar:= 'v';
              '�': OutChar:= 'G';
              '�': OutChar:= 'g';
              '�': OutChar:= 'D';
              '�': OutChar:= 'd';
              '�': OutChar:= 'E';
              '�': OutChar:= 'e';
              '�': OutChar:= 'G';
              '�': OutChar:= 'g';
              '�': OutChar:= 'Z';
              '�': OutChar:= 'z';
              '�': OutChar:= 'I';
              '�': OutChar:= 'i';
              '�': OutChar:= 'IY';
              '�': OutChar:= 'iy';
              '�': OutChar:= 'K';
              '�': OutChar:= 'k';
              '�': OutChar:= 'L';
              '�': OutChar:= 'l';
              '�': OutChar:= 'M';
              '�': OutChar:= 'm';
              '�': OutChar:= 'N';
              '�': OutChar:= 'n';
              '�': OutChar:= 'O';
              '�': OutChar:= 'o';
              '�': OutChar:= 'P';
              '�': OutChar:= 'p';
              '�': OutChar:= 'R';
              '�': OutChar:= 'r';
              '�': OutChar:= 'S';
              '�': OutChar:= 's';
              '�': OutChar:= 'T';
              '�': OutChar:= 't';
              '�': OutChar:= 'U';
              '�': OutChar:= 'u';
              '�': OutChar:= 'F';
              '�': OutChar:= 'f';
              '�': OutChar:= 'H';
              '�': OutChar:= 'h';
              '�': OutChar:= 'C';
              '�': OutChar:= 'c';
              '�': OutChar:= 'CH';
              '�': OutChar:= 'ch';
              '�': OutChar:= 'SH';
              '�': OutChar:= 'sh';
              '�': OutChar:= 'CH';
              '�': OutChar:= 'ch';
              '�': OutChar:= '''';
              '�': OutChar:= '''';
              '�': OutChar:= 'Y';
              '�': OutChar:= 'y';
              '�': OutChar:= '''';
              '�': OutChar:= '''';
              '�': OutChar:= 'E';
              '�': OutChar:= 'e';
              '�': OutChar:= 'YU';
              '�': OutChar:= 'yu';
              '�': OutChar:= 'YA';
              '�': OutChar:= 'ya';
          else
               OutChar := Ch;
          end;
          Stroka := Stroka + OutChar;
      end;
      Result := Stroka;
  end;
  //----------------------------------------------------------------------------
  function ReplaceSub(str, sub1, sub2: String): String;
  var
    aPos: Integer;
    rslt: String;
  begin
    aPos := Pos(sub1, str);
    rslt := '';
    while (aPos <> 0) do begin
       rslt := rslt + Copy(str, 1, aPos - 1) + sub2;
       Delete(str, 1, aPos + Length(sub1) - 1);
      aPos := Pos(sub1, str);
    end;
    Result := rslt + str;
  end;
  //----------------------------------------------------------------------------
  Function StringXOR(const Str :String; Value : Byte) : String;
  var
    I,Code,New : Integer;
    Ch  : Char;
    StrNew : String;
  begin
    StrNew := '';
    For I:= 1 to Length(Str) Do
    begin
        Ch := Str[I];
        Code := Ord(Ch);
        New  := Code xor 10;
        StrNew := StrNew + Chr(New);
    end;
    Result := StrNew;
  end;

  //----------------------------------------------------------------------------
  // ����������� ������ � ������������� �� ������ �����
  //----------------------------------------------------------------------------
  function GetSeparatorRec(const sRows: string;
                                 cSeparator: char = ','): TSepRec;
  var
    cCol: array of integer;
    i, j: integer;
    bSTRING: boolean;
  begin
    Result.Max := -1;

    j := 1; bSTRING := False;
    SetLength(cCol,j);
    cCol[0] := 0;
    for i := 1 to Length(sRows) do begin
      if sRows[i] = '"' then bSTRING := not bSTRING;
      if (sRows[i] = cSeparator) and (not bSTRING) then begin
        j := j + 1;
        SetLength(cCol,j);
        cCol[j-1] := i;
      end;
    end;
    j := j + 1;
    SetLength(cCol,j);
    cCol[j-1] := Length(sRows)+1;

    Result.Max := High(cCol);
    if Result.Max > 0 then begin
      SetLength(Result.Rec, Result.Max + 1);
      Result.Rec[0] := IntToStr(Result.Max);
      for i := 1 to Result.Max do
        Result.Rec[i] := Copy(sRows,cCol[i-1]+1,cCol[i]-cCol[i-1]-1);
    end;
  end;

  //----------------------------------------------------------------------------
  // ���������� ��������� ��������� � ������
  //----------------------------------------------------------------------------
  function CountPos(const subtext: string; Text: string): Integer;
  begin
    if (Length(Subtext) = 0) or (Length(Text) = 0) or (Pos(Subtext, Text) = 0)
    then
        Result := 0
    else
        Result := (Length(Text) - Length(StringReplace(Text, Subtext, '', [rfReplaceAll]))) div Length(subtext);
  end;

  //----------------------------------------------------------------------------
  // ������� ������� ��� ��������� ������ SubStr � ������ Str
  // � ���������� ������ ������� ������ ��������� ��������
  //----------------------------------------------------------------------------
  function FindSub(SubStr, Str: String): TPosRec;
  var
    ArrPos   : array of Integer;
    I, IndexArr : Integer;
    Counts, Position: Integer;
    LenStr : Integer;
  begin
    Counts := CountPos(SubStr,Str);
    Result.Max := Counts;
    IF Result.Max = 0 then
    begin
       Result.Rec := nil;
       Exit;
    end;

    SetLength(ArrPos ,Counts);
    IndexArr := 0;

    // ������ ��������� - �������� 0
    Counts   := 0;
    repeat
    begin
      Position := Pos(SubStr, Str);
      If Position <> 0 then
      begin
       // ���������� ������� � ������ �������� �� ������ ������
       ArrPos[IndexArr] := Position + Counts;
       // ����� ������ �� ������ �� ���������� ������� SubStr
       LenStr := Position + Length(SubStr) - 1;
       // ������� � ������ �����
       Delete(Str, 1, LenStr);
       // ���������� ��������
       Counts := Counts + LenStr;
       // ����.�������
       Inc(IndexArr);
      end;
    end;
    until (Position =0);

    // ���������� �������
    SetLength(Result.Rec, Result.Max);
    for I := 0 to Result.Max-1 do
        Result.Rec[I] := ArrPos[I];
    // ������
    //SetLength(ArrPos, 0);
  end;

  //----------------------------------------------------------------------------
  // ������� ���������� ���������� ������ �� �������� ���� ������
  // ������� ������� �� ���������������� � ����� ��������  ChRepl
  //----------------------------------------------------------------------------
  function GenCorrectFileName(Str: String; ChRepl : Char): String;
  var
    ArrSymbols : Array of Char;
    Find   : Char;
  begin
    SetLength(ArrSymbols,8);
    ArrSymbols[0] := '/';
    ArrSymbols[1] := '|';
    ArrSymbols[2] := '\';
    ArrSymbols[3] := '*';
    ArrSymbols[4] := ':';
    ArrSymbols[5] := ';';
    ArrSymbols[6] := '"';
    ArrSymbols[7] := #10;
    ArrSymbols[8] := #13;

    for Find in ArrSymbols  do
    begin
        if pos(Find, Str) <> 0 then
           Str := ReplaceSub(Str, Find, ChRepl);
    end;
    Result := Str;
  end;

  function  WinToDos(Str :String) :String;
  begin
    CharToOem(PChar(Str),PAnsiChar(Str));
    Result:=Str;
  end;

  {------------------------------------------------------------------}
  function  DosToWin(Str : String) :String;
  begin
    OEMToChar(PAnsiChar(Str),PChar(Str));
    Result:=Str;
  end;
end.
