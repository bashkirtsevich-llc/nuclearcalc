object dlgAddVariable: TdlgAddVariable
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add variable'
  ClientHeight = 169
  ClientWidth = 424
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
  object btnOk: TButton
    Left = 237
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 318
    Top = 120
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object leVarName: TLabeledEdit
    Left = 90
    Top = 32
    Width = 303
    Height = 21
    EditLabel.Width = 67
    EditLabel.Height = 13
    EditLabel.Caption = 'Variable name'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object leVarValue: TLabeledEdit
    Left = 90
    Top = 75
    Width = 303
    Height = 21
    EditLabel.Width = 67
    EditLabel.Height = 13
    EditLabel.Caption = 'Variable value'
    LabelPosition = lpLeft
    TabOrder = 3
    OnKeyPress = leVarValueKeyPress
  end
end
