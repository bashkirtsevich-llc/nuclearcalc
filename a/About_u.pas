unit About_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, icons_u;

type
  TdlgAbout = class(TForm)
    btnOk: TButton;
    imgLogo: TImage;
    lbProductName: TLabel;
    lbProductVersion: TLabel;
    lbAuthor: TLabel;
    lbThanks: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgAbout: TdlgAbout;

implementation

{$R *.dfm}

procedure TdlgAbout.FormCreate(Sender: TObject);
var Logo:TBitmap;
    Data:TMemoryStream;
begin
  Logo:=TBitmap.Create;
  Data:=TMemoryStream.Create;
  Data.Write(bmp_logodata,SizeOf(bmp_logodata));
  Data.Position:=0;
  Logo.LoadFromStream(Data);
  imgLogo.Canvas.Draw(0,0,Logo);
  Data.Free;
  Logo.Free;
end;

end.
