object dlgRow: TdlgRow
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Numercial row calculator'
  ClientHeight = 385
  ClientWidth = 554
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
  object btnCompute: TButton
    Left = 373
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Compute'
    Default = True
    TabOrder = 0
    OnClick = btnComputeClick
  end
  object btnClose: TButton
    Left = 454
    Top = 344
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
  end
  object gbFunction: TGroupBox
    Left = 24
    Top = 24
    Width = 505
    Height = 97
    Caption = 'Function'
    TabOrder = 2
    object lbFunction: TLabel
      Left = 16
      Top = 24
      Width = 45
      Height = 13
      Caption = 'Function:'
    end
    object edFunction: TEdit
      Left = 16
      Top = 48
      Width = 473
      Height = 21
      TabOrder = 0
      Text = 'Sin(n)'
    end
  end
  object gbLimits: TGroupBox
    Left = 24
    Top = 127
    Width = 505
    Height = 122
    Caption = 'Limits'
    TabOrder = 3
    object lbTopLimit: TLabel
      Left = 16
      Top = 24
      Width = 43
      Height = 13
      Caption = 'Top limit:'
    end
    object lbBottomLimit: TLabel
      Left = 255
      Top = 24
      Width = 59
      Height = 13
      Caption = 'Bottom limit:'
    end
    object lbStep: TLabel
      Left = 16
      Top = 67
      Width = 26
      Height = 13
      Caption = 'Step:'
    end
    object edTopLimit: TEdit
      Left = 24
      Top = 40
      Width = 229
      Height = 21
      TabOrder = 0
      Text = '1'
      OnKeyPress = edBottomLimitKeyPress
    end
    object edBottomLimit: TEdit
      Left = 259
      Top = 40
      Width = 230
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyPress = edBottomLimitKeyPress
    end
    object edStep: TEdit
      Left = 24
      Top = 83
      Width = 225
      Height = 21
      TabOrder = 2
      Text = '1'
      OnKeyPress = edBottomLimitKeyPress
    end
  end
  object gbResult: TGroupBox
    Left = 24
    Top = 255
    Width = 505
    Height = 75
    Caption = 'Result'
    TabOrder = 4
    object edResult: TEdit
      Left = 16
      Top = 32
      Width = 464
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
  end
end
