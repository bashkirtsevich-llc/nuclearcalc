unit Variables_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TwndVariables = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lvVars: TListView;
    btnAdd: TButton;
    procedure lvVarsDblClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    Variables:String;
    procedure Parse;
    { Public declarations }
  end;

var
  wndVariables: TwndVariables;

implementation

//uses AddVar_u;

{$R *.dfm}

procedure TwndVariables.btnAddClick(Sender: TObject);
var Item:TListItem;
begin
  {Application.CreateForm(TdlgAddVariable, dlgAddVariable);
  if dlgAddVariable.ShowModal=mrOk then
    begin
      Item:=lvVars.Items.Add;
      Item.Caption:=dlgAddVariable.leVarName.Text;
      Item.SubItems.Add(dlgAddVariable.leVarValue.Text)
    end;
  dlgAddVariable.Free;  }
end;

procedure TwndVariables.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    //VK_RETURN:ModalResult:=mrOk;
    VK_ESCAPE:ModalResult:=mrCancel;
  end;
end;

procedure TwndVariables.lvVarsDblClick(Sender: TObject);
var _val:string;
begin
  if lvVars.ItemIndex=-1 then Exit;
  _val:=lvVars.Items[lvVars.ItemIndex].SubItems[0];
  if InputQuery('Variable','Enter a variable value',_val) then
    lvVars.Items[lvVars.ItemIndex].SubItems[0]:=_val;
end;

procedure TwndVariables.Parse;
var _pos:word;
    _temp:string;
    Item:TListItem;
  function Split(_text:string; before:boolean):string;
  var _equal:word;
  begin
    _equal:=Pos('=',_text);
    if before then
      Split:=Copy(_text,1,_equal-1)
    else
      Split:=Copy(_text,_equal+1,Length(_text));
  end;
begin
  _temp:=Variables;
  //_temp:=_temp+#13;
  _pos:=0;
  While _pos< length(_temp) do
    begin
      inc(_pos);
      if _temp[_pos]=#13 then
        begin
          //showmessage(Copy(_temp,1,_pos-1));
          Item:=lvVars.Items.Add;
          Item.Caption:=Split(Copy(_temp,1,_pos-1),true);
          Item.SubItems.Add(Split(Copy(_temp,1,_pos-1),False));
          Delete(_temp,1,_pos);
          _pos:=0;
        end;
    end;
end;

end.
