object dlgAbout: TdlgAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 105
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgLogo: TImage
    Left = 12
    Top = 12
    Width = 81
    Height = 81
  end
  object lbProductName: TLabel
    Left = 104
    Top = 17
    Width = 91
    Height = 13
    Caption = '[Atomic Calculator]'
  end
  object lbProductVersion: TLabel
    Left = 104
    Top = 37
    Width = 54
    Height = 13
    Caption = 'Version 1.4'
  end
  object lbAuthor: TLabel
    Left = 104
    Top = 56
    Width = 208
    Height = 13
    Caption = 'Copyright M.A.D.M.A.N. Software (c) 2009'
  end
  object lbThanks: TLabel
    Left = 103
    Top = 76
    Width = 127
    Height = 13
    Caption = 'Special thanks to Thrasher'
  end
  object btnOk: TButton
    Left = 366
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
