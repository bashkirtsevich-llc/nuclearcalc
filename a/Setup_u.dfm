object dlgSetup: TdlgSetup
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Setup'
  ClientHeight = 327
  ClientWidth = 504
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
  object btnOk: TButton
    Left = 317
    Top = 287
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 398
    Top = 287
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 11
    TabOrder = 1
  end
  object pcMain: TPageControl
    Left = 24
    Top = 24
    Width = 449
    Height = 249
    ActivePage = tsStartup
    TabOrder = 2
    object tsStartup: TTabSheet
      Caption = 'Startup mode'
      object gbStartupMode: TGroupBox
        Left = 8
        Top = 8
        Width = 417
        Height = 129
        Caption = 'Startup mode'
        TabOrder = 0
        object lbMode: TLabel
          Left = 11
          Top = 27
          Width = 68
          Height = 13
          Caption = 'Default mode:'
        end
        object cbRunMode: TComboBox
          Left = 85
          Top = 24
          Width = 316
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Calculator'
          Items.Strings = (
            'Calculator'
            '3D/2D plotter')
        end
        object cbSplash: TCheckBox
          Left = 11
          Top = 51
          Width = 390
          Height = 17
          Caption = 'Show startup splash'
          TabOrder = 1
        end
        object cbDisplayLogMemo: TCheckBox
          Left = 11
          Top = 74
          Width = 390
          Height = 17
          Caption = 'Display log memo'
          TabOrder = 2
        end
        object cbRememberRestoreWindowsPos: TCheckBox
          Left = 11
          Top = 97
          Width = 390
          Height = 17
          Caption = 'Remember and restore windows positions'
          TabOrder = 3
        end
      end
    end
    object tsLog: TTabSheet
      Caption = 'Log config'
      ImageIndex = 1
      object gbLogConfig: TGroupBox
        Left = 8
        Top = 8
        Width = 417
        Height = 106
        Caption = 'Log config'
        TabOrder = 0
        object lbSaveDir: TLabel
          Left = 11
          Top = 50
          Width = 43
          Height = 13
          Caption = 'Save dir:'
          Enabled = False
        end
        object cbSaveLogData: TCheckBox
          Left = 11
          Top = 24
          Width = 398
          Height = 17
          Caption = 'Save log data'
          TabOrder = 0
          OnClick = cbSaveLogDataClick
        end
        object edSaveFolder: TEdit
          Left = 85
          Top = 47
          Width = 297
          Height = 21
          Enabled = False
          TabOrder = 1
        end
        object btnBrowse: TButton
          Left = 388
          Top = 47
          Width = 21
          Height = 21
          Caption = '...'
          Enabled = False
          TabOrder = 2
          OnClick = btnBrowseClick
        end
        object cbMoveLog: TCheckBox
          Left = 11
          Top = 74
          Width = 398
          Height = 17
          Caption = 'Move log with main window'
          TabOrder = 3
        end
      end
    end
    object tsKeys: TTabSheet
      Caption = 'Keys'
      ImageIndex = 2
      object gbKeys: TGroupBox
        Left = 8
        Top = 8
        Width = 417
        Height = 161
        Caption = 'Keys'
        TabOrder = 0
        object lbCalculate: TLabel
          Left = 16
          Top = 27
          Width = 80
          Height = 13
          Caption = 'Calculate action:'
        end
        object lbReturnAction: TLabel
          Left = 16
          Top = 68
          Width = 69
          Height = 13
          Caption = 'Return action:'
        end
        object cbClearAfterCompute: TCheckBox
          Left = 16
          Top = 109
          Width = 385
          Height = 17
          Caption = 'Clear after compute'
          TabOrder = 0
        end
        object cbReturnAfterCompute: TCheckBox
          Left = 16
          Top = 132
          Width = 385
          Height = 17
          Caption = 'Return after compute'
          TabOrder = 1
        end
      end
    end
    object tsAliases: TTabSheet
      Caption = 'Aliases'
      ImageIndex = 3
      object gbAliases: TGroupBox
        Left = 8
        Top = 8
        Width = 417
        Height = 105
        Caption = 'Aliaces'
        TabOrder = 0
        object lbAliaseName: TLabel
          Left = 11
          Top = 49
          Width = 61
          Height = 13
          Caption = 'Aliase name:'
          Enabled = False
        end
        object cbEnableAliases: TCheckBox
          Left = 11
          Top = 24
          Width = 390
          Height = 17
          Caption = 'Enable aliases'
          TabOrder = 0
          OnClick = cbEnableAliasesClick
        end
        object edAliaseName: TEdit
          Left = 11
          Top = 72
          Width = 390
          Height = 21
          Enabled = False
          TabOrder = 1
          OnKeyPress = edAliaseNameKeyPress
        end
      end
    end
  end
end
