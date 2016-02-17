object dlgConfig: TdlgConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 265
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
  object btnOk: TButton
    Left = 373
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 454
    Top = 232
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object pcMain: TPageControl
    Left = 8
    Top = 8
    Width = 521
    Height = 218
    ActivePage = tsInterface
    TabOrder = 2
    object tsInterface: TTabSheet
      Caption = 'Interface'
      ImageIndex = 1
      object lbLanguage: TLabel
        Left = 3
        Top = 88
        Width = 51
        Height = 13
        Caption = 'Language:'
      end
      object gbToolBar: TGroupBox
        Left = 3
        Top = 3
        Width = 505
        Height = 78
        BiDiMode = bdLeftToRight
        Caption = 'Tool bar'
        ParentBiDiMode = False
        TabOrder = 0
        object cbShowCaptions: TCheckBox
          Left = 16
          Top = 24
          Width = 473
          Height = 17
          Caption = 'Show toolbar captions'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object cbShowHints: TCheckBox
          Left = 16
          Top = 44
          Width = 473
          Height = 17
          Caption = 'Show hints'
          TabOrder = 1
        end
      end
      object cbLangList: TComboBox
        Left = 3
        Top = 107
        Width = 190
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
      object cbHideInTray: TCheckBox
        Left = 3
        Top = 134
        Width = 498
        Height = 17
        Caption = 'Minimize program in tray'
        TabOrder = 2
      end
    end
    object tsColors: TTabSheet
      Caption = 'Colors'
      ImageIndex = 2
      object gb2Dplotter: TGroupBox
        Left = 3
        Top = 3
        Width = 505
        Height = 90
        Caption = '2D plotter'
        TabOrder = 0
        object lbXaxisColor: TLabel
          Left = 8
          Top = 24
          Width = 67
          Height = 13
          Caption = 'Axis "X" color:'
        end
        object lbYaxisColor: TLabel
          Left = 8
          Top = 56
          Width = 67
          Height = 13
          Caption = 'Axis "Y" color:'
        end
        object lbGridColor: TLabel
          Left = 203
          Top = 24
          Width = 49
          Height = 13
          Caption = 'Grid color:'
        end
        object lbGraphColor: TLabel
          Left = 203
          Top = 56
          Width = 59
          Height = 13
          Caption = 'Graph color:'
        end
        object cbXaxisColor: TColorBox
          Left = 81
          Top = 21
          Width = 116
          Height = 22
          Selected = clRed
          ItemHeight = 16
          TabOrder = 0
        end
        object cbYaxisColor: TColorBox
          Left = 81
          Top = 53
          Width = 116
          Height = 22
          Selected = clLime
          ItemHeight = 16
          TabOrder = 1
        end
        object cbGridColor: TColorBox
          Left = 268
          Top = 21
          Width = 116
          Height = 22
          Selected = clSilver
          ItemHeight = 16
          TabOrder = 2
        end
        object cbGraphColor: TColorBox
          Left = 268
          Top = 53
          Width = 116
          Height = 22
          Selected = clGray
          ItemHeight = 16
          TabOrder = 3
        end
      end
      object gb3Dplotter: TGroupBox
        Left = 3
        Top = 97
        Width = 505
        Height = 90
        Caption = '3D plotter'
        TabOrder = 1
        object lb3DXaxisColor: TLabel
          Left = 8
          Top = 19
          Width = 67
          Height = 13
          Caption = 'Axis "X" color:'
        end
        object lb3DYaxisColor: TLabel
          Left = 8
          Top = 43
          Width = 67
          Height = 13
          Caption = 'Axis "Y" color:'
        end
        object lb3DZaxisColor: TLabel
          Left = 8
          Top = 67
          Width = 67
          Height = 13
          Caption = 'Axis "Z" color:'
        end
        object lb3DGridColor: TLabel
          Left = 203
          Top = 19
          Width = 49
          Height = 13
          Caption = 'Grid color:'
        end
        object lb3DGraphColor: TLabel
          Left = 203
          Top = 43
          Width = 58
          Height = 13
          Caption = 'GraphColor:'
        end
        object cb3Dxcolor: TColorBox
          Left = 81
          Top = 12
          Width = 116
          Height = 22
          Selected = clRed
          ItemHeight = 16
          TabOrder = 0
        end
        object cb3Dycolor: TColorBox
          Left = 81
          Top = 36
          Width = 116
          Height = 22
          Selected = clLime
          ItemHeight = 16
          TabOrder = 1
        end
        object cb3Dzcolor: TColorBox
          Left = 81
          Top = 60
          Width = 116
          Height = 22
          Selected = clBlue
          ItemHeight = 16
          TabOrder = 2
        end
        object cb3Dgridcolor: TColorBox
          Left = 268
          Top = 12
          Width = 116
          Height = 22
          Selected = clSilver
          ItemHeight = 16
          TabOrder = 3
        end
        object cb3Dgraphcolor: TColorBox
          Left = 268
          Top = 36
          Width = 116
          Height = 22
          Selected = clGray
          ItemHeight = 16
          TabOrder = 4
        end
      end
    end
  end
end
