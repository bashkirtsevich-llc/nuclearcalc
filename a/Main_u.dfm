object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = '[Atomic Calculator]'
  ClientHeight = 333
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  Position = poDesigned
  OnCanResize = FormCanResize
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    513
    333)
  PixelsPerInch = 96
  TextHeight = 13
  object btnClear: TSpeedButton
    Left = 464
    Top = 15
    Width = 41
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'C'
    OnClick = btnClearClick
  end
  object lbFuncResult: TLabel
    Left = 8
    Top = 21
    Width = 75
    Height = 13
    Caption = 'Function result:'
  end
  object lbEnterFunction: TLabel
    Left = 8
    Top = 42
    Width = 45
    Height = 13
    Caption = 'Function:'
  end
  object gbAriphmetic: TGroupBox
    Left = 8
    Top = 195
    Width = 236
    Height = 134
    Anchors = [akLeft, akBottom]
    TabOrder = 2
    object sb7: TSpeedButton
      Left = 8
      Top = 9
      Width = 53
      Height = 22
      Caption = '7'
      OnClick = OnKeyClick
    end
    object sb8: TSpeedButton
      Left = 64
      Top = 9
      Width = 53
      Height = 22
      Caption = '8'
      OnClick = OnKeyClick
    end
    object sb9: TSpeedButton
      Left = 120
      Top = 9
      Width = 53
      Height = 22
      Caption = '9'
      OnClick = OnKeyClick
    end
    object sb4: TSpeedButton
      Left = 8
      Top = 33
      Width = 53
      Height = 22
      Caption = '4'
      OnClick = OnKeyClick
    end
    object sb5: TSpeedButton
      Left = 64
      Top = 33
      Width = 53
      Height = 22
      Caption = '5'
      OnClick = OnKeyClick
    end
    object sb6: TSpeedButton
      Left = 120
      Top = 33
      Width = 53
      Height = 22
      Caption = '6'
      OnClick = OnKeyClick
    end
    object sb1: TSpeedButton
      Left = 8
      Top = 57
      Width = 53
      Height = 22
      Caption = '1'
      OnClick = OnKeyClick
    end
    object sb2: TSpeedButton
      Left = 64
      Top = 57
      Width = 53
      Height = 22
      Caption = '2'
      OnClick = OnKeyClick
    end
    object sb3: TSpeedButton
      Left = 120
      Top = 57
      Width = 53
      Height = 22
      Caption = '3'
      OnClick = OnKeyClick
    end
    object sb0: TSpeedButton
      Left = 8
      Top = 81
      Width = 53
      Height = 22
      Caption = '0'
      OnClick = OnKeyClick
    end
    object sbZap: TSpeedButton
      Left = 64
      Top = 81
      Width = 53
      Height = 22
      Caption = ','
      OnClick = OnKeyClick
    end
    object sbPoint: TSpeedButton
      Left = 120
      Top = 81
      Width = 53
      Height = 22
      Caption = '.'
      OnClick = OnKeyClick
    end
    object sbAdd: TSpeedButton
      Left = 176
      Top = 9
      Width = 53
      Height = 22
      Caption = '+'
      OnClick = OnKeyClick
    end
    object sbSub: TSpeedButton
      Left = 176
      Top = 33
      Width = 53
      Height = 22
      Caption = '-'
      OnClick = OnKeyClick
    end
    object sbMul: TSpeedButton
      Left = 176
      Top = 57
      Width = 53
      Height = 22
      Caption = '*'
      OnClick = OnKeyClick
    end
    object sbDiv: TSpeedButton
      Left = 176
      Top = 81
      Width = 53
      Height = 22
      Caption = '/'
      OnClick = OnKeyClick
    end
    object sbEquals: TSpeedButton
      Left = 176
      Top = 105
      Width = 53
      Height = 22
      Caption = '='
      OnClick = sbEqualsClick
    end
    object sbPow: TSpeedButton
      Left = 8
      Top = 105
      Width = 53
      Height = 22
      Caption = '^'
      OnClick = OnKeyClick
    end
    object sbLeftBrckt: TSpeedButton
      Left = 64
      Top = 105
      Width = 53
      Height = 22
      Caption = '('
      OnClick = OnKeyClick
    end
    object sbRightBrckt: TSpeedButton
      Left = 120
      Top = 105
      Width = 53
      Height = 22
      Caption = ')'
      OnClick = OnKeyClick
    end
  end
  object edResult: TEdit
    Left = 89
    Top = 15
    Width = 369
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 1
  end
  object gbKeyBoard: TGroupBox
    Left = 250
    Top = 195
    Width = 255
    Height = 111
    Anchors = [akRight, akBottom]
    TabOrder = 3
    object _sb1: TSpeedButton
      Left = 8
      Top = 7
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb2: TSpeedButton
      Left = 68
      Top = 7
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb3: TSpeedButton
      Left = 128
      Top = 7
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb4: TSpeedButton
      Left = 188
      Top = 7
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb5: TSpeedButton
      Left = 8
      Top = 40
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb6: TSpeedButton
      Left = 68
      Top = 40
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb7: TSpeedButton
      Left = 128
      Top = 40
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb8: TSpeedButton
      Left = 188
      Top = 40
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb9: TSpeedButton
      Left = 8
      Top = 73
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb10: TSpeedButton
      Left = 68
      Top = 73
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb11: TSpeedButton
      Left = 128
      Top = 73
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
    object _sb12: TSpeedButton
      Left = 188
      Top = 73
      Width = 59
      Height = 30
      OnClick = _sb1Click
    end
  end
  object tsKeyboards: TTabSet
    Left = 250
    Top = 308
    Width = 255
    Height = 21
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    SoftTop = True
    Style = tsSoftTabs
    Tabs.Strings = (
      'Trigonometric'
      'Hyperbolic'
      'Mathematic'
      'Numercial'
      'Constants'
      'Functions #1'
      'Functions #2'
      'Functions #3'
      'Logic')
    TabIndex = 0
    OnChange = tsKeyboardsChange
  end
  object memFunc: TMemo
    Left = 8
    Top = 61
    Width = 497
    Height = 128
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = pmMemFunc
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    OnKeyPress = memFuncKeyPress
  end
  object mnuMain: TMainMenu
    Left = 16
    Top = 64
    object File1: TMenuItem
      Caption = 'File'
      object Clear1: TMenuItem
        Caption = 'Clear'
        ShortCut = 32776
        OnClick = btnClearClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Save1: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        ShortCut = 32856
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Copy1: TMenuItem
        Tag = 1
        Caption = 'Copy'
        OnClick = Paste1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Paste1: TMenuItem
        Tag = 2
        Caption = 'Paste'
        OnClick = Paste1Click
      end
    end
    object Memory1: TMenuItem
      Caption = 'Memory'
      object Addtomemory1: TMenuItem
        Caption = 'Add to memory'
        ShortCut = 45
        OnClick = Addtomemory1Click
      end
      object Memorylist1: TMenuItem
        Caption = 'Memory list'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Clearvariables1: TMenuItem
        Caption = 'Clear variables'
        OnClick = Clearvariables1Click
      end
      object Variablelist1: TMenuItem
        Caption = 'Variable list'
        OnClick = Variablelist1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ShowHidelog1: TMenuItem
        Caption = 'Show/Hide log'
        ShortCut = 115
        OnClick = ShowHidelog1Click
      end
    end
    object Cofiguration1: TMenuItem
      Caption = 'Cofiguration'
      object Setup1: TMenuItem
        Caption = 'Setup'
        OnClick = Setup1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Language1: TMenuItem
        Caption = 'Language'
      end
    end
    object Mode1: TMenuItem
      Caption = 'Mode'
      object N2D3Dplotter1: TMenuItem
        Caption = '2D/3D plotter'
        OnClick = N2D3Dplotter1Click
      end
      object IntegralComputer1: TMenuItem
        Caption = 'Integral computer'
        Enabled = False
        OnClick = IntegralComputer1Click
      end
      object Numercialrowcomputer1: TMenuItem
        Caption = 'Numercial row computer'
        OnClick = Numercialrowcomputer1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Help2: TMenuItem
        Caption = 'Help'
        ShortCut = 112
        OnClick = Help2Click
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object dlgSave: TSaveDialog
    Filter = 'ACM files (*.acm)|*.ACM'
    Title = 'Save calc state to file'
    Left = 48
    Top = 64
  end
  object dlgOpen: TOpenDialog
    Filter = 'ACM files (*.acm)|*.ACM'
    Title = 'Load calc state'
    Left = 80
    Top = 64
  end
  object Tray: TTrayIcon
    Hint = '[Atomic Calculator]'
    PopupMenu = TrayMenu
    OnDblClick = TrayDblClick
    Left = 112
    Top = 64
  end
  object TrayMenu: TPopupMenu
    Left = 144
    Top = 64
    object Restore1: TMenuItem
      Tag = 1
      Caption = 'Restore'
      OnClick = Exit2Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Exit2: TMenuItem
      Tag = 2
      Caption = 'Exit'
      OnClick = Exit2Click
    end
  end
  object pmMemFunc: TPopupMenu
    OnPopup = pmMemFuncPopup
    Left = 176
    Top = 64
    object Cut1: TMenuItem
      Tag = 1
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = Selectall1Click
    end
    object Copy2: TMenuItem
      Tag = 2
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = Selectall1Click
    end
    object Paste2: TMenuItem
      Tag = 3
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = Selectall1Click
    end
    object Delete1: TMenuItem
      Tag = 4
      Caption = 'Delete'
      OnClick = Selectall1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Selectall1: TMenuItem
      Tag = 5
      Caption = 'Select all'
      ShortCut = 16449
      OnClick = Selectall1Click
    end
  end
  object amHotKeys: TActionManager
    Left = 208
    Top = 64
    StyleName = 'Platform Default'
    object CalculateAction: TAction
      Caption = 'Calculate'
      OnExecute = CalculateActionExecute
    end
    object ReturnAction: TAction
      Caption = 'Return'
      OnExecute = ReturnActionExecute
    end
  end
end
