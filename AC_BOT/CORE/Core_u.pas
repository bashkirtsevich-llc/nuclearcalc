unit Core_u;

interface

uses Const_u, Windows, SysUtils, Classes, uCalcul;

function Calculate(_func:PChar):PChar; stdcall;
function PrintHelp(Chapter:byte):PChar; stdcall;
function GetVersion:PChar; stdcall;
function Parse(Msg: PChar; Available:boolean):PChar; stdcall;

implementation

function TranslitRus2Lat(const Str: string): string;
const
  RArrayL = 'àáâãäå¸æçèéêëìíîïðñòóôõö÷øùüûúýþÿ';
  RArrayU = 'ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÜÛÚÝÞß';
  colChar = 33;
  arr: array[1..2, 1..ColChar] of string =
  (('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y',
    'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f',
    'kh', 'ts', 'ch', 'sh', 'shch', '''', 'y', '''', 'e', 'yu', 'ya'),
    ('A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y',
    'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F',
    'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '''', 'Y', '''', 'E', 'Yu', 'Ya'));
var
  i: Integer;
  LenS: Integer;
  p: integer;
  d: byte;
begin
  result := '';
  LenS := length(str);
  for i := 1 to lenS do
  begin
    d := 1;
    p := pos(str[i], RArrayL);
    if p = 0 then
    begin
      p := pos(str[i], RArrayU);
      d := 2
    end;
    if p <> 0 then
      result := result + arr[d, p]
    else
      result := result + str[i]; //åñëè íå ðóññêàÿ áóêâà, òî áåðåì èñõîäíóþ
  end;
end;

function StringToInteger(s:string):integer;
var _tmp:string;
    _index:integer;
begin
  Result := 0;
  if s = '' then Exit;
  _tmp := '';
  for _index := 1 to Length(s) do
    if (s[_index] in ['0'..'9']) then
      _tmp := _tmp + s[_index];
  Result := StrToInt(_tmp);
end;

  function Calculate(_func:PChar):PChar; stdcall;
  var Calc:TCalcul;
      _tmp:PChar;
  begin
    Calc := TCalcul.Create;
    Calc.Formula := TranslitRus2Lat(_func);
    _tmp := PChar(Calc.Calc);
    if Calc.CalcError then
    begin
      {Result := Calc.CalcErrorText;
      Calc.Free;
      Exit;  }
      _tmp:= PChar(Calc.CalcErrorText);
    end;
    Result := _tmp;
    Calc.Free;
  end;

  function PrintHelp(Chapter:byte):PChar; stdcall;
  begin
    case Chapter of
      0: Result := PChar(Q_HEADER);
      1: Result := PChar(Q_COPYRIGHT);
      2: Result := PChar(B_FUNCTION);
      3: Result := PChar(B_RESULT);
      4: Result := PChar(B_ERROR);
      5: Result := PChar(CORE_CONTENT);
      6: Result := PChar(CORE_CH1);
      7: Result := PChar(CORE_CH2);
      8: Result := PChar(CORE_CH3);
      9: Result := PChar(CORE_CH4);
      10: Result := PChar(CORE_CH5);
      11: Result := PChar(CORE_CH6);
      12: Result := PChar(CORE_CH7);
      13: Result := PChar(CORE_CH8);
      14: Result := PChar(CORE_VER);
      15: Result := PChar(BOT_NOT_ACCESSIBLE);
      16: Result := PChar(NOT_FOUND);
    end;
  end;

  function GetVersion:PChar; stdcall;
  begin
    Result := PChar(CORE_VER);
  end;

  function Parse(Msg: PChar; Available:boolean):PChar; stdcall;
  var HalfResult:String;
      index:integer;
      s:string;
  begin
    if Available then
    begin
      Result := PrintHelp(15);
      Exit;
    end;
    index:=0;
    If Msg='' Then
    Begin
      Exit;
    End;
    s := trim(Msg);
    if s[1] = '?' then
    begin
      Delete(s,1,1);
      if Length(s)<> 0 then
      begin
        index := stringtointeger(trim(s));
        if (index+5 in [5..13]) then
          Result{._result} := PChar(Format('%s%s%s',[PrintHelp(0),PrintHelp(index+5),PrintHelp(1)]))
        else
          Result{._result} := PChar(Format('%s%s%s',[PrintHelp(0),PrintHelp(16),PrintHelp(1)]));
        Exit;
      end;
      Result{._result} := PChar(Format('%s%s%s',[PrintHelp(0),PrintHelp(5),PrintHelp(1)]));
      Exit;
    end;
    if lowercase(copy(s,1,4)) = 'help' then
    begin
      Delete(s,1,4);
      if Length(s)<> 0 then
      begin
        index := stringtointeger(trim(s));
        if (index+5 in [5..13]) then
          Result{._result} := PChar(Format('%s%s%s',[PrintHelp(0),PrintHelp(index+5),PrintHelp(1)]))
        else
          Result{._result} := PChar(Format('%s%s%s',[PrintHelp(0),PrintHelp(16),PrintHelp(1)]));
        Exit;
      end;
      Result{._result} := PChar(Format('%s%s%s',[PrintHelp(0),PrintHelp(5),PrintHelp(1)]));
      Exit;
    end;
    Result := PChar(Format('%s%s %s'#13#10+'%s %s %s',[PrintHelp(0),PrintHelp(2),Msg,PrintHelp(3),Calculate(PChar(Msg)),PrintHelp(1)]));
  end;

end.
