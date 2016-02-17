unit Setup_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ComCtrls, HotKey_u;

type
  TdlgSetup = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pcMain: TPageControl;
    tsStartup: TTabSheet;
    gbStartupMode: TGroupBox;
    lbMode: TLabel;
    cbRunMode: TComboBox;
    cbSplash: TCheckBox;
    cbDisplayLogMemo: TCheckBox;
    cbRememberRestoreWindowsPos: TCheckBox;
    tsLog: TTabSheet;
    gbLogConfig: TGroupBox;
    lbSaveDir: TLabel;
    cbSaveLogData: TCheckBox;
    edSaveFolder: TEdit;
    btnBrowse: TButton;
    cbMoveLog: TCheckBox;
    tsKeys: TTabSheet;
    gbKeys: TGroupBox;
    lbCalculate: TLabel;
    tsAliases: TTabSheet;
    gbAliases: TGroupBox;
    cbEnableAliases: TCheckBox;
    lbAliaseName: TLabel;
    edAliaseName: TEdit;
    cbClearAfterCompute: TCheckBox;
    lbReturnAction: TLabel;
    cbReturnAfterCompute: TCheckBox;
    procedure cbSaveLogDataClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure cbEnableAliasesClick(Sender: TObject);
    procedure edAliaseNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    hkCalculate,hkReturn:THotKeyEx;
    { Public declarations }
  end;

var
  dlgSetup: TdlgSetup;

implementation

{$R *.dfm}

{
1 хоткей: считать
2 хоткей: перевод строки
1 опция: автоперевод строки после счёта
2 опция: автоочистка после счёта
}


procedure TdlgSetup.btnBrowseClick(Sender: TObject);
var Dir:string;
begin
  if SelectDirectory('Select directory','',Dir) then
    edSaveFolder.Text:=Dir;
end;

procedure TdlgSetup.cbEnableAliasesClick(Sender: TObject);
begin
  lbAliaseName.Enabled:=(Sender as TCheckBox).Checked;
  edAliaseName.Enabled:=(Sender as TCheckBox).Checked;
end;

procedure TdlgSetup.cbSaveLogDataClick(Sender: TObject);
begin
  lbSaveDir.Enabled:=(Sender as TCheckBox).Checked;
  edSaveFolder.Enabled:=(Sender as TCheckBox).Checked;
  btnBrowse.Enabled:=(Sender as TCheckBox).Checked;
end;

procedure TdlgSetup.edAliaseNameKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8,#65..#90,#97..#122,';','_']) then
  begin
    MessageBox(Handle,PChar(Format('Unexpected character "%s"',[Key])),'Error',MB_OK+MB_ICONEXCLAMATION);
    Key:=#0;
  end;
end;

procedure TdlgSetup.FormCreate(Sender: TObject);
begin
  hkCalculate:=THotKeyEx.Create(Self);
  hkReturn:=THotKeyEx.Create(Self);
  with hkCalculate do
  begin
    Parent:=gbKeys;
    Left := 16;
    Top := 43;
    Width := 385;
    Height := 19;
    HotKey := 16397;
    InvalidKeys := [];
    Modifiers := [hkCtrl];
    TabOrder := 0;
  end;
  with hkReturn do
  begin
    Parent:=gbKeys;
    Left := 16;
    Top := 84;
    Width := 385;
    Height := 19;
    HotKey := 13;
    InvalidKeys := [];
    Modifiers := [];
    TabOrder := 1;
  end;
end;

end.
