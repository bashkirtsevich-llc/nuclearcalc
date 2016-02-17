object wndDebugger: TwndDebugger
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '[AC]-Debugger'
  ClientHeight = 473
  ClientWidth = 713
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
    Left = 495
    Top = 73
    Width = 1
    Height = 381
    Cursor = crSizeWE
    Align = alRight
    ResizeStyle = rsUpdate
    ExplicitLeft = 526
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 454
    Width = 713
    Height = 19
    Panels = <
      item
        Width = 170
      end
      item
        Width = 200
      end>
  end
  object pnlImportantInfo: TPanel
    Left = 496
    Top = 73
    Width = 217
    Height = 381
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 296
      Width = 217
      Height = 1
      Cursor = crSizeNS
      Align = alBottom
      ResizeStyle = rsUpdate
      ExplicitTop = 282
      ExplicitWidth = 185
    end
    object lbCalcDebug: TListBox
      Left = 0
      Top = 0
      Width = 217
      Height = 296
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
    end
    object lbCalcVars: TListBox
      Left = 0
      Top = 297
      Width = 217
      Height = 84
      Align = alBottom
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
    end
  end
  object pnlCode: TPanel
    Left = 0
    Top = 73
    Width = 495
    Height = 381
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object spl2: TSplitter
      Left = 0
      Top = 296
      Width = 495
      Height = 1
      Cursor = crSizeNS
      Align = alBottom
      ResizeStyle = rsUpdate
      ExplicitTop = 282
      ExplicitWidth = 527
    end
    object lbCode: TListBox
      Left = 0
      Top = 0
      Width = 495
      Height = 296
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
    end
    object lbInterpreterDebug: TListBox
      Left = 0
      Top = 297
      Width = 495
      Height = 84
      Align = alBottom
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
    end
  end
  object barMain: TCoolBar
    Left = 0
    Top = 0
    Width = 713
    Height = 73
    Bands = <
      item
        Control = tbDebug
        ImageIndex = -1
        MinHeight = 69
        Width = 707
      end>
    object tbDebug: TToolBar
      Left = 11
      Top = 0
      Width = 698
      Height = 69
      ButtonHeight = 68
      ButtonWidth = 55
      Caption = 'tbDebug'
      Images = frmMain.ToolBarIcons
      ShowCaptions = True
      TabOrder = 0
      object btnStepInto: TToolButton
        Left = 0
        Top = 0
        Caption = 'Step into'
        ImageIndex = 5
        OnClick = btnStepIntoClick
      end
      object btnStepOver: TToolButton
        Left = 55
        Top = 0
        Caption = 'Step over'
        ImageIndex = 5
        OnClick = btnStepOverClick
      end
      object btnStop: TToolButton
        Left = 110
        Top = 0
        Caption = 'Stop'
        ImageIndex = 6
        OnClick = btnStopClick
      end
      object btnRun: TToolButton
        Left = 165
        Top = 0
        Caption = 'Continue'
        ImageIndex = 3
        OnClick = btnRunClick
      end
    end
  end
end
