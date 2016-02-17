object wndVariables: TwndVariables
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Variables'
  ClientHeight = 386
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvVars: TListView
    Left = 0
    Top = 0
    Width = 215
    Height = 351
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
      end
      item
        Caption = 'Value'
        Width = 110
      end>
    ReadOnly = True
    RowSelect = True
    PopupMenu = pmEditVars
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnPlace: TPanel
    Left = 0
    Top = 351
    Width = 215
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnAdd: TSpeedButton
      Left = 8
      Top = 6
      Width = 53
      Height = 22
      Caption = 'Add'
      OnClick = btnAddClick
    end
    object btnDel: TSpeedButton
      Left = 67
      Top = 6
      Width = 53
      Height = 22
      Caption = 'Delete'
      OnClick = btnDelClick
    end
    object btnClear: TSpeedButton
      Left = 126
      Top = 6
      Width = 53
      Height = 22
      Caption = 'Clear'
      OnClick = btnClearClick
    end
  end
  object pmEditVars: TPopupMenu
    Left = 16
    Top = 40
    object Addvariable1: TMenuItem
      Caption = 'Add variable'
      OnClick = btnAddClick
    end
    object Deletevariable1: TMenuItem
      Caption = 'Delete variable'
      OnClick = btnDelClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = btnClearClick
    end
  end
end
