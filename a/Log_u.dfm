object wndLog: TwndLog
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Log'
  ClientHeight = 144
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 0
    Top = 0
    Width = 503
    Height = 144
    Align = alClient
    PopupMenu = pmLog
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object pmLog: TPopupMenu
    Left = 8
    Top = 8
    object Copylog1: TMenuItem
      Tag = 1
      Caption = 'Copy log'
      OnClick = Clearlog1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Clearlog1: TMenuItem
      Tag = 2
      Caption = 'Clear log'
      ShortCut = 32814
      OnClick = Clearlog1Click
    end
  end
  object Refocuser: TTimer
    OnTimer = RefocuserTimer
    Left = 40
    Top = 8
  end
end
