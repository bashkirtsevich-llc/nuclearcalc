unit Proxy_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TdlgProxy = class(TForm)
    gbProxy: TGroupBox;
    lbProxyType: TLabel;
    lbProxyHost: TLabel;
    lbProxyPort: TLabel;
    lbUserName: TLabel;
    lbPass: TLabel;
    cbProxyType: TComboBox;
    edAddress: TEdit;
    edPort: TEdit;
    cbAuthentification: TCheckBox;
    edUserName: TEdit;
    edUserPass: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure cbAuthentificationClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgProxy: TdlgProxy;

implementation

{$R *.dfm}

procedure TdlgProxy.cbAuthentificationClick(Sender: TObject);
var _b:boolean;
begin
  _b := (Sender as TCheckBox).Checked;
  edUserName.Enabled := _b;
  edUserPass.Enabled := _b;
  lbUserName.Enabled := _b;
  lbPass.Enabled := _b;
end;

end.
