object dlgSetup: TdlgSetup
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Setup'
  ClientHeight = 321
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 445
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 526
    Top = 288
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object S: TPageControl
    Left = 167
    Top = 8
    Width = 434
    Height = 274
    ActivePage = tsGeneral
    TabOrder = 2
    object tsGeneral: TTabSheet
      Caption = 'General'
      object lbModules: TLabel
        Left = 8
        Top = 3
        Width = 43
        Height = 13
        Caption = 'Modules:'
      end
      object clbModulesList: TCheckListBox
        Left = 8
        Top = 22
        Width = 409
        Height = 211
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object tsApplication: TTabSheet
      Caption = 'Application'
      ImageIndex = 1
      object gbAppConfig: TGroupBox
        Left = 3
        Top = 3
        Width = 414
        Height = 118
        Caption = 'Application config'
        TabOrder = 0
        object lbAppTitle: TLabel
          Left = 9
          Top = 16
          Width = 77
          Height = 13
          Caption = 'Application title:'
        end
        object lbAppIcon: TLabel
          Left = 9
          Top = 59
          Width = 78
          Height = 13
          Caption = 'Application icon:'
        end
        object edAppTitle: TEdit
          Left = 8
          Top = 32
          Width = 397
          Height = 21
          TabOrder = 0
        end
        object edAppIcon: TEdit
          Left = 9
          Top = 78
          Width = 368
          Height = 21
          TabOrder = 1
        end
        object btnBrowsIco: TButton
          Left = 384
          Top = 78
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 2
          OnClick = btnBrowsIcoClick
        end
      end
      object gbOutputName: TGroupBox
        Left = 3
        Top = 127
        Width = 414
        Height = 58
        Caption = 'Output file name'
        TabOrder = 1
        object edOutName: TEdit
          Left = 9
          Top = 24
          Width = 396
          Height = 21
          TabOrder = 0
        end
      end
    end
    object tsProtection: TTabSheet
      Caption = 'Protection'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 28
      object cbEnableProtection: TCheckBox
        Left = 8
        Top = 8
        Width = 409
        Height = 17
        Caption = 'Enable protecton (used UPX after building)'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbUsePassword: TCheckBox
        Left = 8
        Top = 31
        Width = 409
        Height = 17
        Caption = 'Set password'
        TabOrder = 1
        OnClick = cbUsePasswordClick
      end
      object lePassword: TLabeledEdit
        Left = 8
        Top = 72
        Width = 409
        Height = 21
        EditLabel.Width = 50
        EditLabel.Height = 13
        EditLabel.Caption = 'Password:'
        Enabled = False
        PasswordChar = '*'
        TabOrder = 2
      end
      object leConfirm: TLabeledEdit
        Left = 8
        Top = 112
        Width = 409
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Confirm password:'
        Enabled = False
        PasswordChar = '*'
        TabOrder = 3
      end
    end
  end
  object tvCategories: TTreeView
    Left = 8
    Top = 8
    Width = 153
    Height = 274
    Indent = 19
    TabOrder = 3
    OnClick = tvCategoriesClick
    Items.NodeData = {
      03020000002C0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000
      00000000000107470065006E006500720061006C003400000000000000000000
      00FFFFFFFFFFFFFFFFFFFFFFFF0000000001000000010B4100700070006C0069
      0063006100740069006F006E00320000000000000000000000FFFFFFFFFFFFFF
      FFFFFFFFFF0000000000000000010A500072006F00740065006300740069006F
      006E00}
  end
  object dlgOpen: TOpenDialog
    Left = 8
    Top = 8
  end
end
