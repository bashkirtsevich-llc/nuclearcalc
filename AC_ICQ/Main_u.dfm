object wndMain: TwndMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '[Atomic Calculator]'
  ClientHeight = 443
  ClientWidth = 849
  Color = clBtnFace
  Constraints.MinHeight = 369
  Constraints.MinWidth = 776
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    849
    443)
  PixelsPerInch = 96
  TextHeight = 13
  object lbResult: TLabel
    Left = 24
    Top = 136
    Width = 34
    Height = 13
    Caption = 'Result:'
  end
  object lbFunction: TLabel
    Left = 24
    Top = 168
    Width = 45
    Height = 13
    Caption = 'Function:'
  end
  object btnCalculate: TSpeedButton
    Left = 248
    Top = 360
    Width = 121
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = 'Calculate'
    OnClick = btnCalculateClick
  end
  object gbHistory: TGroupBox
    Left = 392
    Top = 24
    Width = 425
    Height = 361
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'History'
    TabOrder = 4
    DesignSize = (
      425
      361)
    object memLog: TMemo
      Left = 6
      Top = 15
      Width = 413
      Height = 338
      Anchors = [akLeft, akTop, akRight, akBottom]
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object btnConnect: TButton
    Left = 472
    Top = 400
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Connect'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 560
    Top = 400
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Disconnect'
    Enabled = False
    TabOrder = 1
    OnClick = btnDisconnectClick
  end
  object btnExit: TButton
    Left = 736
    Top = 400
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Exit'
    TabOrder = 3
    OnClick = btnExitClick
  end
  object btnProxy: TButton
    Left = 648
    Top = 400
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Proxy'
    TabOrder = 2
    OnClick = btnProxyClick
  end
  object gbLogin: TGroupBox
    Left = 24
    Top = 24
    Width = 345
    Height = 97
    Caption = 'Login'
    TabOrder = 5
    object lbUIN: TLabel
      Left = 16
      Top = 24
      Width = 22
      Height = 13
      Caption = 'UIN:'
    end
    object lbPass: TLabel
      Left = 16
      Top = 56
      Width = 26
      Height = 13
      Caption = 'Pass:'
    end
    object edUIN: TEdit
      Left = 56
      Top = 24
      Width = 273
      Height = 21
      TabOrder = 0
    end
    object edPass: TEdit
      Left = 56
      Top = 56
      Width = 273
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
  end
  object edResult: TEdit
    Left = 72
    Top = 136
    Width = 297
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  object memFunc: TMemo
    Left = 24
    Top = 184
    Width = 345
    Height = 161
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object cbWork: TCheckBox
    Left = 24
    Top = 360
    Width = 218
    Height = 17
    Caption = 'Service is working'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object LiveTimer: TTimer
    Enabled = False
    Interval = 6000
    OnTimer = LiveTimerTimer
    Left = 8
    Top = 8
  end
end
