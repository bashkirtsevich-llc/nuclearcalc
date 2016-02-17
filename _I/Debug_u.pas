unit Debug_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ToolWin, Main_unit, StdCtrls;

type
  TwndDebugger = class(TForm)
    sbStatus: TStatusBar;
    pnlImportantInfo: TPanel;
    pnlCode: TPanel;
    barMain: TCoolBar;
    tbDebug: TToolBar;
    btnStepOver: TToolButton;
    btnStepInto: TToolButton;
    btnStop: TToolButton;
    spl1: TSplitter;
    lbCode: TListBox;
    lbInterpreterDebug: TListBox;
    spl2: TSplitter;
    lbCalcDebug: TListBox;
    lbCalcVars: TListBox;
    Splitter1: TSplitter;
    btnRun: TToolButton;
    procedure btnStopClick(Sender: TObject);
    procedure btnStepIntoClick(Sender: TObject);
    procedure btnStepOverClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wndDebugger: TwndDebugger;

implementation

{$R *.dfm}

procedure TwndDebugger.btnRunClick(Sender: TObject);
begin
  frmMain._interpreter.Debug:=False;
  frmMain._calcul.Debug:=False;
  frmMain._calcul.StepOver;
  frmMain._interpreter.StepOver;
  btnStepInto.Enabled:=False;
  btnStepOver.Enabled:=False;
  btnStop.Enabled:=False;
  sbStatus.Panels[0].Text:='Continue emulation';
end;

procedure TwndDebugger.btnStepIntoClick(Sender: TObject);
begin
  frmMain._calcul.Debug:=True;
  frmMain._interpreter.StepOver;
  sbStatus.Panels[0].Text:='Tracing into';
end;

procedure TwndDebugger.btnStepOverClick(Sender: TObject);
begin
  frmMain._calcul.Debug:=False;
  frmMain._interpreter.StepOver;
  sbStatus.Panels[0].Text:='Stepping over';
end;

procedure TwndDebugger.btnStopClick(Sender: TObject);
begin
{  frmMain._interpreter.HaltInterpreter;
  frmMain._interpreter.StepOver;
  sbStatus.Panels[0].Text:='Stop emulation';
  Close; }
  frmMain.btnStopClick(Sender);
end;

procedure TwndDebugger.FormCreate(Sender: TObject);
begin
  Self.Top:=frmMain.Height+frmMain.Top;
  Self.Left:=Screen.Width-Self.Width;
end;

end.
