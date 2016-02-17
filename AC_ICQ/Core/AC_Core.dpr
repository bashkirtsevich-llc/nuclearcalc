library AC_Core;

uses
  uCalcul, Classes, Const_u;

  function Calculate(_func:PChar):PChar; stdcall;
  var Calc:TCalcul;
      _tmp:PChar;
  begin
    Calc := TCalcul.Create;
    Calc.Formula := _func;
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
      0: Result := PChar(CORE_CONTENT);
      1: Result := PChar(CORE_CH1);
      2: Result := PChar(CORE_CH2);
      3: Result := PChar(CORE_CH3);
      4: Result := PChar(CORE_CH4);
      5: Result := PChar(CORE_CH5);
      6: Result := PChar(CORE_CH6);
      7: Result := PChar(CORE_CH7);
      8: Result := PChar(CORE_CH8);
    end;
  end;

  function GetVersion:PChar; stdcall;
  begin
    Result := PChar(CORE_VER);
  end;

  exports Calculate, PrintHelp, GetVersion;

begin
end.
