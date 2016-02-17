object dlgAbout: TdlgAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 105
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgLogo: TImage
    Left = 8
    Top = 9
    Width = 88
    Height = 88
  end
  object lblAbout: TLabel
    Left = 104
    Top = 8
    Width = 22
    Height = 13
    Caption = '[AC]'
  end
  object lbAuthor: TLabel
    Left = 104
    Top = 32
    Width = 158
    Height = 13
    Caption = 'M.A.D.M.A.N. Software (c) 2009'
  end
  object lbSpecialThanks: TLabel
    Left = 104
    Top = 56
    Width = 313
    Height = 13
    Caption = 
      'Special thanks to Thrasher, Vayrus, Jan Tungli, thanks to Borlan' +
      'd'
  end
  object lbUPX: TLabel
    Left = 104
    Top = 80
    Width = 209
    Height = 13
    Caption = 'Program used "UPX 3.0 by Markus && Laszlo"'
  end
  object btnOk: TButton
    Left = 398
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
