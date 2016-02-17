object dlgIntegral: TdlgIntegral
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Compute integral'
  ClientHeight = 265
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbIntegralType: TLabel
    Left = 16
    Top = 15
    Width = 67
    Height = 13
    Caption = 'Integral type:'
  end
  object lbTopLimit: TLabel
    Left = 16
    Top = 50
    Width = 60
    Height = 13
    Caption = 'Top limit (x):'
  end
  object lbBottomLimit: TLabel
    Left = 16
    Top = 85
    Width = 76
    Height = 13
    Caption = 'Bottom limit (x):'
  end
  object lbfx: TLabel
    Left = 16
    Top = 120
    Width = 24
    Height = 13
    Caption = 'F(x):'
  end
  object lbFx1: TLabel
    Left = 248
    Top = 50
    Width = 24
    Height = 13
    Caption = 'F(x):'
  end
  object lbFy1: TLabel
    Left = 248
    Top = 85
    Width = 24
    Height = 13
    Caption = 'F(y):'
  end
  object lbResult: TLabel
    Left = 16
    Top = 155
    Width = 42
    Height = 13
    Caption = 'Integral:'
  end
  object imgVisualisation: TImage
    Left = 8
    Top = 184
    Width = 333
    Height = 73
  end
  object btnOk: TButton
    Left = 347
    Top = 201
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 347
    Top = 232
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cbIntegralType: TComboBox
    Left = 89
    Top = 12
    Width = 333
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'Single "X"'
    OnChange = cbIntegralTypeChange
    Items.Strings = (
      'Single "X"'
      'Single "Y"')
  end
  object edXTopLimit: TEdit
    Left = 89
    Top = 47
    Width = 72
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object edXBottomLimit: TEdit
    Left = 90
    Top = 82
    Width = 71
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object edFunction: TEdit
    Left = 89
    Top = 117
    Width = 333
    Height = 21
    TabOrder = 5
    Text = 'Sin(x)'
  end
  object edFx1: TEdit
    Left = 278
    Top = 47
    Width = 67
    Height = 21
    ReadOnly = True
    TabOrder = 6
    Text = '?'
  end
  object edFy1: TEdit
    Left = 278
    Top = 82
    Width = 67
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 7
    Text = '?'
  end
  object edResult: TEdit
    Left = 90
    Top = 152
    Width = 332
    Height = 21
    TabOrder = 8
    Text = '?'
  end
  object edFx2: TEdit
    Left = 351
    Top = 47
    Width = 71
    Height = 21
    ReadOnly = True
    TabOrder = 9
    Text = '?'
  end
  object edFy2: TEdit
    Left = 351
    Top = 82
    Width = 71
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 10
    Text = '?'
  end
  object edYTopLimit: TEdit
    Left = 166
    Top = 47
    Width = 72
    Height = 21
    Enabled = False
    TabOrder = 11
    Text = '1'
  end
  object edYBottomLimit: TEdit
    Left = 167
    Top = 82
    Width = 71
    Height = 21
    Enabled = False
    TabOrder = 12
    Text = '0'
  end
end
