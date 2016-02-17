(*   ********************************************************
     *                  Borland Delphi                      *
     *     TInterpreter object, unit uInterpreter.pas       *
     *                   version 2.4.1                      *
     *               Author:  Jan Tungli (c) 2002           *
     *               web:     www.tsoft.szm.sk              *
     *               mailto:  jan.tungli@seznam.cz          *
     ********************************************************

      If you want modify this source code,
      plase send me your source segment
      to mail: jan.tungli@seznam.cz with subject "Interpreter"

    _____________________________________________________________________
   | Interpreter,  key words & syntax:                                   |
   |=====================================================================|
   |       IF ...   THEN { ... } [ELSE { ...}]                           |
   |       WHILE ... DO { ... }                                          |
   |       PROCEDURE <ProcedureName> { ... }                             |
   |       EXEC <ProcedureName>                                          |
   |       BREAK                                                         |
   |       CONTINUE                                                      |
   |       EXIT                                                          |
   |       BEEP                                                          |
   |       END.  // ritual program end                                   |
   |       /* note */                                                    |
   |---------------------------------------------------------------------|
   |    Notice: all variables are global varaibles                       |
   |_____________________________________________________________________|

   -----------------------------------------------------------------------
   History:
     ver. 2.4 18.5.2002  beta version
     ver.2.4.1. 21.5.2002 - corect use note /* */
                            error position
                            ELSE syntax control
   -----------------------------------------------------------------------

   Example:
     Interpreter1.Calcul:=Calcul1;
     Interpreter1.Prog:=Memo1.text;
     Interpreter1.Execute;
     if Interpreter1.Error then begin
       ShowMessage(Interpreter1.ErrorText);
       Memo1.SetFocus;
       Memo1.SelStart:=Interpreter1.ErrorPos-1;
     end;

*)


unit uInterpreter;

interface
uses
  Windows, SysUtils, Classes, Controls,
  uFunctions, uCalcul;

type
  TPosRecord= record
                z:integer;  // angle brackets level  { }
                p:integer;
                pp:integer;
                //pp>0 is WHILE position after DO keyword & p is position of expression : While <expression> DO
                //pp=0 is IF ...THEN  & p expression value 0/1 : IF <expression> THEN
                //pp=-1 is EXEC <PROCEDURE> & p= is next position
                c:integer;  //WHILE counter
              end;
  TInterpreter=class(TObject)
  private
    fErr:boolean;
    fErrText:string;
    fErrPos:integer;
    fProg:String;
    fCalcul:TCalcul;
    fFunc:TStringList;
    fPos:array of TPosRecord;
    fInd, fCnt:integer;
    procedure Procedures;
    function GetToWord(word:string; var i:integer):string;
  public
    constructor Create;
    destructor Destroy;override;
  published
    property Prog: string read fProg write fProg;
    property Calcul: TCalcul read fCalcul write fCalcul;
    property Error:boolean read fErr;
    property ErrorText:string read fErrText;
    property ErrorPos:integer read fErrPos;
    procedure Execute;
  end;


implementation
const cMaxWhile:integer=65000; //max. while repeat count

constructor TInterpreter.Create;
begin
  inherited create;
  fFunc:=TStringList.Create;
  fCalcul:=nil;
end;

destructor Tinterpreter.Destroy;
begin
  fFunc.Free; SetLength(fPos,0);
  inherited destroy;
end;

procedure TInterpreter.Procedures;
var i,j,zz:integer;
    t:string;
    b,z,n:boolean;
begin
  fFunc.text:='';
  b:=false; z:=false; fErr:=false; zz:=0; n:=false;
  i:=0;
  while i<length(fprog) do begin
    inc(i);
    if not (fProg[i] in [#0..#13,';']) then begin
      if (not b) and (fprog[i]='"') then begin z:=not(z); continue; end;
      if (not z) and (fProg[i]=#39) then begin b:=not(b); continue; end;
      if (not z) and (not b) then begin
        if (fProg[i]='/') and (i+1<length(fProg)) and (fProg[i+1]='*') then begin
          n:=true; //nf:=i;
          continue;
        end;
        if (fProg[i]='/') and (i-1>0) and (fProg[i-1]='*') then begin
          n:=false;
          continue;
        end;
        if n then continue; //notice   /* ... */
        if fProg[i]='{' then begin inc(zz); continue; end;
        if fProg[i]='}' then begin
          dec(zz);
          if zz<0 then begin
            fErr:=true;
            fErrText:='Invalid syntax: count of angle brackets, from '+IntToStr(i);
            fErrPos:=i;
            exit;
          end;
          continue;
        end;
        if fProg[i] in ['p','P'] then begin
          t:=system.copy(fprog,i,length('PROCEDURE '));
          if Uppercase(t)='PROCEDURE ' then begin
            j:=i+length('PROCEDURE ');
            while (j<length(fProg)) and (fprog[j] in [#0..#13,' ']) do inc(j);
            if (j<length(fProg)) and (fProg[j] in ['A'..'Z','a'..'z','_']) then begin
              t:='';
              while (j<length(fProg)) and (fProg[j] in ['A'..'Z','a'..'z','_','0'..'9']) do begin
                t:=t+fProg[j];
                inc(j);
              end;
              while (length(fProg)>j) and (fProg[j] in [' ',#0..#13]) do inc(j);
              if (j>=length(fProg)) or (fProg[j]<>'{') then begin
                fErr:=true;
                fErrText:='Invalid procedure definitions from '+intToStr(length(fprog));
                ferrpos:=length(fProg);
              end;
              t:=Uppercase(t);
              fFunc.add(t+'='+IntToStr(j-1));
            end else begin
              fErr:=true;
              fErrText:='Invalid first character in procedure name ('+fprog[j]+') from '+IntToStr(j);
              ferrPos:=j;
            end;
          end;
        end;
      end;
    end;
  end;
  if zz<>0 then begin
    fErr:=true;
    fErrText:='Invalid syntax: count of angle brackets, from '+IntToStr(i);
    fErrPos:=i;
  end;
end;

function Tinterpreter.GetToWord(word:string; var i:integer):string;  {then, do}
var t:string;
    j,l,x:integer;
    z,b,n:boolean;
begin
  result:='';
  word:=uppercase(word);
  l:=length(word); z:=false; b:=false; n:=false;
  for j:=i to length(fprog)-l do begin
    if fprog[j] in [#0..#13] then continue;
    if (not b) and (fProg[j]='"') then begin z:=not z; continue; end;
    if (not z) and (fProg[j]=#39) then begin b:=not b; continue; end;
    if (not z) and (not b) then begin
      if (fProg[i]='/') and (i+1<length(fProg)) and (fProg[i+1]='*') then begin
        n:=true; //nf:=i;
        continue;
      end;
      if (fProg[i]='/') and (i-1>0) and (fProg[i-1]='*') then begin
        n:=false;
        //system.delete(fProg,nf,i-nf+1);
        //i:=nf-1;
        continue;
      end;
      if n then continue;
      if fProg[j] in [';','{','}'] then begin fErr:=true; fErrText:='Syntax error from '+IntToStr(j); fErrPos:=j; exit; end;
      if UpCase(fProg[j+1])=word[2] then begin
        t:=copy(fProg,j,l+1);
        if uppercase(system.copy(t,1,l))=word then begin
          if length(t)=l+1 then begin
            if not (t[l+1] in [' ','{',#0..#13]) then continue;
            if not (fprog[j-1] in [')',';',#0..#13,' ']) then continue;
          end;
          x:=j+l;
          while (Length(fProg)>x) and (fProg[x] in [' ',#0..#13]) do inc(x);
          if fProg[x]<>'{' then begin
            fErr:=true;
            fErrText:='Incorrect syntax:'+UpperCase(word)+' lack "{" form '+IntToStr(x);
            fErrPos:=x;
            exit;
          end;
          result:=trim(system.copy(fProg,i,j-i));
          i:=j+l;
          Exit;
        end;
      end;
    end;
  end;
  fErr:=true;
  fErrText:='Incorrect syntax: lack "'+word+'" key word from '+IntToStr(i);
  fErrPos:=i;
end;

procedure TInterpreter.Execute;
var z,b,n :boolean;
    i,j,zz,ii:integer;
    t,s:string;

procedure Go;
var w:string;
begin
  if ii=0 then ii:=1;
  if ii>=i then exit;
  w:=trim(system.copy(fprog,ii,i-ii));
  while (w<>'') and  (w[1] in ['{',' ',';']) do system.delete(w,1,1);
  if (w<>'') and (w<>';') then begin
    fCalcul.Formula:=w;
    try
      fCalcul.calc;
      if fCalcul.CalcError then begin
        fErr:=true;
        fErrText:=fCalcul.CalcErrorText+#13#10+' formula:'+w;
        ferrPos:=ii;
      end;
    except
      if fErr=false then begin
        fErr:=true;
        fErrText:='Invalid formula:'+w;
        ferrPos:=ii;
      end;
    end;
  end;
end;
begin
  if fCalcul=nil then begin
    fErr:=true;
    fErrText:='Errro, CALCUL object is nil';
    exit;
  end;
  fErr:=false; fErrPos:=0; ferrText:='';
  Procedures;
  if fErr then exit;
  fCnt:=20; Setlength(fPos,fCnt);
  fInd:=0;fPos[0].z:=0; fPos[0].p:=1; fPos[0].pp:=0;
  b:=false; z:=false; fErr:=false;
  i:=0; zz:=0; ii:=1;  n:=false;
  while i<length(fprog) do begin
    inc(i);
    if fprog[i] in [#0..#13,' ',';'] then continue;
    if (not b) and (fprog[i]='"') then begin z:=not(z);continue; end;
    if (not z) and (fProg[i]=#39) then begin b:=not(b);continue; end;
    if b or z then continue;
    if (fProg[i]='/') and (i+1<length(fProg)) and (fProg[i+1]='*') then begin
      n:=true; //nf:=i;
      continue;
    end;
    if (fProg[i]='/') and (i-1>0) and (fProg[i-1]='*') then begin
      n:=false; ii:=i+1;
      continue;
    end;
    if n then continue;
    if fProg[i]='{' then begin inc(zz); continue; end;
    if fProg[i]='}' then begin
      if fPos[find].p<>0 then go;
      ii:=i+1;
      dec(zz);
      if zz<0 then begin
        fErr:=true; fErrText:='Incorrect syntax ?} from '+IntToStr(i);
        ferrPos:=i;
        exit;
      end;
      if fPos[fInd].z=zz then begin
        if fPos[fInd].pp=0 then begin //IF
          dec(fInd); continue;
        end;
        if fPos[fInd].pp>0 then begin   //while
          i:=fPos[fInd].p; ii:=fPos[fInd].pp;
          t:=system.copy(fprog,i,ii-i-2);
          fCalcul.Formula:='logic('+trim(t)+')';
          try
            s:=fCalcul.calc;
            if fcalcul.CalcError then begin
               fErr:=true;
               fErrText:=fCalcul.CalcErrorText;
               fErrPos:=ii;
            end;
          except
             fErr:=true;
             fErrText:='Invalid formula:'+t;
             fErrPos:=ii;
          end;
          if fErr then exit;
          if s='0' then begin
            fPos[fInd].p:=0; fPos[fInd].pp:=0;  // ako if FALSE then
          end else begin
            fPos[fInd].c:=fPos[fInd].c+1;
            if fPos[fInd].c>cMaxWhile then begin
              fErr:=true;
              fErrText:='Overflow WHILE count limit (set max. '+IntToStr(cMaxWhile)+')';
              fErrPos:=fPos[fInd].p;
              exit;
            end;
          end;
        end;
        if fPos[fInd].pp=-1 then begin  //procedure
          i:=fPos[fInd].p; ii:=i;
          dec(fInd);
          continue;
        end;
      end;
      continue;
    end;
    if fPos[fInd].p=0 then begin
      ii:=i+1; continue;
    end;
    case fprog[i] of
    'i','I':
      begin //IF
        t:=uppercase(system.copy(fProg,i,3));
        if t='IF ' then begin
          go;
          if fErr then exit;
          i:=i+3;
          t:=getToWord('THEN',i);
          if fErr then exit;
          if (t='') or (t=';') then begin
            fErr:=true;
            fErrText:='Incorrect syntax IF ... THEN from '+IntToStr(i);
            fErrPos:=i;
            exit;
          end;
          fCalcul.Formula:='logic('+t+')';
          try
            s:=fCalcul.calc;
            fErr:=fCalcul.CalcError;
            fErrText:=fCalcul.CalcErrorText+#13#10+'Formula:'+t;
         except
            fErr:=fCalcul.CalcError;
            fErrText:=fCalcul.CalcErrorText+#13#10+'Formula:'+t;
            if not fErr then begin
              fErr:=true;
              fErrText:='Invalid formula:'+t;
            end;
          end;
          if fErr then begin ferrPos:=i;exit;end;
          inc(fInd);
          if fInd>=fCnt then fCnt:=fCnt+20; SetLength(fPos,fCnt);
          fPos[fInd].z:=zz; fPos[fInd].pp:=0;
          if s='1' then fPos[fInd].p:=1 else fPos[fInd].p:=0;
          ii:=i;
        end;
      end;
    'e','E':
      begin //EXEC , EXIT ,ELSE, END.
        t:=uppercase(system.copy(fProg,i,5));
        if (system.copy(t,1,4)='ELSE') and (length(t)>4) and (t[5] in [' ','{',#0..#13]) then begin
          j:=i-1;
          while j>1 do begin
            if fProg[j] in [' ',#0..#13] then begin dec(j); continue; end else break;
          end;
          if (j<=1) or (fprog[j]<>'}') then begin
            ferr:=true;
            fErrtext:='Incorrect syntax:  lack "}" before ELSE from '+intToStr(i);
            ferrPos:=i;
            exit;
          end;
          j:=i+4;
          while fprog[j] in [' ',#0..#13] do inc(j);
          if fprog[j]<>'{' then begin
            ferr:=true;
            fErrtext:='Incorrect syntax: lack "{" after ELSE from '+intToStr(j);
            ferrPos:=j;
            exit;
          end;
          go;
          if fErr then begin ferrPos:=i;exit;end;
          i:=i+4;
          inc(fInd);
          if fInd>fCnt-1 then begin
            fErr:=true;
            fErrtext:='Incorrect syntax ?ELSE from '+IntToStr(i);
            fErrPos:=i;
            exit;
          end;
          if (fPos[fInd].pp<>0) or (not(fPos[fInd].p in [1,0])) or (fPos[fInd].z<>zz) then begin
            fErr:=true;
            fErrText:='Incorrect syntax ?ELSE from '+IntToStr(i);
            fErrPos:=i;
            exit;
          end;
          if fPos[fInd].p=1 then fPos[find].p:=0 else fPos[find].p:=1;
          ii:=i;
        end;
        if t='EXEC ' then begin
          go;
          if fErr then begin fErrPos:=i;exit;end;
          i:=i+5;
          t:='';
          while fprog[i] in [' ',#0..#13] do inc(i);
          for j:=i to length(fprog) do begin
            if fProg[j] in ['A'..'Z','a'..'z','_','0'..'9'] then t:=t+fprog[j] else break;
          end;
          t:=Uppercase(t);
          i:=i+length(t);
          j:=fFunc.IndexOfName(t);
          if (t='') or (j<0) or (not (t[1] in ['A'..'Z','_'])) then begin
            fErr:=true;
            fErrText:='Invalid EXEC procedure name from '+IntToStr(i);
            fErrPos:=i;
            exit;
          end;
          j:=StrToInt(trim(system.copy(fFunc.strings[j],Pos('=',fFunc.strings[j])+1,255)));
          inc(fInd);
          if fInd>fCnt-1 then begin fCnt:=fCnt+20; Setlength(fPos,fCnt); end;
          fPos[fInd].z:=zz; fPos[fInd].p:=i; fPos[fInd].pp:=-1; //procedure
          i:=j;
          ii:=i;
        end;
        if (system.copy(t,1,4)='EXIT') and (length(t)>4) and (t[5] in ['{','}',' ',';',#0..#13]) then begin
          go;
          if fErr then begin ferrPos:=i;exit;end;
          i:=i+4;
          for j:=fInd downto 0 do begin
            if fPos[j].pp=-1 then begin
              fInd:=j; i:=fPos[fInd].p; ii:=i; zz:=fPos[fInd].z; fInd:=j-1;
              break;
            end;
          end;
          if j<=0 then exit;
        end;
        if (system.copy(t,1,4)='END.') then begin
          if  ( (length(t)>4) and (t[5] in [' ',';',#0..#13]) ) or (length(t)=4) then begin
            go;
            if fErr then begin fErrPos:=i;exit;end;
            i:=i+4;
            ii:=i;
            Exit;
          end;
        end;
      end;
    'w','W':
      begin //WHILE
        t:=uppercase(system.copy(fProg,i,6));
        if t='WHILE ' then begin
          go;
          if fErr then begin fErrPos:=i;exit;end;
          Inc(fInd);
          if fInd>=fCnt then begin fCnt:=fCnt+20; SetLength(fPos,fCnt); end;
          fPos[fInd].z:=zz;
          fPos[fInd].p:=i;
          i:=i+6;
          fPos[fInd].p:=i;
          t:=GetToWord('DO',i);
          if fErr then exit;
          if (t='') or (t=';') then begin
            fErr:=true;
            fErrtext:='Incorrect syntax WHILE ?... DO from '+IntToStr(i);
            fErrPos:=i;
            Exit;
          end;
          fPos[fInd].pp:=i; fPos[fInd].c:=0;
          fCalcul.Formula:='logic('+trim(t)+')';
          try
            s:=fCalcul.calc;
            fErr:=fCalcul.CalcError;
            fErrText:=fCalcul.CalcErrorText+#13#10+'Formula:'+t;
          except
            fErr:=fCalcul.CalcError;
            fErrText:=fCalcul.CalcErrorText+#13#10+'Formula:'+t;
            if not fErr then begin
              fErr:=true;
              fErrtext:='Invalid formula:'+t;
            end;
          end;
          if fErr then begin
             ferrPos:=i;
             exit;
          end;
          if s='0' then begin
            fPos[fInd].p:=0; fPos[fInd].pp:=0;  // ako if FALSE then
          end;
          ii:=i;
        end;
      end;
    'b','B':
      begin //BREAK , BEEP
        if (i<length(fprog)) and (fProg[i+1] in ['e','E']) then begin //beep
          t:=uppercase(system.copy(fProg,i,5));
          if (system.copy(t,1,4)='BEEP') and (length(t)>4) and (t[5] in ['{','}',' ',';',#0..#13]) then begin
            go;
            Beep;
            i:=i+5; ii:=i;
          end;
        end else begin //Break
          t:=uppercase(system.copy(fProg,i,6));
          if (system.copy(t,1,5)='BREAK') and (length(t)>5) and (t[6] in ['{','}',' ',';',#0..#13]) then begin
            go;
            if fErr then begin ferrPos:=i;exit;end;
            i:=i+5;
            for j:=fInd downto 0 do begin
              if fPos[j].pp>0 then begin
                fInd:=j;
                i:=fPos[fInd].p-1; ii:=fPos[fInd].pp; zz:=fPos[fInd].z;
                fPos[fInd].pp:=0; fPos[fInd].p:=0;  // ako if false then ...
                Break;
              end;
            end;
            if j<=0 then ii:=i;
          end;
        end;
      end;
    'c','C':
      begin //Continue
        t:=uppercase(system.copy(fProg,i,9));
        if (system.copy(t,1,8)='CONTINUE') and (length(t)>8) and (t[9] in ['{','}',' ',';',#0..#13]) then begin
          go;
          if fErr then begin ferrPos:=i;exit;end;
          i:=i+8;
          for j:=fInd downto 0 do begin
            if fPos[j].pp>0 then begin
              fInd:=j;
              t:=system.copy(fProg,fPos[find].p,fPos[find].pp-fPos[find].p-2);
              fCalcul.Formula:='logic('+t+')';
              try
                s:=fCalcul.calc;
                fErr:=fCalcul.CalcError;
                fErrText:=fCalcul.CalcErrorText+#13#10+'Formula:'+t;
                ferrPos:=i;
              except
                fErr:=fCalcul.CalcError;
                fErrText:=fCalcul.CalcErrorText+#13#10+'Formula:'+t;
                if not fErr then begin
                  fErr:=true;
                  fErrtext:='Invalid formula:'+t;
                  ferrPos:=i;
                end;
              end;
              if fErr then exit;
              i:=fPos[fInd].p-1; ii:=fPos[fInd].pp; zz:=fPos[fInd].z;
              if s='0' then begin
                fPos[fInd].pp:=0; fPos[fInd].p:=0; //ako if false then ...
              end;
              Break;
            end;
          end;
          if j<=0 then ii:=i;
        end;
      end;
    end; {case}
  end; {while}
end;


end.
