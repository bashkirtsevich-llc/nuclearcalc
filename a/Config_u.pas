unit Config_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TdlgConfig = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pcMain: TPageControl;
    tsInterface: TTabSheet;
    tsColors: TTabSheet;
    gbToolBar: TGroupBox;
    cbShowCaptions: TCheckBox;
    cbShowHints: TCheckBox;
    cbHideInTray: TCheckBox;
    gb2Dplotter: TGroupBox;
    gb3Dplotter: TGroupBox;
    lbXaxisColor: TLabel;
    lbYaxisColor: TLabel;
    lbGridColor: TLabel;
    lbGraphColor: TLabel;
    cbXaxisColor: TColorBox;
    cbYaxisColor: TColorBox;
    cbGridColor: TColorBox;
    cbGraphColor: TColorBox;
    lb3DXaxisColor: TLabel;
    lb3DYaxisColor: TLabel;
    lb3DZaxisColor: TLabel;
    lb3DGridColor: TLabel;
    lb3DGraphColor: TLabel;
    cb3Dxcolor: TColorBox;
    cb3Dycolor: TColorBox;
    cb3Dzcolor: TColorBox;
    cb3Dgridcolor: TColorBox;
    cb3Dgraphcolor: TColorBox;
    cbShowToolBar: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgConfig: TdlgConfig;

implementation

{$R *.dfm}

end.
