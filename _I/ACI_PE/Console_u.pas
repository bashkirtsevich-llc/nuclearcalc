unit Console_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TwndConsole = class(TForm)
    memLog: TMemo;
    edConsole: TEdit;
    procedure edConsoleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    function OnReadln:string;
    function OnRead:string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wndConsole: TwndConsole;
  Entered:boolean;

implementation

//uses Main_unit,Vars_u;

{$R *.dfm}

procedure TwndConsole.edConsoleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    begin
      Entered:=True;
      {memLog.Lines.Add(edConsole.Text);
      edConsole.Clear; }
    end;
end;

procedure TwndConsole.FormCreate(Sender: TObject);
begin
{  Entered:=false;
  Self.Top:=frmMain.Top+frmMain.Height+75;
  Self.Left:=wndVariables.Left+wndVariables.Width+75;}
  //Self.Show;
end;

function TwndConsole.OnReadln:string;
//var temp:string;
begin
  while not Entered do
    Application.HandleMessage;
  Entered:=False;
  Result:=edConsole.Text;
  memLog.Lines.Add(edConsole.Text);
  edConsole.Clear;
end;

function TwndConsole.OnRead:string;
//var temp:string;
begin
  while not Entered do
    Application.HandleMessage;
  Entered:=False;
  Result:=edConsole.Text;
  memLog.Text:=memLog.Text+edConsole.Text;
  edConsole.Clear;
end;

end.
