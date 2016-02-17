object dlgAdd: TdlgAdd
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add account'
  ClientHeight = 233
  ClientWidth = 513
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
    Left = 327
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 408
    Top = 184
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object gbJIDorUIN: TGroupBox
    Left = 32
    Top = 24
    Width = 451
    Height = 137
    Caption = 'Add account'
    TabOrder = 2
    object leJIDorUIN: TLabeledEdit
      Left = 72
      Top = 40
      Width = 361
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = 'leJIDorUIN'
      EditLabel.ParentBiDiMode = False
      LabelPosition = lpLeft
      TabOrder = 0
    end
    object lePass: TLabeledEdit
      Left = 72
      Top = 80
      Width = 361
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Password:'
      LabelPosition = lpLeft
      PasswordChar = '*'
      TabOrder = 1
    end
  end
end
