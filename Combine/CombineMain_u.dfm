object wndMain: TwndMain
  Left = 0
  Top = 0
  Caption = '[AC]'
  ClientHeight = 505
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
  OnClose = FormClose
  OnCreate = FormCreate
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
        Width = 8
        Caption = 'sp1'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object btnSave: TToolButton
        Left = 145
        Top = 0
        Caption = 'Save'
        ImageIndex = 2
        OnClick = btnSaveClick
      end
      object sp2: TToolButton
        Left = 206
        Top = 0
        Width = 8
        Caption = 'sp2'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object btnMode: TToolButton
        Left = 214
        Top = 0
        Caption = 'Mode'
        DropdownMenu = mnuMode
        ImageIndex = 3
        Style = tbsDropDown
        OnClick = btnModeClick
      end
      object btnConfig: TToolButton
        Left = 290
        Top = 0
        Caption = 'Config'
        ImageIndex = 4
        OnClick = btnConfigClick
      end
      object sp3: TToolButton
        Left = 351
        Top = 0
        Width = 8
        Caption = 'sp3'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object btnHelp: TToolButton
        Left = 359
        Top = 0
        Caption = 'Help'
        ImageIndex = 5
      end
      object btnAbout: TToolButton
        Left = 420
        Top = 0
        Caption = 'About'
        ImageIndex = 6
      end
    end
  end
  object pmNewFile: TPopupMenu
    Left = 8
    Top = 88
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
    Left = 40
    Top = 88
  end
  object mnuMain: TMainMenu
    Left = 72
    Top = 88
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
      object Setup1: TMenuItem
        Caption = 'Setup'
        OnClick = btnConfigClick
      end
    end
    object Mode1: TMenuItem
      Caption = 'Mode'
      object Calculator1: TMenuItem
        Caption = 'Calculator'
      end
      object Interpreter1: TMenuItem
        Caption = 'Syntax interpreter'
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Help2: TMenuItem
        Caption = 'Help'
      end
      object About1: TMenuItem
        Caption = 'About'
      end
    end
  end
  object mnuMode: TPopupMenu
    Left = 104
    Top = 88
    object Calculator2: TMenuItem
      Caption = 'Calculator'
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Syntaxinterpreter1: TMenuItem
      Caption = 'Syntax interpreter'
    end
  end
  object dlgSave: TSaveDialog
    Filter = 'ACG files (*.acg)|*.ACG'
    Title = 'Save graph to file'
    Left = 136
    Top = 88
  end
  object dlgOpen: TOpenDialog
    Filter = 'ACG files (*.acg)|*.ACG'
    Left = 168
    Top = 88
  end
  object Tray: TTrayIcon
    Hint = '[AC]'
    BalloonTitle = '[AC]'
    BalloonFlags = bfInfo
    PopupMenu = TrayMenu
    OnDblClick = TrayDblClick
    Left = 200
    Top = 88
  end
  object TrayMenu: TPopupMenu
    Left = 232
    Top = 88
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
end
