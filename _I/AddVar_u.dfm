object dlgAddVar: TdlgAddVar
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add variable'
  ClientHeight = 129
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 157
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 238
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object leVarName: TLabeledEdit
    Left = 88
    Top = 20
    Width = 225
    Height = 21
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Variable name:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object leVarValue: TLabeledEdit
    Left = 88
    Top = 55
    Width = 225
    Height = 21
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Variable value:'
    LabelPosition = lpLeft
    TabOrder = 3
  end
end
