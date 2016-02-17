object dlgProxy: TdlgProxy
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Proxy'
  ClientHeight = 289
  ClientWidth = 537
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
  object gbProxy: TGroupBox
    Left = 24
    Top = 24
    Width = 489
    Height = 209
    Caption = 'Proxy'
    TabOrder = 2
    object lbProxyType: TLabel
      Left = 16
      Top = 24
      Width = 57
      Height = 13
      Caption = 'Proxy type:'
    end
    object lbProxyHost: TLabel
      Left = 16
      Top = 56
      Width = 43
      Height = 13
      Caption = 'Address:'
    end
    object lbProxyPort: TLabel
      Left = 16
      Top = 88
      Width = 24
      Height = 13
      Caption = 'Port:'
    end
    object lbUserName: TLabel
      Left = 16
      Top = 144
      Width = 55
      Height = 13
      Caption = 'User name:'
      Enabled = False
    end
    object lbPass: TLabel
      Left = 16
      Top = 176
      Width = 50
      Height = 13
      Caption = 'Password:'
      Enabled = False
    end
    object cbProxyType: TComboBox
      Left = 96
      Top = 24
      Width = 377
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'NONE'
      Items.Strings = (
        'NONE'
        'HTTP'
        'HTTPS'
        'SOCKS4'
        'SOCKS5')
    end
    object edAddress: TEdit
      Left = 96
      Top = 56
      Width = 377
      Height = 21
      TabOrder = 1
    end
    object edPort: TEdit
      Left = 96
      Top = 88
      Width = 377
      Height = 21
      TabOrder = 2
    end
    object cbAuthentification: TCheckBox
      Left = 96
      Top = 120
      Width = 377
      Height = 17
      Caption = 'Authentification'
      TabOrder = 3
      OnClick = cbAuthentificationClick
    end
    object edUserName: TEdit
      Left = 96
      Top = 144
      Width = 377
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object edUserPass: TEdit
      Left = 96
      Top = 176
      Width = 377
      Height = 21
      Enabled = False
      PasswordChar = '*'
      TabOrder = 5
    end
  end
  object btnOk: TButton
    Left = 344
    Top = 248
    Width = 81
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 432
    Top = 248
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
end
