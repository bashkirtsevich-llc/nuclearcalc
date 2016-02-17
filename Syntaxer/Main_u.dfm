object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 405
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 408
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object reCode: TRichEdit
    Left = 8
    Top = 8
    Width = 369
    Height = 265
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'x:=0;'
      '/* Hello world application say */'
      'exec next_x;'
      ' exec'
      'end.'
      ''
      'procedure next_x'
      '{'
      '  while do { }'
      '  glColor3f(0,0,0);'
      '  showmessage("hello world");'
      '  result:= a and b;'
      '}')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 400
    Top = 24
    Width = 185
    Height = 89
    TabOrder = 2
  end
end
