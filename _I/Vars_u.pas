unit Vars_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, Menus;

type
  TwndVariables = class(TForm)
    lvVars: TListView;
    btnPlace: TPanel;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;
    btnClear: TSpeedButton;
    pmEditVars: TPopupMenu;
    Addvariable1: TMenuItem;
    Deletevariable1: TMenuItem;
    N1: TMenuItem;
    Clear1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    function VarsAsText:String;
    procedure TextAsVars(Vars:string);
    { Public declarations }
  end;

var
  wndVariables: TwndVariables;

implementation

uses Main_unit, AddVar_u;

{$R *.dfm}

procedure TwndVariables.btnAddClick(Sender: TObject);
var _item:TListItem;
begin
  Application.CreateForm(TdlgAddVar,dlgAddVar);
  if dlgAddVar.ShowModal=mrOk then
  begin
    _item:=lvVars.Items.Add;
    _item.Caption:=dlgAddVar.leVarName.Text;
    _item.SubItems.Add(dlgAddVar.leVarValue.Text);
  end;
  dlgAddVar.Free;
end;

procedure TwndVariables.btnClearClick(Sender: TObject);
begin
  lvVars.Clear;
end;

procedure TwndVariables.btnDelClick(Sender: TObject);
begin
  lvVars.Items[lvVars.ItemIndex].Delete;
end;

function TwndVariables.VarsAsText:String;
var _index:integer;
    _temp:String;
begin
  _temp:='';
  for _index := 0 to lvVars.Items.Count-1 do
  begin
    _temp:=_temp+lvVars.Items[_index].Caption+'='+
           lvVars.Items[_index].SubItems[0]+#13#10;
  end;
  Result:=_temp;
end;

procedure TwndVariables.TextAsVars(Vars: string);
var _temp:string;
  procedure SeparString(s:string);
  var index:integer;
      item:TListItem;
  begin
    for index:=1 to Length(s) do
      if s[index]='=' then Break;
    item:=lvVars.Items.Add;
    item.Caption:=Copy(s,1,index-1);
    item.SubItems.Add(Copy(s,index+1,Length(s)));
  end;
begin
  if Length(Vars)=0 then
  begin
    lvVars.Clear;
    Exit;
  end;
  lvVars.Clear;
  //if Vars[Length(Vars)]<>#13 then Vars:=Vars+#13;
  while Pos(#13,Vars)<>0 do
  begin
    _temp:=Copy(Vars,1,Pos(#13,Vars)-1);
    Delete(Vars,1,Pos(#13,Vars)+1);
    SeparString(_temp);
  end;
end;

procedure TwndVariables.FormCreate(Sender: TObject);
begin
  Self.Left:=0;
  Self.Top:=frmMain.Height+frmMain.Top;
  Self.Show;
end;

end.
