unit About_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TdlgAbout = class(TForm)
    btnOk: TButton;
    imgLogo: TImage;
    lbAppName: TLabel;
    lbCopyRight: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgAbout: TdlgAbout;

implementation

{$R *.dfm}

end.
