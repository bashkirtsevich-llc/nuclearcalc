object wnd3D: Twnd3D
  Left = 0
  Top = 0
  Caption = '3D view'
  ClientHeight = 385
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 187
    Height = 385
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
    object lbYmin: TLabel
      Left = 8
      Top = 62
      Width = 29
      Height = 13
      Caption = 'Y min:'
    end
    object lbXmax: TLabel
      Left = 8
      Top = 85
      Width = 33
      Height = 13
      Caption = 'X max:'
    end
    object lbYmax: TLabel
      Left = 8
      Top = 108
      Width = 33
      Height = 13
      Caption = 'Y max:'
    end
    object lbXstep: TLabel
      Left = 8
      Top = 131
      Width = 27
      Height = 13
      Caption = 'X div:'
    end
    object lbYdiv: TLabel
      Left = 8
      Top = 154
      Width = 27
      Height = 13
      Caption = 'Y div:'
    end
    object sbZoomIn: TSpeedButton
      Tag = 5
      Left = 8
      Top = 353
      Width = 23
      Height = 25
      Caption = '+'
      OnClick = sbZoomInClick
    end
    object sbZoomOut: TSpeedButton
      Tag = -5
      Left = 32
      Top = 353
      Width = 23
      Height = 25
      Caption = '-'
      OnClick = sbZoomInClick
    end
    object edFunction: TEdit
      Left = 56
      Top = 13
      Width = 121
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
    object edYmin: TEdit
      Left = 56
      Top = 59
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '-10'
    end
    object edXmax: TEdit
      Left = 56
      Top = 82
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '10'
    end
    object edYmax: TEdit
      Left = 56
      Top = 105
      Width = 121
      Height = 21
      TabOrder = 4
      Text = '10'
    end
    object edXdiv: TEdit
      Left = 56
      Top = 128
      Width = 121
      Height = 21
      TabOrder = 5
      Text = '10'
    end
    object edYdiv: TEdit
      Left = 56
      Top = 151
      Width = 121
      Height = 21
      TabOrder = 6
      Text = '10'
    end
    object btnDraw: TButton
      Left = 56
      Top = 353
      Width = 121
      Height = 25
      Caption = 'Draw graphic'
      TabOrder = 10
      OnClick = btnDrawClick
    end
    object gbAxis: TGroupBox
      Left = 8
      Top = 173
      Width = 169
      Height = 66
      Caption = 'Axis'
      TabOrder = 7
      object cbDrawXaxis: TCheckBox
        Left = 11
        Top = 14
        Width = 155
        Height = 17
        Caption = 'Draw X axis'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbDrawYaxis: TCheckBox
        Left = 11
        Top = 29
        Width = 155
        Height = 17
        Caption = 'Draw Y axis'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object cbDrawZaxis: TCheckBox
        Left = 11
        Top = 44
        Width = 155
        Height = 17
        Caption = 'Draw Z axis'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
    object gbGrids: TGroupBox
      Left = 8
      Top = 240
      Width = 169
      Height = 66
      Caption = 'Grids'
      TabOrder = 8
      object cbDrawXgrid: TCheckBox
        Left = 11
        Top = 14
        Width = 155
        Height = 17
        Caption = 'Draw XY grid'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbDrawYgrid: TCheckBox
        Left = 11
        Top = 29
        Width = 155
        Height = 17
        Caption = 'Draw YZ grid'
        TabOrder = 1
      end
      object cbDrawZgrid: TCheckBox
        Left = 11
        Top = 44
        Width = 155
        Height = 17
        Caption = 'Draw XZ grid'
        TabOrder = 2
      end
    end
    object cbOutOfTheLimit: TCheckBox
      Left = 8
      Top = 335
      Width = 169
      Height = 17
      Caption = 'Out of the limit'
      TabOrder = 9
    end
    object cbMode: TComboBox
      Left = 8
      Top = 312
      Width = 169
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 11
      Text = 'Linear'
      OnChange = cbModeChange
      Items.Strings = (
        'Linear'
        'Cylinder'
        'Sphere')
    end
  end
end
