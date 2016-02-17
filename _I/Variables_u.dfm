object wndVariables: TwndVariables
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Global variables'
  ClientHeight = 241
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 205
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnKeyDown = FormKeyDown
  end
  object btnCancel: TButton
    Left = 286
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnKeyDown = FormKeyDown
  end
  object lvVars: TListView
    Left = 8
    Top = 8
    Width = 434
    Height = 193
    Columns = <
      item
        Caption = 'Variable name'
        Width = 90
      end
      item
        Caption = 'Variable value'
        Width = 320
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
    OnDblClick = lvVarsDblClick
    OnKeyDown = FormKeyDown
  end
  object btnAdd: TButton
    Left = 367
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Add Variable'
    TabOrder = 2
    OnClick = btnAddClick
    OnKeyDown = FormKeyDown
  end
end
