object wnd2D: Twnd2D
  Left = 0
  Top = 0
  Caption = '2D view'
  ClientHeight = 457
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = imgGraphMouseDown
  OnMouseMove = imgGraphMouseMove
  OnMouseUp = imgGraphMouseUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPad: TPanel
    Left = 0
    Top = 0
    Width = 187
    Height = 457
    Align = alLeft
    TabOrder = 0
    object lbFunctionName: TLabel
      Left = 8
      Top = 16
      Width = 45
      Height = 13
      Caption = 'Function:'
    end
    object lbXmin: TLabel
      Left = 8
      Top = 39
      Width = 29
      Height = 13
      Caption = 'X min:'
    end
    object lbXmax: TLabel
      Left = 8
      Top = 62
      Width = 33
      Height = 13
      Caption = 'X max:'
    end
    object lbXdiv: TLabel
      Left = 8
      Top = 85
      Width = 27
      Height = 13
      Caption = 'X div:'
    end
    object sbZoomIn: TSpeedButton
      Tag = 5
      Left = 8
      Top = 425
      Width = 23
      Height = 25
      Caption = '+'
      OnMouseDown = sbZoomInMouseDown
      OnMouseUp = sbZoomInMouseUp
    end
    object sbZoomOut: TSpeedButton
      Tag = -5
      Left = 32
      Top = 425
      Width = 23
      Height = 25
      Caption = '-'
      OnMouseDown = sbZoomInMouseDown
      OnMouseUp = sbZoomInMouseUp
    end
    object btnAdd: TSpeedButton
      Left = 140
      Top = 13
      Width = 37
      Height = 21
      Caption = 'Add'
      OnClick = btnAddClick
    end
    object lbColor: TLabel
      Left = 8
      Top = 108
      Width = 29
      Height = 13
      Caption = 'Color:'
    end
    object edFunction: TEdit
      Left = 56
      Top = 13
      Width = 81
      Height = 21
      TabOrder = 0
      Text = 'Cos(X)'
    end
    object edXmin: TEdit
      Left = 56
      Top = 36
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '-10'
    end
    object edXmax: TEdit
      Left = 56
      Top = 59
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '10'
    end
    object edXdiv: TEdit
      Left = 56
      Top = 82
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '10'
    end
    object gbGrid: TGroupBox
      Left = 8
      Top = 129
      Width = 169
      Height = 93
      Caption = 'Grid'
      TabOrder = 5
      object lbX: TLabel
        Left = 11
        Top = 65
        Width = 32
        Height = 13
        Caption = 'X axis:'
      end
      object lbY: TLabel
        Left = 11
        Top = 42
        Width = 32
        Height = 13
        Caption = 'Y axis:'
      end
      object cbDrawGrid: TCheckBox
        Left = 11
        Top = 16
        Width = 147
        Height = 17
        Caption = 'Draw grid'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbDrawGridClick
      end
      object edYdimension: TEdit
        Left = 48
        Top = 39
        Width = 110
        Height = 21
        TabOrder = 1
        Text = '5'
      end
      object edXdimension: TEdit
        Left = 48
        Top = 62
        Width = 110
        Height = 21
        TabOrder = 2
        Text = '10'
      end
    end
    object btnDraw: TButton
      Left = 56
      Top = 425
      Width = 121
      Height = 25
      Caption = 'Draw graph'
      Default = True
      TabOrder = 9
      OnClick = btnDrawClick
    end
    object gbAxis: TGroupBox
      Left = 8
      Top = 224
      Width = 169
      Height = 60
      Caption = 'Axis'
      TabOrder = 6
      object cbDrawXaxis: TCheckBox
        Left = 11
        Top = 17
        Width = 147
        Height = 17
        Caption = 'Draw "X" axis'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbDrawYaxis: TCheckBox
        Left = 11
        Top = 34
        Width = 147
        Height = 17
        Caption = 'Draw "Y" axis'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object cbOutOfTheLimit: TCheckBox
      Left = 8
      Top = 402
      Width = 169
      Height = 17
      Caption = 'Out of the limit'
      TabOrder = 8
    end
    object gbGraphics: TGroupBox
      Left = 8
      Top = 288
      Width = 169
      Height = 108
      Caption = 'Graphics'
      TabOrder = 7
      object clbGraphics: TCheckListBox
        Left = 3
        Top = 16
        Width = 161
        Height = 88
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object clBoxColors: TColorBox
      Left = 56
      Top = 105
      Width = 121
      Height = 22
      DefaultColorColor = clGray
      Selected = clGray
      ItemHeight = 16
      TabOrder = 4
    end
  end
end
