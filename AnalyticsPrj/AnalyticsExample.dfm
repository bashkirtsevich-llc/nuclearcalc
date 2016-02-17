object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Antiderivative calculation'
  ClientHeight = 274
  ClientWidth = 792
  Color = clBtnFace
  Constraints.MaxHeight = 308
  Constraints.MinHeight = 300
  Constraints.MinWidth = 800
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Courier New'
  Font.Style = [fsBold]
  OldCreateOrder = False
  DesignSize = (
    792
    274)
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 24
    Top = 176
    Width = 7
    Height = 14
  end
  object LabeledEdit1: TLabeledEdit
    Left = 154
    Top = 16
    Width = 630
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 133
    EditLabel.Height = 14
    EditLabel.Caption = 'Function    F(x,y)='
    LabelPosition = lpLeft
    TabOrder = 0
    Text = 'sin(x)+cos(x)'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 154
    Top = 98
    Width = 630
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 126
    EditLabel.Height = 14
    EditLabel.Caption = 'Antiderivative  F='
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 154
    Top = 126
    Width = 630
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 126
    EditLabel.Height = 14
    EditLabel.Caption = 'Antiderivative  F='
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 360
    Top = 56
    Width = 257
    Height = 25
    Caption = 'Calculate antiderivative'
    Default = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object XPManifest1: TXPManifest
    Left = 656
    Top = 40
  end
end
