object wndMain: TwndMain
  Left = 0
  Top = 0
  Caption = '[Atomic Calculator] - "Plotter"'
  ClientHeight = 565
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mnuMain
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbMain: TCoolBar
    Left = 0
    Top = 0
    Width = 754
    Height = 85
    Bands = <
      item
        Control = tbMenu
        ImageIndex = -1
        MinHeight = 78
        Width = 748
      end>
    Visible = False
    object tbMenu: TToolBar
      Left = 11
      Top = 0
      Width = 739
      Height = 78
      ButtonHeight = 76
      ButtonWidth = 61
      Caption = 'tbMenu'
      Images = ToolIcons
      ShowCaptions = True
      TabOrder = 0
      object btnNew: TToolButton
        Left = 0
        Top = 0
        Caption = 'New'
        DropdownMenu = pmNewFile
        ImageIndex = 0
        Style = tbsDropDown
        OnClick = btnNewClick
      end
      object btnOpen: TToolButton
        Left = 76
        Top = 0
        Caption = 'Open'
        ImageIndex = 1
        OnClick = btnOpenClick
      end
      object sp1: TToolButton
        Left = 137
        Top = 0
        Width = 5
        Caption = 'sp1'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object btnSave: TToolButton
        Left = 142
        Top = 0
        Caption = 'Save'
        ImageIndex = 2
        OnClick = btnSaveClick
      end
      object sp2: TToolButton
        Left = 203
        Top = 0
        Width = 5
        Caption = 'sp2'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object btnMode: TToolButton
        Left = 208
        Top = 0
        Caption = 'Mode'
        DropdownMenu = mnuMode
        ImageIndex = 3
        Style = tbsDropDown
        OnClick = btnModeClick
      end
      object btnConfig: TToolButton
        Left = 284
        Top = 0
        Caption = 'Config'
        ImageIndex = 4
        OnClick = btnConfigClick
      end
      object sp3: TToolButton
        Left = 345
        Top = 0
        Width = 5
        Caption = 'sp3'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object btnHelp: TToolButton
        Left = 350
        Top = 0
        Caption = 'Help'
        DropdownMenu = mnuHelp
        ImageIndex = 5
        Style = tbsDropDown
      end
    end
  end
  object pmNewFile: TPopupMenu
    Left = 16
    Top = 8
    object N2DGraph1: TMenuItem
      Tag = 2
      Caption = '2D Graph'
      OnClick = N3DGraph1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N3DGraph1: TMenuItem
      Tag = 1
      Caption = '3D Graph'
      OnClick = N3DGraph1Click
    end
  end
  object ToolIcons: TImageList
    Height = 48
    Width = 48
    Left = 48
    Top = 8
  end
  object mnuMain: TMainMenu
    Left = 80
    Top = 8
    object N5: TMenuItem
      Caption = '^'
      OnClick = N5Click
    end
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New'
        object N2DGraph2: TMenuItem
          Tag = 2
          Caption = '2D Graph'
          OnClick = N3DGraph1Click
        end
        object N3DGraph2: TMenuItem
          Tag = 1
          Caption = '3D Graph'
          OnClick = N3DGraph1Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = btnSaveClick
      end
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = btnOpenClick
      end
      object Close1: TMenuItem
        Caption = 'Close'
        OnClick = Close1Click
      end
      object Closeall1: TMenuItem
        Caption = 'Close all'
        OnClick = Closeall1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Configuration1: TMenuItem
      Caption = 'Configuration'
      object Setup2: TMenuItem
        Caption = 'Setup'
        OnClick = Setup2Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Setup1: TMenuItem
        Caption = 'Plotter configuration'
        OnClick = btnConfigClick
      end
    end
    object Mode1: TMenuItem
      Caption = 'Mode'
      object Calculator1: TMenuItem
        Caption = 'Calculator'
        OnClick = Calculator2Click
      end
      object IntegralComputer: TMenuItem
        Caption = 'Integral computer'
        Enabled = False
        OnClick = IntegralComputerClick
      end
      object Numercialrowcalculator1: TMenuItem
        Caption = 'Numercial row calculator'
        OnClick = Numercialrowcalculator1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Help2: TMenuItem
        Caption = 'Help'
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object mnuMode: TPopupMenu
    Left = 112
    Top = 8
    object Calculator2: TMenuItem
      Caption = 'Calculator'
      OnClick = Calculator2Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object IntegralComputer2: TMenuItem
      Caption = 'Integral computer'
      OnClick = IntegralComputerClick
    end
  end
  object dlgSave: TSaveDialog
    Filter = 'ACG files (*.acg)|*.ACG'
    Title = 'Save graph to file'
    Left = 144
    Top = 8
  end
  object dlgOpen: TOpenDialog
    Filter = 'ACG files (*.acg)|*.ACG'
    Left = 176
    Top = 8
  end
  object Tray: TTrayIcon
    Hint = '[AC]'
    BalloonTitle = '[AC]'
    BalloonFlags = bfInfo
    PopupMenu = TrayMenu
    OnDblClick = TrayDblClick
    Left = 208
    Top = 8
  end
  object TrayMenu: TPopupMenu
    Left = 240
    Top = 8
    object Restore1: TMenuItem
      Tag = 1
      Caption = 'Restore'
      OnClick = Close2Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Close2: TMenuItem
      Tag = 2
      Caption = 'Close'
      OnClick = Close2Click
    end
  end
  object mnuHelp: TPopupMenu
    Left = 272
    Top = 8
    object Help3: TMenuItem
      Caption = 'Help'
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object About2: TMenuItem
      Caption = 'About'
      OnClick = About1Click
    end
  end
end
