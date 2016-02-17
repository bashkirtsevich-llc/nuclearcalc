object wndCode: TwndCode
  Left = 0
  Top = 0
  ActiveControl = reCode
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Code editor'
  ClientHeight = 441
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 0
    Top = 324
    Width = 700
    Height = 1
    Cursor = crSizeNS
    Align = alBottom
    ResizeStyle = rsUpdate
    ExplicitTop = 342
  end
  object lbLog: TListBox
    Left = 0
    Top = 325
    Width = 700
    Height = 97
    Align = alBottom
    ItemHeight = 13
    TabOrder = 0
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 422
    Width = 700
    Height = 19
    Panels = <
      item
        Text = 'Ready'
        Width = 110
      end
      item
        Text = 'Hash code'
        Width = 50
      end>
  end
  object tsProjects: TTabSet
    Left = 0
    Top = 0
    Width = 700
    Height = 21
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    PopupMenu = pmTabs
    SoftTop = True
    Style = tsSoftTabs
    Tabs.Strings = (
      'Unit0.acs')
    TabIndex = 0
    TabPosition = tpTop
    OnChange = tsProjectsChange
    OnMouseDown = tsProjectsMouseDown
  end
  object reCode: TRichEdit
    Left = 0
    Top = 21
    Width = 700
    Height = 303
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    PopupMenu = pmEditorContext
    ScrollBars = ssBoth
    TabOrder = 3
    WantTabs = True
    WordWrap = False
    OnKeyPress = reCodeKeyPress
  end
  object pmEditorContext: TPopupMenu
    Images = frmMain.imglistMenu
    OnPopup = pmEditorContextPopup
    Left = 8
    Top = 32
    object Undo1: TMenuItem
      Tag = 1
      Caption = 'Undo'
      ShortCut = 16474
      OnClick = Find1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Cut1: TMenuItem
      Tag = 2
      Caption = 'Cut'
      ImageIndex = 5
      ShortCut = 16472
      OnClick = Find1Click
    end
    object Copy1: TMenuItem
      Tag = 3
      Caption = 'Copy'
      ImageIndex = 4
      ShortCut = 16451
      OnClick = Find1Click
    end
    object Paste1: TMenuItem
      Tag = 4
      Caption = 'Paste'
      ImageIndex = 6
      ShortCut = 16470
      OnClick = Find1Click
    end
    object Delete1: TMenuItem
      Tag = 5
      Caption = 'Delete'
      ImageIndex = 7
      OnClick = Find1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Selectall1: TMenuItem
      Tag = 6
      Caption = 'Select all'
      ImageIndex = 8
      ShortCut = 16449
      OnClick = Find1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Readonly1: TMenuItem
      Tag = 7
      Caption = 'Read only'
      OnClick = Find1Click
    end
    object Find1: TMenuItem
      Tag = 8
      Caption = 'Find'
      ShortCut = 16454
      OnClick = Find1Click
    end
  end
  object dlgFind: TFindDialog
    Options = [frDown, frHideUpDown, frDisableUpDown, frDisableWholeWord, frWholeWord]
    OnFind = dlgFindFind
    Left = 40
    Top = 32
  end
  object pmTabs: TPopupMenu
    Left = 72
    Top = 32
    object Newtab1: TMenuItem
      Tag = 1
      Caption = 'New tab'
      OnClick = Closetab1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Closetab1: TMenuItem
      Tag = 2
      Caption = 'Close tab'
      OnClick = Closetab1Click
    end
  end
end
