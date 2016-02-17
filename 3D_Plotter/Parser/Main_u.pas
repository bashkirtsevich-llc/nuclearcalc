unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function rasstr(a:string):string;
begin
  result:=a;
end;

procedure TForm1.Button1Click(Sender: TObject);
var s1,a:string;
    i,ni,j:integer;
begin
  s1:='';
  a:=edit1.Text;
for i:=length(a) downto 1 do //просматривает строку а с конца
begin
 if a[i]=')' then ni:=i; //запоминает положение последней )
 if a[i]='(' then //если встречает (, значит это и есть сама€ глубока€ ( )
  begin
   for j:=i+1 to ni-1 do s1:=s1+a[j];
   delete(a,i,2+length(s1)); //удал€ет исходную скобкуЕ
   insert(rasstr(s1),a,i); //Е и вставл€ет вместо нее значение скобки
   //возвращаетс€ выше на скобку и продолжает далее цикл
   for j:=i to length(a) do 
     if a[j]=')' then begin ni:=j; break; end;
   s1:='';
  end;
end;
a:=rasstr(a); //расчет конечного результата
caption:=a;
end;

end.
