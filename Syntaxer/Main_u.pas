unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    reCode: TRichEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure LightSyntax;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  LightSyntax;
end;

procedure TForm1.LightSyntax;
var stringIndex:Integer;
    stringLength:Integer;
    TotalLength:Integer;
    itemString:String;
    index:integer;
    _temp:integer;
procedure LightLexem(_startPos,_length:Integer; _fontStyle:TFontStyles; _color:TColor);
begin
  reCode.SelStart:=_startPos;
  reCode.SelLength:=_length;
  reCode.SelAttributes.Style:=_fontStyle;
  reCode.SelAttributes.Color:=_color;
end;
begin
  totalLength:=0;
  for stringIndex:=0 to reCode.Lines.Count-1 do
  begin
    itemString:=reCode.Lines[stringIndex]+' ';
    stringLength:=Length(itemString)-1;
    index:=0;
    while index<stringlength+1 do
    begin
      case itemstring[index] of
        '{','}': LightLexem((totallength+index)-1,1,[],clGreen);
        '/': if Copy(itemstring,index,2)='/*' then
          begin
            _temp:=index;
            while copy(itemstring,_temp,2)<>'*/' do
            begin
              inc(_temp);
              if _temp>Length(reCode.Text) then Break;
            end;
            LightLexem((totallength+index)-1,(_temp-index)+2,[fsItalic],clGreen);
            inc(Index,_temp-index);
          end;
        '"': begin
            _temp:=index+1;
            while itemstring[_temp]<>'"' do
            begin
              inc(_temp);
              if _temp>Length(reCode.Text) then Break;
            end;
            LightLexem((totallength+index)-1,(_temp-index)+1,[],clBlue);
            inc(index,_temp-index);
          end;
        '0'..'9','.': LightLexem((totallength+index)-1,1,[],clBlue);
        'a','A': if uppercase(copy(itemstring,index-1,5))=' AND ' then LightLexem((totallength+index)-1,3,[fsBold],clNavy);
        'd','D': if uppercase(copy(itemstring,index-1,3))=' DO' then LightLexem((totallength+index)-1,2,[fsBold],clNavy);
        'e','E': begin
          if uppercase(copy(itemstring,index,4))='EXEC' then LightLexem((totallength+index)-1,4,[fsBold],clNavy);
          if uppercase(copy(itemstring,index,4))='ELSE' then LightLexem((totallength+index)-1,4,[fsBold],clNavy);
          if uppercase(copy(itemstring,index,4))='END.' then LightLexem((totallength+index)-1,4,[fsBold],clNavy);
        end;
        'i','I': if uppercase(copy(itemstring,index-1,3))=' IF' then LightLexem((totallength+index)-1,2,[fsBold],clNavy);
        'n','N': if uppercase(copy(itemstring,index-1,5))=' NOT ' then LightLexem((totallength+index)-1,3,[fsBold],clNavy);
        'o','O': if uppercase(copy(itemstring,index-1,4))=' OR ' then LightLexem((totallength+index)-1,2,[fsBold],clNavy);
        'p','P': if uppercase(copy(itemstring,index,9))='PROCEDURE' then LightLexem((totallength+index)-1,9,[fsBold],clNavy);
        't','T': if uppercase(copy(itemstring,index-1,5))=' THEN' then LightLexem((totallength+index)-1,4,[fsBold],clNavy);
        'w','W': if uppercase(copy(itemstring,index,6))='WHILE ' then LightLexem((totallength+index)-1,6,[fsBold],clNavy);
        end;
      inc(index);
    end;
    inc(TotalLength,StringLength+1);
  end;
end;

end.
