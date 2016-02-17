unit uFunctions;

interface

uses Sysutils,Classes;
type

TText_array=array of String;
TText=class(TObject)
  private
    Names:String;      // ;<variable names>=<index>  in texts; use texts[index]
    Texts:TText_array;
    fCnt,fMaxCnt:integer;
  public
    constructor Create;
    destructor Destroy;override;
    function  Exists(name:string):boolean;   // exists VariableName
    function  GetValue(name:string):string; // returned variable value
    procedure SetValue(name,txt:string);  // add or update
    function  Rename(oldName,newName:string):boolean; // rename variable
    procedure Delete(name:string);    // delete variable
    procedure Clear;                  // clear variables
    function  Text:string;            // created : <Varaiable>=<Value>  {multy line}
    procedure AddLineText(s:string); // variable = value  ; must bee on 1 line
    function  Count:integer;         // really variable count
    function  Name(index:integer):string;    // variable name by index
  published
 end;

{---------------------------}
   function MStrToFloat(c:string; var d:extended):boolean;   //StrToFloat
   function MFloatToStr(x:extended):string;
   function MDateToStr(Dt:TDateTime):string;
   function MTimeToStr(Dt:TdateTime):string;
   function MDateTimeToStr(Dt:TDateTime):string;
   function MStrToDate(Dt:string):double;
   function MStrToTime(Dt:string):double;
   function MStrToDateTime(Dt:string):double;
   function Prefix(Count:byte; C:char; S:ShortString):ShortString;


implementation

constructor TText.Create;
begin
  inherited;
  fCnt:=0; fMaxCnt:=0; Names:='';
end;

destructor TText.Destroy;
begin
  fCnt:=0; fMaxCnt:=0; Names:='';
  SetLength(texts,0);
  inherited;
end;

procedure TText.Clear;
begin
  fCnt:=0; fMaxCnt:=0; Names:='';
  SetLength(texts,0);
end;

function TText.Exists(name:string):boolean;
begin
  name:=AnsiUppercase(name);
  result:=Pos(';'+name+'=',Names)>0;
end;

function TText.GetValue(name:string):string;
var i:integer;
    s:string;
begin
  name:=AnsiUppercase(name);
  result:='';
  i:=Pos(';'+name+'=',Names);
  if i>0 then begin
    s:=copy(names,i,length(name)+20);
    s:=copy(s,Pos('=',s)+1,20);
    i:=Pos(';',s);
    if i>1 then s:=copy(s,1,i-1);
    i:=StrToint(s);
    result:=Texts[i];
  end;
end;

procedure TText.SetValue(name,txt:string);  //add or update
var i:integer;
    s:string;
begin
  name:=AnsiUppercase(name);
  i:=Pos(';'+name+'=',Names);
  if i>0 then begin
    s:=copy(names,i,length(name)+20);
    s:=copy(s,Pos('=',s)+1,20);
    i:=Pos(';',s);
    if i>1 then s:=copy(s,1,i-1);
    i:=StrToint(s);
    Texts[i]:=txt;
  end else begin
    inc(fCnt);
    Names:=Names+';'+name+'='+IntToStr(fCnt);
    if fMaxCnt<=fCnt then begin
      fMaxCnt:=fMaxCnt+10; Setlength(Texts,fMaxCnt);
    end;
    texts[fCnt]:=txt;
  end;
end;

function TText.Rename(oldName,newName:string):boolean;
begin
  result:=false;
  oldName:=AnsiUppercase(oldName);
  newName:=AnsiUppercase(newName);
  if Exists(newName) then exit;
  if Exists(oldName) then exit;
  Names:=StringReplace(Names,';'+oldName+'=',';'+newName+'=',[]);
  result:=true;
end;

procedure TText.Delete(name:string);
var i,p,k,j:integer;
    s:string;
begin
  name:=AnsiUppercase(name);
  i:=Pos(';'+name+'=',Names);
  if i=0 then exit;
  if i>0 then begin
    s:=copy(names,i,length(name)+20);
    s:=copy(s,Pos('=',s)+1,20);
    p:=Pos(';',s);
    if p>1 then s:=copy(s,1,p-1);
    p:=StrToint(s);
    texts[p]:='';
  end;
  k:=length(names);
  for j:=i+length(name) to i+length(name)+20 do begin
    if Names[j]=';' then begin k:=j-1; break; end;
  end;
  system.Delete(Names,i,k-i+1);
  for i:=length(names) downto 1 do begin
    if Names[i]='=' then begin
      s:=copy(Names,i+1,20);
      j:=StrToInt(s);
      fCnt:=j;
      Break;
    end;
  end;
end;

function TText.Count:integer;
var i,j:integer;
begin
  j:=0;
  for i:=1 to length(names) do if Names[i]=';' then inc(j);
  result:=j;
end;

function TText.Name(index:integer):string;
var i,j:integer;
    s:string;
begin
  result:='';
  if index<0 then exit;
  index:=index+1;
  j:=0;
  if j<index then begin
    for i:=1 to length(names) do begin
      if Names[i]=';' then begin
        inc(j); if j=index then Break;
      end;
    end;
  end;
  if j<index then exit;
  s:=copy(Names,j+1,100);
  s:=copy(s,1,Pos('=',s)-1);
  result:=s;
end;

function TText.Text:string;
var s,m:string;
    i,j,k:integer;
begin
  result:='';
  if Names<>'' then s:=copy(Names,2,600000) else s:='';
  i:=Pos('=',s);
  while i>0 do begin
    m:=copy(s,1,i-1);
    system.delete(s,1,i);
    j:=pos(';',s);
    if j=0 then j:=length(s)+1;
    k:=StrToInt(copy(s,1,j-1));
    system.delete(s,1,j);
    result:=result+m+'='+texts[k]+#13#10;
    i:=Pos('=',s);
  end;
end;

procedure TText.AddLineText(s:string); // iba riadkovy ,  <VariableName>=<Value> , Variable accept  max. 1 line Value
var mL:TStringList;
    i:integer;
    t:string;
begin
  mL:=TStringList.Create;
  mL.text:=s;
  for i:=0 to mL.Count-1 do begin
    s:=mL.Strings[i];
    if pos('=',s)=0 then continue;
    t:=copy(s,1,Pos('=',s)-1);
    s:=copy(s,Pos('=',s)+1,600000);
    SetValue(t,s);
  end;
  mL.Free;
end;

{===========================================}
function Prefix(Count:byte; C:char; S:ShortString):ShortString;
begin
  while length(S)<count do S:=C+S;
  Result:=s;
end;

function MStrToFloat(c:string; var d:extended):boolean;   //StrToFloat
var err:integer;
    s:string;
begin
  s:=Trim(c);
  s:=StringReplace(s,',','.',[rfReplaceAll]);
  if (s<>'') and (s[1] in ['"',#39]) then system.delete(s,1,1);
  if (s<>'') and (s[length(s)] in ['"',#39]) then system.delete(s,length(s),1);
  Val(s,d,err);
  result:=err=0;
end;

function MFloatToStr(x:extended):string;
var s:string;
    i,j,k:word;
begin
  Str(x:0:15,s);
  i:=Pos('.',s);
  k:=0;
  for j:=Length(s) downto i+2 do if s[j]='0' then inc(k) else break;
  if k>0 then system.delete(s,Length(s)-k+1,k);
  if system.copy(s,length(s)-1,2)='.0' then system.delete(s,length(s)-1,2);
  result:=s;
end;

function MDateToStr(Dt:TDateTime):string;
begin
  result:=FormatDateTime('yyyy"/"mm"/"dd',dt);
end;

function MTimeToStr(Dt:TdateTime):string;
begin
  result:=FormatDateTime('hh":"nn":"ss"."zzz',dt);
end;

function MDateTimeToStr(Dt:TDateTime):string;
begin
  Result:=MDateToStr(Dt)+' '+MTimeToStr(Dt);
end;

function MStrToDate(Dt:string):double;
var i,j,Y,M,D,err:integer;
begin
  result:=0;
  Dt:=trim(Dt);
  if (dt<>'') and (dt[1]='"') then system.delete(dt,1,1);
  if (dt<>'') and (dt[length(dt)]='"') then system.delete(dt,length(dt),1);
  dt:=StringReplace(dt,' /','/',[rfReplaceAll]);
  dt:=StringReplace(dt,'/ ','/',[rfReplaceAll]);
  Dt:=trim(Dt);
  if (Dt='') or (not (dt[1] in ['0'..'9'])) then exit;
  if Pos(' ',dt)>1 then Dt:=system.copy(Dt,1,Pos(' ',dt)-1);
  Y:=1; M:=1; D:=1;
  i:=Pos('/',dt);
  if i>1 then begin
    Val(system.copy(dt,1,i-1),Y,err);
    system.delete(dt,1,i);
    i:=Pos('/',dt);
    if i>1 then begin
      Val(trim(system.copy(dt,1,i-1)),j,err);
      if err=0 then M:=j;
      system.delete(dt,1,i);
    end;
    Val(trim(dt),D,err);
  end else begin
    Val(trim(dt),i,err);
    if err=0 then Y:=i;
  end;
  if M>0 then begin
    if M mod 12=0 then begin
      Y:=Y+(M div 13);
    end else begin
      Y:=Y + (M div 12);
    end;
    M:=(M mod 12); if M=0 then M:=12;
  end else begin
    M:=ABS(M);
    Y:=Y-1-(M div 12); M:=12 -(M mod 12)
  end;
  if Y<1 then begin Y:=1; M:=1; D:=1; end;
  result:=EncodeDate(Y,M,1);
  Result:=Result+d-1;
  i:=trunc(EncodeDate(1,1,1));
  if result<i then result:=i;
end;

function MStrToTime(Dt:string):double;
var i,D,H,M,S,SS,err:integer;
begin
  Dt:=trim(Dt);result:=0;
  if (dt<>'') and (dt[1]='"') then system.delete(dt,1,1);
  if (dt<>'') and (dt[length(dt)]='"') then system.delete(dt,length(dt),1);
  Dt:=trim(Dt);
  dt:=StringReplace(dt,'  ',' ',[rfReplaceAll]);
  dt:=StringReplace(dt,' /','/',[rfReplaceAll]);
  dt:=StringReplace(dt,'/ ','/',[rfReplaceAll]);
  dt:=StringReplace(dt,' :',':',[rfReplaceAll]);
  dt:=StringReplace(dt,': ',':',[rfReplaceAll]);
  dt:=StringReplace(dt,' .','.',[rfReplaceAll]);
  dt:=StringReplace(dt,'. ','.',[rfReplaceAll]);
  if (Pos(' ',dt)>1) then begin
    Dt:=system.copy(Dt,Pos(' ',dt)+1,255);
    Dt:=trim(dt);
  end;
  if (Dt='') or (not (dt[1] in ['-','0'..'9'])) then exit;
  M:=0; S:=0; ss:=0;
  i:=Pos(':',dt);
  if i>1 then begin
    Val(trim(system.copy(dt,1,i-1)),H,err);
    system.delete(dt,1,i);
    i:=Pos(':',dt);
    if i>1 then begin
      Val(trim(system.copy(dt,1,i-1)),M,err);
      system.delete(dt,1,i);
      i:=Pos('.',dt);
      if i>0 then begin
        Val(trim(system.copy(dt,1,i-1)),S,err); //sec
        system.delete(dt,1,i);
        Val(trim(dt),SS,err);   //MSec
      end else begin
        Val(trim(dt),i,err);
        if err=0 then S:=i else S:=0;
      end;
    end else begin
      val(trim(dt),i,err);
      if err=0 then M:=i else M:=0;
    end;
  end else begin
    Val(trim(dt),i,err);
    if err=0 then H:=i else H:=0;
  end;

  D:=0; //day
  if ss>=0 then begin
    S:=S+(ss div 1000); ss:=ss mod 1000;
  end else begin
    ss:=abs(ss);
    s:=s-1-(ss div 1000); ss:=1000-(ss mod 999);
  end;
  if S>=0 then begin
    M:=M+(s div 60); S:=s mod 60;
  end else begin
    S:=abs(S);
    M:=M-1-(s div 60); s:=60-(s mod 59);
  end;
  if M>=0 then begin
    H:=H+(M div 60); M:=M mod 60;
  end else begin
    M:=abs(M);
    H:=H-1-(M div 60); M:=60-(M mod 59);
  end;
  if H>=0 then begin
    D:=D + (H div 24); H:=H mod 24;
  end else begin
    H:=Abs(H);
    D:=D-1-(H div 24); H:=24-(H mod 23);
  end;
  result:=D+frac(EncodeTime(H,M,S,SS))
end;

function MStrToDateTime(Dt:string):double;
VAR D:double;
    H,M,S,ss:word;
begin
  dt:=trim(dt);
  if Pos('/',dt)=0 then begin
    if Pos(':',dt)>0 then begin
      result:=MStrToTime(dt);
    end else result:=MStrToDate(dt);
  end else begin
    result:=MStrToDate(dt);
    if Pos(':',dt)>0 then begin
      d:=MStrToTime(dt);
      IF RESULT<0 THEN BEGIN
        if d<0 then  begin
          DecodeTime(Abs(d),H,M,S,ss);
          H:=23-H; M:=59-M; S:=59-S;
          RESULT:=RESULT + Trunc(d) - 1 -Frac(EncodeTime(H,M,S,999));
        end else
          RESULT:=RESULT+Trunc(d)-Frac(d);
      END ELSE result:=result+D;
    end;
  end;
end;

end.
