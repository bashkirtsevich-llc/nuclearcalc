object wndMode: TwndMode
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Swich mode'
  ClientHeight = 153
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbMode: TLabel
    Left = 26
    Top = 40
    Width = 30
    Height = 13
    Caption = 'Mode:'
  end
  object btnOk: TButton
    Left = 200
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 281
    Top = 112
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object cbMode: TComboBox
    Left = 26
    Top = 61
    Width = 319
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'Caclulator'
    Items.Strings = (
      'Caclulator'
      'Syntax interpreter')
  end
end
