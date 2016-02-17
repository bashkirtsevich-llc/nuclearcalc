unit HotKey_u;

interface

uses Classes, ComCtrls, Windows;

type
  THotKeyEx = class (THotKey)
  private
  public
    constructor Create(AOwner:TComponent);
    procedure OnHotKeyKeyDown(Sender:TObject; var Key: Word; Shift: TShiftState);
  end;

implementation

constructor THotKeyEx.Create(AOwner:TComponent);
begin
  Self.OnKeyDown:=Self.OnHotKeyKeyDown;
  inherited;
end;

procedure THotKeyEx.OnHotKeyKeyDown(Sender:TObject; var Key: Word; Shift: TShiftState);
var
  lMod: Word;
begin
  if Key in [VK_RETURN, VK_TAB, VK_SPACE,VK_BACK,VK_DELETE,VK_ESCAPE] then
    with THotKeyEx(Sender) do
    begin
      lMod := 0;
      if ssCtrl in Shift then
        inc( lMod, scCtrl );
      if ssAlt in Shift then
        inc( lMod, scAlt );
      if ssShift in Shift then
        inc( lMod, scShift );
      HotKey := Key + lMod;
      Key := 0;
    end;
end;

end.
 