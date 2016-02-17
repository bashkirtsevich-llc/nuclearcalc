object wndConsole: TwndConsole
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Console'
  ClientHeight = 385
  ClientWidth = 663
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
  object memLog: TMemo
    Left = 0
    Top = 0
    Width = 663
    Height = 364
    Cursor = crArrow
    Align = alClient
    BorderStyle = bsNone
    Color = clNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clSilver
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object edConsole: TEdit
    Left = 0
    Top = 364
    Width = 663
    Height = 21
    Cursor = crArrow
    Align = alBottom
    BorderStyle = bsNone
    Color = clNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clSilver
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyDown = edConsoleKeyDown
  end
end
