unit NewFile_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, StdCtrls;

type
  TdlgNewFile = class(TForm)
    Icons: TImageList;
    btnOk: TButton;
    btnCancel: TButton;
    lvNewFile: TListView;
    procedure lvNewFileClick(Sender: TObject);
    procedure lvNewFileDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgNewFile: TdlgNewFile;

implementation

{$R *.dfm}

procedure TdlgNewFile.lvNewFileClick(Sender: TObject);
begin
  btnOk.Enabled:=lvNewFile.ItemIndex<>-1;
end;

procedure TdlgNewFile.lvNewFileDblClick(Sender: TObject);
begin
  if btnOk.Enabled then
    ModalResult:=mrOk;
end;

end.
