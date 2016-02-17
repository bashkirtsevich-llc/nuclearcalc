unit MathematicsFunc;


{=================================================================

THrefLabel
  author: Martin Radu (mstorm@mail.md)

=================================================================}



interface

type
  TE = ^TElem;
  TElem = record
            Oper  : byte;
            Value : extended;
            Left  : TE;
            Right : TE;
          end;


function Parse_Line(s : string; var R : TE) : boolean;
function Count_Func(ex : boolean; R : TE; x,y,z,_n : extended; var F : extended) : boolean;
function Count_Const(s : string; var r : extended) : boolean;
procedure Delete_Tree(A : TE);



implementation

const
  OX        = 0;
  OP        = 1;
  ODx       = 2;
  ODy       = 3;
  OValue    = 4;
  OPlus     = 5;     {Математические операции}
  OMinus    = 6;
  OMul      = 7;
  ODiv      = 8;
  OIntDiv   = 9;
  OPower    = 10;
  OSin      = 11;    {Тригонометрические функции}
  OCos      = 12;
  OTan      = 13;
  OCtg      = 14;
  OSec      = 15;
  OCosec    = 16;
  OArcSin   = 17;    {Обратные тригонометрические}
  OArcCos   = 18;
  OArcTan   = 19;
  OArcCtg   = 20;
  OArcSec   = 21;
  OArcCosec = 22;
  OSqrt     = 23;    {Квадрат и корень}
  OSqr      = 24;
  OLn       = 25;    {Логарифмы}
  OLg       = 26;
  OExp      = 27;    {Экспонента}
  OAbs      = 28;    {Модуль}
  OSh       = 29;    {Гиперболические функции}
  OCh       = 30;
  OTh       = 31;
  OCth      = 32;
  OSch      = 33;
  OCsch     = 34;
  OArSh     = 35;    {Обратные гиперболические}
  OArCh     = 36;
  OArTh     = 37;
  OArCth    = 38;
  OArSch    = 39;
  OArCsch   = 40;
  OInt      = 41;    {Целочисленные}
  ORound    = 42;
  OZ        = 43;    {Собственные функции}
  ORandom   = 44;
  OFx       = 45;
  OFy       = 46;
  O_N       = 47;
  OPlX      = 128;   {Табличные и полиномные функции}
  OPlY      = 129;
  OSq       = 130;

function Parse_Line(s : string; var R : TE) : boolean;
type
  solve  = array [1..12] of extended;
function UpStr(s : string): string;
var
  i : integer;
  ss : string;
begin
  ss:='';
  for i:=1 to Length(s) do
    ss:=ss+UpCase(s[i]);
  UpStr:=ss;
end;
function SearchOp(s : string;op : string) : integer;
var
  c : integer;
  i : integer;
begin
  c:=0;
  for i:=Length(s) downto 1 do
    if s[i]=')' then Inc(c)
    else if s[i]='(' then Dec(c)
         else if s[i]=op then if c=0 then begin SearchOp:=i;exit;end;
  SearchOp:=0;
end;
function CheckSq(s : string; var r : solve; var m : integer) : boolean;
type
  table = array [1..12] of record
                             x,y : extended;
                           end;
  matrix = array [1..103,1..102] of extended;
var
  points : table;
  n      : integer;
function Gauss(l : integer; a : matrix; var r : solve) : boolean;
var
  i,j,k : integer;
  corr  : extended;
begin
  Gauss:=true;
  for i:=1 to l-1 do
    for j:=i+1 to l do
      if a[j,i]<>0 then
        begin
          corr:=a[i,i]/a[j,i];
          for k:=i to l+1 do
            a[j,k]:=a[j,k]*corr-a[i,k];
        end;
  for j:=l downto 2 do
    for i:=1 to j-1 do
      begin
        if a[j,j]=0 then begin Gauss:=false; exit; end;
        corr:=a[i,j]/a[j,j];
        a[i,j]:=0;
        a[i,l+1]:=a[i,l+1]-corr*a[j,l+1]
      end;
  for i:=1 to l do
    if a[i,i]<>0 then
      r[i]:=a[i,l+1]/a[i,i]
    else
      Gauss:=false;
end;
function sq(n,m : integer; t : table; var r : solve) : boolean;
var
  i,j : integer;
  p   : array [0..201] of extended;
  b   : array [0..101] of extended;
  xp  : array [1..102] of extended;
  a   : matrix;
begin
  for j:=1 to n do
    xp[j]:=1;
  for i:=0 to 2*m do
    begin
      p[i]:=0;
      for j:=1 to n do
        p[i]:=p[i]+xp[j];
      if i<=m then
        begin
          b[i]:=0;
          for j:=1 to n do
            b[i]:=b[i]+xp[j]*t[j].y;
        end;
      for j:=1 to n do
        xp[j]:=xp[j]*t[j].x;
    end;
  for i:=1 to m+1 do
    begin
      for j:=1 to m+1 do
        a[i,j]:=p[i+j-2];
      a[i,m+2]:=b[i-1];
    end;
  sq:=Gauss(m+1,a,r);
end;
var
  i    : integer;
  A    : TE;
  temp : extended;
begin
  CheckSq:=false;
  n:=1;
  repeat
    i:=1;
    while i<length(s) do
      begin
        if s[i]=',' then break;
        Inc(i);
      end;
    if s[i]<>',' then
      begin
        if Parse_Line(s,A) then
          begin
            if Count_Func(false,A,0,0,0,0,temp) then
              begin
                if Round(temp)>n-1 then
                  begin CheckSq:=false; exit; end;
                m:=Round(temp);
                Delete_Tree(A);
                Dec(n);
                break;
              end
            else
              begin
                Delete_Tree(A);
                exit;
              end;
          end
        else exit;
      end;
    if Parse_Line(Copy(s,1,i-1),A) then
      begin
        if not(Count_Func(false,A,0,0,0,0,points[n].x)) then
          begin
            Delete_Tree(A);
            exit;
          end
        else
          Delete_Tree(A);
      end
    else exit;
    s:=Copy(s,i+1,length(s)-i);
    i:=1;
    while i<length(s) do
      begin
        if s[i]=';' then break;
        Inc(i);
      end;
    if s[i]<>';' then
      begin
        if Parse_Line(s,A) then
          begin
            if Count_Func(false,A,0,0,0,0,points[n].y) then
              begin
                Delete_Tree(A);
                m:=n-1;
                break;
              end
            else
              begin
                Delete_Tree(A);
                exit;
              end;
          end
        else exit;
      end;
    if Parse_Line(Copy(s,1,i-1),A) then
      begin
        if not(Count_Func(false,A,0,0,0,0,points[n].y)) then
          begin
            Delete_Tree(A);
            exit;
          end
        else
          Delete_Tree(A);
      end
    else exit;
    s:=Copy(s,i+1,length(s)-i);
    Inc(n);
    if n>100 then
      begin
        CheckSq:=false;
        exit;
      end;
  until false;
  CheckSq:=sq(n,m,points,r);
end;
function CheckTable(s : string) : boolean;
var
  i : integer;
  F : extended;
  A : TE;
begin
  CheckTable:=false;
  repeat
    i:=1;
    while i<length(s) do
      begin
        if s[i]=',' then break;
        Inc(i);
      end;
    if s[i]<>',' then exit;
    if Parse_Line(Copy(s,1,i-1),A) then
      begin
        if not(Count_Func(false,A,0,0,0,0,F)) then
          begin
            Delete_Tree(A);
            exit;
          end
        else
          Delete_Tree(A);
      end
    else exit;
    s:=Copy(s,i+1,length(s)-i);
    i:=1;
    while i<length(s) do
      begin
        if s[i]=';' then break;
        Inc(i);
      end;
    if s[i]<>';' then
      begin
        if Parse_Line(s,A) then
          begin
            if Count_Func(false,A,0,0,0,0,F) then
              begin
                Delete_Tree(A);
                CheckTable:=true;
                exit;
              end
            else
              begin
                Delete_Tree(A);
                exit;
              end;
          end
        else exit;
      end;
    if Parse_Line(Copy(s,1,i-1),A) then
      begin
        if not(Count_Func(false,A,0,0,0,0,F)) then
          begin
            Delete_Tree(A);
            exit;
          end
        else
          Delete_Tree(A);
      end
    else exit;
    s:=Copy(s,i+1,length(s)-i);
  until false;
end;
var
  i,Code,n : integer;
  V        : extended;
  s1,s2    : string;
  O1,O2    : TE;
  Sav      : TE;
  t        : solve;
  A        : TE;
  F        : extended;
begin
  s:=UpStr(s);
  Parse_Line:=false;
  if s='' then exit;
  if s[1]='-' then s:='0'+s;
  if s='X' then
    begin
      New(R); R^.Oper:=OX; R^.Left:=nil; R^.Right:=nil;
      Parse_Line:=true; exit;
    end;
  if s='Y' then
    begin
      New(R); R^.Oper:=OP; R^.Left:=nil; R^.Right:=nil;
      Parse_Line:=true; exit;
    end;
  if s='Z' then
    begin
      New(R); R^.Oper:=OZ; R^.Left:=nil; R^.Right:=nil;
      Parse_Line:=true; exit;
    end;
  if s='N' then
    begin
      New(R); R^.Oper:=O_N; R^.Left:=nil; R^.Right:=nil;
      Parse_Line:=true; exit;
    end;
  if s='PI' then
    begin
      New(R); R^.Oper:=OValue; R^.Value:=pi; R^.Left:=nil; R^.Right:=nil;
      Parse_Line:=true; exit;
    end;
  if s='E' then
    begin
      New(R); R^.Oper:=OValue; R^.Value:=exp(1); R^.Left:=nil; R^.Right:=nil;
      Parse_Line:=true; exit;
    end;
  Val(s,V,Code);
  if Code=0 then
    begin
      New(R); R^.Oper:=OValue; R^.Value:=V; R^.Left:=nil; R^.Right:=nil;
      Parse_Line:=true; exit;
    end;
  i:=SearchOp(s,'+');
  if i<>0 then
    begin
      s1:=Copy(s,1,i-1);s2:=Copy(s,i+1,Length(s)-i);
      if Parse_Line(s1,O1) and Parse_Line(s2,O2) then
        begin
          New(R); R^.Oper:=OPlus;
          R^.Left:=O1; R^.Right:=O2;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  i:=SearchOp(s,'-');
  if i<>0 then
    begin
      s1:=Copy(s,1,i-1);s2:=Copy(s,i+1,Length(s)-i);
      if Parse_Line(s1,O1) and Parse_Line(s2,O2) then
        begin
          New(R); R^.Oper:=OMinus;
          R^.Left:=O1; R^.Right:=O2;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  i:=SearchOp(s,'*');
  if i<>0 then
    begin
      s1:=Copy(s,1,i-1);s2:=Copy(s,i+1,Length(s)-i);
      if Parse_Line(s1,O1) and Parse_Line(s2,O2) then
        begin
          New(R);R^.Oper:=OMul;
          R^.Left:=O1; R^.Right:=O2;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  i:=SearchOp(s,'/');
  if i<>0 then
    begin
      s1:=Copy(s,1,i-1);s2:=Copy(s,i+1,Length(s)-i);
      if Parse_Line(s1,O1) and Parse_Line(s2,O2) then
        begin
          New(R);R^.Oper:=ODiv;
          R^.Left:=O1; R^.Right:=O2;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  i:=SearchOp(s,'\');
  if i<>0 then
    begin
      s1:=Copy(s,1,i-1);s2:=Copy(s,i+1,Length(s)-i);
      if Parse_Line(s1,O1) and Parse_Line(s2,O2) then
        begin
          New(R);R^.Oper:=OIntDiv;
          R^.Left:=O1; R^.Right:=O2;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  i:=SearchOp(s,'^');
  if i<>0 then
    begin
      s1:=Copy(s,1,i-1);s2:=Copy(s,i+1,Length(s)-i);
      if Parse_Line(s1,O1) and Parse_Line(s2,O2) then
        begin
          New(R);R^.Oper:=OPower;
          R^.Left:=O1; R^.Right:=O2;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='PL' then
    begin
      s:=Copy(s,3,length(s)-2);
      if (s[1]='(') and (s[length(s)]=')') then
        begin
          s:=Copy(s,2,Length(s)-2);
          if CheckTable(s) then
            begin
              New(R); O1:=R; Sav:=R;
              repeat
                O1^.Oper:=OPlX;
                i:=1;
                while i<length(s) do
                  begin
                    if s[i]=',' then break;
                    Inc(i);
                  end;
                if Parse_Line(Copy(s,1,i-1),A) and
                   Count_Func(false,A,0,0,0,0,F) then
                  Delete_Tree(A);
                O1^.Value:=F;
                s:=Copy(s,i+1,length(s)-i);
                New(O2);
                O1^.Left:=O2;O1:=O2;
                O1^.Oper:=OPlY;
                i:=1;
                while i<length(s) do
                  begin
                    if s[i]=';' then break;
                    Inc(i);
                  end;
                if s[i]<>';' then
                  begin
                    if Parse_Line(s,A) and
                       Count_Func(false,A,0,0,0,0,F) then
                      Delete_Tree(A);
                    O1^.Value:=F;
                    O1^.Left:=Nil;
                    break;
                  end;
                if Parse_Line(Copy(s,1,i-1),A) and
                   Count_Func(false,A,0,0,0,0,F) then
                  Delete_Tree(A);
                O1^.Value:=F;
                New(O2); O1^.Left:=O2; O1:=O2;
                s:=Copy(s,i+1,length(s)-i);
              until false;
              R:=Sav;
              Parse_Line:=true;
              exit;
            end
          else
            exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='DX' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=ODx; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='DY' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=ODy; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='FX' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OFx; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='FY' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OFy; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,8)='ARCCOSEC' then
    begin
      s1:=Copy(s,9,length(s)-8);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArcCosec; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,5)='COSEC' then
    begin
      s1:=Copy(s,6,length(s)-5);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OCosec; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='SIN' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OSin; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='COS' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OCos; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='TG' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OTan; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='CTG' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OCtg; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='SEC' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OSec; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,6)='ARCSIN' then
    begin
      s1:=Copy(s,7,length(s)-6);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArcSin; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,6)='ARCCOS' then
    begin
      s1:=Copy(s,7,length(s)-6);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArcCos; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,5)='ARCTG' then
    begin
      s1:=Copy(s,6,length(s)-5);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArcTan; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,6)='ARCCTG' then
    begin
      s1:=Copy(s,7,length(s)-6);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArcCtg; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,6)='ARCSEC' then
    begin
      s1:=Copy(s,7,length(s)-6);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArcSec; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,4)='SQRT' then
    begin
      s1:=Copy(s,5,length(s)-4);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OSqrt; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='SQR' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OSqr; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='SQ' then
    begin
      s:=Copy(s,3,length(s)-2);
      if (s[1]='(') and (s[length(s)]=')') then
        begin
          s:=Copy(s,2,Length(s)-2);
          if CheckSq(s,t,n) then
            begin
              New(R);O1:=R;
              for i:=1 to n do
                begin
                  O1^.Oper:=OSq; O1^.Value:=t[i];
                  New(O2); O1^.Left:=O2; O1:=O2;
                end;
              O1^.Oper:=OSq; O1^.Value:=t[n+1]; O1^.Left:=Nil;
              Parse_Line:=true;
              exit;
            end
          else exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='LN' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OLn; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='LG' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OLg; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='ABS' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OAbs; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='EXP' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OExp; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='SH' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OSh; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='CH' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OCh; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,2)='TH' then
    begin
      s1:=Copy(s,3,length(s)-2);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OTh; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='CTH' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OCth; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='SCH' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OSch; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,4)='CSCH' then
    begin
      s1:=Copy(s,5,length(s)-4);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OCsch; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,4)='ARSH' then
    begin
      s1:=Copy(s,5,length(s)-4);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArSh; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,4)='ARCH' then
    begin
      s1:=Copy(s,5,length(s)-4);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArCh; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,4)='ARTH' then
    begin
      s1:=Copy(s,5,length(s)-4);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArTh; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,5)='ARCTH' then
    begin
      s1:=Copy(s,6,length(s)-5);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArCth; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,5)='ARSCH' then
    begin
      s1:=Copy(s,6,length(s)-5);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArSch; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,6)='ARCSCH' then
    begin
      s1:=Copy(s,7,length(s)-6);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OArCsch; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,3)='INT' then
    begin
      s1:=Copy(s,4,length(s)-3);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=OInt; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if Copy(s,1,5)='ROUND' then
    begin
      s1:=Copy(s,6,length(s)-5);
      if Parse_Line(s1,O1) then
        begin
          New(R); R^.Oper:=ORound; R^.Left:=O1;
          Parse_Line:=true; exit;
        end
      else
        exit;
    end;
  if (s[1]='(') and (s[Length(s)]=')') then
    begin
      s:=Copy(s,2,Length(s)-2);
      if Parse_Line(s,R) then
        begin Parse_Line:=true; exit; end;
    end;
  if s[1]=' ' then
    begin
      s:=Copy(s,2,Length(s)-1);
      if Parse_Line(s,R) then
        begin Parse_Line:=true; exit; end;
    end;
  if s[length(s)]=' ' then
    begin
      s:=Copy(s,1,Length(s)-1);
      if Parse_Line(s,R) then
        begin Parse_Line:=true; exit; end;
    end;
  Parse_Line:=false;
end;

function Count_Func(ex : boolean; R : TE; x,y,z,_n : extended; var F : extended) : boolean;
type
  table = array[1..100] of record x,y : extended;
  end;
function L(n,i : integer; x : extended; t : table; var r : extended) : boolean;
var
  j     : integer;
  s1,s2 : extended;
begin
  s1:=1; s2:=1;
  for j:=1 to n do
    if i<>j then
      begin
        s1:=s1*(x-t[j].x);
        s2:=s2*(t[i].x-t[j].x);
      end;
  if s2<>0 then begin r:=s1/s2; L:=true; end else L:=false;
end;
function PL(n: integer; x : extended; t : table; var s : extended) : boolean;
var
  j : integer;
  r : extended;
begin
  s:=0;
  for j:=1 to n do
    begin
      if L(n,j,x,t,r) then
        s:=s+r*t[j].y
      else
        begin PL:=false; exit; end;
    end;
  PL:=true;
end;
function Count_Power(x,y : extended) : extended;
var
  r : extended;
begin
  if (x=0) and (y<>0) then
    begin
      Count_Power:=0;
      exit;
    end;
  if y<0 then begin y:=-y; x:=1/x; end;
  r:=1;
  while trunc(y)<>0 do
    begin
      r:=r*x;
      y:=y-1;
    end;
  Count_Power:=r;
end;
const
  deltax=1e-4;
var
  n      : integer;
  q1,q2  : extended;
  points : table;
begin
  Randomize;
  Count_Func:=false; 
  case R^.Oper of
    OX      : if ex then begin F:=x; Count_Func:=true; end;
    OP      : if ex then begin F:=y; Count_Func:=true; end;
    OZ      : if ex then begin F:=z; Count_Func:=true; end;
    O_N     : if ex then begin F:=_n; Count_Func:=true; end;
    OValue  : begin F:=R^.Value; Count_Func:=true; end;
    OPlus   : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and Count_Func(ex,R^.Right,x,y,z,_n,q2) then
                begin F:=q1+q2; Count_Func:=true; end
              else Count_Func:=false;
    OMinus  : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and Count_Func(ex,R^.Right,x,y,z,_n,q2) then
                begin F:=q1-q2; Count_Func:=true; end
              else Count_Func:=false;
    OMul    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and Count_Func(ex,R^.Right,x,y,z,_n,q2) then
                begin F:=q1*q2; Count_Func:=true; end
              else Count_Func:=false;
    ODiv    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and Count_Func(ex,R^.Right,x,y,z,_n,q2) and (q2<>0) then
                begin F:=q1/q2; Count_Func:=true; end
              else Count_Func:=false;
    OIntDiv : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and Count_Func(ex,R^.Right,x,y,z,_n,q2) and (q2<>0) then
                begin F:=Int(q1/q2); Count_Func:=true; end
              else Count_Func:=false;
    OPower  : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and Count_Func(ex,R^.Right,x,y,z,_n,q2) then
                if (q1<=0) and (q2=trunc(q2)) then
                  begin F:=Count_Power(q1,q2); Count_Func:=true; end
                else
                  if q1>0 then
                    begin F:=exp(q2*ln(q1)); Count_Func:=true; end
                  else Count_Func:=false
              else Count_Func:=false;
    ODx     : if Count_Func(ex,R^.Left,x+deltax,y,z,_n,q1) and
                 Count_Func(ex,R^.Left,x-deltax,y,z,_n,q2) then
                begin F:=(q1-q2)/(2*deltax); Count_Func:=true; end
              else Count_Func:=false;
    ODy     : if Count_Func(ex,R^.Left,x,y+deltax,z,_n,q1) and
                 Count_Func(ex,R^.Left,x,y-deltax,z,_n,q2) then
                begin F:=(q1-q2)/(2*deltax); Count_Func:=true; end
              else Count_Func:=false;
    OFx     : if Count_Func(ex,R^.Left,x+deltax,y,z,_n,q1) and
                 Count_Func(ex,R^.Left,x-deltax,y,z,_n,q2) then
                begin F:=((q2-q1)/(2*deltax)); Count_Func:=true; end
              else Count_Func:=false;
    OFy     : if Count_Func(ex,R^.Left,x,y+deltax,z,_n,q1) and
                 Count_Func(ex,R^.Left,x,y-deltax,z,_n,q2) then
                begin F:=((q2-q1)/(2*deltax)); Count_Func:=true; end
              else Count_Func:=false;
    OSin    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=sin(q1); Count_Func:=true; end
              else Count_Func:=false;
    OCos    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=cos(q1); Count_Func:=true; end
              else Count_Func:=false;
    OTan    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (cos(q1)<>0) then
                begin F:=sin(q1)/cos(q1); Count_Func:=true; end
              else Count_Func:=false;
    OCtg    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (sin(q1)<>0) then
                begin F:=cos(q1)/sin(q1); Count_Func:=true; end
              else Count_Func:=false;
    OSec    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (cos(q1)<>0) then
                begin F:=1/cos(q1); Count_Func:=true; end
              else Count_Func:=false;
    OCosec  : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (sin(q1)<>0) then
                begin F:=1/sin(q1); Count_Func:=true; end
              else Count_Func:=false;
    OArcSin : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (abs(q1)<=1.0) then
                if Abs(q1)=1.0 then
                  begin F:=q1*pi/2; Count_Func:=true; end
                else
                  begin F:=ArcTan(q1/sqrt(1-sqr(q1))); Count_Func:=true; end
              else Count_Func:=false;
    OArcCos : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (abs(q1)<=1.0) then
                if q1=0 then
                  begin F:=pi/2; Count_Func:=true; end
                else
                  begin
                    F:=ArcTan(sqrt(1-sqr(q1))/q1);
                    if q1<0 then F:=F+pi;
                    Count_Func:=true;
                  end
              else Count_Func:=false;
    OArcTan : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=ArcTan(q1); Count_Func:=true; end
              else Count_Func:=false;
    OArcCtg : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=pi/2-ArcTan(q1); Count_Func:=true; end
              else Count_Func:=false;
    OArcSec : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (q1<>0) and (abs(1/q1)<=1.0) then
                if q1=0 then
                  begin F:=pi/2; Count_Func:=true; end
                else
                  begin
                    F:=ArcTan(sqrt(1-sqr(1/q1))*q1);
                    if q1<0 then F:=pi+F;
                    Count_Func:=true;
                  end
              else Count_Func:=false;
    OArcCosec : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (q1<>0) and (abs(1/q1)<=1.0) then
                if Abs(1/q1)=1.0 then
                  begin F:=-(1/q1)*pi/2; Count_Func:=true; end
                else
                  begin
                    F:=-ArcTan((1/q1)/sqrt(1-sqr(1/q1)));
                    Count_Func:=true;
                  end
              else Count_Func:=false;
    OSqrt   : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (q1>=0) then
                begin F:=sqrt(q1); Count_Func:=true; end
               else Count_Func:=false;
    OSqr    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=sqr(q1); Count_Func:=true; end
              else Count_Func:=false;
    OLn     : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (q1>0) then
                begin F:=Ln(q1); Count_Func:=true; end
              else Count_Func:=false;
    OLg     : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (q1>0) then
                begin F:=Ln(q1)/Ln(10); Count_Func:=true; end
              else Count_Func:=false;
    OAbs    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=Abs(q1); Count_Func:=true; end
              else Count_Func:=false;
    OExp    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=exp(q1); Count_Func:=true; end
              else Count_Func:=false;
    OSh     : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=(exp(q1)-exp(-q1))/2; Count_Func:=true; end
              else Count_Func:=false;
    OCh     : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=(exp(q1)+exp(-q1))/2; Count_Func:=true; end
              else Count_Func:=false;
    OTh     : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and ((exp(q1)+exp(-q1))<>0) then
                begin F:=(exp(q1)-exp(-q1))/(exp(q1)+exp(-q1)); Count_Func:=true; end
              else Count_Func:=false;
    OCth    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and ((exp(q1)-exp(-q1))<>0) then
                begin F:=(exp(q1)+exp(-q1))/(exp(q1)-exp(-q1)); Count_Func:=true; end
              else Count_Func:=false;
    OSch    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and ((exp(q1)+exp(-q1))<>0) then
                begin F:=2/(exp(q1)+exp(-q1)); Count_Func:=true; end
              else Count_Func:=false;
    OCsch   : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and ((exp(q1)-exp(-q1))<>0) then
                begin F:=2/(exp(q1)-exp(-q1)); Count_Func:=true; end
              else Count_Func:=false;
    OArSh   : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and ((q1+sqrt(sqr(q1)+1))>0) then
                begin F:=Ln(q1+sqrt(sqr(q1)+1)); Count_Func:=true; end
              else Count_Func:=false;
    OArCh   : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (sqr(q1)>1) and((q1+sqrt(sqr(q1)-1))>0) then
                begin F:=Ln(q1+sqrt(sqr(q1)-1)); Count_Func:=true; end
              else Count_Func:=false;
    OArTh   : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and ((1-q1)<>0) and ((1-q1)*(1+q1)>0) then
                begin F:=ln(sqrt((1+q1)/(1-q1))); Count_Func:=true; end
              else Count_Func:=false;
    OArCth  : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and ((q1-1)<>0) and ((q1+1)/(q1-1)>0) then
                begin F:=ln((q1+1)/(q1-1))/2; Count_Func:=true; end
              else Count_Func:=false;
    OArSch  : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (q1<>0) and (sqr(1/q1)>1) and((1/q1+sqrt(sqr(1/q1)-1))>0) then
                begin
                  F:=Ln(1/q1+sqrt(sqr(1/q1)-1));
                  Count_Func:=true;
                end
              else Count_Func:=false;
    OArCsch : if Count_Func(ex,R^.Left,x,y,z,_n,q1) and (q1<>0) and ((1/q1+sqrt(sqr(1/q1)+1))>0) then
                begin
                  F:=Ln(1/q1+sqrt(sqr(1/q1)+1));
                  Count_Func:=true;
                end
              else Count_Func:=false;
    ORound  : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=Round(q1); Count_Func:=true; end
              else Count_Func:=false;
    ORandom : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=Random(Round(q1)); Count_Func:=true; end
              else Count_Func:=false;
    OInt    : if Count_Func(ex,R^.Left,x,y,z,_n,q1) then
                begin F:=Int(q1); Count_Func:=true; end
              else Count_Func:=false;
    OPlX    : begin
                n:=0;
                while true do
                  begin
                    Inc(n);
                    points[n].X:=R^.Value;
                    R:=R^.Left;
                    points[n].Y:=R^.Value;
                    if R^.Left=Nil then break;
                    R:=R^.Left;
                  end;
                if PL(n,x,points,F) then Count_Func:=true
                else Count_Func:=false;
              end;
    OSq     : begin
                F:=0; q2:=1;
                while true do
                  begin
                    q1:=R^.Value;
                    F:=F+q2*q1;
                    q2:=q2*x;
                    if R^.Left=nil then break;
                    R:=R^.Left;
                  end;
                Count_Func:=true;
              end;
    else Count_Func:=false;
  end;
end;


procedure Delete_Tree(A : TE);
procedure Delete_Table(R : TE);
var O: TE;
begin
  while R^.Left<>nil do
    begin
      O:=R^.Left;
      Dispose(R);
      R:=O;
    end;
  Dispose(R);
end;
begin
  case A^.Oper of
    OPlus, OMinus, OMul, ODiv, OPower, OIntDiv :
                                    begin
                                      Delete_Tree(A^.Left);
                                      Delete_Tree(A^.Right);
                                      Dispose(A);
                                    end;
    OSin, OCos, OTan, OCtg, OArcSin, OArcCos, ODx, ODy,
    OArcTan, OArcCtg, OSqrt, OSqr, OLn, OLg,
    OAbs, OExp, OSh, OCh, OTh, OCth, ORound,
    OArSh, OArCh, OArTh, OArCth, OInt,
    OSec, OCosec, OArcSec, OArcCosec,
    OSch, OCsch, OArSch, OArCsch :
                                    begin
                                      Delete_Tree(A^.Left);
                                      Dispose(A);
                                    end;
    OX,OP,OValue                  : Dispose(A);
    OPlX,OPlY,OSq                 : Delete_Table(A);
      else Dispose(A);
  end;
end;

function Count_Const(s : string; var r : extended) : boolean;
var
  A : TE;
begin
  if Parse_Line(s, A) then
    if Count_Func(false, A, 0, 0, 0, 0, r) then
      begin
        Delete_Tree(A);
        Count_Const:=true;
      end
    else
      Count_Const:=false
  else
    Count_Const:=false;
end;

end.
