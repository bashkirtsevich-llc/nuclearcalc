

(*   ********************************************************
     *           TCalcul object, unit uCalcul.pas           *
     *                   version 3.3                        *
     *               Author:  Jan Tungli (c) 2002,2004      *
     *               web:     www.tsoft.szm.com             *
     *               mailto:  jan.tungli@seznam.cz          *
     ********************************************************

      If you want modify this source code,
      plase send me your source segment
      to mail: jan.tungli@seznam.cz with subject "Calcul"

    _____________________________________________________________________
   | Variable types:                                                     |
   |=====================================================================|
   |   x,y         : numeric - (integer, float)                          |
   |   a,b         : boolean (1 or 0)                                    |
   |   s,t,v       : string                                              |
   |   d           : DateTimeString  (StampString)                       |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Basic operations:                                                   |
   |=====================================================================|
   |   numeric:          x + y , x - y , x * y, x / y, x ^ y             |
   |   compare:          x > y, x < y, x >= y, x <= y, x = y, x <> y     |
   |   ansi compare:     s > t, s < t, s >= t, s <= t, s = t, s <> t     |
   |   boolean (1/0):    a AND b,  a OR b, NOT(a)                        |
   |   boolean (1/0):    x in [...]  // example: 12 in [22,12,3]         |
   |   set variable :    x:=formula (or value) ;                         |
   |   destroy variable: FreeVar(s);    // s=variable name               |
   |   logical:          ExistVar(s)  // s=variable name                 |
   |   formula separation with semicolon :  formula1 ; formula2          |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Type conversion:                                                    |
   |=====================================================================|
   |   boolean (1/0):   Logic(x)                                         |
   |   numeric:         Numeric(s)                                       |
   |   string:          String(x)                                        |
   |   char:            Char(x)                                          |
   |   integer:         Ascii(s)                                         |
   |---------------------------------------------------------------------|
   |   all types:       Eval(f)  // where f is formula in [...]          |
   |   string :         NumBase(x,base) // base from <2..16>             |
   |   integer:         BaseNum(s,base) // base from <2..16>
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Math operations:                                                    |
   |=====================================================================|
   |  numeric (integer): x Div y,  x Mod y                               |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Math functions:                                                     |
   |=====================================================================|
   |    Abs(x), Frac(x), Trunc(x), Heaviside(x) or H(x), Sign(x),        |
   |    Sqrt(x), Ln(x), Exp(x),                                          |
   |    Cos(x), CTg(x), Ch(x), CTh(x), Sin(x),  Sh(x), Tg(x), Th(x),     |
   |    ArcSin(x), ArcCos(x), ArcTg(x), ArcCtg(x),                       |
   |    MaxVal(x [,y, ...]),  MinVal(x [,y, ...]),                       |
   |    SumVal(x [,y,...]),   AvgVal(x [,y, ...])                        |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | String operations:                                                  |
   |=====================================================================|
   |    s || t ,                                                         |
   |    s Like t,      // (%,_)                                          |
   |    s Wildcard t   // (*,?)                                          |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | String functions:                                                   |
   |=====================================================================|
   |   integer: Length(s), Pos(t,s)                                      |
   |   string:  Trim(s), TrimLeft(s), TrimRight(s), Upper(s), Lower(s),  |
   |            Copy(s,x,[y]), CopyTo(s,x,[y]), Delete(s,x,[y]),         |
   |            Insert(s,t,x);                                           |
   |            Replace(s,t,v,[1/0=ReplaceAll,[1/0=IgnoreCase]] );       |
   |            IFF(a,s,t);    //IF a>=1 then Result:=s else Result:=t   |
   |            Prefix(count,char,s)                                     |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Date, Time functions:                                               |
   |=====================================================================|
   |   integer: Year(s), Month(s), Day(s), WeekDay(s),                   |
   |            Hour(s), Minute(s), Sec(s)                               |
   |   numeric: StrToStamp(d)  LastDay(x) // last day in Month (28-31)   |
   |   string:  StampToStr(x), StampToDateStr(x), StampToTimeStr(x)      |
   |   System variables: _NOW, _TIME, _DATE                              |
   |_____________________________________________________________________|

       Delta days with  2002/1/1 - 1999/1/1 :
          DeltaDays:=StrToStamp("2002/1/1") - StrToStamp("1999/1/1")

   Example:
      procedure TForm1.CalcBtnClick(Sender: TObject);
      var s:string;
      begin
        Combobox1.text:='(2+x+y) || s' ;
        Calcul1.Variables:='x=100'#13#10+
                           'y=200'#13#10+
                           's="hello"'#13#10;
        Calcul1.Formula := ComboBox1.text;
        s:=Calcul1.calc;
        if Calcul1.CalcError=false then
          ShowMessage(Calcul1.Formula+'='+s);
        else
          ShowMessage(Calcul1.CalcErrorText);
      end; {----}

  ************************************************************************)

(* History:

   10.8.2001
   ver.1.2 - implemented aritmetic functions with use variables

   1.5.2002
   ver.2.0 & 2.1 - implememnted string & dateTime functions & Eval() function

   6.5.2002
   ver.2.2 - implemented set variable ":=" and FreeVar(), ExistVar(), NumBase(), BaseNum() functions

   10.5.2002
   ver.2.3 - finally version Date & Time operations & LastDay(..) function

   11.5.2002
   ver.2.4 - implemented 'in' operation

   22.8.2003
   ver 2.5. add: OnGetVariable event   (with ShortString variable)
            add: Prefix function
            add: constats _LF = #13#10; _TB=#9; _PI:=3.14...
            add: property QuoteChar default is "  for strings
            add: function FormulaVariables

   4.2.2004
   ver. 3.0  mem. allocation - error fixed !!!

   6.2.2004
   ver. 3.1  modify: OnGetVariable event (with Variant variable)
             add system constats:  _NOW, _TIME, _DATE
             add VarObj:TText object  - support multy line values and very speed wokr with variables

Bug list:
   x^(y+2) - exponet must by single value or variable y:=y+2; x^y
   a:=1; 1 in [a,b]  - [..] must by set of values not alloved variables

  If you want modify this source code,
  plase send me your source segment
  to mail: jan.tungli@seznam.cz with subject "Calcul"

*)

unit uCalcul;

interface

uses
  Windows, SysUtils, Classes, Controls, Math, Masks,
  uFunctions, OpenGL, console_u, Advanced, Forms;

type
TCalc_Tree=record
   id,num:Integer;
   con:string[255];
   l,r:pointer;
   typ:byte;
   end;
PCalc_Tree=^TCalc_Tree;
TCalc_vek=array of byte;


TGetVariableEvent=procedure(sender:Tobject;const VariableName:string;var VariableValue: variant; var Handled:boolean; Index:integer=0) of object;

TShowInterpreterPos=procedure(Sender: TObject; Code:string) of object;
TUseModule=procedure(Sender:TObject; Module:string) of object;

TGoToXY=procedure(Sender:TObject;X,Y:Single)of object;
TSetBuffSize=procedure(Sender:TObject;Size:LongWord)of object;
//TLineToXY=procedure(Sender:TObject;X,Y:Single)of object;
TConsoleSupport=procedure(Sender:TObject;var Text:String)of object;

TCalcul=class(TObject)
  private
   Pause:Boolean;
   _halt:Boolean;
   fErr:boolean;
   Bc:integer;
   PrevLex,Curlex:integer;
   fPos:integer;
   FFormula:string;
   Tree:pointer;
   fVek:Tcalc_vek;
   cVek,MaxVek:integer;
   fVaria:TText;
   //FVariables:TStringList;
   fFParams:TStringList;
   fResultType:byte;
   fErrText:string;
   FOngetVariable : TGetVariableEvent;
   fQuote:char;
   fSub:boolean; // sub Calc
   fIndex:integer;
   fOnInitConsole:TNotifyEvent;
   fOnFreeConsole:TNotifyEvent;
   fOnInit3D:TNotifyEvent;
   fOnInit2D:TNotifyEvent;
   fOnFree3D:TNotifyEvent;
   fOnFree2D:TNotifyEvent;
   fOnMoveToXY:TGoToXY;
   fOnLineToXY:TGoToXY;
   fOnWriteln:TConsoleSupport;
   fOnWrite:TConsoleSupport;
   fOnRead:TConsoleSupport;
   fOnReadln:TConsoleSupport;
   fOnSetAxisLength:TGoToXY;
   fOnDraw2D:TNotifyEvent;
   fOnSetBuffSize:TSetBuffSize;
   fOnClearConsole:TNotifyEvent;
   fDebug:Boolean;
   fOnShowPos:TShowInterpreterPos;
   fOnUseModule:TUseModule;
   function gettree(s:string):pointer;
   procedure deltree(t:PCalc_Tree);
   procedure Error(s:string);
   procedure SetVariables(Value:string); // support only 1 line values
   function GetVariables:string;          // support multy line values
   function m1(c:string):extended;   //StrToFloat
   function m0(s:string):integer;    //StrToInt
   function m2(x:extended):string;   //FloatToStr
   function m3(s:string):boolean;    //StrToBool
   procedure Addvek(t:pointer);
   procedure Delvek(t:pointer);
   function IsString(s:string):boolean;
   function Separ(s:string):string;
   function aReadln:string;
   function aRead:string;
  public
   Parent:TWinControl; 
   constructor Create;
   procedure Sub(Master:TCalcul);
   destructor Destroy;override;
   function Calc(index:integer=0):string;
   function Test(s:string {sys:boolean=false}):integer;
   function FormulaVariables:string;
   procedure StepOver;
   procedure Stop;
  published
   property Debug:Boolean read fDebug write fDebug default False;
   property Formula:string read FFormula write fFormula;
   property Variables:string read GetVariables write SetVariables;
   property VarObj:TText read fVaria; // Variables values type TText -> unit uFunctions
   property CalcError: boolean read fErr;
   property CalcErrorText: string read fErrText;
   property ResultType : byte read fResultType;   // 0=unknown; 1=numeric; 2=string
   property QuoteChar:char read fQuote write fQuote default '"';
   property OnGetVariable : TGetVariableEvent Read FOnGetVariable Write FOnGetVariable;
   property OnInitConsole:TNotifyEvent read fOnInitConsole write fOnInitConsole;
   property OnFreeConsole:TNotifyEvent read fOnFreeConsole write fOnFreeConsole;
   property OnInit3D:TNotifyEvent read fOnInit3D write fOnInit3D;
   property OnFree3D:TNotifyEvent read fOnFree3D write fOnFree3D;
   property OnInit2D:TNotifyEvent read fOnInit2D write fOnInit2D;
   property OnFree2D:TNotifyEvent read fOnFree2D write fOnFree2D;
   property OnMoveToXY:TGoToXY read fOnMoveToXY write fOnMoveToXY;
   property OnLineToXY:TGoToXY read fOnLineToXY write fOnLineToXY;
   property OnColsoleReadln:TConsoleSupport read fOnReadln write fOnReadln;
   property OnColsoleRead:TConsoleSupport read fOnRead write fOnRead;
   property OnColsoleWriteln:TConsoleSupport read fOnWriteln write fOnWriteln;
   property OnColsoleWrite:TConsoleSupport read fOnWrite write fOnWrite;
   property OnSetAxisLength:TGoToXY read fOnSetAxisLength write fOnSetAxisLength;
   property OnDraw2D:TNotifyEvent read fOnDraw2D write fOnDraw2D;
   property OnSetBuffSize:TSetBuffSize read fOnSetBuffSize write fOnSetBuffSize;
   property OnClearConsole:TNotifyEvent read fOnClearConsole write fOnClearConsole;
   property OnShowInterpreterPos:TShowInterpreterPos read fOnShowPos write fOnShowPos;
   property OnuseModule:TUseModule read fOnUseModule write fOnUseModule;
 end;

implementation

const
  _random       =40;
  //OpenGL functions
  _glVertex3f   =73;
  _drawAxis     =74;
  _drawGrids    =75;
  _glColor3f    =76;
  _moveToXY     =78;
  _lineToXY     =79;
  _glNewList    =80;
  _glEndList    =81;
  _glDeleteList =82;
  _glLineWidth  =83;
  //86;
  _clearConsole =86;
  //Standard functions
  _messagebox   =181;
  _format       =182;
  _sleep        =183;
  //Consloe support
  _read         =184;
  _readln       =185;
  _write        =186;
  _writeln      =187;
  //OpenGL operators
  _glBegin      =188;
  _glEnd        =189;
  //Mode functions
  _init2D       =190;
  _free2D       =191;
  _init3D       =192;
  _initConsole  =194;
  _setXYaxisLength=195;
  _draw2D       =84;
  _setBuffSize  =85;
  _useModule    =87;
  _void         =89;


function TCalcul.aReadln:string;
begin
  Result:=wndConsole.onreadln;
end;

function TCalcul.aRead:string;
begin
  Result:=wndConsole.onread;
end;

function IntToFloat(X:Integer):Extended;
begin
  Result:=X;
end;  

Function LastDay(DD:TdateTime): byte;
const
  DaysPerMonth: array[1..12] of Integer =
    (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var  Y,M,D:word;
begin
  result:=0;
  DecodeDate(DD,Y,M,D);
  if not ((Y=1) and (M=1) and (D=1)) then begin
    Result := DaysPerMonth[M];
    if (M=2) and IsLeapYear(Y) then Result:=Result+1;
  end;
End;

function NumBase(AnyInteger, NumberBase :integer):string; //(2,8,10,16));
  CONST DataSize = 32;  (* bit-size of an INTEGER *)
  VAR   Index : INTEGER;
        Digit : array [1..DataSize] OF CHAR;
begin
  result:='';
  IF (NumberBase > 1) and (NumberBase < 17) then begin
    Index := 0;
    repeat
      INC (Index);
      Digit [Index] := CHR(AnyInteger mod NumberBase + ORD('0'));
      IF (Digit [Index] > '9') then INC (Digit [Index],7);
      AnyInteger := AnyInteger div NumberBase;
    UNTIL (AnyInteger = 0) OR (Index = DataSize);
    While (Index > 0) do begin
      result:=result+Digit[Index];
      DEC (Index);
    end;
  end;
end;

function BaseNum(s:string; NumberBase :integer):integer; //(2,8,10,16,32));
var i:integer;
    j:byte;
begin
  s:=UpperCase(s); j:=0;
  IF (NumberBase > 1) and (NumberBase < 17) then begin
    while (length(s)>0) and (s[1]='0') do system.delete(s,1,1);
    result:=0;
    if length(s)=0 then exit;
    For i:=length(s) downto 1 do begin
      if (s[i] in ['0'..'9']) then j:=byte(s[i])-byte('0')
      else
        if s[i] in ['A'..'F'] then j:=byte(s[i])-byte('A')+10
        else begin
          result:=-1; exit;
        end;
      try
       result:=result+j*trunc(power(NumberBase,length(s)-i)+0.1);
      except
        result:=-1; break;
      end;
    end;
  end else result:=-1;
end;

(*------------------------------------------------------------------*)

//*********************************************************************

constructor TCalcul.Create;
begin
  inherited;
  fVaria:=TText.Create;
  fQuote:='"';
  Tree:=nil;
  cVek:=0; MaxVek:=0;setlength(fvek,0);
  Formula:='0';
  //FVariables:=TStringList.Create;
  //Fvariables.Clear;
  FFParams:=TStringList.Create;
  FFParams.Clear;
  Pause:=False;
  _halt:=False;
end;

procedure TCalcul.Sub(Master:TCalcul);
begin
  fVaria.Free;
  fVaria:=Master.fVaria;
  fSub:=true;
end;

destructor TCalcul.Destroy;
begin
  if not fSub then fVaria.Free else fVaria:=nil;
  DelTree(Tree);
  FFParams.Free;
  //FVariables.Free;
  inherited;
end;

//***************************************************************


function TCalcul.m1(c:string):extended;   //StrToFloat
var d:extended;
    err:integer;
    s:string;
begin
  s:=Trim(c);
  s:=StringReplace(s,',','.',[rfReplaceAll]);
  Val(s,d,err);
  if err>0 then begin
    d:=0;
    Error('Error, convert to numeric value:'+c);
  end;
  result:=d;
end;

function TCalcul.m0(s:string):integer;   //StrToInt
var x:extended;
begin
  result:=0;
  if fErr then exit;
  x:=m1(s);
  if x>0 then x:=x+0.0000001;
  if x<0 then x:=x-0.0000001;
  result:=trunc(x);
end;

function TCalcul.m2(x:extended):string;   //FloatToStr
var s:string;
    i,j,k:word;
begin
  Str(x:0:12,s);
  i:=Pos('.',s);
  k:=0;
  for j:=Length(s) downto i+2 do if s[j]='0' then inc(k) else break;
  if k>0 then system.delete(s,Length(s)-k+1,k);
  if system.copy(s,length(s)-1,2)='.0' then system.delete(s,length(s)-1,2);
  result:=s;
end;

function TCalcul.m3(s: string):Boolean;
begin
  if Copy(s,1,1)='1' then Result:=true else Result:=false;
end;

procedure TCalcul.StepOver;
begin
  Pause:=False;
end;

procedure TCalcul.Stop;
begin
  _halt:=True;
  Pause:=False;
  fDebug:=False;
end;

function TCalcul.calc(index:integer):String;
var fMultyparam:boolean;
   function c(t:PCalc_TREE):string;
   var r:extended;
       d,dd:double;
       s,ms,temp:string;
       TC:TCalcul;
       j,i,k:integer;
       Y1,D1,H1,MM1,S1:word;
       sp:array [1..5] of string;
       mRepFlag: TReplaceFlags;
       handled:boolean;
       var_Res:variant;
   begin
     Pause:=fDebug;
     if fDebug then
     begin // Debug pause
       while Pause do Application.HandleMessage;
     end;
     if _halt then
     begin
      Result:='';
      Exit;
     end;

     i:=-1; c:=''; mRepFlag:=[];
     if fErr then exit;
     try
       if t^.num in [3..6,10..35,40,44,47..55,62,65..68,72,197,198,200,201,203,208..211,220..225,
                     _initConsole{,_freeConsole},_init3D,{_free3D,}_init2D,_free2D,
                     _glBegin,_glEnd,_glVertex3f,_moveToXY,_lineToXY,_sleep,
                     _read,_readln,_messagebox,_drawGrids,_drawAxis,
                     _glNewList,_glEndList,_glColor3f,_glDeleteList,
                     _glLineWidth,_setXYaxisLength,_draw2D,_setBuffSize,
                     _clearConsole,_useModule,_void] then t^.typ:=1; //numeric
       if t^.num in [38,39,41,43,45,46,56..58,60,61,64,69,70,71,196,202,226,
                     _writeln,_write,_format] then t^.typ:=2; //string
     except Error('Invalid formula (..)'); end;
     if ferr then exit;
     case t^.num of
     // dual operations
     //Addons
     _initConsole:
      begin
        if c(t^.l)='1' then
          if Assigned(fOnInitConsole) then
            begin
              fOnInitConsole(Self);
              c:=m2(1);
            end else
              c:=m2(0);
        if c(t^.l)='0' then
          if Assigned(fOnFreeConsole) then
            begin
              fOnFreeConsole(Self);
              c:=m2(1);
            end else
              c:=m2(0);
      end;
     _init2D:
      begin
        if Assigned(fOnInit2D) then
          begin
            fOnInit2D(Self);
            c:=m2(1);
          end else
            c:=m2(0);
      end;
     _free2D:
      begin
        if Assigned(fOnFree2D) then
          begin
            fOnFree2D(Self);
            c:=m2(1);
          end else
            c:=m2(0);
      end;
     _init3D:
      begin
        if c(t^.l)='1' then
          if Assigned(fOnInit3D) then
            begin
              fOnInit3D(Self);
              c:=m2(1);
            end else
              c:=m2(0)
          else
        if Assigned(fOnFree3D) then
          begin
            fOnFree3D(Self);
            c:=m2(1);
          end else
            c:=m2(0);
      end;
     _glBegin:
      begin
        //glNewList(1,GL_COMPILE);
        glBegin(m0(c(t^.l)));
        c:=m2(1);
      end;
     _glEnd:
      begin
        glEnd();
        //glEndList;
      end;
     _glNewList:
      begin
        glNewList(1,GL_COMPILE);
      end;
     _glEndList:
      begin
        glEndList;
      end;
     _readln:
      begin
        c:=c(t^.l);
        temp:=aReadln;
        if temp<>'' then
          c:=temp;
      end;
     _read:
      begin
        c:=c(t^.l);
        temp:=aRead;
        if temp<>'' then
          c:=temp;
      end;
     _writeln:
      begin
        temp:=c(t^.l);
        if Assigned(fOnWriteln) then
          fOnWriteln(Self,temp);
      end;
     _write:
      begin
        temp:=c(t^.l);
        if Assigned(fOnWrite) then
          fOnWrite(Self,temp);
      end;
     _sleep: Sleep(m0(c(t^.l)));
     _glLineWidth: glLineWidth(m1(c(t^.l)));
     _draw2D :
     begin
        if Assigned(fOnDraw2D) then
          fOnDraw2D(Self);
     end;
     _setBuffSize:
     begin
       if Assigned(fOnSetBuffSize) then
         fOnSetBuffSize(Self,m0(c(t^.l)));       
     end;
     _clearConsole: if Assigned(fOnClearConsole) then
        fOnClearConsole(Self);
     _useModule: if Assigned(fOnUseModule) then fOnUseModule(Self,string(c(t^.l)));
     _void: c:='0';
     //
     3: begin
         c:=m2(m1(c(t^.l))+m1(c(t^.r)));
         (*
         s:=c(t^.l);
         mS:=c(t^.r);
         s:=m2(m1(s)+m1(ms));
         FFParams.Strings[ffParams.Count-3]:=s;
         c:=s;
         *)
        end;
     4: c:=m2(m1(c(t^.l))-m1(c(t^.r)));
     5: c:=m2(m1(c(t^.l))*m1(c(t^.r)));
     6: begin
          r:=m1(c(t^.r));
          if abs(r)<0.00000001 then c:='0' else c:=m2(m1(c(t^.l))/r);
        end;
     // unary + or unary -
     7,8: c:=(t^.con);

     // variable or function
     9:begin
        if t^.con[1]='[' then begin
          result:=trim(t^.con);
        end else begin
          if not ((t^.con[1] in [#255,'_','A'..'Z','a'..'z']) or (Pos('@@',t^.con)=1)) then begin
            Error('Unknown variable:'+t^.con+', invalid character in name');
            c:='';
          end else begin
            if Pos('_',t^.con)=1 then begin
              if (t^.con='_LF') or (t^.con='_TB') or (t^.con='_PI') or (t^.con='_E') or
                 (t^.con='_NOW') or (t^.con='_TIME') or (t^.con='_DATE') or
                 (t^.con='_GL_LINES') or (t^.con='_GL_POINTS') or
                 (t^.con='_CREATE') or (t^.con='_FREE') or
                 (t^.con='_MB_OK') or (t^.con='_MB_OKCANCEL') or
                 (t^.con='_MB_ABORTRETRYIGNORE') or (t^.con='_MB_YESNOCANCEL') or
                 (t^.con='_MB_YESNO') or (t^.con='_MB_RETRYCANCEL') or
                 (t^.con='_MB_ICONHAND') or (t^.con='_MB_ICONQUESTION') or
                 (t^.con='_MB_ICONEXCLAMATION') or (t^.con='_MB_ICONASTERISK') or
                 (t^.con='_TRUE') or (t^.con='_FALSE')
              then begin //constats
                if t^.con='_LF' then i:=99999;
                if t^.con='_TB' then i:=99998;
                if t^.con='_PI' then i:=99997;
                if t^.con='_NOW' then i:=99996;
                if t^.con='_DATE' then i:=99995;
                if t^.con='_TIME' then i:=99994;
                if t^.con='_E' then i:=99993;
                if t^.con='_GL_POINTS' then i:=99992;
                if t^.con='_GL_LINES' then i:=99991;
                if t^.con='_CREATE' then i:=99990;
                if t^.con='_FREE' then i:=99989;
                //
                if t^.con='_MB_OK' then i:=99988;
                if t^.con='_MB_OKCANCEL' then i:=99987;
                if t^.con='_MB_ABORTRETRYIGNORE' then i:=99986;
                if t^.con='_MB_YESNOCANCEL' then i:=99985;
                if t^.con='_MB_YESNO' then i:=99984;
                if t^.con='_MB_RETRYCANCEL' then i:=99983;
                if t^.con='_MB_ICONHAND' then i:=99982;
                if t^.con='_MB_ICONQUESTION' then i:=99981;
                if t^.con='_MB_ICONEXCLAMATION' then i:=99980;
                if t^.con='_MB_ICONASTERISK' then i:=99979;
                //
                if t^.con='_TRUE' then i:=99978;
                if t^.con='_FALSE' then i:=99977;
              end;
            end else begin
              // GET VARIABLE index
              i:=-1;
              if fVaria.Exists(t^.con) then i:=1;
              if i<0 then begin
                handled:=False;
                if Assigned(FOngetVariable) then FOngetVariable(Self,t^.con,var_Res,handled);
                (*
                if handled then begin
                  fVariables.Add(t^.con + '='+ var_Res);
                  i := fVariables.IndexOfName(t^.con);
                end;
                *)
              end;
            end;
            if i<0 then begin
              if handled then begin
                s:=Var_Res;
                t^.typ:=2;
                if s<>'' then begin
                  if s[1]=fQuote then begin
                    if s[length(s)]=fQuote then system.delete(s,length(s),1);
                    if s<>'' then system.delete(s,1,1);
                  end else t^.typ:=1;
                end;
                c:=s; s:='';
              end else begin c:='' ; Error('Unknown variable:'+t^.con); end;
            end else begin
              if i<99970 then s:=t^.con+'='+fVaria.GetValue(t^.con); // no constatnts
              if Pos('@@',s)=1 then begin //:= eval
                 ms:=copy(s,1,Pos('=',s)-1); ms:=copy(ms,3,255);
                 s:=copy(s,Pos('=',s)+1,65000);
                 if s<>'' then begin
                   if (s[1]='[') and (s[length(s)]=']') then begin
                     system.delete(s,1,1);
                     system.delete(s,length(s),1);
                     s:=trim(s);
                   end;
                 end;
                 TC:=TCalcul.Create;
                 TC.QuoteChar:=fQuote;
                 TC.Sub(Self);
                 TC.formula:=s;
                 try
                   result:=TC.Calc;
                   t^.typ:=TC.ResultType;
                 finally
                   TC.free;
                   if fVaria.Exists('@@'+ms) then FVaria.Delete('@@'+ms);
                   fVaria.SetValue(ms,result);
                 end;
              end else begin
                t^.typ:=2;
                if Pos('=',s)>0 then begin
                  s:=system.copy(s,Pos('=',s)+1,65000);
                  s:=Trimleft(s);
                  if s<>'' then begin
                    if s[1]=fQuote then begin
                      if s[length(s)]=fQuote then system.delete(s,length(s),1);
                      if s<>'' then system.delete(s,1,1);
                    end else t^.typ:=1;
                  end;
                end else begin
                  s:='';
                  if i>=99970 then begin
                    t^.typ:=2; {string value}
                    case i of
                    99999: s:=#13#10; //_LF
                    99998: s:=#9;     //_TB
                    99997: begin Str(PI:0:16,s); t^.typ:=1;{numeric value} end; //_PI
                    99996: s:=MDateTimeToStr(now);  //_NOW
                    99995: s:=MDateToStr(now);      //_DATE
                    99994: s:=MTimeToStr(now);      //_TIME
                    99993: begin Str(exp(1):0:16,s); t^.typ:=1;{numeric value} end; //_E
                    99992: begin s:=IntToStr(GL_POINTS); t^.typ:=1; end;
                    99991: begin s:=IntToStr(GL_LINES); t^.typ:=1; end;
                    99990: begin s:='1'; t^.typ:=1; end;
                    99989: begin s:='0'; t^.typ:=1; end;
                    99988: begin s:='0'; t^.typ:=1; end;
                    99987: begin s:='1'; t^.typ:=1; end;
                    99986: begin s:='2'; t^.typ:=1; end;
                    99985: begin s:='3'; t^.typ:=1; end;
                    99984: begin s:='4'; t^.typ:=1; end;
                    99983: begin s:='5'; t^.typ:=1; end;
                    99982: begin s:='16'; t^.typ:=1; end;
                    99981: begin s:='32'; t^.typ:=1; end;
                    99980: begin s:='48'; t^.typ:=1; end;
                    99979: begin s:='64'; t^.typ:=1; end;
                    99978: begin s:='1'; t^.typ:=1; end;
                    99977: begin s:='0'; t^.typ:=1; end;
                    end;
                  end;
                end;
                c:=s; // VARAIBLE VALUE
              end;
            end;
          end;
        end;
     end;

     //single operations
     10: c:=m2(-m1(c(t^.l)));
     11: c:=m2(cos(m1(c(t^.l))));
     12: c:=m2(sin(m1(c(t^.l))));
     13: c:=m2(tan(m1(c(t^.l))));
     //Addons
     _random: c:=m2(random(m0(c(t^.l))));
     //
     14: begin
          r:=tan(m1(c(t^.l)));
          if r<-0.0000001 then c:='-1' else
            if r>0.00000001 then c:='1' else c:=m2(1/r);
         end;
     15: c:=m2(abs(m1(c(t^.l))));
     16: begin
           r:=m1(c(t^.l));
           if r<-0.0000001 then c:='-1' else if r>0.00000001 then c:='1' else c:='0';
         end;
     17: c:=m2(sqrt(m1(c(t^.l))));
     18: begin
      if m1(c(t^.l))>0 then
        c:=m2(ln(m1(c(t^.l))))
      else c:='0';
     end;
     19: c:=m2(exp(m1(c(t^.l))));
     20: c:=m2(arcsin(m1(c(t^.l))));
     21: c:=m2(arccos(m1(c(t^.l))));
     22: c:=m2(arctan(m1(c(t^.l))));
     23: c:=m2(pi/2-arctan(m1(c(t^.l))));
     24: begin
           r:=m1(c(t^.l));
           c:=m2((exp(r)-exp(-r))/2);
         end;
     25: begin
           r:=m1(c(t^.l));
           c:=m2((exp(r)+exp(-r))/2);
         end;
     26: begin
           r:=m1(c(t^.l));
           c:=m2((exp(r)-exp(-r))/(exp(r)+exp(-r)));
         end;
     27: begin
           r:=m1(c(t^.l));
           c:=m2((exp(r)+exp(-r))/(exp(r)-exp(-r)));
         end;
     28: begin
           r:=m1(c(t^.l));
           if r>=0 then c:='1' else c:='0';
         end;
     29: begin //ExistVar
           if  not fVaria.Exists(c(t^.l)) then c:='0' else c:='1';
         end;
     30: begin  //FreeVar
           if fVaria.Exists(c(t^.l)) then begin
             FVaria.delete(c(t^.l));
             c:='1';
           end else c:='0';
         end;
     31: c:=m2(power( m1(c(t^.l)),m1(c(t^.r))));
     32: c:=m2(LastDay(m0(c(t^.l))));  //LastDay(Stamp)
     33: c:=m2(frac(m1(c(t^.l))));  //frac
     34: c:=m2(trunc(m1(c(t^.l)))); //trunc
     35: c:=m2(length(c(t^.l)));  //length
     38: c:=trimLeft(c(t^.l)); //trimleft
     39: c:=trimright(c(t^.l)); //trimright

     41: c:=trim(c(t^.l)); //trim
     42: begin    //eval
           s:=trim(c(t^.l));
           if s<>'' then begin
             if (s[1]='[') and (s[length(s)]=']') then begin
               system.delete(s,1,1);
               system.delete(s,length(s),1);
               s:=trim(s);
             end;
           end;
           TC:=TCalcul.Create;
           TC.QuoteChar:=fQuote;
           TC.Sub(self);
           TC.formula:=s;
           try
             c:=TC.Calc;
             t^.typ:=TC.ResultType;
           finally
             TC.free;
           end;
         end;
     43: c:=char(m0(c(t^.l))); //char
     44: begin
           s:=c(t^.l);    //ascii
           if s<>'' then c:=m2(0.0+byte(s[1]));
         end;
     45: c:=AnsiUpperCase(c(t^.l));
     46: c:=AnsiLowerCase(c(t^.l));
     47: if m1(c(t^.l))>=1 then c:='0' else c:='1'; // not
     48: begin //weekday
          s:=c(t^.l);
          d:=MStrToDateTime(s);
          j:=DayOfWeek(d);
          if j>0 then if j=1 then j:=7 else j:=j-1;
          c:=IntToStr(j);
         end;
     49: begin //month
          s:=c(t^.l);
          d:=MStrToDateTime(s);
          DecodeDate(d,Y1,MM1,D1);
          c:=intToStr(MM1);
         end;
     50: begin //year
          s:=c(t^.l);
          d:=MStrToDateTime(s);
          DecodeDate(d,Y1,MM1,D1);
          c:=intToStr(Y1);
         end;
     51: begin //day
          s:=c(t^.l);
          d:=MStrToDateTime(s);
          DecodeDate(d,Y1,MM1,D1);
          c:=intToStr(D1);
         end;
     52: begin //hour
          s:=c(t^.l);
          d:=MStrToDateTime(s);
          DecodeTime(d,H1,MM1,S1,Y1);
          c:=intToStr(H1);
         end;
     53: begin //minute
          s:=c(t^.l);
          d:=MStrToDateTime(s);
          DecodeTime(d,H1,MM1,S1,Y1);
          c:=intToStr(MM1);
         end;
     54: begin //sec
          s:=c(t^.l);
          d:=MStrToDateTime(s);
          DecodeTime(d,H1,MM1,S1,Y1);
          c:=intToStr(S1);
         end;
     55: begin //StrToStamp
            s:=c(t^.l);
            d:=MStrToDateTime(s);
            c:=m2(d);
         end;
     56: begin //StampToDateStr
            s:=c(t^.l);
            c:=MDateToStr(m1(s))
         end;
     57: begin //StampToTimeStr
            s:=c(t^.l);
            c:=MTimeToStr(m1(s))
         end;
     58: begin //StampToStr
            s:=c(t^.l);
            c:=MDateTimeToStr(m1(s))
         end;
     60..72,_glVertex3f,_moveToXY,_lineToXY,_format,
     _messagebox,_drawGrids,_drawAxis,
     _glColor3f,_glDeleteList,226,
     _setXYaxisLength: begin

           FFParams.add(IntToStr(t^.num));
           FFParams.add('[!!!]');
           fMultyParam:=false;
           s:=c(t^.l);
           c:=s;
           fMultyParam:=false;
           FFParams.Insert(FFParams.count-2,s);
           if ffParams.count=0 then exit;
           j:=m0(FFparams.Strings[FFParams.Count-2]);
           i:=0;
           case j of      //min param count;
             60 :i:=2; //copy
             61 :i:=2; //copyto
             62 :i:=2; //pos
             63 :i:=2; //delete
             64 :i:=3; //replace
             65 :i:=1; //maxval
             66 :i:=1; //minval
             67 :i:=1; //SumVal
             68 :i:=1; //AvgVal
             69 :i:=3; //Iff
             70 :i:=3; //Insert
             71 :i:=2; //NumBase
             72 :i:=2; //baseNum
             _glVertex3f :i:=3;
             _moveToXY :i:=2;
             _lineToXY :i:=2;
             _format :i:=2;
             _messagebox :i:=3;
             _drawGrids :i:=3;
             _drawAxis :i:=3;
             _glColor3f :i:=3;
             _glDeleteList :i:=2;
             226:i:=2;
             _setXYaxisLength :i:=2;
           else
             Error('Internal error, function with params');
           end;
           if not fErr then begin
             FFparams.Delete(FFParams.Count-1);
             FFparams.Delete(FFParams.Count-1);
           end;
           if FFparams.count>0 then begin
             k:=0;
             if not (j in [65,66,67,68]) then begin
               while (FFParams.count>0) and (k<5) and (FFParams.Strings[FFparams.count-1]<>'[!!!]') do begin
                 inc(k);
                 sp[k]:=trim(FFParams.strings[FFParams.count-1]);
                 ffParams.delete(FFParams.Count-1);
               end;
               if k<i then begin Error('Not enough params'); exit; end;
             end;
             dd:=0; ;s:=sp[1];
             case j of
               226: begin
                   if k<3 then begin sp[3]:=sp[2]; sp[2]:=' '; end;
                   if sp[2]='' then sp[2]:=' ';
                   s:=Prefix(m0(sp[1]),sp[2][1],sp[3]);
               end;
               60:begin  //copy
                   if k<3 then sp[3]:=IntToStr(length(sp[1]));
                   if (length(sp[1])>=m0(sp[2])) and (m0(sp[3])>0) then
                   s:=system.copy(sp[1],m0(sp[2]),m0(sp[3])) else s:='';
                end;
               61:begin  //copyto
                   if k<3 then sp[3]:=IntToStr(length(sp[1]));
                   if (length(sp[1])>=m0(sp[2])) and (m0(sp[3])>=m0(sp[2])) then
                   s:=system.copy(sp[1],m0(sp[2]),m0(sp[3])-m0(sp[2])+1) else s:='';
               end;
               62:begin //pos
                   s:=IntToStr(pos(sp[1],sp[2]));
               end;
               63:begin  //delete
                   if k<3 then sp[3]:=IntToStr(length(sp[1]));
                   if (length(sp[1])>=m0(sp[2])) and (m0(sp[3])>0) then
                   system.delete(sp[1], m0(sp[2]), m0(sp[3]) );
                   s:=sp[1];
               end;
               64:begin  //replace
                   mRepFlag:=[];
                   if k<5 then sp[5]:='1';
                   if k<4 then sp[4]:='1';
                   if m0(sp[4])=1 then mRepFlag:=mRepFlag+[rfReplaceAll];
                   if m0(sp[5])=1 then mRepFlag:=mRepFlag+[rfIgnoreCase];
                   s:=StringReplace(sp[1],sp[2],sp[3],mRepFlag);
               end;
               65:begin  //maxval
                 k:=0;
                 while (fErr=false) and (FFParams.count>0) and (FFParams.Strings[FFparams.count-1]<>'[!!!]') do begin
                   inc(k);
                   d:=m1(trim(FFParams.strings[FFParams.count-1]));
                   if k=1 then dd:=d else if d>dd then dd:=d;
                   ffParams.delete(FFParams.Count-1);
                 end;
                 if k<1 then Error('Error, not enough params');
                 s:=m2(dd);
               end;
               66:begin  //minval
                 k:=0;
                 while (fErr=false) and (FFParams.count>0) and (FFParams.Strings[FFparams.count-1]<>'[!!!]') do begin
                   inc(k);
                   d:=m1(trim(FFParams.strings[FFParams.count-1]));
                   if k=1 then dd:=d else if d<dd then dd:=d;
                   ffParams.delete(FFParams.Count-1);
                 end;
                 if k<1 then Error('Error, not enough params');
                 s:=m2(dd);
               end;
               67:begin  //sumVal
                 dd:=0;
                 while (fErr=false) and (FFParams.count>0) and (FFParams.Strings[FFparams.count-1]<>'[!!!]') do begin
                   inc(k);
                   d:=m1(trim(FFParams.strings[FFParams.count-1]));
                   dd:=dd+d;
                   ffParams.delete(FFParams.Count-1);
                 end;
                 if k<1 then Error('Error, not enough params');
                 s:=m2(dd);
               end;
               68:begin  //AvgVal
                 dd:=0; k:=0; s:='0';
                 while (fErr=false) and (FFParams.count>0) and (FFParams.Strings[FFparams.count-1]<>'[!!!]') do begin
                   inc(k);
                   d:=m1(trim(FFParams.strings[FFParams.count-1]));
                   dd:=dd+d;
                   ffParams.delete(FFParams.Count-1);
                 end;
                 if k<1 then Error('Error, not enough params') else s:=m2(dd/k);
               end;
               69:begin  //IFF(a,s,t) - string
                   if m0(sp[1])=1 then s:=sp[2] else s:=sp[3];
               end;
               70:begin  //insert(t,s,x)
                 if length(sp[1])=0 then sp[1]:=sp[2] else begin
                   if m0(sp[3])>length(s)+1 then sp[3]:=IntToStr(length(s)+1);
                   if m0(sp[3])<=0 then sp[3]:='1';
                   system.insert(sp[2],sp[1],m0(sp[3]));
                 end;
                 s:=sp[1];
               end;
               71: begin
                   if m0(sp[2])>16 then sp[2]:='16';
                   if m0(sp[2])<2 then sp[2]:='2';
                   s:=NumBase(m0(sp[1]),m0(sp[2]));
               end;
               72: begin
                   if m0(sp[2])>16 then sp[2]:='16';
                   if m0(sp[2])<2 then sp[2]:='2';
                   i:=Basenum(sp[1],m0(sp[2]));
                   if i>0 then s:=IntToStr(i) else s:='';
               end;
               _glVertex3f: begin
                  glVertex3f(m1(sp[1]),m1(sp[2]),m1(sp[3]));
                  s:='1'
               end;
               _moveToXY:begin
                  if Assigned(fOnMoveToXY) then
                    begin
                      fOnMoveToXY(Self,m1(sp[1]),m1(sp[2]));
                      s:='1';
                    end else
                      s:='0';
               end;
               _lineToXY:begin
                  if Assigned(fOnLineToXY) then
                    begin
                      fOnLineToXY(Self,m1(sp[1]),m1(sp[2]));
                      s:='1';
                    end else
                      s:='0';
               end;
              _format:begin
                  s:=Format(sp[1],[sp[2],sp[3],sp[4],sp[5]]);
                end;
              _messagebox:begin
                  s:='1';//IntToStr(MessageBox(Self.Parent.Handle,PChar(sp[1]),PChar(sp[2]),m0(sp[3])));
                  MessageBox(Self.Parent.Handle,PChar(sp[1]),PChar(sp[2]),m0(sp[3]));
                end;
              _drawGrids:begin
                  s:='1';
                  DrawGrids(m3(sp[1]),m3(sp[2]),m3(sp[3]));
                end;
              _drawAxis:begin
                  s:='1';
                  DrawAxis(m3(sp[1]),m3(sp[2]),m3(sp[3]));
                end;
              _glColor3f:begin
                  glColor3f(m1(sp[1]),m1(sp[2]),m1(sp[3]));
                end;
              _glDeleteList:
                begin
                  glDeleteLists(m0(sp[1]),m0(sp[2]));  
                end;
              _setXYaxisLength:
                begin
                  if Assigned(fOnSetAxisLength) then
                    fOnSetAxisLength(Self,m1(sp[1]),m1(sp[2]));
                end;
             end;{case}
             c:=s;
           end;
           //s:=c(t^.l);
           //FFparams.Insert(0,s);
         end;
     196: c:=c(t^.l);      //string()
     197: begin   //numeric()
            s:=c(t^.l);
            s:=StringReplace(s,' ','',[rfReplaceAll]);
            s:=StringReplace(s,',','.',[rfReplaceAll]);
            c:=m2(m1(s));
          end;
     198: begin //logic 0,1
            if m0(c(t^.l)) >=1 then c:='1' else c:='0';
          end;

     {-------------  dual oper ---------------------------------}
     200: begin
           j:=m0(c(t^.r));     // div
           if j=0 then c:='0' else c:=m2(m0(c(t^.l)) div j);
         end;
     201: c:=m2(m0(c(t^.l)) mod m0(c(t^.r))); //mod
     202: c:=c(t^.l) + c(t^.r);    // ||
     203: begin  //in
            s:=c(t^.l);
            ms:=trim(c(t^.r));
            if ms[1]='[' then ms[1]:=',' else Error('Invalid parameter for operation in [..]');
            if ms[length(ms)]=']' then ms[length(ms)]:=',' else Error('Invalid parameter for operation in [..]');
            if Pos('.0',s)=length(s)-1 then system.delete(s,length(s)-1,2);
            if Pos('.00',s)=length(s)-2 then system.delete(s,length(s)-2,3);
            ms:=StringReplace(ms,' ,',',',[rfReplaceAll]);
            ms:=StringReplace(ms,', ',',',[rfReplaceAll]);
            ms:=StringReplace(ms,','+fQuote,',',[rfReplaceAll]);
            ms:=StringReplace(ms,fQuote+',',',',[rfReplaceAll]);
            //ms:=StringReplace(ms,',"',',',[rfReplaceAll]);
            //ms:=StringReplace(ms,'",',',',[rfReplaceAll]);
            ms:=StringReplace(ms,'.0,',',',[rfReplaceAll]);
            ms:=StringReplace(ms,'.00,',',',[rfReplaceAll]);
            if Pos(','+s+',',ms)>0 then result:='1' else result:='0';
          end;
     210: if (m1(c(t^.l))>=1) and (m1(c(t^.r))>=1) then c:='1' else c:='0';  //and
     211: if (m1(c(t^.l))>=1) or (m1(c(t^.r))>=1) then c:='1' else c:='0';  //or
     220: if c(t^.l)=c(t^.r) then c:='1' else c:='0';  //=
     225: if c(t^.l)<>c(t^.r) then c:='1' else c:='0';  //<>
     221,222,223,224:
         begin
           d:=m1(c(t^.l));
           dd:=m1(c(t^.r));
           if fErr  then begin
             fErr:=false; fErrText:='';
             s:=c(t^.l);
             ms:=c(t^.r);
             j:=AnsiCompareStr(s,ms);
             case t^.num of
              221: if j<0  then c:='1' else c:='0';  //<
              222: if j<=0 then c:='1' else c:='0';  //<=
              223: if j>0 then c:='1' else c:='0';  //>
              224: if j>=0 then c:='1' else c:='0';  //>=
             end;
           end else begin
             case t^.num of
              221: if d<dd then c:='1' else c:='0';  //<
              222: if d<=dd then c:='1' else c:='0';  //<=
              223: if d>dd then c:='1' else c:='0';  //>
              224: if d>=dd then c:='1' else c:='0';  //>=
             end;
           end;
         end;
     230:begin
           s:=c(t^.r);
           s:=StringReplace(s,'%','*',[rfReplaceAll]);
           s:=StringReplace(s,'_','?',[rfReplaceAll]);
           if MatchesMask(c(t^.l),s) then c:='1' else c:='0';
         end;
     231:begin
           s:=c(t^.r);
           if MatchesMask(c(t^.l),s) then c:='1' else c:='0';
         end;
     251: begin   // ;  formula separated
            result:=c(t^.l); //must evaluated
            result:=c(t^.r);
          end;
     250://if FFParams.Count<2 then Error('Error param. count') else
         begin
           (*
           60=copy(s,x,[y]);
           61=copyto(s,x,[y]);
           62=Pos(t,s)
           63=Delete(s,x,[y]);
           64=replace(s,t,v,ReplaceAll=1/0,IgnoreCase=1/0)
           65=MaxVal(x,y,[z, ...])
           66=MinVal(x,y,[z, ...])
           67=SumVal(x,...)
           68=AvgVal(x,...)
           69=IFF(a,x,y);
           70=Insert(t,s,x);
           *)
           s:=c(t^.r);
           FFParams.Insert(FFParams.count-2,s);
           c:=c(t^.l);
         end;
     else  {case else}
       Error('Internal error oper code '+inttoStr(t^.num));
     end;
   end;
var sss:string;
begin
  fIndex:=index;
  FFParams.clear; FFParams.Text:='';
  if Pos(fQuote,fFormula)>0 then fResultType:=2 else fResultType:=1;
  while (fFormula<>'') and (fFormula[length(fFormula)] in [';',' ']) do system.delete(fFormula,length(fFormula),1);
  try
    sss:=Separ(fFormula);
    Test(sss);
    sss:=c(tree);
    if fDebug then
      if Assigned(fOnShowPos) then fOnShowPos(Self,Format('Formula: %s Result: %s',[fFormula,sss]));
    if not fErr then begin
      fResultType:=PCalc_TREE(Tree)^.typ;
      result:=sss;
      if fResultType=2 then begin
        if not IsString(sss) then  result:=fQuote+sss+fQuote; //result:=AnsiQuotedStr(sss,fQuote);
      end;
    end;
    DelTree(Tree);
    cVek:=0; MaxVek:=0; SetLength(fVek,0);
  except
    Error('');
    try
     DelTree(Tree);
     cVek:=0; MaxVek:=0; SetLength(fVek,0);
     except end;
  end;
end;

function TCalcul.IsString(s:string):boolean;
begin
  s:=trim(s); result:=false;
  if length(s)=0 then exit;
  if s[1]<>fQuote then exit;
  if s[length(s)]<>fQuote then exit;
  result:=true;
end;

procedure TCalcul.Error(s:string);
begin
 if fErr=false then begin
   if s='' then s:='invalid formula';
   fErrText:=s;
   fErr:=true;
   //if Err then if Assigned(fErr) then fErr(self,fErrText);
 end;
 //Raise ; //Exception.Create(s);
end;



//*********************************************************************

function TCalcul.GetTree(s:string):pointer;
    //Get number from string

    function getnumber(s:string):string;
    begin
      Result:='';
      try
      //Begin
      //if Pos(DecimalSeparator,s)>0 then s[Pos(DecimalSeparator,s)]:='.';
      while (fpos<=length(s)) and  (s[fpos] in ['0'..'9']) do begin
        Result:=Result+s[fpos];
        inc(fpos);
      end;
      if fpos>length(s) then exit;
      if s[fpos]='.' then
        begin
        //Fraction part
        Result:=result+'.';inc(fpos);
        if (fpos>length(s)) or not(s[fpos] in ['0'..'9'])
              then begin Error('Wrong number in '+s); exit; end;
        while (fpos<=length(s)) and
              (s[fpos] in ['0'..'9']) do
                   begin
                   Result:=Result+s[fpos];
                   inc(fpos);
                   end;
        end;
      if fpos>length(s) then exit;
      //Power
      if (s[fpos]<>'e')and(s[fpos]<>'E') then exit;
      Result:=Result+s[fpos];inc(fpos);
      if fpos>length(s) then begin Error('Wrong number in '+s); exit end;
      if s[fpos] in ['-','+'] then
           begin
           Result:=Result+s[fpos];
           inc(fpos);
           end;
      if (fpos>length(s)) or not(s[fpos] in ['0'..'9'])
         then begin Error('Wrong number in '+s); exit; end;
      while (fpos<=length(s)) and
              (s[fpos] in ['0'..'9']) do
                   begin
                   Result:=Result+s[fpos];
                   inc(fpos);
                   end;
      except
      end;
    end;

    //Read lexem from string

    procedure getlex(s:string; var num:integer; var con:string);
    var mb:boolean;
        i:integer;
        mcon:string;
        ccc:char;
        z:boolean;
    begin
      con:=''; num:=0;
      //skip spaces
      while (fpos<=length(s))and (s[fpos] in [' ',#0..#13,'{','}']) do inc(fpos);
      if fpos>length(s) then begin num:=0;  exit; end;

      if s[fpos]=fQuote then begin
         inc(fpos); mb:=true;
         while mb do begin
           mb:=false;
           while(fpos<=length(s))and (s[fpos]<>fQuote) do begin
            con:=con+s[fpos];
            inc(fpos);
           end;
           if (fpos<length(s))and (s[fpos+1]=fQuote) then begin
            inc(fpos);con:=con+s[fpos]; inc(fpos);
            mb:=true;
           end;   //"alfa""
         end;
         if (fpos>length(s)) or ((fpos<length(s)) and (s[fpos]<>fQuote)) then Error('String value end error');
         num:=8;
      end else begin
        case s[fpos] of
        '(': num:=1;
        ')': num:=2;
        '+': num:=3;
        '-': begin
             num:=4;
               if (fpos<length(s)) and (s[fpos+1]in ['1'..'9','0']) and (curlex in [0,1] )then begin
                inc(fpos);
                con:='-'+getnumber(s);
                dec(fpos);
                num:=7;
               end;
             end;
        '*': num:=5;
        '/': num:=6;
        '^': num:=31;
        '|': begin
               if (s[fpos+1]='|')  then Inc(fpos);
               num:=202; //a add b  string operation
             end;
        '1'..'9','0':
            begin
              con:=getnumber(s);
              dec(fpos);
              num:=7;
            end;
        '>': begin
                 if(fpos<=length(s))and (s[fpos+1]='=') then begin
                   num:=224; inc(fpos);     //>=
                 end else num:=223;         //>
             end;
        '<': begin
                 if(fpos<=length(s))and (s[fpos+1]='=') then begin
                   num:=222; inc(fpos);     //<=
                 end else begin
                   if (fpos<=length(s))and (s[fpos+1]='>') then begin
                     num:=225; inc(fpos); //<>
                   end else num:=221;     //<
                 end;
             end;
        '=' : num:=220;
        ',' : num:=250;
        ';' : num:=251; //formules separator;
        'a'..'z','A'..'Z','_','[',#255:    //num=9 nastavi ze je to funkcia alebo variable
            begin
              ccc:=s[fpos];
              if ccc='[' then begin
                i:=Pos('] ',s);
                if i=0 then i:=Pos('];',s);
                if (i=0) and (s[length(s)]=']') then i:=length(s);
                if i=0 then Error('Invalid set parameter [..]');
                con:=system.copy(s,fPos,i-fPos+1);
                fPos:=i+1;
                num:=9;
              end else begin
                while(fpos<=length(s))and (s[fpos] in ['a'..'z','A'..'Z','_','.','1'..'9','0']) do
                begin
                  con:=con+s[fpos];
                  inc(fpos);
                end;
                if (ccc=#255) and (length(s)>=fpos+1) and (s[fpos]=#255) then con:=con+#255 else dec(fpos); //variable 'name'
                if (ccc<>#255) and (length(s)>=fpos+1) and (s[fpos+1]='(') then con:=con+'('; //funkcia
                if (ccc<>#255) and (length(s)>=fpos+2) and (s[fpos+1]=':') and (s[fpos+2]='=') then begin
                   fPos:=fPos+2; i:=fpos; z:=false;
                   while (i<length(s)) do begin
                     inc(i);
                     if (s[i]=';') and (z=false) then begin dec(i); break; end;
                     if s[i]=fQuote then z:=not(z);
                   end;
                   con:='@@'+con;
                   fVaria.SetValue(con,'['+copy(s,fPos+1,i-fpos)+']');
                   fPos:=i;
                   num:=9;
                end;
                if ccc=#255 then begin
                  if con[length(con)]=#255 then con:=system.copy(con,1,length(con)-2) else Error('Invalid varaible name '+con) //variab 'name'
                end;
                num:=9;
              end;
            end;
        end;
      end;

      if num=9 then begin
        if length(con)>1 then begin
          mcon:=lowercase(con);
          if mCon[length(mcon)]='(' then begin
            //function  to from 11 to 199
               (*
           60=copy(s,x,[y]);
           61=copyto(s,x,[y]);
           62=Pos(t,s)
           63=Delete(s,x,[y]);
           64=replace(s,t,v,ReplaceAll=1/0,IgnoreCase=1/0)
           65=MaxVal(x,y,[z, ...])
           66=MinVal(x,y,[z, ...])
           *)
            case mcon[1] of
              'g':begin
                   if mcon='glbegin(' then num:=_glBegin;
                   if mcon='glend(' then num:=_glEnd;
                   if mcon='glvertex3f(' then num:=_glVertex3f;
                   if mcon='glnewlist(' then num:=_glNewList;
                   if mcon='glendlist(' then num:=_glEndList;
                   if mcon='glcolor3f(' then num:=_glColor3f;
                   if mcon='gldeletelists(' then num:=_glDeleteList;
                   if mcon='gllinewidth(' then num:=_glLineWidth;
                  end;
              'r': begin
                      if mcon='random(' then num:=_random;
                      if mcon='replace(' then num:=64;
                      if mcon='readln(' then num:=_readln;
                      if mcon='read(' then num:=_read;
                    end;
              'p': begin
                     if mcon='pos(' then num:=62;
                     if mcon='prefix(' then num:=226;
                   end;
              'f': begin
                if mcon='frac(' then num:=33;
                if mcon='freevar(' then num:=30;
                {if mcon='freeconsole(' then num:=_freeConsole;}
                if mcon='free2d(' then num:=_free2D;
                //if mcon='free3d(' then num:=_free3D;
                if mcon='format(' then num:=_format;
              end;
              'c':begin
              if mcon='cos(' then num:=11;
              if mcon='ctg(' then num:=14;
              if mcon='ch(' then num:=25;
              if mcon='cth(' then num:=27;
              if mcon='char(' then num:=43;
              if mcon='copy(' then num:=60;     //copy(a,x,y)
              if mcon='copyto(' then num:=61;     //copy(a,x,y)
              if mcon='clr(' then num:=_clearConsole;
              end;
              's':begin
                if mcon='string(' then num:=196;
                if Pos('stamp',mcon)=1 then
                  begin
                    if mcon='stamptodatestr(' then num:=56;
                    if mcon='stamptotimestr(' then num:=57;
                    if mcon='stamptostr(' then num:=58;
                  end;
              if mcon='strtostamp(' then num:=55;
              if mcon='sin(' then num:=12;
              if mcon='sign('then num:=16;
              if mcon='sqrt(' then num:=17;
              if mcon='sh(' then num:=24;
              if mcon='sec(' then num:=54;
              if mcon='sumval(' then num:=67;
              if mcon='sleep(' then num:=_sleep;
              if mcon='setxyaxislength(' then num:=_setXYaxisLength;
              if mcon='setbuffsize(' then num:=_setBuffSize;
              end;
              't': begin
              if mcon='trunc(' then num:=34;
              if mcon='trim(' then num:=41;
              if mcon='tg(' then num:=13;
              if mcon='th(' then num:=26;
              if mcon='trimleft(' then num:=38;
              if mcon='trimright(' then num:=39;
              end;
              'a':begin
                if Pos('arc',mcon)=1 then begin
                  if mcon='arcsin(' then num:=20;
                  if mcon='arccos(' then num:=21;
                  if mcon='arctg(' then num:=22;
                  if mcon='arcctg(' then num:=23;
                end else begin
                  if mcon='abs(' then num:=15;
                  if mcon='ascii(' then num:=44;
                  if mcon='avgval(' then num:=68;
                end;
              end;
              'l':begin
              if mcon='ln(' then num:=18;
              if mcon='lower(' then num:=46;
              if mcon='logic(' then  num:=198;
              if mcon='length(' then  num:=35;
              if mcon='lastday(' then  num:=32;
              if mcon='linetoxy(' then num:=_lineToXY;
              end;
              'e':begin
              if mcon='exp(' then num:=19;
              if mcon='eval(' then num:=42;
              if mcon='existvar(' then num:=29;
              end;
              'h':begin
              if (mcon='heaviside(') or (mcon='h(') then num:=28;
              if (mcon='hour(') then num:=52;
              end;
              'u':if mcon='upper(' then num:=45;
              'n':begin
                if mcon='not(' then num:=47;            // not(a)
                if mcon='numeric(' then num:=197;            // not(a)
                if mcon='numbase(' then num:=71;
              end;
              'd':begin
              if mcon='delete(' then num:=63;    //
              if mcon='day(' then num:=51;     //day()
              if mcon='drawgrids(' then num:=_drawGrids;
              if mcon='drawaxis(' then num:=_drawAxis;
              if mcon='draw2d(' then num:=_draw2D;
              end;
              'm':begin
              if mcon='month(' then num:=49;
              if mcon='minute(' then num:=53;
              if mcon='maxval(' then num:=65;
              if mcon='minval(' then num:=66;
              if mcon='movetoxy(' then num:=_moveToXY;
              if mcon='messagebox(' then num:=_messagebox;
              end;
              //'v': if mcon='void(' then num:=_void;
              'w':begin
                if mcon='weekday(' then num:=48;
                if mcon='writeln(' then num:=_writeln;
                if mcon='write(' then num:=_write;
              end;
              'y':if mcon='year(' then num:=50;
              'i':begin
                if mcon='iff(' then num:=69;
                if mcon='insert(' then num:=70;
                if mcon='include(' then num:=_useModule;
                if mcon='initconsole(' then num:=_initConsole;
                if mcon='init2d(' then num:=_init2D;
                if mcon='init3d(' then num:=_init3D;
              end;
              'b': if mcon='basenum(' then num:=72;
            end; {case}
            if num=9 then Error('Invalid function '+con+'...)');
          end else begin
            case mcon[1] of
              // 2nd operands from 200 to 255
             'l':begin
                if mcon='like' then num:=230;  //like (%,_');
                if mcon='lf' then num:=2;
              end;
              'w': begin                   //like by do (*,?)
              if mcon='wildcard' then num:=231;
              end;
              'a':begin
               if mcon='and' then num:=210;
              end;
              'd':begin
              if mcon='div' then num:=200;
              end;
              'm':begin
              if mcon='mod' then num:=201;
              end;
              'o':if mcon='or' then num:=211;
              'i':if mcon='in' then num:=203;
            else
              //Error('Invalic operand '+con);
            end;//case
          end;
        end;
      end;
      inc(fpos);
      PrevLex:=CurLex;
      CurLex:=num;
    end;

var neg:boolean;
    l,r,res:PCalc_Tree;
    n,op:integer;
    c:string;

    function newnode:PCalc_Tree;
    begin
      //Result:=allocmem(sizeof(TCalc_Tree));
      new(result);
      AddVek(result);
      Result^.l:=nil;
      Result^.r:=nil;
    end;

    function getsingleop:pointer;
    var op,bracket:integer;
        opc:string;
        l,r,res:PCalc_Tree;
    begin
      l:=nil; result:=nil;
      try
        if n=1 then begin
          inc(bc); l:=gettree(s);
        end else begin
          // First operand
          if not(n in [7..199,226]) then begin
            Error('? operand '); exit
          end;
          op:=n;opc:=c;
          if n in [7,8,9] then begin
           // Number or variable
           l:=newnode; l^.num:=op; l^.con:=opc;
          end else begin
            //Function
            getlex(s,n,c);
            if n<>1 then begin Error(''); exit; end;  //first char must by:(
            inc(bc);
            l:=newnode;
            l^.l:=gettree(s); l^.num:=op; l^.con:=opc;
          end;
        end;
        //Operation symbol
        getlex(s,n,c);
        //Power symbol
        while n in [31] do begin
         getlex(s,n,c);
         bracket:=0;
         if n=1 then  begin   bracket:=1;   getlex(s,n,c);   end;
         if not (n in [7,8,9]) then begin Error('Invalid values'); exit; end;
         r:=newnode; r^.num:=n; r^.con:=c;
         res:=newnode; res^.l:=l; res^.r:=r; res^.num:=31; l:=res;
         if bracket=1 then
         begin
           getlex(s,n,c);
           if n<>2 then begin Error(''); exit; end;
         end;
          getlex(s,n,c);
        end;
        Result:=l;
      except
        DelTree(l);
        Result:=nil;
      end;
    end;


    function getop:pointer;  // unary or dual operand
    var op:integer;
        l,r,res:PCalc_Tree;
    begin
      neg:=false;
      getlex(s,n,c);
      // Unary - or +
       if prevlex in [0,1,4,3] then begin
         if n=4 then  begin  neg:=true; getlex(s,n,c);  end;
         if n=3 then getlex(s,n,c);
       end;
       l:=getsingleop;
      // 2nd operand **************
       while n in [5,6,200..255] do begin
         op:=n;
         getlex(s,n,c);
         r:=getsingleop;
         //res:=allocmem(sizeof(TCalc_Tree));
         new(res);
         Addvek(res);
         res^.l:=l; res^.r:=r; res^.num:=op;l:=res;
       end;
      // Unary minus
       if neg then begin
         //res:=allocmem(sizeof(TCalc_Tree));
         new(res);
         addvek(res);
         res^.l:=l; res^.r:=nil; res^.num:=10;l:=res;
       end;
       Result:=l;
    end;

begin
  l:=nil; result:=nil;
  try
    l:=getop;
    while true do begin
       if n in [0,2] then begin
         if n=2 then dec(bc);
         Result:=l; exit;
       end;
       if not( n in [3,4,8,9]) then begin Error('Invalid expression'); exit; end;
       op:=n;
       r:=getop;
       new(res);
       //res:=allocmem(sizeof(TCalc_Tree));
       Addvek(res);
       res^.l:=l; res^.r:=r; res^.num:=op;l:=res;
    end;
    Result:=l;
  except
    DelTree(l);
    Result:=nil;
  end;
end;


//***************************************************************


function TCalcul.Test(s:string {sys:boolean=false}):integer;
begin
  deltree(tree); result:=0;
  cVek:=0; MaxVek:=0; SetLength(fVek,0);
  fErr:=false; fErrtext:='';
  Prevlex:=0;  Curlex:=0;  fPos:=1;  bc:=0;
  Tree:=GetTree(s); if s='{' then exit;
  PCalc_tree(tree)^.typ:=fResultType;
  if (bc<>0 ) or fErr then begin
     DelTree(Tree);
     cVek:=0; MaxVek:=0; SetLength(fVek,0);
     result:=-1;
   end else result:=1;
end;

//Tree deletion

procedure TCalcul.deltree(t:PCalc_Tree);
begin
 try
   if t=nil then exit;
   if cVek>0 then begin
     if (t^.id>cVek) or (t^.id<1) then exit;
     try if t^.l<> nil then Deltree(t^.l); except end;
     try if t^.r<> nil then Deltree(t^.r); except end;
     Delvek(t);
     try Dispose(t); except end;
   end;
   t:=nil;
 except
 end;
end;

procedure TCalcul.SetVariables(Value:String);
begin
  fVaria.Clear;
  fVaria.AddLineText(Value);
end;

function TCalcul.GetVariables:String;
begin
  result:=fVaria.text;
end;

procedure TCalcul.Addvek(t:pointer);
begin
  inc(cVek);
  if cVek>=MaxVek then begin
    MaxVek:=Maxvek+64; SetLength(fVek,MaxVek);
  end;
  PCalc_tree(t)^.id:=cVek;
  fVek[cVek]:=1;
end;

procedure TCalcul.Delvek(t:pointer);
begin
  if (PCalc_tree(t)^.id<=cVek) and (PCalc_Tree(t)^.id>0) then
    fvek[PCalc_Tree(t)^.id]:=0;
end;

function Tcalcul.Separ(s:string):string;
var b: array[1..100] of smallint;
  i,j,k:integer;
  z,c:boolean;
begin
  i:=Pos(',',s);
  if i=0 then begin result:=s;exit;end;
  z:=false; c:=false;
  i:=0; k:=0;
  while i<length(s) do begin
    inc(i);
    if s[i]=fQuote then z:=not(z);
    if (not c) and (s[i]='[') then c:=true;
    if (not c) and (s[i]=']') then c:=false;
    if (not z) and (not c) then begin
      if s[i]=',' then begin
        if (k>0) and (b[k]=0) then begin
          system.insert(')',s,i); inc(i);
          dec(k);
        end else begin
          j:=i;
          system.insert(')',s,i); inc(i);
          b[1]:=0;
          while j>1 do begin
            dec(j);
            if s[j] =')' then b[1]:=b[1]-1;
            if s[j] ='(' then b[1]:=b[1]+1;
            if b[1]>0 then begin
              system.insert('(',s,j); inc(i);
              b[1]:=0;j:=0;
            end;
          end;
        end;
        inc(i);
        system.insert('(',s,i);
        k:=k+1; b[k]:=0;
        continue;
      end;
      if k>0 then begin
        if s[i] ='(' then b[k]:=b[k]+1;
        if s[i] =')' then b[k]:=b[k]-1;
        if b[k]<0 then begin
          dec(k); system.insert(')',s,i); inc(i);
        end;
      end;
    end;
  end;
  result:=s;
end;

Function TCalcul.FormulaVariables:string;
const cEnd='+-*/|&^!<>=]);,}{';
var t,k,rr:string;
    z:boolean;
    i,j:integer;
begin
  t:=fFormula; rr:=';'; Result:='';
  t:=StringReplace(t,#13#10,' ',[rfReplaceAll,rfIgnoreCase]);
  while Pos(' ',t)>0 do system.delete(t,Pos(' ',t),1);
  i:=Pos('eval('+fQuote,lowerCase(t));
  while i>0 do begin
    if i>0 then begin
      for j:=i+Length('eval('+fQuote) to length(t)-1 do begin
        if (t[j]=fQuote) and (t[j+1]=')') then begin
           t[j]:='+';
           t:=copy(t,1,i-1)+'+'+ copy(t,i+length('eval('+fQuote),length(t));
           break;
        end;
      end;
    end;
    i:=Pos('eval('+fQuote,lowerCase(t));
  end;
  z:=false; t:=t+';'; k:='';
  for i:=1 to length(t) do begin
    if t[i]=fQuote then z:=not(z);
    if not z then begin
      if t[i] in ['A'..'Z','a'..'z','_','0'..'9','.'] then k:=k+t[i]
      else begin
        if (k<>'') and (Pos(copy(t,i,1),cEnd)>0)  then begin
          if k[1] in ['A'..'Z','a'..'z','_'] then begin
            if Pos(';'+Lowercase(k)+';',';in;like;wildcard;and;or;xor;mod;div;_lf;_tb;_pi;_date;_time;_now;_user;')=0
            then begin
              if Pos(';'+LowerCase(k)+';',lowercase(rr))=0 then rr:=rr+k+';';
            end;
          end;
        end;
        k:='';
      end;
    end;
  end;
  system.Delete(rr,1,1);
  result:=rr;
end;

end.
