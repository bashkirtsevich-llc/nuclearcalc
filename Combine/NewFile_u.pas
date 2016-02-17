unit NewFile_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList;

type
  TdlgNewFile = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lvType: TListView;
    imgListMain: TImageList;
    procedure lvTypeDblClick(Sender: TObject);
    procedure lvTypeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgNewFile: TdlgNewFile;

implementation

{$R *.dfm}

procedure TdlgNewFile.lvTypeClick(Sender: TObject);
begin
  btnOk.Enabled:=lvType.ItemIndex<>-1;
end;

procedure TdlgNewFile.lvTypeDblClick(Sender: TObject);
begin
  if btnOk.Enabled then
    ModalResult:=mrOk;
end;

end.
