object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 393
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object imgGraph: TImage
    Left = 153
    Top = 0
    Width = 564
    Height = 393
    Align = alClient
    OnMouseDown = imgGraphMouseDown
    OnMouseMove = imgGraphMouseMove
    OnMouseUp = imgGraphMouseUp
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 561
    ExplicitHeight = 369
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 393
    Align = alLeft
    TabOrder = 0
    object lbXmin: TLabel
      Left = 8
      Top = 133
      Width = 25
      Height = 13
      Caption = 'X min'
    end
    object lbXmax: TLabel
      Left = 8
      Top = 160
      Width = 29
      Height = 13
      Caption = 'X max'
    end
    object lbXdv: TLabel
      Left = 8
      Top = 187
      Width = 23
      Height = 13
      Caption = 'X div'
    end
    object btnDrawGraph: TButton
      Left = 67
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Draw graphic'
      TabOrder = 1
      OnClick = btnDrawGraphClick
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 66
      Width = 134
      Height = 45
      Max = 100
      Min = 5
      PageSize = 1
      Frequency = 10
      Position = 10
      TabOrder = 2
      OnChange = TrackBar1Change
    end
    object edFunction: TEdit
      Left = 8
      Top = 8
      Width = 134
      Height = 21
      TabOrder = 0
      Text = 'Sin(x)'
    end
    object edXmin: TEdit
      Left = 43
      Top = 130
      Width = 99
      Height = 21
      TabOrder = 3
      Text = '-10'
    end
    object edXmax: TEdit
      Left = 43
      Top = 157
      Width = 99
      Height = 21
      TabOrder = 4
      Text = '10'
    end
    object edXdiv: TEdit
      Left = 43
      Top = 184
      Width = 99
      Height = 21
      TabOrder = 5
      Text = '10'
    end
    object cbDrawGrid: TCheckBox
      Left = 8
      Top = 211
      Width = 134
      Height = 17
      Caption = 'Draw grid'
      TabOrder = 6
    end
  end
end
