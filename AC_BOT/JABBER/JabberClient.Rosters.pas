{*******************************************************}
{                                                       }
{       Jabber Roster Collection                        }
{                                                       }
{  	    Copyright (c) 2008-2009 Dmitriy Kuzan           }
{                                                       }
{*******************************************************}
unit JabberClient.Rosters;

interface

uses Classes, SysUtils,
     JabberClient.Types,
     JabberClient.Tools;

type
  TRosterItem = class;

  // Roster collection
  TRostersCollections = class(TCollection)
  private
    function  GetItems(Index: Integer): TRosterItem;
    procedure SetItems(Index: Integer; const Value: TRosterItem);
  protected
    Function  Add: TRosterItem;
  public
    Function  AddRoster(JID : string; RosterInfo : TRosterInfo ): TRosterItem;
    Function  UpdateRoster(JID : string; RosterInfo : TRosterInfo): TRosterItem;
    Function  DeleteRoster(JID : string): Boolean;
    function  FindItemJID(JID: string) : TRosterItem;
    property  Items[Index: Integer]: TRosterItem read GetItems write SetItems; default;
  end;

  // Поле
  TRosterItem = class(TCollectionItem)
  private
    FJID : string;
    FName: string;
    FSubscription: TSubscriptionStates;
    FID: String;
  public
    constructor Create(Collection: TCollection); override;
    destructor  Destroy; override;
    property ID : String read FID  write FID;
  published
    property JID : string read FJID write FJID;
    property Name : string read FName write FName;
    property SubscriptionStates : TSubscriptionStates read FSubscription write FSubscription;
  end;



implementation

function TRostersCollections.Add : TRosterItem;
begin
  Result := TRosterItem(inherited Add);
end;

function TRostersCollections.AddRoster(JID: string;  RosterInfo: TRosterInfo): TRosterItem;
var
  RI : TRosterItem;
begin
  RI := Add;
  RI.ID   := GetRandomHexBytes(24); // Сгенерируем уникальный ID
  RI.JID  := JID;
  RI.Name := RosterInfo.Name;
  RI.SubscriptionStates  := RosterInfo.SubscriptionStates;;
  Result := RI;
end;

function TRostersCollections.DeleteRoster(JID: string): Boolean;
var
  RI : TRosterItem;
begin
  //    { TODO : резервирован }
  RI := FindItemJID(JID);
  if Assigned(RI) then
  begin
     Delete(RI.Index);
     Result := True;
  end
  else
     Result := False;
end;

function  TRostersCollections.UpdateRoster(JID: string;  RosterInfo: TRosterInfo): TRosterItem;
var
  RI : TRosterItem;
begin
 //    { TODO : резервирован }
  RI := FindItemJID(JID);
  if Assigned(RI) then
  begin
     RI.Name := RosterInfo.Name;
     RI.SubscriptionStates  := RosterInfo.SubscriptionStates;;
     Result := RI;
  end
  else
     Result := nil
end;

function TRostersCollections.FindItemJID(JID: string): TRosterItem;
var
  I : Integer;
begin
  for I := 0 to Count - 1 do
  begin
      if AnsiCompareStr(JID, Items[i].JID) = 0 then
      begin
         Result := Items[i];
         Exit;
      end;
  end;
  Result := nil;
end;

function TRostersCollections.GetItems(Index: Integer): TRosterItem;
begin
  Result := TRosterItem(inherited GetItem(Index))
end;

procedure TRostersCollections.SetItems(Index: Integer;
                                          const Value: TRosterItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRosterItem }
constructor TRosterItem.Create(Collection: TCollection);
begin
 inherited;
end;

destructor TRosterItem.Destroy;
begin
 inherited;
end;

end.
