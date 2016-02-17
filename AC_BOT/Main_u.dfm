object wndMain: TwndMain
  Left = 0
  Top = 0
  Caption = '[AC]'
  ClientHeight = 437
  ClientWidth = 753
  Color = clBtnFace
  Constraints.MinHeight = 451
  Constraints.MinWidth = 679
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 217
    Top = 0
    Height = 418
    ExplicitLeft = 256
    ExplicitTop = 264
    ExplicitHeight = 100
  end
  object tvMenu: TTreeView
    Left = 0
    Top = 0
    Width = 217
    Height = 418
    Align = alLeft
    HotTrack = True
    Images = icons
    Indent = 35
    ReadOnly = True
    TabOrder = 0
    OnChange = tvMenuChange
    OnClick = tvMenuClick
    Items.NodeData = {
      0101000000210000000000000000000000FFFFFFFFFFFFFFFF00000000040000
      00045B00410043005D002D0000000100000001000000FFFFFFFFFFFFFFFF0000
      0000030000000A43006F006E006E0065006300740069006F006E001F00000002
      00000002000000FFFFFFFFFFFFFFFF0000000000000000034900430051002500
      00000300000003000000FFFFFFFFFFFFFFFF0000000000000000064A00610062
      00620065007200310000000400000004000000FFFFFFFFFFFFFFFF0000000000
      0000000C500072006F0078007900200063006F006E0066006900670037000000
      0500000005000000FFFFFFFFFFFFFFFF00000000000000000F4D006500730073
      006100670065002000730065006E00640069006E006700270000000600000006
      000000FFFFFFFFFFFFFFFF0000000000000000074F007000740069006F006E00
      7300270000000700000007000000FFFFFFFFFFFFFFFF00000000030000000748
      006900730074006F0072007900290000000800000008000000FFFFFFFFFFFFFF
      FF00000000000000000843006F006E0074006100630074007300250000000900
      000009000000FFFFFFFFFFFFFFFF00000000000000000652006F007300740065
      0072002F0000000A0000000A000000FFFFFFFFFFFFFFFF00000000000000000B
      4D0065007300730061006700650020006C006F006700}
  end
  object pcMain: TPageControl
    Left = 220
    Top = 0
    Width = 533
    Height = 418
    ActivePage = tsMain
    Align = alClient
    HotTrack = True
    TabOrder = 1
    object tsMain: TTabSheet
      Caption = '[AC]'
      object Main_bunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object bevMain: TBevel
        Left = 0
        Top = 65
        Width = 525
        Height = 2
        Align = alTop
        Shape = bsSpacer
      end
      object imgMain: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbMainPage: TLabel
        Left = 54
        Top = 16
        Width = 365
        Height = 25
        Caption = '[Atomic Calculator] - "Bot version"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lvMain: TListView
        Left = 0
        Top = 67
        Width = 525
        Height = 323
        Align = alClient
        Columns = <>
        HotTrackStyles = [htHandPoint]
        LargeImages = icons
        TabOrder = 0
        OnDblClick = lvMainDblClick
        OnKeyDown = lvMainKeyDown
      end
    end
    object tsConnection: TTabSheet
      Caption = 'Connection'
      ImageIndex = 1
      object Connection_bunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object bev1: TBevel
        Left = 0
        Top = 65
        Width = 525
        Height = 2
        Align = alTop
        Shape = bsSpacer
      end
      object imgConnection: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbConnection: TLabel
        Left = 54
        Top = 16
        Width = 117
        Height = 25
        Caption = 'Connection'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lvConnection: TListView
        Left = 0
        Top = 67
        Width = 525
        Height = 323
        Align = alClient
        Columns = <>
        HotTrackStyles = [htHandPoint]
        LargeImages = icons
        TabOrder = 0
        OnDblClick = lvConnectionDblClick
        OnKeyDown = lvConnectionKeyDown
      end
    end
    object tsICQ: TTabSheet
      Caption = 'ICQ configuration'
      ImageIndex = 2
      DesignSize = (
        525
        390)
      object ICQ_bunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 2
      end
      object imgICQ: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbICQ: TLabel
        Left = 54
        Top = 16
        Width = 178
        Height = 25
        Caption = 'ICQ - Connection'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbICQ2: TLabel
        Left = 56
        Top = 40
        Width = 214
        Height = 13
        Caption = 'Some parameters for work with ICQ protocol'
      end
      object gbICQlogin: TGroupBox
        Left = 3
        Top = 71
        Width = 519
        Height = 105
        Anchors = [akLeft, akTop, akRight]
        Caption = 'ICQ login'
        TabOrder = 3
        DesignSize = (
          519
          105)
        object lbUIN: TLabel
          Left = 16
          Top = 32
          Width = 22
          Height = 13
          Caption = 'UIN:'
        end
        object lbICQpassword: TLabel
          Left = 16
          Top = 72
          Width = 50
          Height = 13
          Caption = 'Password:'
        end
        object cbUIN: TComboBox
          Left = 72
          Top = 24
          Width = 433
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 0
          Text = '565825863'
          OnSelect = cbUINSelect
        end
        object edPassword: TEdit
          Left = 72
          Top = 64
          Width = 433
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          PasswordChar = '*'
          TabOrder = 1
          Text = 'A10c8RwZ'
        end
      end
      object btnICQConnect: TButton
        Left = 285
        Top = 362
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Connect'
        TabOrder = 0
        OnClick = btnICQConnectClick
      end
      object btnICQDisconnect: TButton
        Left = 366
        Top = 362
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Disconnect'
        Enabled = False
        TabOrder = 1
        OnClick = btnICQDisconnectClick
      end
      object btnICQApply: TButton
        Left = 447
        Top = 362
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Apply'
        TabOrder = 2
      end
    end
    object tsJabber: TTabSheet
      Caption = 'Jabber configuration'
      ImageIndex = 3
      DesignSize = (
        525
        390)
      object Jabber_bunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object imgJabber: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbJabber: TLabel
        Left = 54
        Top = 16
        Width = 209
        Height = 25
        Caption = 'Jabber - Connection'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbJabber2: TLabel
        Left = 56
        Top = 40
        Width = 265
        Height = 13
        Caption = 'Some parameters for work with XMPP (Jabber) protocol'
      end
      object gbJabberLogin: TGroupBox
        Left = 3
        Top = 71
        Width = 519
        Height = 130
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Jabber login'
        TabOrder = 3
        DesignSize = (
          519
          130)
        object lbJID: TLabel
          Left = 16
          Top = 29
          Width = 20
          Height = 13
          Caption = 'JID:'
        end
        object lbDomain: TLabel
          Left = 16
          Top = 64
          Width = 39
          Height = 13
          Caption = 'Domain:'
        end
        object lbJabberPass: TLabel
          Left = 16
          Top = 100
          Width = 50
          Height = 13
          Caption = 'Password:'
        end
        object cbDomain: TComboBox
          Left = 104
          Top = 56
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 0
          Text = 'jabber.ru'
          Items.Strings = (
            'jabber.ru'
            'jabbus.org'
            'qip.ru')
        end
        object edJabberPassword: TEdit
          Left = 104
          Top = 92
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          PasswordChar = '*'
          TabOrder = 1
          Text = 'MaZ1420Ljrrp'
        end
        object edJID: TComboBox
          Left = 104
          Top = 26
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 2
          Text = 'atomic_calculator'
          OnSelect = edJIDSelect
        end
      end
      object btnJabberConnect: TButton
        Left = 285
        Top = 362
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Connect'
        TabOrder = 0
        OnClick = btnJabberConnectClick
      end
      object btnJabberDisconnect: TButton
        Left = 366
        Top = 362
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Disconnect'
        Enabled = False
        TabOrder = 1
        OnClick = btnJabberDisconnectClick
      end
      object btnJabberApply: TButton
        Left = 447
        Top = 362
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Apply'
        TabOrder = 2
      end
    end
    object tsProxy: TTabSheet
      Caption = 'Proxy config'
      ImageIndex = 4
      DesignSize = (
        525
        390)
      object s: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object imgProxy: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbProxy: TLabel
        Left = 54
        Top = 16
        Width = 196
        Height = 25
        Caption = 'PROXY Connection'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 56
        Top = 40
        Width = 230
        Height = 13
        Caption = 'Some parameters for connect with proxy server'
      end
      object gbProxy: TGroupBox
        Left = 3
        Top = 94
        Width = 519
        Height = 234
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Proxy'
        Enabled = False
        TabOrder = 1
        DesignSize = (
          519
          234)
        object lbProxyType: TLabel
          Left = 16
          Top = 27
          Width = 57
          Height = 13
          Caption = 'Proxy type:'
          Enabled = False
        end
        object lbProxyAddress: TLabel
          Left = 16
          Top = 64
          Width = 43
          Height = 13
          Caption = 'Address:'
          Enabled = False
        end
        object lbProxyPort: TLabel
          Left = 16
          Top = 99
          Width = 24
          Height = 13
          Caption = 'Port:'
          Enabled = False
        end
        object lbUserName: TLabel
          Left = 16
          Top = 157
          Width = 55
          Height = 13
          Caption = 'User name:'
          Enabled = False
        end
        object lbUserPassword: TLabel
          Left = 16
          Top = 195
          Width = 50
          Height = 13
          Caption = 'Password:'
          Enabled = False
        end
        object cbProxyType: TComboBox
          Left = 104
          Top = 24
          Width = 401
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'NONE'
          Items.Strings = (
            'NONE'
            'HTTP'
            'HTTPS'
            'SOCKS5'
            'SOCKS6')
        end
        object edAddress: TEdit
          Left = 104
          Top = 61
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          TabOrder = 1
        end
        object edPort: TEdit
          Left = 104
          Top = 96
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          OnKeyPress = edPortKeyPress
        end
        object cbAuthentificate: TCheckBox
          Left = 104
          Top = 131
          Width = 401
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Authentification'
          Enabled = False
          TabOrder = 3
          OnClick = cbAuthentificateClick
        end
        object edUserName: TEdit
          Left = 104
          Top = 154
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          TabOrder = 4
        end
        object edUserPassword: TEdit
          Left = 104
          Top = 192
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          PasswordChar = '*'
          TabOrder = 5
        end
      end
      object btnProxyApply: TButton
        Left = 447
        Top = 362
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Apply'
        TabOrder = 0
        OnClick = btnProxyApplyClick
      end
      object cbEnableProxy: TCheckBox
        Left = 3
        Top = 71
        Width = 519
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Enable proxy'
        TabOrder = 2
        OnClick = cbEnableProxyClick
      end
    end
    object tsMsgSending: TTabSheet
      Caption = 'Message sending'
      ImageIndex = 5
      DesignSize = (
        525
        390)
      object MsgBunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object imgMsgSending: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbMessage: TLabel
        Left = 54
        Top = 16
        Width = 179
        Height = 25
        Caption = 'Message delivery'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMessage2: TLabel
        Left = 56
        Top = 40
        Width = 219
        Height = 13
        Caption = 'Message delivery with Jabber or ICQ protocol'
      end
      object gbMessage: TGroupBox
        Left = 3
        Top = 71
        Width = 519
        Height = 316
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Message'
        TabOrder = 0
        DesignSize = (
          519
          316)
        object lbHost: TLabel
          Left = 13
          Top = 27
          Width = 59
          Height = 13
          Caption = 'UIN/Jabber:'
        end
        object lbMessageText: TLabel
          Left = 13
          Top = 53
          Width = 46
          Height = 13
          Caption = 'Message:'
        end
        object edDestination: TEdit
          Left = 78
          Top = 24
          Width = 348
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object cbDeliveryType: TComboBox
          Left = 432
          Top = 24
          Width = 73
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = 'ICQ'
          Items.Strings = (
            'ICQ'
            'Jabber')
        end
        object memMsg: TMemo
          Left = 13
          Top = 72
          Width = 492
          Height = 197
          Anchors = [akLeft, akTop, akRight, akBottom]
          ScrollBars = ssVertical
          TabOrder = 2
        end
        object btnSend: TButton
          Left = 430
          Top = 280
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Send'
          TabOrder = 3
          OnClick = btnSendClick
        end
        object cbAutoClear: TCheckBox
          Left = 13
          Top = 284
          Width = 411
          Height = 17
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Clear after send'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
      end
    end
    object tsConfig: TTabSheet
      Caption = 'Configurations'
      ImageIndex = 6
      DesignSize = (
        525
        390)
      object Config_bunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object imgConfig: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbConfig: TLabel
        Left = 54
        Top = 16
        Width = 154
        Height = 25
        Caption = 'Configurations'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbConfig2: TLabel
        Left = 56
        Top = 40
        Width = 87
        Height = 13
        Caption = 'Bot configurations'
      end
      object pcConfig: TPageControl
        Left = 3
        Top = 71
        Width = 519
        Height = 316
        ActivePage = tsICQconfig
        Anchors = [akLeft, akTop, akRight, akBottom]
        HotTrack = True
        TabOrder = 0
        object tsICQconfig: TTabSheet
          Caption = 'ICQ config'
          DesignSize = (
            511
            288)
          object lbICQAccount: TLabel
            Left = 9
            Top = 19
            Width = 43
            Height = 13
            Caption = 'Account:'
          end
          object cbAccount: TComboBox
            Left = 64
            Top = 16
            Width = 433
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbAccountChange
          end
          object gbAccount: TGroupBox
            Left = 9
            Top = 43
            Width = 488
            Height = 126
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Account'
            TabOrder = 1
            DesignSize = (
              488
              126)
            object lbAccUIN: TLabel
              Left = 16
              Top = 24
              Width = 22
              Height = 13
              Caption = 'UIN:'
            end
            object lbAccPass: TLabel
              Left = 16
              Top = 59
              Width = 50
              Height = 13
              Caption = 'Password:'
            end
            object edAccUIN: TEdit
              Left = 71
              Top = 21
              Width = 402
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edAccPass: TEdit
              Left = 72
              Top = 56
              Width = 401
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              MaxLength = 8
              PasswordChar = '*'
              TabOrder = 3
            end
            object btnAddUIN: TButton
              Left = 317
              Top = 87
              Width = 75
              Height = 25
              Anchors = [akTop, akRight]
              Caption = 'Add'
              TabOrder = 0
              OnClick = btnAddUINClick
            end
            object btnAccSave: TButton
              Left = 398
              Top = 87
              Width = 75
              Height = 25
              Anchors = [akTop, akRight]
              Caption = 'Save'
              TabOrder = 1
              OnClick = btnAccSaveClick
            end
          end
        end
        object tsJabberConfig: TTabSheet
          Caption = 'Jabber config'
          ImageIndex = 1
          DesignSize = (
            511
            288)
          object lbJabberAcc: TLabel
            Left = 9
            Top = 19
            Width = 43
            Height = 13
            Caption = 'Account:'
          end
          object cbJabberAccount: TComboBox
            Left = 64
            Top = 16
            Width = 433
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbJabberAccountChange
          end
          object gbJabber: TGroupBox
            Left = 9
            Top = 43
            Width = 488
            Height = 126
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Account'
            TabOrder = 1
            DesignSize = (
              488
              126)
            object lbAccJID: TLabel
              Left = 16
              Top = 24
              Width = 20
              Height = 13
              Caption = 'JID:'
            end
            object edAccPassJabber: TLabel
              Left = 16
              Top = 59
              Width = 50
              Height = 13
              Caption = 'Password:'
            end
            object edAccJid: TEdit
              Left = 71
              Top = 21
              Width = 402
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edAccJabberPass: TEdit
              Left = 71
              Top = 56
              Width = 402
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              PasswordChar = '*'
              TabOrder = 3
            end
            object btnSaveAcc: TButton
              Left = 398
              Top = 87
              Width = 75
              Height = 25
              Anchors = [akTop, akRight]
              Caption = 'Save'
              TabOrder = 1
              OnClick = btnSaveAccClick
            end
            object btnAddJabber: TButton
              Left = 317
              Top = 87
              Width = 75
              Height = 25
              Anchors = [akTop, akRight]
              Caption = 'Add'
              TabOrder = 0
              OnClick = btnAddJabberClick
            end
          end
        end
        object tsServiceConfig: TTabSheet
          Caption = 'Service config'
          ImageIndex = 3
          DesignSize = (
            511
            288)
          object cbBotAvailable: TCheckBox
            Left = 9
            Top = 15
            Width = 488
            Height = 17
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Bot is not available'
            TabOrder = 0
            OnClick = cbBotAvailableClick
          end
          object gbGeneral: TGroupBox
            Left = 9
            Top = 38
            Width = 488
            Height = 91
            Anchors = [akLeft, akTop, akRight]
            Caption = 'General'
            TabOrder = 1
            DesignSize = (
              488
              91)
            object btnOpenCore: TSpeedButton
              Left = 456
              Top = 24
              Width = 21
              Height = 21
              Anchors = [akTop, akRight]
              Caption = '...'
              OnClick = btnOpenCoreClick
            end
            object lbCorePath: TLabel
              Left = 13
              Top = 27
              Width = 27
              Height = 13
              Caption = 'Core:'
            end
            object lbCoreInfo: TLabel
              Left = 48
              Top = 48
              Width = 44
              Height = 13
              Caption = 'Core info'
            end
            object edCorePath: TEdit
              Left = 46
              Top = 24
              Width = 404
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnKeyDown = edCorePathKeyDown
            end
          end
          object gbHistory: TGroupBox
            Left = 9
            Top = 135
            Width = 488
            Height = 106
            Anchors = [akLeft, akTop, akRight]
            Caption = 'History'
            TabOrder = 2
            DesignSize = (
              488
              106)
            object cbSaveHistory: TCheckBox
              Left = 13
              Top = 24
              Width = 464
              Height = 17
              Anchors = [akLeft, akTop, akRight]
              Caption = 'Automatically load and save history'
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = cbSaveHistoryClick
            end
            object cbSaveLoadContactList: TCheckBox
              Left = 13
              Top = 47
              Width = 464
              Height = 17
              Anchors = [akLeft, akTop, akRight]
              Caption = 'Automatically load and save contac tlist'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = cbSaveLoadContactListClick
            end
            object cbSaveLoadRoster: TCheckBox
              Left = 13
              Top = 70
              Width = 464
              Height = 17
              Anchors = [akLeft, akTop, akRight]
              Caption = 'Automatically load and save roster list'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = cbSaveLoadRosterClick
            end
          end
        end
      end
    end
    object tsHistory: TTabSheet
      Caption = 'History'
      ImageIndex = 7
      object Shape4: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object imgHistory: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbHistory: TLabel
        Left = 54
        Top = 16
        Width = 288
        Height = 25
        Caption = 'Message history && contacts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbHistory2: TLabel
        Left = 56
        Top = 40
        Width = 254
        Height = 13
        Caption = 'Messages history and ICQ contact list, and roster list'
      end
      object bev3: TBevel
        Left = 0
        Top = 65
        Width = 525
        Height = 2
        Align = alTop
        Shape = bsSpacer
      end
      object lvHistoryMenu: TListView
        Left = 0
        Top = 67
        Width = 525
        Height = 323
        Align = alClient
        Columns = <>
        HotTrackStyles = [htHandPoint]
        LargeImages = icons
        TabOrder = 0
        OnDblClick = lvHistoryMenuDblClick
        OnKeyDown = lvHistoryMenuKeyDown
      end
    end
    object tsContactList: TTabSheet
      Caption = 'Contact list'
      ImageIndex = 8
      object ContactList_bunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object imgContact: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object ICQcontact: TLabel
        Left = 54
        Top = 16
        Width = 163
        Height = 25
        Caption = 'ICQ contact list'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ICQcontact2: TLabel
        Left = 56
        Top = 40
        Width = 74
        Height = 13
        Caption = 'ICQ contact list'
      end
      object bev4: TBevel
        Left = 0
        Top = 65
        Width = 525
        Height = 2
        Align = alTop
        Shape = bsSpacer
      end
      object lvContact: TListView
        Left = 0
        Top = 67
        Width = 525
        Height = 323
        Align = alClient
        Columns = <
          item
            Caption = 'ICQ'
            Width = 150
          end
          item
            Caption = 'Nick'
            Width = 300
          end>
        ReadOnly = True
        TabOrder = 0
        ViewStyle = vsReport
        OnKeyDown = lvContactKeyDown
      end
    end
    object tsRoster: TTabSheet
      Caption = 'Roster'
      ImageIndex = 9
      object Roster_bunner: TShape
        Left = 0
        Top = 0
        Width = 525
        Height = 65
        Align = alTop
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 65
      end
      object imgRoster: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object lbRoster: TLabel
        Left = 54
        Top = 16
        Width = 69
        Height = 25
        Caption = 'Roster'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbRoster2: TLabel
        Left = 56
        Top = 40
        Width = 81
        Height = 13
        Caption = 'Jabber roster list'
      end
      object bev2: TBevel
        Left = 0
        Top = 65
        Width = 525
        Height = 2
        Align = alTop
        Shape = bsSpacer
      end
      object lvRoster: TListView
        Left = 0
        Top = 67
        Width = 525
        Height = 323
        Align = alClient
        Columns = <
          item
            Caption = 'JID'
            Width = 400
          end>
        ReadOnly = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object tsMessageLog: TTabSheet
      Caption = 'Message log'
      ImageIndex = 10
      object memLog: TMemo
        Left = 0
        Top = 0
        Width = 525
        Height = 390
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 418
    Width = 753
    Height = 19
    Panels = <
      item
        Text = 'Status:'
        Width = 50
      end
      item
        Text = 'Ready'
        Width = 100
      end>
  end
  object icons: TImageList
    Height = 32
    Width = 32
    Left = 16
    Top = 24
    Bitmap = {
      494C01010B000C00040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFEFFFDFDFDFFFBFB
      FBFFFCFCFCFFFDFDFDFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFEFFEBEB
      EBFFC1B4B0FFA78177FFA7624FFFAE5338FFB34D2EFFB74C29FFB84C28FFB84F
      29FFB84C28FFB64B28FFB14C2CFFAB4F34FFA05B48FF9D766BFFADA19EFFD7D7
      D7FFFAFAFAFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFEFFEBEB
      EBFFC1B4B0FFA78177FFA7624FFFAE5338FFB34D2EFFB74C29FFB84C28FFB84F
      29FFB84C28FFB64B28FFB14C2CFFAB4F34FFA05B48FF9D766BFFADA19EFFD7D7
      D7FFFAFAFAFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBFBFBFFF1F1F1FFDFDFDFFFCFCF
      CFFFCFCFCFFFDFDFDFFFEFEFEFFFF7F7F7FFF9F9F9FFF7F7F7FFF6F6F6FFF5F5
      F5FFF7F7F7FFFAFAFAFFFDFDFDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEECECFFB38679FFD250
      22FFF26A27FFF9873BFFFC9B4AFFFDA653FFFEAB57FFFEAD59FFFEAE5AFFFEAE
      5AFFFEAE5AFFFEAD59FFFEAB57FFFDA653FFFC9A4AFFF8853AFFF16725FFCA48
      1CFF96685AFFCFCECEFFFEFEFEFF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEECECFFB38679FFD250
      22FFF26A27FFF9873BFFFC9B4AFFFDA653FFFEAB57FFFEAD59FFFEAE5AFFFEAE
      5AFFFEAE5AFFFEAD59FFFEAB57FFFDA653FFFC9A4AFFF8853AFFF16725FFCA48
      1CFF96685AFFCFCECEFFFEFEFEFF000000000000000000000000000000000000
      00000000000000000000FDFDFDFFF6F6F6FFE3E3E3FFC3C3C3FFA0A0A0FF8A8A
      8AFF898989FF999999FFAFAFAFFFC0C0C0FFC3C3C3FFBEBEBEFFB8B8B8FFB7B7
      B7FFC0C0C0FFD3D3D3FFE9E9E9FFF7F7F7FFFDFDFDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E8E3E2FFCA5D39FFF77B33FFFEA9
      55FFFEAE5AFFFEB05DFFFEB161FFFEB364FFFEB466FFFEB568FFFEB669FFFEB6
      69FFFEB669FFFEB568FFFEB567FFFEB465FFFEB262FFFEB15FFFFEAF5CFFFEA8
      55FFF67630FFB64926FFBDB9B8FFFEFEFEFF0000000000000000000000000000
      000000000000000000000000000000000000E8E3E2FFCA5D39FFF77B33FFFEA9
      55FFFEAE5AFFFEB05DFFFEB161FFFEB364FFFEB466FFFEB568FFFEB669FFFEB6
      69FFFEB669FFFEB568FFFEB567FFFEB465FFFEB262FFFEB15FFFFEAF5CFFFEA8
      55FFF67630FFB64926FFBDB9B8FFFEFEFEFF0000000000000000000000000000
      000000000000FDFDFDFFF2F2F2FFD8D8D8FFB5B5B5FF949494FF808080FF7F7C
      79FF787675FF7C7C7CFF828282FF878787FF888888FF878787FF858585FF8585
      85FF8C8C8CFF9E9E9EFFBABABAFFDADADAFFF1F1F1FFFCFCFCFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFDFFCE6A49FFFA8E43FFFEB05DFFFEB2
      63FFFEB568FFFEB76CFFFEB96FFFFEBA72FFFEBB75FFFEBC76FFE6A97CFF9B6D
      7DFFEBA96FFFFEBC77FFFEBC76FFFEBB74FFFEBA71FFFEB86EFFFEB66AFFFEB4
      65FFFEB160FFF98940FFAD4F30FFE0E0E0FF0000000000000000000000000000
      0000000000000000000000000000FDFDFDFFCE6A49FFFA8E43FFFEB05DFFFEB2
      63FFFEB568FFFEB76CFFFEB96FFFFEBA72FFFEBB75FFFEBC76FFE6A97CFF9B6D
      7DFFEBA96FFFFEBC77FFFEBC76FFFEBB74FFFEBA71FFFEB86EFFFEB66AFFFEB4
      65FFFEB160FFF98940FFAD4F30FFE0E0E0FF0000000000000000000000000000
      0000FCFCFCFFF2F2F2FFD8D8D8FFB4B4B4FF959595FF858585FF7F7D7CFFCAC5
      BEFFC4BFB8FF82807DFF848484FF858585FF868686FF878787FF878787FF8888
      88FF8A8A8AFF8F8F8FFF9F9F9FFFBCBCBCFFDEDEDEFFF5F5F5FFFDFDFDFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E4C9C0FFF6712EFFFEB465FFFEB66BFFFEB9
      71FFFEBC76FFFEBE7AFFFEC07EFFFEC181FFF3BA85FF8566B5FF211BF0FF0000
      D1FF201993FF896276FFF6B97FFFFEC283FFFEC180FFFEBF7CFFFEBD78FFFEBB
      74FFFEB86EFFFEB569FFF16A2BFFA3948FFF0000000000000000000000000000
      0000000000000000000000000000E4C9C0FFF6712EFFFEB465FFFEB66BFFFEB9
      71FFFEBC76FFFEBE7AFFFEC07EFFFEC181FFF3BA85FF8566B5FF211BF0FF0000
      D1FF201993FF896276FFF6B97FFFFEC283FFFEC180FFFEBF7CFFFEBD78FFFEBB
      74FFFEB86EFFFEB569FFF16A2BFFA3948FFF0000000000000000FEFEFEFFFBFB
      FBFFEFEFEFFFD7D7D7FFB8B8B8FF9D9D9DFF8F8F8FFF8A8A8AFFADA7A1FFD9D5
      D0FFDBD7D1FFD3CEC8FF908C89FF909090FF919191FF929292FF939393FF9494
      94FF959595FF979797FFA0A0A0FFB5B5B5FFD3D3D3FFEDEDEDFFFBFBFBFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E39377FFFA9E56FFFEBA73FFFEBD79FFFEC0
      7FFFFEC384FFFEC589FFFEC78DFFFEC990FFD4AA91FF3737C2FF2F2FE5FF0000
      ECFF2828E1FF2A28ACFFE1B08CFFFEC992FFFEC88EFFFEC388FFFEC487FFFEC2
      82FFFEBF7CFFFEBC76FFFA9852FF9F6550FF0000000000000000000000000000
      0000000000000000000000000000E39377FFFA9E56FFFEBA73FFFEBD79FFFEC0
      7FFFFEC384FFFEC589FFFEC78DFFFEC990FFD4AA91FF3737C2FF2F2FE5FF0000
      ECFF2828E1FF2A28ACFFE1B08CFFFEC992FFFEC88EFFFEC388FFFEC487FFFEC2
      82FFFEBF7CFFFEBC76FFFA9852FF9F6550FF00000000FEFEFEFFF9F9F9FFEAEA
      EAFFD2D2D2FFB7B7B7FFA2A2A2FF999999FF969696FF928F8CFFD9D5CFFFDCD9
      D3FFDDDAD4FFDEDAD5FFDBD7D2FFA29D99FF9B9B9AFF979593FF927E69FF956D
      3FFF945D19FF935A14FF955C17FF93642CFFACA69EFFE2E2E2FFF4F4F4FFFCFC
      FCFFFEFEFEFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFEFFF3F3F3FFFCFCFCFFF2835AFFFCB571FFFEBF7EFFFEC487FFFEC7
      8DFFFECA92FFFECC97FFFECE9BFFFED09FFFEDC5A0FF5958C2FF4141D5FF0202
      CBFF2E2ECCFF413BA6FFF2C69CFFFDCEA2FFFDCD9DFFFDC28AFFFDB376FFFBA9
      6BFFFEC68BFFFDBF80FFFCB270FFAF5A3AFF0000000000000000000000000000
      0000FEFEFEFFF3F3F3FFFCFCFCFFF2835AFFFCB571FFFEBF7EFFFEC487FFFEC7
      8DFFFECA92FFFECC97FFFECE9BFFFED09FFFEDC5A0FF5958C2FF4141D5FF0202
      CBFF2E2ECCFF413BA6FFF2C69CFFFDCEA2FFFDCD9DFFFDC28AFFFDB376FFFBA9
      6BFFFEC68BFFFDBF80FFFCB270FFAF5A3AFFFEFEFEFFF8F8F8FFEAEAEAFFD2D2
      D2FFBABABAFFAAAAAAFFA3A3A3FFA1A1A1FF999896FFD0CBC4FFDDD9D4FFD3D0
      CBFFD9D6D1FFE0DDD8FFE0DDD8FFDFDBD6FFC3BDB5FFDDB584FFE7B87AFFEDC1
      87FFCE9A5AFFA96207FFAA6205FFAA6205FFA26110FFB8B4B1FFDFDFDFFFEDED
      EDFFF7F7F7FFFCFCFCFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000828BB1FF2A5EAFFF6478A7FFE17A56FFFEC285FFFABD82FFFECA94FFFECE
      9BFFFED0A1FFFED3A6FFFED5AAFFFED7AEFFFCD8B0FF6F6BD1FF5454FEFF1919
      FAFF4747EDFF564CABFFFDD5ADFFFEDFBAFFFED59FFFFECA8EFFFEBE7BFFFCAC
      6BFFFECD99FFFABE84FFFDBF84FFB55D3AFF0000000000000000000000000000
      0000828BB1FF2A5EAFFF6478A7FFE17A56FFFEC285FFFABD82FFFECA94FFFECE
      9BFFFED0A1FFFED3A6FFFED5AAFFFED7AEFFFCD8B0FF6F6BD1FF5454FEFF1919
      FAFF4747EDFF564CABFFFDD5ADFFFEDFBAFFFED59FFFFECA8EFFFEBE7BFFFCAC
      6BFFFECD99FFFABE84FFFDBF84FFB55D3AFFFDFDFDFFF6F6F6FFE8E8E8FFD4D4
      D4FFC3C3C3FFB7B7B7FFB2B2B2FFAEAEAEFFB4AEA8FFDCD9D3FFDEDAD5FFC3C0
      BCFFB1AEABFFCDCAC6FFE3DFDBFFE3E0DCFFE2DEDAFFD4C9BCFFBB8440FFCC8E
      3CFFE5B578FFC38A44FFB0690DFFB0690DFFB0690DFF987142FFCDCDCDFFDDDD
      DDFFECECECFFF7F7F7FFFDFDFDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000345ABDFF2BABFEFF4292D7FFCE7362FFFECA94FFF7BC86FFFED1A2FFFED4
      A9FFFED7AFFFFEDAB4FFFEDCB9FFFEDEBDFFFEE2C0FF706AB0FF4D4DD9FF2C2C
      E7FF5B5BF3FF6F61B7FFFEE0BEFFFEE2BFFFFEDEADFFD2C989FFFDC98DFFFCB9
      7EFFFED4A7FFF7BD89FFFEC691FFB36343FF0000000000000000000000000000
      0000345ABDFF2BABFEFF4292D7FFCE7362FFFECA94FFF7BC86FFFED1A2FFFED4
      A9FFFED7AFFFFEDAB4FFFEDCB9FFFEDEBDFFFEE2C0FF706AB0FF4D4DD9FF2C2C
      E7FF5B5BF3FF6F61B7FFFEE0BEFFFEE2BFFFFEDEADFFD2C989FFFDC98DFFFCB9
      7EFFFED4A7FFF7BD89FFFEC691FFB36343FFFEFEFEFFFCFCFCFFF6F6F6FFEEEE
      EEFFE3E3E3FFD7D7D7FFCBCBCBFFA5A29EFFDBD7D2FFDFDCD7FFD9D6D1FFBBB8
      B5FFB9B7B3FFBBB9B5FFC2C0BCFFE4E2DEFFE6E3DFFFE5E2DEFFDED7CFFFBE8D
      51FFC48430FFDAAA70FFB4711AFFB67115FFB67115FFB26D15FFB5B1ADFFDFDF
      DFFFEDEDEDFFF7F7F7FFFDFDFDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000345AC2FF2BABFEFF4193DBFFD3877AFFFEC998FFF6BF90FFFDD5ACFFFEDB
      B6FFFEDEBDFFFEE1C2FFFEE3C7FFFEE5CBFFFEE8CFFF8B84C4FF5757DFFF2C2C
      D4FF5050CAFF8374A7FFFEE7CEFFFEE2B9FFFCE0B7FF85C171FFF7CB9DFFFDBE
      90FFFCD5AEFFF7C295FFFDC393FFAB735BFF0000000000000000000000000000
      0000345AC2FF2BABFEFF4193DBFFD3877AFFFEC998FFF6BF90FFFDD5ACFFFEDB
      B6FFFEDEBDFFFEE1C2FFFEE3C7FFFEE5CBFFFEE8CFFF8B84C4FF5757DFFF2C2C
      D4FF5050CAFF8374A7FFFEE7CEFFFEE2B9FFFCE0B7FF85C171FFF7CB9DFFFDBE
      90FFFCD5AEFFF7C295FFFDC393FFAB735BFF0000000000000000FEFEFEFFFDFD
      FDFFF8F8F8FFEEEEEEFFC8C7C6FFD4CEC8FFDFDCD7FFDCD9D4FFB4B2AEFFBAB8
      B4FFC9C7C3FFC4C2BFFFCDCAC7FFBCBAB7FFDEDBD8FFE8E6E2FFE8E6E2FFE4E1
      DCFFC29B6CFFB89365FFC48F4EFFBD7920FFBD791FFFBC781FFFA18B70FFEAEA
      EAFFF5F5F5FFFBFBFBFFFEFEFEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003359C7FF2BABFEFF4293DEFFCDA9A7FFFCB788FFFBD3ACFFF4C5A0FFFEE1
      C3FFFEE5CAFFFEE8D0FFFEEAD5FFFEEDDAFFFEEEDDFFA19CD2FF6666FAFF3636
      FEFF5F5FF3FF9F92BDFFFEEFDEFFFEEBD2FFFEE8CFFFFEE4C9FFFEDFC1FFFED8
      B7FFF3C39FFFFDD8B5FFFBB182FFB09990FF0000000000000000000000000000
      00003359C7FF2BABFEFF4293DEFFCDA9A7FFFCB788FFFBD3ACFFF4C5A0FFFEE1
      C3FFFEE5CAFFFEE8D0FFFEEAD5FFFEEDDAFFFEEEDDFFA19CD2FF6666FAFF3636
      FEFF5F5FF3FF9F92BDFFFEEFDEFFFEEBD2FFFEE8CFFFFEE4C9FFFEDFC1FFFED8
      B7FFF3C39FFFFDD8B5FFFBB182FFB09990FF0000000000000000000000000000
      0000FDFDFDFFF5F5F5FFC1BBB4FFDEDBD6FFE1DED9FFC9C6C2FFADABA8FFC7C5
      C1FFC9C6C3FFD4D1CEFFAFADABFFCBC9C6FFC9C7C4FFD2D0CDFFEBE9E6FFEBE8
      E5FFE8E5E2FFC2BAB1FFC69559FFC58634FFC68530FFC4822BFFB28145FFF2F2
      F2FFFBFBFBFFFEFEFEFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000345BCBFF2CACFEFF4294E1FFE5DFE4FFFA9966FFFEE1C2FFEDBA9AFFFEE8
      D1FFFEEBD8FFFEEEDEFFFEF1E4FFFEF4E8FFFEF6ECFFB3B0D0FF5454CAFF2F2F
      D9FF5353DEFFBCB0CDFFFEF6EEFFFEF5EAFFFEF3E6FFFEF0E1FFFEEDDBFFFEEB
      D5FFEDBB9CFFFEE3C6FFE98D5EFFD9D6D5FF0000000000000000000000000000
      0000345BCBFF2CACFEFF4294E1FFE5DFE4FFFA9966FFFEE1C2FFEDBA9AFFFEE8
      D1FFFEEBD8FFFEEEDEFFFEF1E4FFFEF4E8FFFEF6ECFFB3B0D0FF5454CAFF2F2F
      D9FF5353DEFFBCB0CDFFFEF6EEFFFEF5EAFFFEF3E6FFFEF0E1FFFEEDDBFFFEEB
      D5FFEDBB9CFFFEE3C6FFE98D5EFFD9D6D5FF0000000000000000000000000000
      000000000000C0BCB7FFDAD6D1FFDEDBD6FFE2DFDAFFE4E1DDFFD8D5D2FFBEBC
      B9FFC3C1BEFFCAC8C5FFD3D1CEFFD8D6D3FFBEBCBAFFBDBBB9FFBCBAB8FFE8E6
      E4FFEDEBE8FFE5E3E0FFC69E6CFFCA8D41FFCF9244FFCF9243FFC8893BFFE4E3
      E2FFFEFEFEFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005371CEFF8ECEE1FF5A8FE0FFF0F0F5FFF9A983FFFEDCC0FFF6D6BFFFF1CE
      B9FFFEF2E5FFFEF5ECFFFEF8F2FFFEF7F3FFFEFBF7FFCAC8E6FF4F4FD3FF2525
      CCFF3939B5FFD5CCD8FFFEFAF6FFFEF9F5FFFEFAF5FFFEF7EFFFFEF4E9FFEEC8
      B4FFF9DFCBFFFED9BDFFB68169FFFCFCFCFF0000000000000000000000000000
      00005371CEFF8ECEE1FF5A8FE0FFF0F0F5FFF9A983FFFEDCC0FFF6D6BFFFF1CE
      B9FFFEF2E5FFFEF5ECFFFEF8F2FFFEF7F3FFFEFBF7FFCAC8E6FF4F4FD3FF2525
      CCFF3939B5FFD5CCD8FFFEFAF6FFFEF9F5FFFEFAF5FFFEF7EFFFFEF4E9FFEEC8
      B4FFF9DFCBFFFED9BDFFB68169FFFCFCFCFF0000000000000000000000000000
      0000ECE9E6FFD3CEC7FFCDC9C4FFC8C5C1FFD7D5D1FFE3E0DDFFE7E4E1FFE4E2
      DEFFCFCDCAFFBEBDBAFFC7C6C3FFB5B3B1FFDEDDDAFFBFBDBBFFDEDCDAFFBFBE
      BCFFD8D7D4FFEAE8E6FFC29C6EFFD09D5EFFD69D51FFD69D51FFD49A4FFFC7C1
      B9FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F9FF8A8BA6FFB8B9BBFF757698FFF3F3F3FFFDEBE3FFFBAA80FFFEF1E3FFE3B2
      A0FFFDF7F1FFFEFBF8FFFDECE6FFFCD8C6FFFDDCCDFFE1CDD0FF2625B8FF1112
      BCFF211EAEFFEECEC5FFFEDAC5FFFCC49EFFFDECE4FFFEFBF8FFFBF3EFFFE5B8
      A8FFFEF3E8FFE99B72FFDAD4D2FF00000000000000000000000000000000F9F9
      F9FF8A8BA6FFB8B9BBFF757698FFF3F3F3FFFDEBE3FFFBAA80FFFEF1E3FFE3B2
      A0FFFDF7F1FFFEFBF8FFFDECE6FFFCD8C6FFFDDCCDFFE1CDD0FF2625B8FF1112
      BCFF211EAEFFEECEC5FFFEDAC5FFFCC49EFFFDECE4FFFEFBF8FFFBF3EFFFE5B8
      A8FFFEF3E8FFE99B72FFDAD4D2FF00000000000000000000000000000000FBFB
      FBFFC8C1BAFFCCC5BBFFE5BF8EFFC8B094FFBBB8B4FFD1CFCBFFE3E0DDFFE9E7
      E4FFEBE9E6FFE3E1DFFFBCBAB8FFE1DFDDFFC6C5C3FFD6D5D3FFF0EEECFFF0EF
      ECFFC4C3C1FFD1D0CEFFC5A988FFCB995DFFDEA861FFDEA862FFDDA761FFC5B5
      A1FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFEFFBDBDBDFF7171
      71FF787775FF9F9B96FF777572FF5F5F5FFF9C9C9CFFEEC1AAFFFDD0B7FFF8EC
      E7FFE1B1A6FFFEECE3FFFBD6C4FFFEEDD9FFFAAD8AFFA283AAFF010CDDFF0027
      E5FF010ADBFFB2859DFFFDB489FFFECF9DFFFBBD96FFFEE8DBFFDFAB9EFFFAF0
      ECFFFBC9AEFFBFA89CFFFEFEFEFF0000000000000000FEFEFEFFBDBDBDFF7171
      71FF787775FF9F9B96FF777572FF5F5F5FFF9C9C9CFFEEC1AAFFFDD0B7FFF8EC
      E7FFE1B1A6FFFEECE3FFFBD6C4FFFEEDD9FFFAAD8AFFA283AAFF010CDDFF0027
      E5FF010ADBFFB2859DFFFDB489FFFECF9DFFFBBD96FFFEE8DBFFDFAB9EFFFAF0
      ECFFFBC9AEFFBFA89CFFFEFEFEFF000000000000000000000000FEFEFEFFBDB9
      B5FFC8BEB2FFD8A96EFFDCAF78FFEFC48AFFD6B183FFB9AFA3FFCAC8C5FFE0DE
      DBFFEBE9E6FFEEEDEAFFEDECE9FFEEECEAFFF1F0EEFFD9D8D6FFC8C7C6FFEDEC
      EAFFEAE9E7FFD0CFCDFF988875FFC18D4DFFE6B574FFE7B675FFE7B675FFB6A2
      88FFFBFBFBFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFFB0B0B0FF8B8A89FFCCC0
      B3FFF2E0CCFFF9E5CEFFF1DBC1FFCFB79EFF79746FFF898582FFEFB597FFFDD9
      C5FFE7B6A6FFE79D85FFFDEEE1FFD8D7C9FF7994A0FF347AACFF2D86BAFF2E89
      BAFF257FB5FF2D73A3FF7B9396FFDCC29DFFFDC390FFE39378FFEBB8A4FFFCCE
      B5FFC39D8AFFFBFBFBFF0000000000000000FEFEFEFFB0B0B0FF8B8A89FFCCC0
      B3FFF2E0CCFFF9E5CEFFF1DBC1FFCFB79EFF79746FFF898582FFEFB597FFFDD9
      C5FFE7B6A6FFE79D85FFFDEEE1FFD8D7C9FF7994A0FF347AACFF2D86BAFF2E89
      BAFF257FB5FF2D73A3FF7B9396FFDCC29DFFFDC390FFE39378FFEBB8A4FFFCCE
      B5FFC39D8AFFFBFBFBFF00000000000000000000000000000000DBDAD9FFC1B4
      A4FFC28A43FFCC9B5FFFF5CA8FFFFED396FFFCD194FFE6B980FFBCA387FFC3C1
      BEFFDBD9D7FFEBE9E7FFF1EFEDFFF2F1EFFFF3F2F0FFF4F3F1FFF3F2F0FFF2F1
      F0FFE6E5E3FFD0CFCEFFB0AAA3FFB17A3BFFEDBF84FFEFC387FFEFC387FFD3B2
      8AFFE6E5E4FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DADADAFF8F8F8EFFE3D5C5FFFFEE
      DBFFFFEBD4FFFFE8CFFFFFE5C8FFFFE2C2FFE1BD9AFF7B746FFFB5B1AFFFE9BA
      A1FFFDB78FFFE18C6DFF8BB5CBFF4B9EC9FF61B1D9FF61B2DAFF5EAFD8FF59AB
      D4FF51A5D0FF479ECAFF3994C2FF2C85B3FF909F9AFFE48662FFF8AC81FFC6A6
      95FFFCFCFCFF000000000000000000000000DADADAFF8F8F8EFFE3D5C5FFFFEE
      DBFFFFEBD4FFFFE8CFFFFFE5C8FFFFE2C2FFE1BD9AFF7B746FFFB5B1AFFFE9BA
      A1FFFDB78FFFE18C6DFF8BB5CBFF4B9EC9FF61B1D9FF61B2DAFF5EAFD8FF59AB
      D4FF51A5D0FF479ECAFF3994C2FF2C85B3FF909F9AFFE48662FFF8AC81FFC6A6
      95FFFCFCFCFF00000000000000000000000000000000FBFBFBFFB9A998FFB072
      24FFC39153FFF1C385FFF8CB8BFFF8CB8BFFF8CB8BFFF8CA8BFFEFBF82FFC69E
      6FFFC5BCB3FFDFDEDCFFF0EEECFFF4F3F1FFF5F4F2FFF6F5F3FFF6F6F4FFF7F6
      F5FFF6F5F3FFEEEEECFFDDDCDBFFA9753EFFF1C78EFFF7CF96FFF7CF96FFEDCA
      9DFFE5DFDAFFEEE8E3FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9AFFCFC5BBFFFEEDDAFFFFEA
      D3FFFFE6CAFFFFDFBDFFFFD8AEFFFFD2A4FFFFD0A0FFC79E80FF727272FFFDFD
      FDFFE4D1C7FF728D99FF6CB9E0FF7DC6EAFF7EC7EBFF7EC6EAFF7AC4E8FF75BF
      E5FF6CB9E0FF61B1DAFF54A8D2FF459DC9FF308DBDFF6A7D86FFBAADA6FFFEFE
      FEFF000000000000000000000000000000009A9A9AFFCFC5BBFFFEEDDAFFFFEA
      D3FFFFE6CAFFFFDFBDFFFFD8AEFFFFD2A4FFFFD0A0FFC79E80FF727272FFFDFD
      FDFFE4D1C7FF728D99FF6CB9E0FF7DC6EAFF7EC7EBFF7EC6EAFF7AC4E8FF75BF
      E5FF6CB9E0FF61B1DAFF54A8D2FF459DC9FF308DBDFF6A7D86FFBAADA6FFFEFE
      FEFF0000000000000000000000000000000000000000D7C6B5FFA05F12FFC08D
      50FFE9B775FFEFBD7AFFEFBD7AFFEFBD7AFFEFBD7AFFEFBD7AFFEFBD7AFFECBA
      77FFD4A164FFD2BDA7FFF2F0EFFFF5F4F3FFF6F6F4FFF7F7F5FFF8F7F6FFF8F8
      F7FFF9F8F7FFF2ECE5FFE3D6C7FFA27341FFF4CC96FFFCD7A2FFFCD7A2FFEFC8
      96FFE2C4A0FFE5DDD4FFE6DFD8FFFEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000929292FFEDDCCBFFFFEBD4FFFFE6
      CAFFFFDDB7FFFFD2A3FFFFCD9AFFFFCE9CFFFFD0A1FFE6AF86FF767575FFF3F3
      F3FF84A4B5FF76C1E7FF8ACFF2FF8BD0F3FF8CD0F3FF8CD0F3FF8BCFF2FF89CE
      F1FF84CBEEFF7BC4E9FF6DBAE0FF5DAED7FF4CA2CDFF3390BFFF567384FFF4F4
      F4FF00000000000000000000000000000000929292FFEDDCCBFFFFEBD4FFFFE6
      CAFFFFDDB7FFFFD2A3FFFFCD9AFFFFCE9CFFFFD0A1FFE6AF86FF767575FFF3F3
      F3FF84A4B5FF76C1E7FF8ACFF2FF8BD0F3FF8CD0F3FF8CD0F3FF8BCFF2FF89CE
      F1FF84CBEEFF7BC4E9FF6DBAE0FF5DAED7FF4CA2CDFF3390BFFF567384FFF4F4
      F4FF00000000000000000000000000000000F1ECE8FF956129FFB7864EFFDEA7
      60FFE3AC63FFE3AC64FFE4AD64FFE4AD64FFE4AD64FFE4AD64FFE4AD64FFE0A9
      61FFDDA55FFFD4A266FFE9DBCCFFF7F6F5FFF8F7F6FFF9F8F7FFF9F9F8FFFAF9
      F9FFF9F8F7FFD3AA78FFB47B38FFAE8252FFF9D4A2FFFFDBA9FFFFDBA9FFF6CF
      9AFFE0B279FFE1C3A1FFEBE8E5FFE1D7CFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000989898FFF3E0CBFFFFE8CEFFFFDF
      BCFFFFD1A2FFFFCD9BFFFFD3A6FFFFD8B0FFFFDBB6FFEAB693FF817F7EFFD5D9
      DBFF5AAAD8FF8FD2F5FF91D3F7FF93D4F8FF93D5F8FF93D4F8FF92D4F7FF90D2
      F6FF8DD1F4FF8ACFF2FF83CAEDFF74BFE5FF61B1DAFF4DA3CEFF2D84B4FFAFB2
      B4FF00000000000000000000000000000000989898FFF3E0CBFFFFE8CEFFFFDF
      BCFFFFD1A2FFFFCD9BFFFFD3A6FFFFD8B0FFFFDBB6FFEAB693FF817F7EFFD5D9
      DBFF5AAAD8FF8FD2F5FF91D3F7FF93D4F8FF93D5F8FF93D4F8FF92D4F7FF90D2
      F6FF8DD1F4FF8ACFF2FF83CAEDFF74BFE5FF61B1DAFF4DA3CEFF2D84B4FFAFB2
      B4FF00000000000000000000000000000000DDD3CBFFD1CAC0FFD4BC9FFFD9C1
      A3FFDAC1A2FFD3A775FFD69D55FFD89C4EFFD89C4EFFD89C4EFFD69A4CFFCDB8
      9FFFEBE9E7FFF5F4F2FFF6F6F4FFF8F7F6FFF9F8F8FFFAFAF9FFFBFAFAFFFBFB
      FAFFFCFBFBFFFBF9F8FFF0D5B2FFF9D4A0FFFEDBA9FFFFDCAAFFFFDCAAFFFEDB
      AAFFF5D3A6FFF0EBE3FFECEAE7FFE8E0DAFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A0FFEAD8C5FFFEE4C6FFFFD7
      ADFFFFCC9AFFFFD3A7FFFFDBB7FFFFE1C4FFFFE5CBFFDAA78EFF8B8B8BFF8AAA
      BDFF8BCFF4FF95D6FAFF98D8FBFF9AD9FCFF9BD9FDFF9AD9FDFF99D8FCFF97D7
      FBFF93D5F8FF90D3F6FF8CD0F3FF86CCEFFF76C0E6FF60B1D9FF469ECCFF5F7C
      8EFFFCFCFCFF000000000000000000000000A0A0A0FFEAD8C5FFFEE4C6FFFFD7
      ADFFFFCC9AFFFFD3A7FFFFDBB7FFFFE1C4FFFFE5CBFFDAA78EFF8B8B8BFF8AAA
      BDFF8BCFF4FF95D6FAFF98D8FBFF9AD9FCFF9BD9FDFF9AD9FDFF99D8FCFF97D7
      FBFF93D5F8FF90D3F6FF8CD0F3FF86CCEFFF76C0E6FF60B1D9FF469ECCFF5F7C
      8EFFFCFCFCFF00000000000000000000000000000000F3EFEBFFDDD4CBFFDAD5
      CEFFE2DFDAFFD9C0A4FFCD9857FFCF903DFFCF903DFFCF903DFFCE8F3CFFC3A9
      88FFE3E2E1FFF5F4F2FFF7F6F5FFF9F8F7FFFAF9F9FFFBFBFAFFFCFCFBFFFDFC
      FCFFFDFDFCFFFDFCFCFFFCFCFBFFF6E3CBFFFAD7A6FFFEDDACFFFEDDACFFF7D5
      A6FFF3EBE1FFF1EFEDFFE2DBD3FFFEFDFDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9D9D9FFBEB9B5FFFCD9B6FFFFD2
      A3FFFFCE9DFFFFD8B1FFFFE1C4FFFFEAD5FFF8D1BCFFB89E95FFBABBBCFF6DAA
      D0FF99D9FCFF9DDAFEFFA2DCFEFFA5DEFFFFA7DEFFFFA6DEFFFFA3DDFEFF9FDB
      FEFF9AD9FDFF96D6FAFF91D3F7FF8CD0F3FF85CBEFFF72BDE3FF5AACD5FF4179
      9CFFF2F2F2FF000000000000000000000000D9D9D9FFBEB9B5FFFCD9B6FFFFD2
      A3FFFFCE9DFFFFD8B1FFFFE1C4FFFFEAD5FFF8D1BCFFB89E95FFBABBBCFF6DAA
      D0FF99D9FCFF9DDAFEFFA2DCFEFFA5DEFFFFA7DEFFFFA6DEFFFFA3DDFEFF9FDB
      FEFF9AD9FDFF96D6FAFF91D3F7FF8CD0F3FF85CBEFFF72BDE3FF5AACD5FF4179
      9CFFF2F2F2FF000000000000000000000000000000000000000000000000F7F4
      F2FFE1D9D1FFD8C8B7FFC59154FFC78530FFC7852EFFC7852EFFC6842EFFBC94
      63FFD7D6D4FFF2F1F0FFF8F7F6FFF9F9F8FFFBFAFAFFFCFCFBFFFDFDFCFFFEFD
      FDFFFEFEFEFFFEFEFDFFFDFDFDFFFCFCFBFFF7EADAFFF8D6A7FFF8D6A7FFF4EA
      DEFFF4F3F2FFEBE8E4FFF2EEEAFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFFB7B7B7FFD6C9BFFFFACA
      A1FFFECC9DFFFED7B3FFFDDCC0FFF2C6AFFFCBA497FFA8A8A8FFF5F8F9FF68B1
      E0FFA0DCFEFFA9DFFEFFAFE1FEFFB4E3FEFFB6E4FEFFB5E3FEFFB1E2FEFFACE0
      FEFFA4DDFEFF9CDAFEFF96D7FAFF91D3F7FF8BCFF3FF80C8ECFF69B7DEFF3E86
      B3FFE9E9E9FF000000000000000000000000FEFEFEFFB7B7B7FFD6C9BFFFFACA
      A1FFFECC9DFFFED7B3FFFDDCC0FFF2C6AFFFCBA497FFA8A8A8FFF5F8F9FF68B1
      E0FFA0DCFEFFA9DFFEFFAFE1FEFFB4E3FEFFB6E4FEFFB5E3FEFFB1E2FEFFACE0
      FEFFA4DDFEFF9CDAFEFF96D7FAFF91D3F7FF8BCFF3FF80C8ECFF69B7DEFF3E86
      B3FFE9E9E9FF0000000000000000000000000000000000000000000000000000
      000000000000FAF8F6FFC49560FFC18231FFC38330FFC1812BFFC07E26FFB77F
      38FFC7C6C5FFEAE9E8FFF8F7F6FFFAF9F9FFFBFBFAFFFCFCFCFFF8F8F8FFF5F5
      F5FFFFFFFFFFFEFEFEFFFEFEFDFFFDFCFCFFFBFBFBFFF7EFE4FFF4E7D8FFF7F6
      F5FFF2F1EFFFE6DFD8FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFCFFC0C0C0FFAEAC
      ACFFD9C4B9FFE2C1B0FFD6B9ADFFB3ADABFFB9B9B9FFF7F7F7FFFBFDFEFF69B2
      E4FFABE0FEFFB5E3FEFFBDE6FEFFC2E8FEFFC5E9FEFFC3E9FEFFBFE7FEFFB8E5
      FEFFAFE2FEFFA5DEFEFF9BD9FDFF95D6F9FF8FD2F5FF88CDF0FF75C0E5FF4188
      B6FFEDEDEDFF00000000000000000000000000000000FCFCFCFFC0C0C0FFAEAC
      ACFFD9C4B9FFE2C1B0FFD6B9ADFFB3ADABFFB9B9B9FFF7F7F7FFFBFDFEFF69B2
      E4FFABE0FEFFB5E3FEFFBDE6FEFFC2E8FEFFC5E9FEFFC3E9FEFFBFE7FEFFB8E5
      FEFFAFE2FEFFA5DEFEFF9BD9FDFF95D6F9FF8FD2F5FF88CDF0FF75C0E5FF4188
      B6FFEDEDEDFF0000000000000000000000000000000000000000000000000000
      00000000000000000000D4B390FFB97C2FFFBD7F2CFFBD7E2BFFBD7E2BFFB777
      25FFBAB2AAFFD9D9D8FFF4F4F3FFFAF9F9FFFBFBFAFFFCFCFCFFEFEFEFFFEEEE
      EEFFF9F9F9FFFFFFFFFFFAF9F9FFC5A5EDFFF7F5F6FFFAFAF9FFF9F8F7FFF6F5
      F3FFE7E1DBFFFBFAF9FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F6F6
      F6FFD5D5D5FFCACACAFFD1D1D1FFF2F2F2FF00000000000000000000000071B4
      E3FFB6E4FEFFC0E7FEFFC9EBFEFFD0EDFEFFD3EFFEFFD2EEFEFFCCECFEFFC4E9
      FEFFB9E5FEFFADE1FEFFA1DCFEFF98D8FCFF92D4F7FF8BCFF3FF7CC5EAFF4C81
      A6FFF9F9F9FF000000000000000000000000000000000000000000000000F6F6
      F6FFD5D5D5FFCACACAFFD1D1D1FFF2F2F2FF00000000000000000000000071B4
      E3FFB6E4FEFFC0E7FEFFC9EBFEFFD0EDFEFFD3EFFEFFD2EEFEFFCCECFEFFC4E9
      FEFFB9E5FEFFADE1FEFFA1DCFEFF98D8FCFF92D4F7FF8BCFF3FF7CC5EAFF4C81
      A6FFF9F9F9FF0000000000000000000000000000000000000000000000000000
      00000000000000000000E7D5C3FFB7803FFFB97A29FFB97A28FFB87927FFB778
      26FFAE9371FFC4C3C2FFE6E5E4FFF8F7F7FFFBFBFAFFF8F8F8FFEBEBEAFFEBEB
      EBFFEEEEEEFFFCFCFCFFC7A6F0FF8C37F6FF8F3FF1FFD6BFEFFFF7F6F5FFF2F1
      EFFFEDE7E2FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000099C6
      E9FFA5D7F7FFC9EBFEFFD4EFFEFFDEF2FEFFE2F4FEFFE0F3FEFFD8F0FEFFCDEC
      FEFFC1E8FEFFB4E3FEFFA6DEFEFF9BD9FDFF94D5F9FF8DD1F4FF6EBBE8FF7E94
      A6FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000099C6
      E9FFA5D7F7FFC9EBFEFFD4EFFEFFDEF2FEFFE2F4FEFFE0F3FEFFD8F0FEFFCDEC
      FEFFC1E8FEFFB4E3FEFFA6DEFEFF9BD9FDFF94D5F9FF8DD1F4FF6EBBE8FF7E94
      A6FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFEFFB58651FFB37627FFB57728FFB47727FFB476
      26FFA17237FF9E9B98FFC7C5C3FFE6E5E4FFF6F5F4FFF9F8F8FFE9E9E9FFE9E9
      E8FFF2F2F2FFDFDCE2FF9557E1FFB587EDFF9F5FEFFF8124F6FFE6DCEFFFE5DD
      D6FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECF4
      FAFF60A9E1FFCEEDFEFFDCF2FFFFE8F6FFFFF1F9FFFFECF8FFFFE1F3FFFFD4EF
      FFFFC6EAFFFFB8E5FFFFAAE0FFFF9DDAFEFF95D6F9FF8ED1F4FF4592CBFFD9DB
      DDFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECF4
      FAFF60A9E1FFCEEDFEFFDCF2FFFFE8F6FFFFF1F9FFFFECF8FFFFE1F3FFFFD4EF
      FFFFC6EAFFFFB8E5FFFFAAE0FFFF9DDAFEFF95D6F9FF8ED1F4FF4592CBFFD9DB
      DDFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D8C3AFFFAB712EFFB1762DFFB1762CFFB175
      2BFFAA6D23FFA69E94FFAF906AFFC6AE8FFFDEDAD7FFEDEDECFFF0F0F0FFEAEA
      E9FFE5E4E4FFC2AADEFFCEB4EDFFDBCEEBFFB384ECFFC29BEFFFECE8E4FFF7F4
      F1FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009BC5E9FF93C7EEFFDFF3FEFFECF8FEFFF8FCFEFFF2FAFEFFE4F5FEFFD6EF
      FEFFC7EAFEFFB9E5FEFFABE0FEFF9EDBFEFF96D6FAFF5FADE5FF8BA0B2FFFEFE
      FEFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009BC5E9FF93C7EEFFDFF3FEFFECF8FEFFF8FCFEFFF2FAFEFFE4F5FEFFD6EF
      FEFFC7EAFEFFB9E5FEFFABE0FEFF9EDBFEFF96D6FAFF5FADE5FF8BA0B2FFFEFE
      FEFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFEFFB18862FFAC7534FFAE7634FFAD75
      33FFAD7432FF9F5F15FFA9630BFFA8620BFFA8691EFFC8AA86FFF2EEE9FFEFEF
      EEFFEAE9E9FFC19DEBFFC19CEDFFCAB4E5FFCCA9F6FFEDE6EEFFEAE3DDFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FCFDFEFF7BB1E2FF96C6EDFFE6F5FEFFECF8FEFFE9F6FEFFDFF3FEFFD2EE
      FEFFC5E9FEFFB7E4FEFFA9DFFEFF9CDAFDFF60AEE7FF7194B3FFF9F9F9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FCFDFEFF7BB1E2FF96C6EDFFE6F5FEFFECF8FEFFE9F6FEFFDFF3FEFFD2EE
      FEFFC5E9FEFFB7E4FEFFA9DFFEFF9CDAFDFF60AEE7FF7194B3FFF9F9F9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F5F1EEFFB3885BFFAB773BFFAB76
      3AFFAA7639FFA67033FF8D5416FF8C5314FF9F6421FFD8A667FFDDBA90FFE6DE
      D6FFECE7E3FFF5F3F2FFE9DFF1FFDEC9F3FFDFD0EDFFE6DFD8FFFDFDFCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFDFEFF95BFE7FF5E9FDDFFBDDDF5FFDBF1FEFFD5EFFFFFCBEC
      FFFFBFE7FFFFB1E2FEFF88C8F4FF4290D5FF91A9BFFFFBFBFBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFDFEFF95BFE7FF5E9FDDFFBDDDF5FFDBF1FEFFD5EFFFFFCBEC
      FFFFBFE7FFFFB1E2FEFF88C8F4FF4290D5FF91A9BFFFFBFBFBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0E9E2FFA87C4CFFA878
      42FFA87841FFA77740FFA16F38FF905B23FF925B20FFC8AC8FFFF7F4F1FF0000
      0000FBFAF9FFECE5E0FFE7E1DBFFF1F0EEFFEDEAE7FFF2EDE9FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E4EEF8FF82B2E2FF5295D8FF5196D9FF529A
      DCFF4A92D9FF4B8AC9FF83A7CCFFE3E7EBFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E4EEF8FF82B2E2FF5295D8FF5196D9FF529A
      DCFF4A92D9FF4B8AC9FF83A7CCFFE3E7EBFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F5F1EDFFC7AE
      95FFBB9D7DFFC3A88CFFCDB7A0FFD9C8B8FFF5F1EEFF00000000000000000000
      00000000000000000000FDFCFCFFECE6E0FFE6DED7FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F2F2FFB3B1B0FFB2B0
      AEFFB2AFAEFFB2AFAEFFB2AFAEFFB2AFADFFB2AEADFFB2AEADFFB2AEACFFB2AE
      ACFFB2AEACFFB2ADABFFB2ADABFFB3ADABFFB3ADAAFFB3ACAAFFB3ACAAFFB3AC
      A9FFB3ACA9FFB3ABA9FFB3ABA8FFB3ABA8FFB3ABA8FFB3AAA8FFB3AAA7FFB3AA
      A7FFB3AAA7FFB3A9A6FFBCB2AFFFFEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFEFFFDFDFDFFFCFCFCFFFAFAFAFFFAFAFAFFFCFCFCFFFDFDFDFFFEFE
      FEFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DFDFDFFFCECECEFFCCCCCCFFC9C9C9FFFCFC
      FCFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFE8F7FDFF99D7F1FFADC3CBFFB3C0C5FFB3C0C5FFB3C0
      C5FFB3C0C5FFB3C0C5FFB3C0C5FFB3C0C5FFB3C0C5FFB3C0C5FFB3C0C5FFB3C0
      C5FFB3C0C5FFC6CACAFFF7F5F4FFFFFFFFFF00000000FDFDFDFFF5EDEAFFFEF5
      F3FFDEDBD0FFBCC8AFFFBCC7AEFFBCC6ADFFBCC6ACFFBCC5ABFFCFCDBBFFFEEC
      E8FFFEEBE6FFFEE9E5FFFEE8E3FFF0D2CEFFE9C0BCFFEDCAC6FFFEE3DDFFFEE2
      DCFFFEE1DBFFFEE0D9FFC5B4D8FFACA2DBFFACA1DAFFACA0DAFFACA0D8FFAC9F
      D7FFD2B7D0FFFED6CEFFF5D7CEFF000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFF6F6F6FFE8E8E8FFD4D4
      D4FFBEBEBEFFADADADFFA0A0A0FF9A9A9AFF9A9A9AFF9F9F9FFFAAAAAAFFBABA
      BAFFCECECEFFE2E2E2FFF2F2F2FFFBFBFBFFFEFEFEFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C7C7C7FFF6F6F6FFE9E9E9FFD7D7D7FFDBDB
      DBFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFFFFFFFFFFFEFEFEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
      FFFFFFFFFFFFFFFFFFFFA9E0F7FFE0AF99FFF8B597FFF9BFA5FFF9BFA5FFF9BF
      A5FFF9BFA5FFF9BFA5FFF9BFA5FFF9BFA5FFF9BFA5FFF9BFA5FFF9BFA5FFF9BF
      A5FFF9BFA5FFF1B69AFFF7B191FFFEFAF8FF0000000000000000F5F1EFFFFEF6
      F5FF9CB992FF3B983BFF3B983BFF3B983BFF3B983BFF3B983BFF3B933AFFEBDC
      D4FFFEECE8FFFEEAE6FFD79B9AFFD67D7DFFD77E7EFFD77D7DFFD38F8EFFFBDF
      D9FFFEE2DCFFE3CBD8FF1242FAFF1244FEFF1244FEFF1244FEFF1244FEFF1244
      FEFF8787DCFFFAD3C9FFFAF3F1FF000000000000000000000000000000000000
      00000000000000000000FEFEFEFFF5F5F5FFDBDBDBFFB5B5B5FF888888FF6565
      65FF6E6E6EFF7E7E7EFF909090FF9C9C9CFFA0A0A0FF9C9C9CFF909090FF7C7C
      7CFF636363FF767676FFA2A2A2FFCBCBCBFFEAEAEAFFFBFBFBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFBFFCDCDCDFFF2F2F2FFE6E6E6FFD3D3D3FFCACA
      CAFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEF9
      FDFFC0E9FAFFBCE6F8FFA1D0E4FFF7AA87FFFEFBF9FFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFF9F8FFFFE9E9FFFFE3E2FFFFED
      ECFFFFEBEAFFC8EBF9FFE9AC90FFFCE7DDFF0000000000000000FDFDFDFFF6EF
      ECFFEBE8E0FF4FAB4EFF4EAF4EFF4EAF4EFF4EAF4EFF4EAF4EFF4EAF4EFFC9D1
      B8FFFCEAE6FFF7E3E0FFD79595FFDF9A9AFFDD9898FFDB9797FFD49292FFDFC4
      C0FFE8CDC8FFA29CCEFF2855EDFF2855EEFF2956F0FF2957F2FF2958F5FF3059
      F2FFE8C9CEFFCABAB5FFFEFEFEFF000000000000000000000000000000000000
      00000000000000000000FAFAFAFFDBDBDBFF9B9B9BFF747474FF8B8B8BFFADAD
      ADFFB0B0B0FFB3B3B3FFB6B6B6FFB8B8B8FFBBBBBBFFBEBEBEFFC2C2C2FFBABA
      BAFF949494FF8D8D8DFF7E7E7EFF7E7E7EFFBBBBBBFFEAEAEAFFFDFDFDFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E6E6E6FFDDDDDDFFEEEEEEFFE5E5E5FFCCCCCCFFB6B6
      B6FF000000000000000000000000000000000000000000000000000000000000
      000000000000E6E6E6FFCCCCCCFFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFA1D9
      F1FFDCBAABFFF6B091FFB0C4CBFFF7AB89FFFEFEFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFA5A4FFFF8281FFFF4B4BFFFF84
      84FFFF8989FFC7EBFAFFE4AE95FFFCE5DBFF000000000000000000000000F5F1
      EFFFFEF8F6FFAAD4A5FF78C776FF78C675FF78C675FF75C373FF65AD63FF94A0
      88FFA99D9BFF968B88FF806F6EFF755B5BFF6D5453FF664F4EFF5F504FFF6359
      57FF635856FF3F4059FF1E2D61FF1E2E63FF203069FF22336FFF253878FF4F51
      79FF8F7B76FF9C9A9AFFBDBDBDFFE0E0E0FF0000000000000000000000000000
      00000000000000000000EBEBEBFF888888FF848484FF959595FF949494FFB3B3
      B3FFCFCFCFFFE1E1E1FFEBEBEBFFEEEEEEFFEBEBEBFFE6E6E6FFDEDEDEFFD2D2
      D2FFADADADFF8D8D8DFF9B9B9BFFB8B8B8FF9D9D9DFFBEBEBEFFFCFCFCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F6F6F6FFCACACAFFD9D9D9FFFDFDFDFF00000000000000000000
      00000000000000000000D2D2D2FFEAEAEAFFE9E9E9FFDFDFDFFFC2C2C2FFABAB
      ABFFF3F3F3FF0000000000000000000000000000000000000000F1F1F1FFC8C8
      C8FFCCCCCCFFC8C8C8FFC0C0C0FFDADADAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FDFEFFEDF8FDFFDDF3FCFFBEC4
      C6FFF7C0A7FFFCF1ECFFB1D2E0FFF7AB89FFFEFEFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFDFCFFFFF8F8FFFFD6D5FFFFCF
      CEFFFFD6D5FFC7EBFAFFE4AE95FFFCE5DBFF000000000000000000000000FDFD
      FDFFF5EFEDFFFEF8F6FFFEF6F5FFFEF5F3FFFEF4F2FFF0E5E3FFC3BCBAFFEFED
      ECFFEAE8E6FFE5E3E0FFE0DEDBFFDCD9D5FFD7D5D0FFD3D0CBFFCFCCC7FFCBC8
      C2FFC8C4BEFFC4C0B9FFC1BCB5FFBDB9B1FFBAB6AEFFB8B3AAFFB5B0A7FFB3AD
      A4FFB0ABA1FFAEA9A0FFB1ABA2FF948C8BFF0000000000000000000000000000
      000000000000D0D0D0FF7D7D7DFF767676FF868686FFC4C4C4FFF1F1F1FFF7F7
      F7FFF3F3F3FFEFEFEFFFEAEAEAFFE5E5E5FFE0E0E0FFDBDBDBFFD6D6D6FFD2D2
      D2FFCECECEFFD7D7D7FFC9C9C9FFB2B2B2FFB8B8B8FFCACACAFFA4A4A4FFF9F9
      F9FF000000000000000000000000000000000000000000000000000000000000
      0000F4F4F4FFD0D0D0FFE2E2E2FFD0D0D0FFBDBDBDFFE9E9E9FF000000000000
      000000000000EBEBEBFFC5C5C5FFDCDCDBFFE4E4E4FFE4E4E4FFD7D7D7FFC3C3
      C3FFD0D0D0FFF5F5F5FF0000000000000000FDFDFDFFD5D5D5FFD1D1D1FFF4F4
      F4FFEFEFEFFFB9B9B9FFD0D0D0FF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFEDF8FDFFB2DEF0FFCFCDCCFFC9CCCDFFC5BC
      B7FFF6CCB8FFFAF9F8FFB1D4E2FFF7AB89FFFEFEFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFC7EBFAFFE4AE95FFFCE5DBFF0000000000000000000000000000
      0000F5F2F0FFFEF9F7FFFEF8F6FFFEF6F5FFFEF5F3FFFCF2EFFFF0E8E6FFF6F6
      F5FFF1F0EEFFECEBE8FFE8E6E3FFE4E1DDFFE0DDD8FFDCD8D3FFD9D4CEFFD5CF
      C9FFD1CBC5FFCDC7C0FFC9C4BCFFC6C0B8FFC2BDB4FFBFB9B0FFBCB6ADFFB9B3
      AAFFB6B1A7FFB4AFA5FFB5B0A6FFADA5A4FF0000000000000000000000000000
      0000CBCBCBFF8D8D8DFF838383FFAAAAAAFFF3F3F3FFF8F8F8FFF6F6F6FFF3F3
      F3FFD3DFD6FF9DC4A8FF7AB68CFF68AF7EFF66AE7CFF6DAD81FF81B090FFA2B9
      A9FFC6C8C7FFC6C6C6FFBEBEBEFFC3C3C3FFCCCCCCFFC0C0C0FFD7D7D7FFA1A1
      A1FFFAFAFAFF0000000000000000000000000000000000000000000000000000
      0000C9C9C9FFF6F6F6FFECECECFFDADADAFFC7C7C7FFAFAFAFFFC5C5C5FFDCDC
      DCFFC1C1C1FFCFCFCFFFD8D8D8FFCECECEFFC6C5C3FFC6C4C2FFCCCCCCFFDBDB
      DBFFE2E2E2FFCFCFCFFFCDCDCDFFDEDEDEFFC8C8C8FFE6E6E6FFEDEDEDFFF2F2
      F2FFE4E4E4FFD1D1D1FFE8E8E8FF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFC6EBFAFFE7C4B4FFFACEBBFFEADAD2FFC9BE
      B8FFFACDB9FFFEFBF9FFB1D4E2FFF7AB89FFFEFEFDFFFEFEFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFEFEFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFC7EBFAFFE4AE95FFFCE5DBFF0000000000000000000000000000
      0000FDFDFDFFF6F1EFFFE4E2DBFF579752FF569751FF569650FF8EB789FFF2F1
      F0FF96928BFF949089FF928E87FF8F8B84FF8D8981FF8A867EFF87837BFF8480
      78FF817D75FF7E7A72FF7B776FFF78746CFF757169FF726E66FF6F6B63FF6C68
      60FF69655DFF79746CFFB5B0A6FFDBCFCCFF000000000000000000000000DFDF
      DFFF888888FF949494FFD9D9D9FFF9F9F9FFF8F8F8FFF1F3F1FF9BC6A6FF43A7
      60FF20A94BFF26B858FF2BBF60FF2DC165FF2EC267FF2FC167FF2EBE66FF2BB4
      5FFF2FA359FF61A277FFA4B1A8FFBCBCBCFFC2C2C2FFD6D6D6FFCACACAFFD5D5
      D5FFA9A9A9FFFEFEFEFF00000000000000000000000000000000000000000000
      0000D4D4D4FFE8E8E8FFF1F1F1FFEAEAEAFFD1D1D1FFB5B5B5FFAFAFAEFFBBBB
      BAFFCDCBCAFFB9A794FFBCA380FFCCB180FFDABE86FFDDC288FFD7BC85FFC8B0
      85FFB9A488FFBBB2A8FFD2D2D2FFC9C9C9FFCACACAFFE2E2E2FFEEEEEEFFE1E1
      E1FFD6D6D6FFBEBEBEFFFAFAFAFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFEBF8FDFFCAEBF9FFD0E6EFFFAEDBEDFFECB79FFFF2F2F1FFE2F3F9FFC8C1
      BCFFF9D0BEFFFDFEFDFFB1D5E3FFF7AB89FFFEFEFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFC7EBFAFFE4AE95FFFCE5DBFF0000000000000000000000000000
      0000FEFEFEFFC3C1C1FFEEE9E8FF539450FF3A8B3AFF388738FF7BAC79FFEAEA
      E9FF454036FF49433AFF484239FF464138FF454036FF423E35FF403B33FF3D39
      30FF3A362EFF36332BFF332F28FF2F2C25FF2B2822FF27241FFF23201CFF1E1C
      18FF1A1815FF3C3A34FFB5B0A6FFDED4D1FF0000000000000000FAFAFAFF8585
      85FF929292FFE6E6E6FFF9F9F9FFF8F8F8FFBCD7C3FF34A657FF1EB852FF23C4
      5EFF27C664FF29C267FF2DB365FF46A970FF58AB7BFF57AB7BFF3DAA6DFF2DB9
      6CFF30C774FF2EC470FF28AC5EFF65A47CFFC3C6C4FFD3D3D3FFDFDFDFFFCECE
      CEFFC8C8C8FFCBCBCBFF00000000000000000000000000000000000000000000
      0000FDFDFDFFC4C4C4FFEDEDEDFFEBEBEBFFDCDCDCFFD6D6D5FFD3D3D3FFB9AB
      9CFFBD976DFFE4C489FFEBCA64FFE2B942FFDBAE33FFDAAC2EFFDDB034FFE4BD
      47FFEECF6DFFE5CA83FFBDA682FFC7C4C0FFD8D8D8FFD4D4D4FFD7D7D7FFCBCB
      CBFFBFBFBFFFDADADAFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFAFD
      FEFFC0E3F1FFF1CEBDFFFACCB7FFC4CED1FFF8B090FFFDEDE5FFECEDEDFFC9C0
      BBFFFAD0BDFFFFFEFCFFB2D5E3FFF7AB89FFFEFEFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFC7EBFAFFE4AE95FFFCE5DBFF0000000000000000000000000000
      0000F1F1F1FFBDBDBDFF939190FF67765DFF374D22FF34381AFF787463FFEBEB
      EBFF49433AFF4E483EFF4D473DFF4B463CFF4A443AFF474238FF443F36FF413D
      34FF3E3A31FF3A362EFF36332BFF322F28FF2E2B25FF2A2721FF26231EFF211F
      1AFF1D1B17FF3E3C35FFB6B1A7FFE0D9D6FF0000000000000000B8B8B8FF8787
      87FFE0E0E0FFF9F9F9FFF8F8F8FF84C096FF17AF4BFF1CC75CFF1FCA64FF22C9
      69FF32B66CFF7FAE94FFBDC0BEFFD3D3D3FFD9D9D9FFDCDCDCFFD3D3D3FFA5B6
      ADFF5FAB85FF2CBD76FF2CCE7EFF27C573FF3CA76AFFC2CEC7FFE1E1E1FFEAEA
      EAFFCDCDCDFFA8A8A8FFF9F9F9FF000000000000000000000000000000000000
      000000000000EDEDEDFFD1D1D1FFDDDDDDFFDADADAFFE2E2E2FFB6A38BFFDBBB
      81FFEAC299FFEAC39AFFCF9F4AFFB1790DFFAD740EFFAC730EFFAE750EFFB47B
      0EFFC18A10FFD4A31FFFE8C451FFCFB272FFC4BBB2FFE2E2E2FFC0C0C0FFB3B3
      B3FFBABABAFFFEFEFEFF0000000000000000FFFFFFFFF4FBFEFFE8F7FDFFDEF3
      FCFFCED4D6FFF2D6C9FFF5FAFBFFC2E6F4FFF6BDA2FFFCF9F7FFEAF7FCFFC9C1
      BDFFFAD1BEFFFEFFFDFFB2D5E3FFF7AB89FFFEFEFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFC7EBFAFFE4AE95FFFCE5DBFF0000000000000000000000000000
      0000E9E9E9FF93908FFF4C3731FF4D1B06FF4C1701FF441401FF7B5F56FFECEC
      ECFF4E483EFF534D42FF524C41FF504A40FF4E493EFF4C463CFF49433AFF4640
      37FF423D34FF3E3A31FF3A362EFF36322BFF312E27FF2D2A24FF282620FF2421
      1DFF1F1D19FF403D37FFB7B2A8FFE3DEDAFF00000000FBFBFBFF7E7E7EFFC4C4
      C4FFF9F9F9FFF8F8F8FF78BC8DFF12BB50FF17CD60FF1ACF67FF1CCB6BFF57B6
      83FFCBD0CDFFEAEDECFFCDE9DDFFBEE3D4FFD1E5DDFFEAEAEAFFEDEDEDFFEBEB
      EBFFD5D5D5FF9DB8ACFF34B980FF26D387FF23CF7EFF31AC6AFFD1DCD5FFEFEF
      EFFFEFEFEFFFC7C7C7FFC4C4C4FF000000000000000000000000000000000000
      00000000000000000000D1D1D1FFCECECEFFDDDDDDFFB9AA95FFDFBD5AFFE5BD
      77FFECC6A0FFECC9A5FFEDCBA9FFDDB88BFFA9710EFFAA720FFFA9700FFFA66D
      0FFFA56B0EFFAB720EFFBE870EFFD9AA27FFD0A777FFBAB1A8FFCFCFCFFFACAC
      ACFFEBEBEBFF000000000000000000000000EDF8FDFFCDE5F0FFE8DAD3FFE2D7
      D2FFD4C6BFFFF5D1C0FFF7EFEAFFC3DFEBFFF7B99EFFFCF6F2FFEAF5F8FFC9C1
      BCFFFAD1BEFFFEFEFDFFB2D5E3FFF7AB89FFFEFEFDFFDEDEDEFFC5C5C5FFC5C5
      C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5
      C5FFE1E1E1FFC7EBFAFFE4AE95FFFCE5DBFF000000000000000000000000FEFE
      FEFF998F8CFF3D1A10FF391309FF612305FF5F2205FF5C2004FF8E6756FFEBEB
      EBFF534D42FF585246FF575145FF554F44FF534D42FF504A40FF4D473DFF4944
      3AFF464137FF423D34FF3D3931FF39352DFF34312AFF302C26FF2B2822FF2624
      1EFF211F1BFF423F38FFB8B3A9FFE5DFDBFF00000000D1D1D1FF939393FFF8F8
      F8FFF8F8F8FF9CCBABFF0EB84EFF12CD5FFF14CF66FF16CD6CFF62B98CFFA4D1
      BCFF66DEABFF29D490FF22D692FF23D896FF23D798FF45D9A5FFABE1CEFFECEC
      ECFFECECECFFE0E0E0FFB3C1BBFF32B884FF1FD288FF1BC77AFF3EAC72FFEEF1
      EFFFF8F8F8FFE0E0E0FFA0A0A0FF000000000000000000000000000000000000
      00000000000000000000EDEDEDFFD1D1D1FFC0BAB2FFD3AD49FFD1A022FFE7C2
      95FFEECDACFFEFD1B3FFF1D6BBFFF1D9C0FFC29330FFBB850EFFB9830EFFB37D
      0EFFAC750FFFA56C0FFFA36A0FFFB17A0DFFE8BF92FFC49C74FFC3C1BFFFC7C7
      C7FFFBFBFBFF000000000000000000000000D7F1FBFFF4D5C7FFFCE4DAFFF1EB
      E8FFDBCFC9FFFBDACAFFFEF8F4FFC6E4F0FFF8BCA0FFFEF8F4FFECF7FAFFC9C1
      BDFFFAD1BEFFFFFEFDFFB2D5E3FFF7AB89FFFEFEFDFFDFDFDEFFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6
      C6FFE2E2E1FFC7EBFAFFE4AE95FFFCE5DBFF0000000000000000FDFDFDFF9078
      70FF40170CFF40170CFF52200AFF752F0AFF722D09FF6E2B08FF996D57FFE9E9
      E8FF585145FF5D574AFF5C5549FF5A5448FF575145FF544E43FF514B40FF4D47
      3DFF49443AFF454037FF403C33FF3B372FFF37332CFF322F28FF2D2A24FF2826
      20FF24211CFF44403AFFB9B4AAFFE4DEDAFF000000009E9E9EFFD2D2D2FFF8F8
      F8FFDEE9E1FF15AB4BFF0DCB5AFF0FCE61FF11CF68FF27C775FF3DCB88FF17D3
      80FF1AD689FF1BD790FF1DD895FF1DD999FF1ED99AFF1ED99BFF1ED99BFF79D9
      B9FFEBEBEBFFEDEDEDFFE3E3E3FFAEC0B9FF62A98DFF7EAD99FF15BD70FF82C2
      9EFFF9F9F9FFF8F8F8FFB0B0B0FFF8F8F8FF0000000000000000000000000000
      00000000000000000000DADADAFFDCDCDCFFB99A59FFCF9E1CFFE5C192FFEFD0
      B1FFF1D5B9FFF3DCC4FFF5E3D0FFF7E8D9FFE2C681FFCD9B0DFFCB980DFFC592
      0EFFBC880EFFB17B0FFFA56D10FF9F660FFFDAB07FFFE9C097FFB49E88FFCECE
      CEFFDDDDDDFF000000000000000000000000D9EFF8FFFAD2C1FFFEFBFAFFF2FA
      FEFFDBD6D3FFFCE1D4FFFFFFFEFFC7E7F4FFF8BEA2FFFEFAF7FFECF8FCFFC9C1
      BDFFFAD1BEFFFFFEFDFFA9CCDBFFF7AB89FFFEFEFDFFE3E3E2FFD0D0D0FFD0D0
      D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0
      D0FFE7E7E6FFC7EBFAFFE4AE95FFFCE5DBFF0000000000000000A48E86FF481B
      0EFF4A1C0FFF5D260EFF873B10FF873B10FF85390FFF81360EFFA47359FFE6E5
      E4FF5C5649FF635B4EFF615A4DFF5F584BFF5C5549FF585246FF544E43FF4E48
      3EFF4C473CFF484239FF433E35FF3E3A31FF39352EFF34312AFF2F2C26FF2A28
      22FF25231EFF45423BFFBAB5ACFFE4DCD8FF000000008E8E8EFFF8F8F8FFF8F8
      F8FF68B782FF0AC351FF0CCB5AFF0DCC60FF0FCD67FF11CF6FFF13D078FF15D2
      80FF17D488FF18D58FFF19D694FF1AD797FF1BD799FF1BD79AFF1BD79AFF1AD6
      99FF7ED0B5FFEBEBEBFFEDEDEDFFE6E6E6FFD4D4D4FF9CD0BAFF14CE7BFF18AD
      61FFE6EEE9FFF9F9F9FFD7D7D7FFE3E3E3FF0000000000000000000000000000
      000000000000F8F8F8FFCFCFCFFFC7C0B8FFC89619FFCB9F50FFF0D2B4FFF1D7
      BDFFF4DEC8FFF4E2CDFFE7CD8AFFDFB942FFDEB018FFDFB219FFDCAF18FFD5A6
      13FFCB9A0EFFBF8D0FFFB17C10FFA36C11FFCEA471FFEBC59FFFCBA37BFFC6BF
      BAFFEBEBEBFF000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFF2FA
      FEFFDBD6D3FFFCE1D4FFFFFFFDFFC7E7F4FFF9BEA2FFFEFAF7FFECF7FBFFC9C1
      BCFFFAD1BEFFFFFEFDFFACCFDDFFF7AB89FFFEFEFDFFE7E7E6FFD3D3D2FFD3D3
      D2FFD3D3D2FFD3D3D2FFD3D3D2FFD3D3D2FFD3D3D2FFD3D3D2FFD3D3D2FFD3D3
      D2FFEAEAE9FFC7EBFAFFE4AE95FFFCE5DBFF00000000D7CDC9FF522112FF5421
      11FF592411FF944515FF9B4817FF9A4716FF974515FF934214FFAE795DFFE1E0
      DFFF615A4DFF767066FF60594DFF6E675CFF79756DFF7B766EFF736F68FF9190
      8DFF736F68FF6A6760FF63605AFF514D46FF3A362EFF36322BFF312E27FF2C29
      23FF27241FFF46433CFFBBB6ADFFE4DBD7FFFEFEFEFFA8A8A8FFF8F8F8FFEAEE
      EBFF10A444FF0AC652FF0BC757FF0CC85DFF0ECA64FF0FCB6CFF11CD74FF13CE
      7CFF15D084FF16D18AFF17D28FFF18D392FF19D494FF19D495FF18D194FF2FB8
      8AFF8FB4A7FFE1E1E1FFEBEBEBFFEDEDEDFFE9E9E9FF60C89BFF12CE79FF10C2
      6AFF8DC4A4FFF9F9F9FFEBEBEBFFD5D5D5FF000000000000000000000000F6F6
      F6FFDDDDDDFFC1C1C1FFDEDEDEFFB79F75FFB7810EFFD8B588FFF2D8BFFFF4DE
      C9FFF7E8D9FFE9D08FFFE3BB36FFEAC33AFFEEC83BFFEFC83BFFECC63AFFE7C0
      38FFDFBB47FFD8B55DFFC49834FFAE7B17FFE8C7A4FFEDCBA8FFE6C098FFD1BA
      A3FF00000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFF2FA
      FEFFDBD6D3FFFCE1D4FFFFFFFDFFC7E7F4FFF8BEA2FFFEFAF7FFEBF6FBFFC8C1
      BCFFFAD1BEFFFEFEFDFFADD1DFFFF7AB89FFFEFEFDFFEDEDECFFDEDEDDFFDEDE
      DDFFDEDEDDFFDEDEDDFFDEDEDDFFDEDEDDFFDEDEDDFFDEDEDDFFDEDEDDFFDEDE
      DDFFEBEBEBFFC7EBFAFFE4AE95FFFCE5DBFF000000007C5447FF5D2514FF6127
      15FF743219FFAC531DFFAD531DFFAB521DFFA9511CFFA24D20FF8F6759FFDCDB
      D9FF665F51FF898277FF8E8981FF686153FF7F7A73FF86827AFF8F8C85FF8C89
      84FF797671FF726E66FF75736EFF545048FF3C382FFF38342CFF322F28FF2D2A
      24FF282620FF47443DFFBCB7AEFFE4DAD6FFFDFDFDFFC1C1C1FFF7F7F7FFB3D1
      BBFF08B345FF09C14FFF0AC253FF0BC359FF0CC15DFF0EC465FF0FC76EFF11C9
      76FF12CB7DFF13CC83FF15CD89FF15CE8CFF16CE8EFF16CE8EFF1ECA8EFF99C9
      B8FFEAEAEAFFEAEAEAFFE9E9E9FFEAEAEAFFEBECECFF25C07DFF10C973FF0FC5
      6AFF45AD71FFF9F9F9FFF8F8F8FFCBCBCBFFF5F5F5FFCCCCCCFFBEBEBEFFB4B4
      B4FFB4B4B4FFB0B0B0FFDBDBDAFFA98242FFA56D13FFBD9355FFF4DFCAFFF5E4
      D2FFDFBF64FFE4BF46FFEDC94BFFF3D04DFFF7D44DFFF7D44BFFF5D149FFEFCC
      4FFFF5E8C8FFF9EDE2FFF5E3D1FFEAD0AFFFF1D5BAFFEFD1B2FFEECCABFFC7A9
      88FF00000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFF2FA
      FEFFDBD6D3FFFCE1D4FFFFFFFDFFC7E7F4FFF8BEA2FFFEFAF7FFE1EDF1FFC5BE
      B9FFF7CDBBFFFBFBFAFFAACDDBFFF7AB89FFFEFEFDFFE3E3E2FFCCCCCCFFCCCC
      CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
      CCFFE3E3E2FFC7EBFAFFE4AE95FFFCE5DBFFDACFCBFF652916FF6B2B17FF6F2D
      18FF75301AFFAE5626FFBD5F24FFBC5E25FF91421FFF6E2C17FF916758FFD7D5
      D2FF6B6355FF726A5BFF6F6758FF726A5CFF716A5DFF625B4DFF5D564AFF5851
      46FF5C574CFF4E483EFF49433AFF443F35FF3E3A31FF39352DFF333029FF2E2B
      25FF292621FF48453EFFBDB9B0FFE3D9D4FFFBFBFBFFD3D3D3FFF6F6F6FF9CC7
      A8FF28BF5CFF07BC4BFF08BC4EFF09BB52FF63B084FF3CAA6FFF0DB962FF0FC2
      6DFF10C474FF11C57AFF12C67FFF12C783FF13C885FF13C886FF14C886FF13C7
      86FF46CE9BFFB8E3D2FFEBEBEBFFE9E9E9FFBCDACDFF0FBE6FFF0EC26BFF0DC0
      64FF149D4DFFF8F8F8FFF9F9F9FFCECECEFFCDCDCDFFDEDEDEFFD9D9D9FFD2D2
      D2FFC8C8C8FFBEBEBEFFD4D4D4FFA57632FFA7711EFFCFAC72FFE1C693FFD9B7
      59FFE3C155FFEDCC5FFFF4D465FFF8DA67FFFCDD65FFFDDD61FFFADA5CFFF4DA
      76FFFDFAF6FFFBF5EFFFF9EEE3FFF6E4D3FFF3DCC4FFF1D6BBFFF0D2B4FFC5A3
      7FFF00000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFF2FA
      FEFFDBD6D3FFFCE1D4FFFFFFFEFFC7E7F4FFF8BEA3FFFEFAF7FFE0EBF0FFC5BD
      B8FFF6CDBAFFFAFAF9FFA7CBD9FFF7AB89FFFEFEFDFFE0E0DFFFC5C5C5FFC5C5
      C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5
      C5FFE0E0DFFFC7EBFAFFE4AE95FFFCE5DBFFAC8B80FF732F19FF7A321AFF7F34
      1BFF863B1AFF9D4B28FFA8512BFF914025FF82351BFF7D321AFF986857FFD0CE
      CBFF706859FF766E5EFF726A5BFF6D6557FF696153FF645C4FFF5E574BFF5953
      47FF544E43FF4F493FFF4A443AFF443F36FF3F3B32FF39362EFF34312AFF2F2C
      25FF2A2721FF48443DFFBEBAB1FFE3D7D2FFFAFAFAFFDEDEDEFFF4F4F4FF93C3
      A0FF58C87BFF1FBC56FF07B649FF1CAC54FFD0D3D1FFE4E5E5FF6EB28EFF0EAB
      5CFF0DBC69FF0FBE6FFF0FBF74FF10C077FF10C079FF10C07BFF10C07BFF10C0
      7BFF10C07AFF10BF79FF51C996FFCBE2D8FF7AC9A4FF0DBB67FF0CBB61FF0BBA
      5BFF079A43FFEAEFEBFFF8F8F8FFCECECEFFD3D3D3FFEFEFEFFFECECECFFEBEB
      EBFFE6E6E6FFCCCCCCFFCECECEFFA67635FFC19651FFCDA758FFD4B050FFE1C0
      61FFEBCE71FFF2D87EFFF7DE85FFFAE286FFFDE482FFFDE37AFFFBDF72FFF7DF
      87FFFEFDFCFFFDFAF8FFFCF6F0FFF9EEE2FFF5E3D1FFF3DBC4FFF1D6BCFFCAAA
      8AFF00000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFF2FA
      FEFFDBD6D3FFFCE1D4FFFFFFFDFFB7D8E5FFF0B59AFFF5F1EEFFD9E5E9FFC4BC
      B8FFF5CCB9FFF9F9F8FFA9CCDAFFF7AB89FFFEFEFDFFFFFFFDFFEEEEEDFFF5F5
      F4FFFFFFFDFFFFFFFDFFFFFFFDFFEAEAE9FFDCDCDBFFFFFFFDFFFFFFFDFFFFFF
      FDFFFFFFFDFFC7EBFAFFE4AE95FFFCE5DBFF93604EFF81351CFF89391EFF913F
      1EFFAC5225FF983F20FF9B4420FF973E20FF943C1FFF8E3A1EFFA06A57FFCCCA
      C5FF7A7368FF7F796EFF7D776DFF7A746AFF757066FF716B62FF6C675EFF6863
      5AFF635F56FF5F5A52FF5B564FFF56524BFF524E47FF4D4A43FF49463FFF4442
      3CFF403D38FF514F49FFBFBBB3FFE3D6D1FFFCFCFCFFD9D9D9FFF2F2F2FF99C5
      A4FF68C884FF61C880FF21B555FF69AB81FFE3E3E3FFEFEFEFFFEFEFEFFFA5C4
      B3FF1FA25FFF0CB261FF0CB767FF0DB76BFF0EB86DFF0EB86EFF0EB86FFF0EB8
      6FFF0EB86EFF0EB86CFF0DB76AFF13B669FF13B564FF0BB45CFF09B357FF09B2
      51FF06963DFFE6ECE7FFF5F5F5FFCDCDCDFFCFCFCFFFF5F5F5FFF2F2F2FFECEC
      ECFFE6E6E6FFCDCDCDFFD2D1D1FFA87F43FFDEC297FFD4B060FFDEBD66FFE9CD
      7CFFF1DA91FFF6E3A2FFFAE8AAFFFBEAAAFFFCEAA3FFFDE797FFFBE38AFFF7DD
      7EFFFAF3DBFFFEFDFCFFFDFAF8FFFBF5EFFFF9EDE1FFF5E3D1FFDDBC96FFC8A9
      88FF00000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFF2FA
      FEFFDBD6D3FFFCE1D4FFFEFEFEFFB9DAE7FFF1B69CFFF7F3F0FFDAE6EAFFC5BD
      B9FFF6CDBAFFFAFAF9FFAACDDBFFF7AB89FFC7C6C5FFA1A1A0FFACACABFF8F8F
      8FFFD2D2D1FFCFCFCEFF90908FFF757574FF727272FF8A8A89FFFBFBFAFFFFFF
      FEFFFFFFFDFFC7EBFAFFE4AE95FFFCE5DBFF8B4A34FF903C1FFF98411FFFC96B
      31FFAC4D27FFAA4D23FFAD4926FFAB4624FFA64423FF9F4121FFA5654EFFD1CD
      C8FFE3E1DDFFF1F0EEFFFBFBFAFFFDFDFDFFF9F8F7FFF4F3F2FFEFEEECFFEBEA
      E7FFE7E5E2FFE2E0DDFFDEDCD8FFDAD8D3FFD6D3CEFFD2CFC9FFCECBC5FFCBC7
      C0FFC7C3BCFFC4C0B8FFC1BBB3FFE5D6D1FF00000000C6C6C6FFF1F1F1FFAACA
      B1FF75C88CFF72C98BFF72C28AFFCAD0CCFFE9E9E9FFE9E9E9FFEDEDEDFFF4F4
      F4FFD1D9D5FF47A774FF0BAC59FF0BAE5DFF0BAF5FFF0BAF61FF0BAF61FF0BAF
      61FF0BAF60FF0BAF5FFF0BAE5CFF0AAD59FF09AD55FF08AC50FF07AB4CFF07AA
      48FF098C37FFF2F3F2FFEFEFEFFFD6D6D6FFF1F1F1FFCCCCCCFFCACACAFFCCCC
      CCFFDBDBDBFFCFCFCFFFD8D8D8FFAE8F62FFD7B474FFD7B25CFFE7CE91FFEED7
      96FFF5E4B2FFF9EDC6FFFBF1CEFFFCF1CBFFFCEFC0FFFCECB1FFFAE69FFFF8E0
      8CFFF3DC91FFFEFEFEFFFEFDFCFFFDFAF8FFFBF5EEFFF8EDE1FFE1C6A2FFD4BD
      A7FF00000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFEDF5
      F8FFD6D0CDFFF6DBCFFFF9F9F8FFBADBE8FFF1B69BFFF6F2EFFFDEEAEEFFC5BD
      B9FFF6CDBAFFFBFBFAFFB3D4E2FFF7AB89FFD4D4D3FF838382FF898989FFC4C4
      C3FFC4C4C3FF696969FFC6C6C5FFB3B3B3FFA6A6A5FF9A9A9AFFFAFAF9FFFFFF
      FDFFFFFFFDFFC0E9FAFFE4AE95FFFCE5DBFF92482EFF9F4223FFC8652DFFB952
      2CFFBF522BFFBF5228FFC15028FFBF4F28FFBA4C27FFB24925FFA74524FFA569
      51FFA57360FFA27563FF9F7666FF9C7669FFB38772FFB7886EFFB1846EFFA77E
      6AFF9D7767FF937164FFD3C7C2FFF3EEECFFF2ECE9FFF1EAE8FFEFE8E5FFEDE5
      E2FFECE2DEFFE9DEDAFFE8DAD5FFFAF8F7FF00000000C3C3C3FFEFEFEFFFC2D5
      C6FF83C794FF7FCA93FFA3C9ADFFEDEDEDFFF1F1F1FFEAEAEAFFE9E9E9FFB9D4
      C3FF6EC28FFF24A95DFF08A54DFF08A650FF08A652FF08A653FF08A753FF08A7
      53FF08A653FF08A651FF08A64FFF08A54CFF06A449FF06A346FF06A342FF05A1
      3FFF2D924DFFF0F0F0FFE4E4E4FFF0F0F0FF000000000000000000000000FDFD
      FDFFEBEBEBFFCDCDCDFFD5D5D5FFB6A693FFE7D2AFFFEDDCBCFFF5EAD4FFEFDC
      A9FFF8EDCCFFFCF6E3FFFDF9EBFFFDF7E5FFFCF4D6FFFBEFC3FFF9E8ADFFF7E0
      96FFF2DE9DFFEFDEADFFF3E6C4FFE8D196FFE4CA90FFF3E8D4FFE0CBB3FFECE2
      D9FF00000000000000000000000000000000D9EFF8FFFAD2C0FFFEFCFAFFEDF5
      F8FFD5CFCCFFF5DACEFFF8F8F7FFBBDCE9FFF2B79CFFF7F3F0FFE0ECF0FFC6BE
      BAFFF7CEBBFFDFDFDEFFB6C8CFFFF5A885FFC1D0D5FFB0D6E5FFAFD5E5FFB2D8
      E8FFAFD6E5FFACD2E1FFB2D8E8FFB2D8E8FFB2D8E8FFB2D8E8FFB2D8E8FFB2D8
      E8FFB1D8E8FFA1CBDBFFF1A988FFFDEDE6FFA15539FFAE4926FFDD7134FFC35C
      29FFC15827FFD46B2FFFC9582DFFD15A30FFCD572EFFC4512AFFB84C26FFAA46
      23FF9C3F20FF8D391DFF7E321AFF6F2B17FF823B20FF974214FF85370FFF742C
      09FF622105FF501702FFCCC0BBFF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECEFFE9E9E9FFDFE4
      E0FF90C49CFF8ECA9DFFCDD6CFFFDCE7DEFFF0F2F0FFF3F3F3FFEEEEEEFF9DBB
      A8FF069039FF059C3FFF059D42FF059D44FF059D45FF059E46FF059E47FF059E
      47FF059E46FF059D45FF059D43FF059C41FF059C3EFF059B3CFF059B39FF0496
      35FF69A67AFFE8E8E8FFC4C4C4FF000000000000000000000000000000000000
      000000000000FEFEFEFFCDCDCDFFCBCAC9FFD0BBA2FFFDF9F6FFFDFBF9FFF8F1
      E1FFF6ECD1FFFAF5E5FFFEFDFBFFFEFBF3FFFCF6E1FFFAEFCAFFF8E7B2FFF5DF
      9BFFF2DFA9FFF2E4BEFFE5C778FFDFC27AFFE2C686FFEFE2C6FFCDB498FF0000
      000000000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFE9F1
      F4FFD0CBC8FFF1D6C9FFF4F4F3FFB2D3E0FFEDB297FFF3EFECFFD8E4E8FFC4BC
      B8FFF5CCB9FF888887FF676767FFD1AD9DFFF4A886FFF5A783FFF5A783FFF7A8
      85FFF7A885FFF6A884FFF7A885FFF7A884FFF7A885FFF7A885FFF5A784FFF7A7
      83FFF7A885FFF7AA87FFFACEBBFFFEFEFEFFB6725AFFBD4F28FFE37736FFF888
      3EFFFA8A40FFFC8D44FFE88141FFD0673FFFD6663EFFD25E36FFC8552DFFB84C
      27FFA84423FF973D1FFF87361CFF772F18FF80391CFF9D491DFF8C3C11FF7A30
      0BFF682506FF4F1804FFE6E0DEFF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECECECFFD9D9D9FFEDED
      EDFFADCBB3FF99CEA5FF96CDA3FF92CBA0FFB6D5BDFFF4F4F4FFF5F5F5FFF0F0
      F0FF82B291FF1B9845FF049638FF049639FF04963AFF05973BFF05973CFF0597
      3CFF05973BFF04963AFF049639FF049637FF049535FF049533FF049431FF0383
      29FFBCCDC0FFE0E0E0FFCBCBCBFF000000000000000000000000000000000000
      00000000000000000000D8D8D8FFE1E1E1FFBBAD9EFFF8F5F1FFFEFDFDFFFEFE
      FDFFFEFDFDFFF5ECD5FFFBF7EDFFFDFBF3FFFBF5E0FFF9EDC8FFF6E4B0FFF0DA
      9AFFEAD394FFFCFAF6FFFBF8F2FFF4EBD8FFE7D4AAFFEBE1D7FFE7DBCFFF0000
      000000000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFE9F1
      F4FFD0CAC7FFF0D5C9FFF3F3F2FFB2D2E0FFEDB297FFF2EEEBFFEDF1F2FFCAC2
      BDFFEBC6B4FFB4CDD6FFB4CCD6FFD8F1FAFFD7EFF7FFA1B7C0FFB6CCD5FFD8EF
      F8FFDAEFF6FFD8EEF7FFD7EFF8FFD6EAF2FFD9EDF5FFD0ECF8FFB0CDD8FFF8B8
      9BFFFEFCFBFFFEFDFDFFFFFFFFFFFFFFFFFFCD9F8EFFC9542BFFF3813CFFFC8C
      41FFFD9249FFFD9A54FFFD9E5CFFEC9457FFD57B4AFFCF6A41FFD16037FFC553
      2BFFB24925FFA04121FF8E391DFF7E331BFFB05728FF833A1BFF712F14FF6627
      13FF6D2809FF613322FFFEFEFEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BEBEBEFFE9E9
      E9FFD7DFD9FFA5CDADFFA2D0ACFF9FCFA9FF9CCDA7FFD1E0D4FFF4F4F4FFF6F6
      F6FFF0F0F0FFB4CBBAFF71B484FF45A964FF209B48FF069034FF038F32FF038E
      32FF038B30FF0A8533FF0D8B36FF038E2FFF038E2DFF038E2CFF028A2AFF4590
      59FFE1E1E1FFD1D1D1FFEFEFEFFF000000000000000000000000000000000000
      00000000000000000000F4F4F4FFCACACAFFD9D9D9FFC2AF9DFFFEFDFDFFFFFE
      FEFFFDFDFBFFFEFEFDFFF7F0DFFFFBF5E5FFF9EFD4FFF6E7BEFFF3DFA8FFEBD3
      95FFE7CF92FFEAD8ACFFFDFDFBFFFEFEFEFFF9F6F3FFD5C1ADFF000000000000
      000000000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFE8F0
      F3FFD0CBC8FFF1D6CAFFF4F4F3FFB3D4E1FFEEB398FFD8D3D1FF898989FFAEA4
      9FFFE6A384FFD9B7A6FFD1B2A3FFD2B2A3FFCDAD9EFFCFAFA0FFCFAFA0FFD8B9
      AAFFDBBAAAFFDBBBACFFD7BAACFFD7B5A5FFDAB8A8FFDBBBACFFEEB399FFFBD3
      C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8DCD7FFCE582EFFEC793CFFFE91
      47FFFE9F5BFFFEAA6AFFFEB177FFFEB178FFEE9F69FFDE8955FFD66943FFCE5A
      32FFBB4D27FFA74423FF943C1FFF82341BFF994922FF8A3E16FF61270DFF4E1D
      0BFF6F290FFFA28375FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E5E5E5FFCFCF
      CFFFECECECFFC2D5C6FFADD2B5FFAAD2B2FFA7D1B0FFA6D0AFFFD7E4DAFFF4F4
      F4FFF7F7F7FFF2F2F2FFD4DBD6FFADC7B4FF99BFA2FF8DBA98FF79B088FF74AB
      84FF8BAF96FF8EB398FF2D994BFF2A9948FF2B9948FF319B4CFF409454FFCBD7
      CEFFE0E0E0FFCDCDCDFF00000000000000000000000000000000000000000000
      00000000000000000000C8C8C8FFA9A9A9FFDADADAFFCBC8C6FFC7B4A1FFFEFD
      FDFFF2E7D0FFEFE2C2FFF0E2C2FFF0E1BDFFF5ECD5FFF0DEB2FFEED69BFFEACF
      8BFFF2E6C9FFE9D7B0FFFEFEFEFFF8F5F2FFD3BDA8FFFEFDFDFF000000000000
      000000000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFEAF2
      F5FFD2CDCAFFF3D8CBFFF6F6F5FFC5E3EFFFF6BBA0FFF3EFECFFB3B3B2FFADAD
      ACFFEADDD7FFEED1C3FFB99A8CFFF5D7CAFFF6D7C8FFF5D5C7FFF6D8CAFFF3D8
      CBFFFBD5C4FFFBDDCFFFDED3CDFFE9BAA5FFFACDB9FFFCDDD0FFFCE7DDFFFEFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000CC8166FFE06F3FFFFE99
      52FFFEA867FFFEB67BFFFEBD87FFEEAD88FFFDB57FFFEC9568FFD8704BFFCC5D
      34FFC15029FFAC4624FF983E20FF9B4C23FFAE582BFFA74E1BFF924113FF8035
      0EFF702F0FFFE6E0DEFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C3C3
      C3FFDDDDDDFFE7E8E7FFBFD5C3FFB4D6BBFFB2D5B9FFAFD4B7FFADD2B4FFCBDF
      CFFFF0F2F1FFF7F7F7FFF7F7F7FFF0F0F0FFEBEBEBFFEAEAEAFFEEEEEEFFE9ED
      EAFFB1D3B9FF88C094FF85BE91FF81BD8EFF7DBA8AFF7BB186FFC6D4C8FFE7E7
      E7FFCACACAFFF9F9F9FF00000000000000000000000000000000000000000000
      000000000000EBEBEBFFB2B2B2FFBEBEBEFFBFBFBFFFDDDDDDFFD3D1CEFFC0AD
      9AFFF1EBE4FFF6F0E3FFEFE2C8FFECDAB2FFF9F6EDFFF7F1E3FFE7CB8BFFE5C7
      81FFEAD8B1FFFBF8F3FFE6DACEFFDBC9B7FFFEFEFEFF00000000000000000000
      000000000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFEDF5
      F8FFD3CECBFFF4D9CCFFD9D9D9FFB8C4C8FFE0AE97FFD2CBC6FFBCCED4FFC1D3
      D9FFB3C6CCFFADBFC6FFB4C6CDFFBDD1D8FFC3D3D9FFC5D5DBFFC5D7DEFFB9D0
      D9FFC4CBCDFFC5D7DEFFC2D3D9FFF3C0A9FFFDEDE7FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000EBDED8FFD16842FFE783
      54FFFCAA6BFFFEBA80FFF9BB89FFE29A7FFFE9A27DFFD5855EFFDD7C50FFDA73
      39FFC3512AFFAC4C23FF9A3F21FF8B3B1AFFA65124FFAB501CFF994415FF8738
      0FFFAE8E7EFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FCFFB5B5B5FFE1E1E1FFE7E9E8FFC5D9C9FFBBD9C1FFB9D9BFFFB6D7BDFFB4D6
      BBFFB6D6BDFFCDE2D1FFE0EBE2FFE7EFE9FFE5EDE6FFD8E6DBFFBFDAC4FF9FCB
      A8FF99C8A3FF95C69FFF92C59CFF8EC299FF8DBA96FFC8D7CBFFEBEBEBFFD5D5
      D5FFEAEAEAFF0000000000000000000000000000000000000000000000000000
      0000FEFEFEFFBFBFBFFFCCCCCCFFD5D5D5FFE7E7E7FFD8D8D8FFDEDEDEFFDDDD
      DDFFC1B7ACFFC2AB90FFCCA563FFDEBC78FFE4CA94FFE4CA93FFDFBC73FFD7B0
      63FFCBA971FFD9C6B2FFF0E9E2FF000000000000000000000000000000000000
      000000000000000000000000000000000000D9EFF8FFFAD2C1FFFEFCFAFFEDF5
      F8FFD4CFCCFFF5DACDFFACACABFF9F9F9EFFD7C9C2FFEBBEAAFFE0AE98FFE2B1
      9AFFE3B19BFFE5B39DFFE2B09AFFE8B8A3FFF7C2ABFFF9C5AEFFFAC8B1FFE7BD
      AAFFF8B698FFFAC8B2FFFAC9B4FFFCE0D4FFFEFEFEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000D9B6A9FFD870
      4BFFED9563FFFEB579FFFEBD86FFEBAB78FFDA9368FFE69263FFE38156FFF689
      43FFC85F2CFFB34D27FF993E20FFC0632FFFBA5B22FFAA501CFF994415FF9762
      46FFFAF9F8FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F9FFBBBBBBFFE5E5E5FFEFF0EFFFD4E1D6FFC1DAC6FFBFDCC5FFBDDB
      C3FFBBDAC1FFB8D8BFFFB6D7BCFFB3D6BAFFB0D4B8FFAED3B5FFABD1B2FFA8D0
      B0FFA5CEADFFA2CCAAFF9EC9A7FFA6C6ACFFDCE4DDFFEDEDEDFFD7D7D7FFF0F0
      F0FF000000000000000000000000000000000000000000000000000000000000
      0000DEDEDEFFD2D2D2FFDDDDDDFFECECECFFEDEDEDFFE4E4E4FFD7D7D7FFD0D0
      D0FFDEDEDEFFD4D4D4FFF6F1EDFFE0D0C0FFD8C2A5FFD6BE9FFFD9C4AAFFE5D8
      CBFFFBF9F7FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9EFF8FFFAD2C1FFFBF9F7FFF8F9
      FAFFDAD4D1FFEACFC3FFCBE3EDFFCAE3EDFFD7EFF9FFD2EBF4FFAEC6D0FFC8E0
      EAFFD9F1FBFFD9F1FCFFD9F1FCFFD1EFFBFFD1E3E9FFD9EAF1FFD3EFFBFFCCDC
      E2FFFAD1BEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000D5AD
      9DFFD87551FFF29B67FFFEB072FFF1A36DFFDB885DFFD57A4AFFDB7A42FFF486
      3FFFC95A2CFFA94523FFA74D2AFFC9662AFFB95A22FFA84E1BFF9E6344FFF2EF
      EDFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFAFFC6C6C6FFE1E1E1FFF6F6F6FFEAEFEBFFD1E1D4FFC5DC
      C9FFC3DDC8FFC1DDC6FFBFDCC4FFBCDBC2FFBAD9C0FFB8D8BEFFB5D7BCFFB2D5
      B9FFB0D1B6FFB3CFB8FFD0DED3FFF1F2F1FFECECECFFD2D2D2FFEFEFEFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D5D5D5FFD5D5D5FFEFEFEFFFF2F2F2FFEDEDEDFFC9C9C9FFDEDEDEFF0000
      0000EFEFEFFFECECECFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9EFF8FFFAD2C0FFECEAE8FFAEAE
      ADFFC5C0BDFFDAAE9AFFEEC7B4FFDAB4A3FFDEB9A8FFD0AA99FFD6B1A0FFD0AB
      9AFFEEC9B7FFF2CDBCFFF2CDBCFFEACABBFFEBBEA9FFF2C6B2FFF2CDBCFFF8CB
      B6FFFCE9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000E5CFC6FFD3815EFFFC9E5CFFE18551FFD9734BFFDA6D44FFDC6837FFCF5B
      2EFFB64B26FFA34222FF913A1EFFB25A2BFFB05520FFB48870FFF7F5F4FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DFDFDFFFD5D5D5FFF4F4F4FFFBFBFBFFF3F6
      F4FFE2EBE4FFD5E3D8FFCBDECFFFC5DBCAFFC3D9C7FFC4D9C8FFC9DCCDFFD4E2
      D7FFE5EDE7FFF7F8F7FFF5F5F5FFDCDCDCFFDCDCDCFFFBFBFBFF000000000000
      000000000000000000000000000000000000000000000000000000000000EEEE
      EEFFB9B9B9FFBEBEBEFFE7E7E7FFDCDCDCFFC9C9C9FFF8F8F8FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DDF1F9FFFAD3C1FFF6F6F6FFD6DA
      DBFFD2D5D6FFF0F1F1FFF0E7E4FFC8C0BCFFF0E7E3FFF4ECE7FFEFE6E2FFF0E8
      E4FFF8EFEBFFF8F0ECFFF8F0EBFFDEE7EAFFEDD1C4FFFCE2D7FFFDF1ECFFFEF7
      F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      000000000000F9F6F5FFDAAE9BFFD0744AFFC96434FFCF5B32FFCD552BFFBE4E
      27FFAD4D25FFA74E20FFAD5927FFBB8160FFDECFC8FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBFBFBFFE5E5E5FFE5E5E5FFF2F2
      F2FFFCFCFCFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFF0F0F0FFD9D9D9FFD9D9D9FFF3F3F3FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C9C9
      C9FFD3D3D3FFCACACAFFDDDDDDFFE4E4E4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7FBFDFFF8D9CAFFE8DAD3FFDCDE
      DFFFDCDEDFFFDCDEDFFFDCDEDFFFDCDEDFFFDCDEDFFFDCDEDFFFDCDEDFFFDCDE
      DFFFDCDEDFFFDCDEDFFFDCDEDFFFDFDDDCFFF9D4C3FFFEF6F2FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000FBFAF9FFE6D2C9FFD2AE9BFFC59B81FFC195
      7EFFD3AA93FFDAC1B4FFF0ECEAFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F5FFECECECFFEBEBEBFFEBEBEBFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFE9E9
      E9FFEAEAEAFFFCFCFCFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FAFA
      FAFFD8D8D8FFFDFDFDFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFEF9F6FFFCE4DAFFFCE1
      D5FFFCE1D5FFFCE1D5FFFCE1D5FFFCE1D5FFFCE1D5FFFCE1D5FFFCE1D5FFFCE1
      D5FFFCE1D5FFFCE1D5FFFCE1D5FFFCE2D6FFFDF1ECFFFFFEFEFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFEFEFEFFFCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFFAFAFAFFF4F4F4FFF1F1F1FFF9F9F9FFFCFCFCFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFEFEFEFFFCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F2F2F2FFC7C7
      C7FFC8C8C8FFF3F3F3FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FEFFFEFEFEFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFEFE
      FEFFFEFEFEFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFF9F9F9FFDEDEDEFFB5B5B5FFAAAAAAFFD5D5D5FFF8F8F8FFFBFB
      FBFFFCFCFCFFFDFDFDFFFCFCFCFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2F2F2FF686868FF080808FF0000
      00FF000000FF080808FF6A6A6AFFF2F2F2FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFDFFFAFAFAFFF7F7F7FFF3F3F3FFF0F0F0FFECEC
      ECFFEAEAEAFFE8E8E8FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE7E7E7FFE9E9
      E9FFECECECFFEFEFEFFFF2F2F2FFF6F6F6FFFAFAFAFFFDFDFDFF000000000000
      000000000000000000000000000000000000FDFDFDFFFDFDFDFFFEFEFEFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFFFDFDFDFFFCFCFCFFFCFCFCFFFBFB
      FBFFFBFBFBFFE9E9E9FFB0B0B0FFD2D2D2FFD0D0D0FFA8A8A8FFE2E2E2FFFBFB
      FBFFFCFCFCFFFDFDFDFFFCFCFCFFFEFEFEFFFDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFDFDFDFFFEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFDFFFAF9
      F8FFF5F3F2FFF1EEEBFFECE8E4FFE8E4DFFFE7E2DDFFE7E2DDFFE9E4E0FFECE9
      E5FFF1EEEBFFF6F4F2FFFAFAF9FFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F9F9F9FF363636FF000000FF01120EFF032E
      25FF033025FF01120EFF000000FF383838FFF6F6F6FF00000000FAFAFAFFBABA
      BAFFB1B1B1FFEFEFEFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFBFFF6F6F6FFF1F1F1FFEBEBEBFFE6E6E6FFE1E1E1FFDCDCDCFFD7D7
      D7FFD3D3D3FFD0D0D0FFC8C8C8FFA4A09EFF98938FFFB4B2B1FFCECECEFFD2D2
      D2FFD6D6D6FFDBDBDBFFDFDFDFFFE4E4E4FFEAEAEAFFEFEFEFFFF5F5F5FFFBFB
      FBFFFEFEFEFF000000000000000000000000FCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFBFAFAFFF6F2EFFFF4EF
      EBFFF7F6F5FFC6C6C6FFC4C4C4FFF6F6F6FFF7F7F7FFC7C7C7FFBABABAFFF7F7
      F7FFFBFBFBFFFCFCFCFFFCFCFCFFFDFDFDFFFCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFFF8F7F6FFEAE6E2FFD8D0
      C9FFC9BDB1FFBFB1A1FFB9AA96FFB5A58FFFB2A28CFFB1A08BFFB0A08EFFB5A5
      96FFBDB0A4FFCAC0B7FFDAD2CCFFEAE7E3FFF8F6F5FFFEFEFEFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F8F8FFF000000FF022820FF066852FF0775
      5CFF08775EFF076F58FF022D23FF000000FF838383FFBFBFBFFF1F1F1FFF0000
      00FF000000FF101010FFB9B9B9FF000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FDFD
      FDFFF7F7F7FFF1F1F1FFEBEBEBFFE5E5E5FFDFDFDFFFD9D9D9FFD3D3D3FFCDCD
      CDFFC4C4C3FF96918DFF9D8F84FFB3A59CFFC0B5ADFFBFB4ACFFA29993FFB1B0
      AFFFCBCBCBFFD1D1D1FFD7D7D7FFDDDDDDFFE3E3E3FFE9E9E9FFEFEFEFFFF5F5
      F5FFFBFBFBFF000000000000000000000000FDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFFFCFCFCFFF3EFEBFFD6B7A1FFD4B2
      98FFDBD0C9FFB0B0AFFFE6E6E5FFFBFBFBFFFAFAFAFFE8E8E8FFA7A7A7FFE5E5
      E5FFFBFBFBFFFCFCFCFFFCFCFCFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      000000000000000000000000000000000000FBFAFAFFE9E4E0FFC2B5AAFFA391
      7CFFA4916EFFAE9D70FFAF9F6EFFAD9D6BFFB09F6EFFAF9E6EFFA28F65FF8C76
      57FF806752FF87705EFF9C8979FFBFB2A6FFE6E0DBFFFAF9F9FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003A3A3AFF000303FF06634EFF087D63FF098C
      6FFF099072FF098A6DFF087B61FF000B09FF151515FF0A0A0AFF000403FF022E
      24FF033328FF000604FF151515FFF4F4F4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFBFFF5F5F5FFF0F0F0FFEBEBEBFFE5E5E5FFE0E0E0FFDBDBDBFFC8C7
      C7FF908278FF937F72FF9C8A7EFFA7978CFFB1A39AFFBCB0A7FFC6BCB5FFB5A9
      A1FFB5B3B2FFDADADAFFDEDEDEFFE4E4E4FFE9E9E9FFEFEFEFFFF4F4F4FFFAFA
      FAFFFEFEFEFF000000000000000000000000FCFCFCFFFCFCFCFFFDFDFDFFFBFB
      FBFFFCFCFCFFFCFCFCFFFBFBFBFFFCFCFCFFFBFAFAFFF0E8E4FFC3967EFFC091
      75FFBDAEA6FFB1B0B0FFF3F3F3FFFBFBFBFFFAFAFAFFF5F5F5FFAFAFAFFFCCCC
      CCFFFBFBFBFFFCFCFCFFFBFBFBFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFBFB
      FBFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      000000000000000000000000000000000000FAF9F8FFDFD9D3FFA49083FF8450
      3DFF873726FF7A5D3CFF5F5D38FF4F522DFF525932FF555B31FF5F5F33FF6C62
      39FF795E42FF70533EFF7E6754FFA08F82FFD8D0C9FFF8F6F5FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000191919FF000E0BFF077159FF098B6EFF0A9C
      7BFF0BA381FF0AA07EFF0A9676FF02251DFF000000FF000201FF065B48FF0770
      58FF066650FF033328FF000000FFB1B1B1FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFEFEFFFCFCFCFFFAFAFAFFF6F6F6FFF2F2F2FFEFEFEFFFA097
      92FF907C6EFF907C6EFF907D6FFF978477FFA19084FFAB9C92FFB6A9A0FFC0B5
      ADFFA8A19CFFEEEEEEFFF1F1F1FFF5F5F5FFF9F9F9FFFCFCFCFFFEFEFEFF0000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFCFCFCFFFBFB
      FBFFFBFBFBFFFAFAFAFFFAFAFAFFFBFBFBFFFBFBFBFFF8F5F4FFDCC7BEFFD6C1
      B7FFB5B2B0FFC0BFBFFFF7F7F7FFFAFAFAFFFAFAFAFFF8F8F8FFC2C2C2FFB6B6
      B6FFF6F6F6FFFAFAFAFFFBFBFBFFFBFBFBFFFBFBFBFFFAFAFAFFFAFAFAFFFBFB
      FBFFFBFBFBFFFCFCFCFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      000000000000000000000000000000000000ECE7E3FFA0665CFF8D0C0AFFA328
      1DFFCC8B65FF893C1DFF493410FF596338FF44562BFF354E1FFF365222FF3B52
      25FF455427FF685135FF947F6FFFBBADA1FFE4DED9FFFAF9F8FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000323232FF000605FF07785EFF0A9475FF0BA6
      83FF0CAF8AFF0BAF8AFF0BA885FF02241CFF000000FF033C2FFF099273FF098A
      6DFF087C62FF04493AFF000000FF9A9A9AFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFEFFB1A5
      9DFF907C6EFF907C6EFF907C6EFF907C6EFF927F71FF9B897CFFA5958AFFB0A2
      98FFC1B8B1FFFEFEFEFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFFBFBFBFFECEC
      ECFFCBCBCBFFBDBDBDFFBFBFBFFFC8C8C8FFDADADAFFEAE9E9FFEFECEBFFEAE8
      E6FFABABABFFCBCBCBFFEEEEEEFFF2F2F2FFF5F5F5FFF9F9F9FFD6D6D6FFA9A9
      A9FFF2F2F2FFF7F7F7FFEEEEEEFFDFDFDFFFCCCCCCFFC1C1C1FFBFBFBFFFC5C5
      C5FFE7E7E7FFFAFAFAFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000D6AEAAFF9C1D18FF9C1B0BFFA64522FFD7B1
      75FF9E4514FF9B3E0DFFAA612BFF626B37FF355321FF365A24FF375F27FF4A6D
      39FF4E6F3CFF3B5E27FF556534FFB4AE9EFFF6F4F3FFFDFDFDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007E7E7EFF000000FF05503FFF0A9878FF0BAA
      86FF0CB48EFF0CB790FF0CB48EFF011914FF000000FF087E63FF0BA683FF0A9E
      7CFF099072FF054E3EFF000000FF868686FF737373FF3D3D3DFF3C3C3CFF6B6B
      6BFFD8D8D8FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B9AD
      A4FF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF958375FF9F8E
      82FFC7BDB7FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFBFBFBFFF3F3F3FFB2B2
      B2FFB1B1B1FFCFCFCFFFD2D2D2FFC5C5C5FFB1B1B1FFA8A8A8FFB5B5B5FFBFBE
      BEFF9C9C9CFFD1D1D1FFE6E6E6FFE7E7E7FFE8E8E8FFEDEDEDFFDEDEDEFF9C9C
      9CFFCACACAFFBDBDBDFFAEAEAEFFB2B2B2FFC1C1C1FFD2D2D2FFD6D6D6FFBBBB
      BBFFADADADFFF0F0F0FFFBFBFBFFFCFCFCFF0000000000000000000000000000
      00000000000000000000C98D87FF9C1A0CFF99300CFF9D4310FFD5AE64FFB773
      2DFFAB5711FFB97337FFCE9B56FF57561FFF375B27FF376128FF376629FF3969
      2AFF3A6B2BFF3C712EFF3A6027FF406329FFA9AC9CFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F3FFADADADFF9A9A9AFF939393FF090909FF000504FF087B61FF0BAC
      88FF0CB690FF0DBB93FF0DBA93FF000907FF000000FF0BAA86FF0CB38DFF0BAB
      88FF0AA07EFF02251DFF000000FF000000FF000000FF000403FF000403FF0000
      00FF070707FFA3A3A3FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BAAD
      A5FF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF927E
      70FFCBBEB8FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFBFBFBFFEBEBEBFFA5A5
      A5FFDEDEDEFFFAFAFAFFFBFBFBFFF9F9F9FFF2F2F2FFDBDBDBFFC4C4C4FFAEAE
      AEFF8E8E8EFFAFAFAFFFD9D9D9FFEAEAEAFFE7E7E7FFD8D8D8FFBEBEBEFF8A8A
      8AFFA1A1A1FFC4C4C4FFE1E1E1FFF2F2F2FFF9F9F9FFFBFBFBFFFBFBFBFFEBEB
      EBFFAFAFAFFFE8E8E8FFFBFBFBFFFCFCFCFF0000000000000000000000000000
      000000000000D19B94FF9C240EFF9C3D0DFFA34F0EFFC99343FFD7A452FFC26C
      1FFFC97525FFE6BC95FFDA9D5CFF9B6824FF43632DFF3D6730FF3D6F32FF3B70
      2FFF3B722EFF3C7930FF3D7730FF3A6428FF62451EFFD1C8C5FF000000000000
      000000000000000000000000000000000000000000000000000000000000C5C5
      C5FF151515FF000000FF000000FF000000FF000000FF000000FF01100DFF0A9E
      7DFF0CB891FF0DBD95FF0CB48EFF000000FF01140FFF0DBD95FF0CBA92FF0CB4
      8EFF066650FF000000FF000000FF01130FFF065F4BFF08775EFF076C55FF0449
      3AFF000B08FF070707FFD7D7D7FF000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BAAD
      A5FF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF907C6EFF907C
      6EFFCFC7C1FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFF5F5F5FFB5B5
      B5FFC9C9C9FFF9F9F9FFFAFAFAFFFBFBFBFFF2F2F2FFE8E8E8FFE6E6E6FFCECE
      CEFFA7A7A7FFB7B7B7FFA2A2A2FFB2B2B2FFB6B6B6FFAAAAAAFFBDBDBDFFA7A7
      A7FFC9C9C9FFEAEAEAFFF5F5F5FFFBFBFBFFFCFCFCFFFBFBFBFFFAFAFAFFDEDE
      DEFFB8B8B8FFF4F4F4FFFBFBFBFFFDFDFDFF0000000000000000000000000000
      0000E6CCC7FF9D2C12FFA0440FFFAC5911FFC2732EFFEED4AFFFDFA753FFD485
      31FFC99A6AFFC3BD99FFABA79AFFA9A5A0FFA7A9A5FFA9ACA9FF86A083FF417B
      38FF3F7935FF3D7731FF3F8134FF3F8234FF65401AFF576934FFDEE0DDFF0000
      0000000000000000000000000000000000000000000000000000FCFCFCFF1C1C
      1CFF000005FF06003DFF090057FF090056FF040025FF000000FF000000FF0222
      1BFF0CB28CFF0DBE96FF0BA985FF000000FF03362BFF0DBE96FF0DBC95FF087E
      63FF000202FF000000FF02281FFF099474FF0A9979FF099173FF098569FF0774
      5CFF044A3AFF000000FF686868FF000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B9AD
      A5FF7A695DFF695A50FF5F5148FF5B4E45FF5C4E46FF62534AFF6D5D53FF7F6D
      61FFD5CEC9FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFAFAFAFFDDDD
      DDFFABABABFFE2E2E2FFF9F9F9FFF8F8F8FFECECECFFE7E7E7FFEDEDEDFFC9C9
      C9FFA3A3A3FFDADADAFFB3B3B3FFA3A3A3FF9A9A9AFFA1A1A1FFCECECEFFACAC
      ACFFC7C7C7FFECECECFFEFEFEFFFFAFAFAFFFBFBFBFFFAFAFAFFEDEDEDFFBABA
      BAFFD9D9D9FFFBFBFBFFFCFCFCFFFCFCFCFF000000000000000000000000FDFB
      FBFFAD4D37FFA24610FFB25E15FFC77123FFD28236FFE5B666FFE4B055FFD9AD
      73FFD4BDA5FFC6C398FF676763FF646464FF646464FF707070FF98A897FF6A9A
      66FF44863DFF418138FF408B38FF408E37FF695221FF4F6F2BFF709064FFFEFE
      FEFF000000000000000000000000000000000000000000000000EAEAEAFF0000
      00FF04002AFF0D0074FF0F008CFF1200A5FF1500B8FF0B0069FF000000FF0000
      00FF043F31FF0CBA93FF077059FF000000FF033B2EFF0CB58FFF098A6DFF0005
      04FF000000FF044738FF0BAD88FF0BAE89FF0BAB87FF0BA481FF0A9777FF0883
      67FF076A53FF000706FF313131FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8E6FFFF22A9
      E0FF0E749DFF0D5F80FF0E678BFF176C8FFF1F7192FF1E6D8DFF11688BFF1081
      ADFF31BBF2FFCCF2FFFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFFCFCFCFFF6F6
      F6FFC9C9C9FFAFAFAFFFE7E7E7FFF4F4F4FFE9E9E9FFE8E8E8FFF4F4F4FFC4C4
      C4FF939393FFB2B2B2FFC4C4C4FFD9DBDBFFD7D8D8FFBABABAFFA4A4A4FF9797
      97FFBFBFBFFFF0F0F0FFEBEBEBFFF7F7F7FFFAFAFAFFF0F0F0FFBCBCBCFFC2C2
      C2FFF5F5F5FFFBFBFBFFFCFCFCFFFDFDFDFF000000000000000000000000DBB0
      A7FFA24111FFB35F15FFCA7527FFD2843AFFDA9548FFE3AE57FFE6BB62FFD5C3
      A1FF9D9D9DFFA9A680FF47473EFF3B3B3BFF3B3B3BFF4C4C4CFF909090FF789D
      77FF559751FF499343FF44903CFF42973BFF5B742AFF57702AFF498935FFD7D5
      D2FF000000000000000000000000000000000000000000000000F9F9F9FF0909
      09FF010011FF0D0079FF11009CFF1400B5FF1600C7FF1800D3FF0F0087FF0000
      02FF000000FF000A07FF000000FF000000FF000000FF000B09FF000706FF0001
      01FF066751FF0CBB93FF0CB992FF0CB891FF0CB58EFF0BAD88FF0A9E7DFF0988
      6BFF076C56FF000A07FF2D2D2DFF000000000000000000000000000000000000
      000000000000000000000000000000000000E9F8FFFF47CAFFFF00B6FFFF02B6
      FFFF04B7FEFF129CD3FF30A7D7FF47ACD4FF55B3D9FF64BFE3FF6DC9EEFF5BCF
      FFFF29C1FFFF05B7FFFF89DCFFFF000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFCFCFCFFFBFB
      FBFFF2F2F2FFC1C1C1FFB1B1B1FFDDDDDDFFE6E6E6FFE8E8E8FFE6E6E6FFAEAE
      AEFF9B9B9BFFD6D6D6FFF0F2F2FFE6ECECFFE0E6E6FFEEEFEFFFDADADAFFA8A8
      A8FF9F9F9FFFD7D7D7FFE5E5E5FFF3F3F3FFEEEEEEFFBFBFBFFFBABABAFFEFEF
      EFFFFBFBFBFFFCFCFCFFFCFCFCFFFDFDFDFF000000000000000000000000B763
      46FFAE5913FFC87426FFD48840FFDB974FFFE1A358FFE2C88CFFE6E5C8FFF0ED
      CCFF4B4B4BFF494832FF4F4E36FF2E2E2EFF2E2E2EFF2B2B2BFF454545FF999C
      9AFFB0B2B2FF6BA96AFF48A544FF46A441FF508F32FF517E2DFF498F34FF8B82
      6DFF000000000000000000000000000000000000000000000000000000007C7C
      7CFF000000FF030023FF100091FF1500C0FF1700D0FF1A01DAFF2109DFFF1E0F
      91FF131313FF152526FF159EA8FF11CEDCFF0CADB9FF052D30FF000000FF076B
      54FF0DBE96FF0DBE96FF0DBD95FF0DBB94FF0CB690FF0BAC88FF0A9B7AFF0883
      68FF055A47FF000000FF565656FF000000000000000000000000000000000000
      0000000000000000000000000000E9F8FFFF27C1FFFF01B6FFFF03B7FFFF06B8
      FFFF08B9FFFF12AAE6FF22C0FFFF31C4FFFF3FC8FFFF4ECCFFFF5BC6F0FF69D4
      FFFF77D8FFFF64D2FFFF0EBAFFFF73D3FFFF0000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFCFCFCFFFCFC
      FCFFFBFBFBFFF1F1F1FFC3C3C3FFABABABFFCDCDCDFFC8C8C8FFB2B2B2FFA7A7
      A7FFB3B3B3FFEDEFF0FFD1EAEBFF81D5D6FF80CDCFFFD0E4E4FFECEEEEFFBEBF
      BFFF9E9E9EFFA5A5A5FFBFBFBFFFD9D9D9FFB3B3B3FFB9B9B9FFEDEDEDFFFAFA
      FAFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFF0000000000000000F3E9E6FFA54A
      15FFC26D1EFFD3863DFFDD9A54FFE5A962FFEAB368FFDFC68CFFB7B6A0FF9D9A
      74FF3B3B3AFF242422FF524F27FF1C1C1CFF1B1B1BFF1E1E1EFF2E2E2EFF4B4B
      4BFF686868FF69AB68FF5BBA56FF5AB752FF59AD47FF559838FF449C37FF517C
      39FFFBFBFBFF000000000000000000000000000000000000000000000000FBFB
      FBFF404040FF060606FF1F1F22FF353061FF463D8FFF5347B2FF5747D1FF5147
      9AFF474747FF47CBD5FF47F1FFFF47F1FFFF47F1FFFF47E1EDFF434C4CFF396A
      5FFF30BD9DFF1FC39EFF0EBE96FF0CBA93FF0CB38DFF0BA783FF099273FF0771
      59FF011611FF000000FFBFBFBFFF000000000000000000000000000000000000
      00000000000000000000000000004FC9FFFF00B6FFFF04B7FFFF07B8FFFF0AB9
      FFFF0BB3F5FF0CB0EFFF10BCFFFF1BBEFFFF29C2FFFF36C6FFFF43BEEEFF51CD
      FFFF5FD1FFFF6CD5FFFF66D3FFFF08B8FFFFA0E4FFFF00000000000000000000
      000000000000000000000000000000000000FDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFCFCFCFFFAFAFAFFF2F2F2FFC4C4C4FF9A9A9AFF9D9D9DFFD3D3D3FFB6B7
      B7FFB5B6B6FFE4EBECFF7BD1D4FF20DADDFF1FD4D7FF83CACBFFE3E8E8FFB9BA
      BAFFB0B0B0FFD5D5D5FFA4A4A4FF939393FFB1B1B1FFEDEDEDFFFAFAFAFFFBFB
      FBFFFBFBFCFFFBFBFCFFFCFCFCFFFDFDFDFF0000000000000000B4B9A4FF6A60
      1FFFC77C2FFFDB9752FFE5AB67FFEDB972FFF2C277FFDDC38BFFB1B09AFF5757
      4EFF4E4D31FF222222FF424026FF292922FF212121FF202020FF2E2E2EFF3939
      39FF6A6A6AFF77B776FF7FBD5EFF85B456FF99671AFF865717FF4AA53CFF4F75
      2BFFD9DDD7FF0000000000000000000000000000000000000000C7C7C7FF2B2B
      2BFF030303FF363636FF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
      4EFF4E5B5CFF4EF2FEFF4EF2FFFF4EF2FFFF4EF2FFFF4EF2FFFF4E7D80FF4E4E
      4EFF4E4D4DFF4E5151FF4B5C59FF34554EFF154339FF03372BFF033025FF0008
      06FF000000FF727272FF00000000000000000000000000000000000000000000
      00000000000000000000CDF0FFFF00B6FFFF03B7FFFF08B9FFFF0BBAFFFF0DBB
      FFFF0EA9E5FF11BCFFFF11BDFFFF12BDFFFF15BDFFFF20C0FFFF2CB6ECFF3AC7
      FEFF47CAFFFF54CEFFFF61D1FFFF41C8FFFF12BBFFFFF1FAFFFF000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFDFDFDFFFBFB
      FBFFFCFCFCFFFAFAFAFFE9E9E9FFBABABAFFB9B9B9FFAAAAAAFFBFBFBFFFA7A7
      A7FFB1B2B2FFDDE3E3FF7BC4C6FF34CCCEFF36C5C8FF88C3C5FFE0E4E5FFB6B7
      B7FFA4A4A4FFC6C6C6FFB6B6B6FFB9B9B9FFABABABFFDFDFDFFFF9F9F9FFFAFA
      FAFFF2F2F8FFF4F4F9FFFBFBFBFFFCFCFDFF000000000000000095A683FF4571
      2CFF5B8134FFDFA462FFEEBA77FFF6C880FFFBD083FFDAC395FFAEAC94FF4343
      43FF364643FF2E3B38FF1B2E3CFF34433AFF1A2E3BFF192A36FF22323EFF2929
      29FF717171FF8DBF81FFC88E3DFFBC7A28FFA46B1FFF659F40FF489B38FF5D55
      1FFFC1C4B6FF00000000000000000000000000000000D3D3D3FF0A0A0AFF2728
      28FF526E68FF59877DFF59857BFF587B73FF576D68FF565B5AFF555555FF5655
      55FF565E5FFF56F1FDFF56F2FFFF56F2FFFF56F2FFFF56F2FFFF567B7DFF5656
      56FF565656FF565656FF565656FF565656FF565656FF434343FF121212FF1919
      19FF9F9F9FFF0000000000000000000000000000000000000000000000000000
      0000000000000000000076D7FFFF01B6FFFF06B8FFFF0BBAFFFF0FBBFFFF11BD
      FFFF11AAE5FF15BEFFFF15BEFFFF15BEFFFF15BEFFFF14BEFFFF17B7F5FF22B9
      F4FF30C4FFFF3CC7FFFF48CAFFFF53CEFFFF09B8FFFF96E3FFFF000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFFCFCFCFFFBFB
      FBFFFAFAFAFFE9E9E9FFB4B4B4FFBDBDBDFFDDDDDDFFD5D5D5FFB5B5B5FF8F8F
      8FFFA3A3A3FFDEE0E0FFC4D5D6FF96C6C7FF99C6C8FFCBD8DAFFE6E7E7FFAFAF
      AFFF888888FFB2B2B2FFD9D9D9FFEFEFEFFFC9C9C9FFAAAAAAFFDCDCDDFFE8E8
      F2FF8989DBFF8484E0FFE2E2F3FFFBFBFCFF00000000000000008DA677FF4B85
      33FF66923DFFEAB373FFF7C885FFFDD48FFFFEDB96FFD7C5A0FF92918AFF4F4F
      44FF1E6688FF96B5C1FF276A82FF115D7EFF1C6680FF0F5575FF105372FF1818
      18FF7D7D7DFFBBAA75FFDA9143FFB78C37FF92AE50FF7EA245FF7D6121FF6C60
      24FFB4C1A9FF000000000000000000000000000000005E5E5EFF1F1F1FFF608A
      81FF62AB9BFF63BBA7FF64C7B1FF64CFB7FF65D3BAFF65D5BCFF64CBB4FF619D
      90FF5D5C5CFF5DB5BBFF5DF3FFFF5DF3FFFF5DF3FFFF5DD1D9FF5D5E5EFF5F86
      7DFF62AF9EFF61A293FF609286FF5F827AFF5E756FFF5D6361FF484848FF0505
      05FF7A7A7AFFFDFDFDFF00000000000000000000000000000000000000000000
      0000000000000000000039C5FFFF03B7FFFF0DBAFFFF0EBBFFFF12BDFFFF15BD
      FDFF14AAE3FF17BAF8FF18BBF9FF18BCFAFF17BBFAFF16BBF9FF15BCFCFF11AD
      E9FF18BEFFFF24C1FFFF30C4FFFF3CC7FFFF1EBEFFFF4DCCFFFF000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFFCFCFCFFFAFA
      FAFFEAEAEAFFB5B5B5FFC7C7C7FFF1F1F1FFEEEEEEFFE6E6E6FFE2E2E2FFBDBD
      BDFF8F8F8FFFADADADFFD2D4D4FFE1E5E5FFE3E7E7FFDDDEDEFFC4C4C4FF9B9B
      9BFFA8A8A8FFDEDEDEFFF3F3F3FFFBFBFBFFF5F5F5FFCFCFD0FFA8A8A9FFBFC0
      D2FF4343C7FF3131CCFFB8B8E3FFFAFAFDFF000000000000000090B27CFF5098
      38FF8BA34AFFF3C081FFFDD394FFFFDCA0FFFFE2A8FFD8CAABFF7F7F7FFF494C
      45FF367C94FF498BA8FF1D6F91FF1C6D8CFF197092FF1B6886FF176281FF1313
      13FF898A8AFFC2B67FFFD19D4EFFA7A44DFF8BDE77FF937F33FF75953BFF7279
      34FFB9BEAAFF000000000000000000000000000000002A2A2AFF444948FF68A2
      95FF69B3A2FF6AC0ADFF6BCAB5FF6BD1BAFF6BD3BCFF6BD5BDFF6CD6BEFF6BD5
      BDFF646E6CFF646565FF64989BFF64B8BEFF64A3A7FF646969FF646464FF6470
      6EFF6AC2AEFF6CD7BFFF6CD6BEFF6BD3BCFF6BCDB7FF6AC2AEFF68A093FF505B
      58FF090909FF7A7A7AFF00000000000000000000000000000000000000000000
      000000000000000000001BBDFFFF07B8FFFF25C1FFFF1CBFFFFF17BFFFFF19BF
      FEFF1ABBF7FF1AB7F1FF1AB0E9FF19AFE7FF1AB9F5FF19BAF6FF16B3EEFF14B3
      F0FF13BDFFFF11BCFFFF17BDFFFF23C0FFFF1EBEFFFF1DBEFFFF000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFBFBFBFFF1F1
      F1FFB9B9B9FFC1C1C1FFF3F3F3FFFAFAFAFFF6F6F6FFEAEAEAFFE7E7E7FFC6C6
      C6FFA9A9A9FFB1B1B1FF9D9D9DFFBABBBBFFC4C4C4FFACADADFFB7B7B7FFACAC
      ACFFBBBBBBFFEDEDEDFFF9F9F9FFFBFBFBFFFBFBFBFFF5F5F5FFC8C8C9FFA1A1
      A7FF9696C7FF9696D1FFE0E0EFFFFBFBFCFF00000000000000009FC490FF56AA
      3DFFABAE59FFF9C88BFFFEDAA1FFFFE2AEFFFFE7B8FFDCD2BAFFB6B6B6FF9BA4
      A6FF88C2CCFF89C4CDFF86C1CDFF88C2CEFF8CC4D1FF91C4CFFF8CC6D1FFB9BA
      BAFFD5D6D6FFCEBA84FFB6B560FFA1BB5FFF89DD74FF79CD62FF6ABF53FF61B1
      47FFC5CFBEFF00000000000000000000000000000000353535FF404342FF6EA5
      99FF6FB4A4FF70C0AEFF71C9B5FF71CEB9FF71D1BCFF71D3BDFF71CAB6FF6C87
      81FF6A6A6AFF6A6D6CFF6B6E6DFF6A6A6AFF6A6A6AFF6C8C85FF6FB2A3FF6A6D
      6CFF6B6F6EFF70B6A6FF72D6BFFF71D3BDFF71CDB8FF70C4B1FF6FB7A7FF6EA5
      99FF505957FF070707FFE8E8E8FF000000000000000000000000000000000000
      0000000000000000000009B8FFFF13BCFFFF3BC8FFFF32C6FFFF29C4FFFF20C2
      FFFF1FC2FFFF20C3FFFF20C3FFFF20C3FFFF1FC2FFFF1DC1FFFF1BC0FFFF18BF
      FFFF15BEFFFF11BCFFFF0EBBFFFF0DBAFFFF10BAFFFF0FBAFFFF000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFFAFAFAFFCECE
      CEFFB3B3B3FFF0F0F0FFFAFAFAFFFCFCFCFFFBFBFBFFF4F4F4FFEAEAEAFFC8C8
      C8FFA9A9A9FFD7D7D7FFB4B4B4FF9A9A9AFF979797FFA3A3A3FFCFCFCFFFA9A9
      A9FFC6C6C6FFF7F7F7FFFBFBFBFFFCFCFCFFFCFCFCFFFAFAFAFFF4F4F4FFBBBB
      BBFFB9B9BDFFEFEFF4FFFAFAFAFFFCFCFCFF0000000000000000BFDBB3FF62B7
      45FFC1B968FFFCCD93FFFFDEABFFFFE6BAFFFFEDC8FFDBD2BDFFC8C4BBFFC2C4
      C0FFA6BEC4FFA1BDC5FFA6BEC4FFA7BEC2FFAABDBEFFADBCB5FF86BA9FFF9CC7
      9AFFA2C195FFAEB26EFF97CA6BFF8BD771FF86D96EFF7ACD60FF6CBF52FF66AF
      45FFE2E6E0FF000000000000000000000000000000007A7A7AFF171717FF7390
      8AFF76B0A3FF76BAABFF77C3B2FF77C8B6FF78CCB9FF76B3A5FF727977FF7272
      72FF727373FF76B9AAFF77BDADFF727272FF727171FF78D3BEFF79DBC5FF76B1
      A4FF727171FF727272FF75A79CFF78D0BCFF77CAB8FF77C2B1FF76B7A8FF75AA
      9EFF748E88FF0A0A0AFFBCBCBCFF000000000000000000000000000000000000
      0000000000000000000018BCFFFF24C0FFFF51CEFFFF48CCFFFF3FCAFFFF35C8
      FFFF2AC5FFFF24C4FFFF24C4FFFF23C4FFFF22C3FFFF20C2FFFF1DC1FFFF1AC0
      FFFF16BFFFFF13BDFFFF0EBBFFFF0ABAFFFF06B8FFFF0FBAFFFF000000000000
      000000000000000000000000000000000000FCFCFCFFFBFBFBFFF1F1F1FFABAB
      ABFFD7D7D7FFFAFAFAFFFBFBFBFFFCFCFCFFFBFBFBFFF9F9F9FFF0F0F0FFCBCB
      CBFF929292FFA9A9A9FFB6B6B6FFCFCFCFFFCFCFCFFFB1B1B1FFA8A8A8FF8C8C
      8CFFC6C6C6FFF4F4F4FFF9F9F9FFFCFCFCFFFCFCFCFFFBFBFBFFFAFAFAFFE1E1
      E1FFA3A3A4FFE9E9EAFFFBFBFBFFFCFCFCFF0000000000000000E6F2E3FF70BF
      4BFFA2BE5EFFFDD097FFFFE1B3FFFFEAC4FFFFF0D3FFFFF4DEFFFFF7E7FFFFF8
      ECFFFFF9EEFFFFF8EDFFFFF8EBFFFFF7E7FFFFF4DEFFFEEECCFFBCF39EFF9AEC
      8DFFB2E48AFF99ED8BFF8EE27DFF8FE179FF89D96CFF7BCE5FFF6FC052FF73AA
      56FFFEFEFEFF00000000000000000000000000000000ECECECFF1A1A1AFF3031
      31FF778F8AFF7CACA1FF7CB8ABFF7CB7AAFF7A9791FF787878FF787878FF7878
      78FF7CB6A9FF7FDCC7FF7CAFA3FF787878FF787B7AFF7FDCC7FF7FDDC7FF7FDC
      C7FF7BA39AFF787878FF787878FF7A948EFF7DBEAFFF7DBDAEFF7CB3A7FF7BA9
      9FFF677471FF010101FFD5D5D5FF000000000000000000000000000000000000
      0000000000000000000031C4FFFF2DC3FFFF66D4FFFF5DD2FFFF54D0FFFF4ACE
      FFFF40CBFFFF32C8FFFF28C6FFFF27C5FFFF25C5FFFF22C3FFFF1FC2FFFF1CC1
      FFFF18BFFFFF13BDFFFF0FBCFFFF0ABAFFFF05B8FFFF2BC2FFFF000000000000
      000000000000000000000000000000000000FCFCFCFFFBFBFBFFE8E8E8FF9C9C
      9CFFD1D1D1FFF4F4F4FFF5F5F5FFF0F1F0FFE4E4E4FFD1D1D1FFBBBBBBFFB1B1
      B1FF9D9D9DFFC6C6C6FFE5E5E5FFEAEAEAFFEBEBEBFFE8E8E8FFD9D9D9FFA4A4
      A4FF9D9D9DFFB4B4B4FFCBCBCBFFE1E1E1FFF0F0F0FFF6F6F6FFF7F7F7FFE2E2
      E2FFA1A1A1FFE4E4E4FFFBFBFBFFFCFCFCFF00000000000000000000000091CE
      73FF9FC962FFFDCE97FFFFE1B7FFFFECCAFFFFF2D9FFFFF6E4FFFFF8ECFFFFFB
      F3FFFFFCF7FFFFFBF3FFFFF9EDFFFFF8EBFFFFF6E4FFFFF1D8FFF4E8B9FFEADF
      9FFFE5D58DFFACE284FFABD87AFFA0DE79FFA6862FFF7EBD52FF73C053FFA1BC
      90FF000000000000000000000000000000000000000000000000D2D2D2FF2222
      22FF101010FF3D3D3DFF4E5050FF393939FF272727FF666666FF7E7E7EFF82AE
      A4FF84D9C6FF85DCC9FF81A19AFF7E7E7EFF7F8786FF85DECAFF85DECAFF85DD
      C9FF84D9C6FF809691FF7E7E7EFF797979FF565756FF66716FFF6F7B78FF5054
      53FF0E0E0EFF555555FF00000000000000000000000000000000000000000000
      000000000000000000006DD5FFFF29C2FFFF79D9FFFF71D8FFFF69D6FFFF5FD4
      FFFF55D2FFFF49CFFFFF39CBFFFF2BC7FFFF27C6FFFF24C4FFFF21C3FFFF1DC1
      FFFF18BFFFFF14BEFFFF0FBCFFFF0AB9FFFF04B7FFFF56CEFFFF000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFF5F5F5FFC9C9
      C9FFABABABFFB4B4B4FFB2B3B3FFB0B2B1FFB1B2B1FFBBBBBBFFCECECEFFE0E0
      E0FFADADADFFDADADAFFF9F9F9FFF9F9F9FFFAFAFAFFFAFAFAFFE4E4E4FFACAC
      ACFFDCDCDCFFD0D0D0FFB9B9B9FFAFAFAFFFB0B0B0FFB9B9B9FFBCBCBCFFB6B6
      B6FFBEBEBEFFF4F4F4FFFBFBFBFFFDFDFDFF000000000000000000000000CDE9
      BEFF9ACC5FFFFAC88FFFFFDEB4FFFFEBCBFFFFF2DAFFFFF6E6FFFFF9EEFFFFFC
      F9FFFFFEFEFFFFFCF9FFFFFAF0FFFFF8ECFFFFF7E7FFFFF2DBFFFFE9C5FFFFDC
      ACFFF6CA89FFB3E184FFDE9C53FFAEB04FFF96A347FF83C256FF75AF4AFFE3E8
      E1FF00000000000000000000000000000000000000000000000000000000F5F5
      F5FF989898FF525252FF414141FF595959FF2E2E2EFF3A3A3AFF86A19BFF89D3
      C3FF8AD8C7FF8ADBC9FF859491FF848484FF869692FF8ADDCBFF8ADECBFF8ADE
      CBFF8ADAC8FF89CFBFFF858E8CFF353535FF212121FF0B0B0BFF030303FF2222
      22FF818181FFF9F9F9FF00000000000000000000000000000000000000000000
      00000000000000000000BAEBFFFF10BAFFFF8CDEFFFF84DDFFFF7CDBFFFF73DA
      FFFF69D7FFFF5ED5FFFF51D1FFFF41CDFFFF2EC7FFFF26C5FFFF22C3FFFF1DC2
      FFFF18BFFFFF13BDFFFF0EBBFFFF08B9FFFF03B7FFFFA2E7FFFF000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFCFCFCFFF6F6
      F6FFE9E9E9FFD9DDDAFFBCD4C5FFCDDDD3FFEBEDECFFF5F6F5FFF9F9F9FFF5F5
      F5FFB1B1B1FFCCCCCCFFF9F9F9FFFBFBFBFFFBFBFBFFFAFAFAFFD5D5D5FFADAD
      ADFFF3F3F3FFF9F9F9FFF6F6F6FFEFEFEFFFE7E7E7FFE1E1E1FFE0E0E0FFE7E7
      E7FFF4F4F4FFFCFCFCFFFCFCFCFFFDFDFDFF000000000000000000000000FBFE
      FBFFA5DF81FFE7BF78FFFFD8A9FFFFE8C6FFFFF1D8FFFFF6E4FFFFF8EDFFFFFB
      F5FFFFFDFAFFFFFCF6FFFFF9EFFFFFF8ECFFFFF6E5FFFFF0D8FFFFE6C0FFFFD8
      A6FFDBD283FFBDCC72FFD99146FFA4A744FF89C95BFF899B45FFB89F8BFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F1F1F1FF0A0A0AFF676F6DFF8FC8BBFF8FD2
      C3FF90D6C6FF90D7C7FF8B8D8CFF8B8B8BFF8CA29DFF90DCCBFF90DECCFF90DE
      CCFF90DACAFF8FD3C4FF8EBCB2FF3B3B3AFF5C5C5CFFFEFEFEFFFCFCFCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFFFF30C3FFFF77D8FFFF96E2FFFF8FE0FFFF86DF
      FFFF7DDDFFFF72DAFFFF65D7FFFF56D3FFFF47CEFFFF33C8FFFF23C3FFFF1CC1
      FFFF17BFFFFF11BCFFFF0CBAFFFF06B8FFFF19BDFFFFF5FCFFFF000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFFCFCFCFFFAFB
      FBFFF9FBFAFFC5E8CFFF57D686FF6ED08DFFDEEEE2FFF9FBFAFFFBFBFBFFF8F8
      F8FFC0C0C0FFB9B9B9FFF7F7F7FFFBFBFBFFFBFBFBFFF8F8F8FFC3C3C3FFBEBE
      BEFFF8F8F8FFFBFBFBFFFAFAFAFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFBFB
      FBFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      0000E1F3DBFFDCB466FFFDCA92FFFFDFB8FFFFECD0FFFFF3DFFFFFF7E8FFFFF8
      EDFFFFF9F1FFFFF9EFFFFFF8EDFFFFF7E8FFFFF3DFFFFFECCEFFFFDFB5FFFFD0
      99FFFABC7AFFE9A059FFD98334FFB85F1BFF9F5522FFAC5345FFFBFAF9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BCBCBCFF0D0D0DFF91A9A4FF94C8BCFF94CE
      C1FF94D2C4FF94C7BBFF909090FF909090FF92AAA4FF95D9C9FF95DCCCFF95DD
      CDFF95D9CAFF94D2C4FF94C8BCFF676D6CFF1D1D1DFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C5F0FFFF2BC1FFFFA5E5FFFF9FE5FFFF99E4
      FFFF90E2FFFF85DFFFFF77DCFFFF69D7FFFF58D3FFFF47CDFFFF35C8FFFF22C2
      FFFF14BEFFFF0EBBFFFF08B9FFFF02B6FFFF9EE2FFFF00000000000000000000
      000000000000000000000000000000000000FDFDFDFFFCFCFCFFFDFDFDFFFBFC
      FBFFFBFCFBFFBDE2C4FF55C674FF6CC782FFE2F0E5FFFBFBFBFFFCFCFCFFFAFA
      FAFFD8D8D8FFA7A7A7FFEFEFEFFFFBFBFBFFFBFBFBFFF4F4F4FFB3B3B3FFD6D6
      D6FFFBFBFBFFFCFCFCFFFCFCFCFFFDFDFDFFFCFCFCFFFCFCFCFFFDFDFDFFFBFB
      FBFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      000000000000EDD9C6FFEEAF6BFFFECE9AFFFFE0BAFFFFEBD1FFFFF2DEFFFFF5
      E4FFFFF6E9FFFFF6E8FFFFF5E4FFFFF2DEFFFFECD1FFFFE2BCFFFFD4A2FFFCC2
      83FFEFAA65FFCFA04BFFC46C21FFAB471AFF9E4F30FFEEE3E1FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AFAFAFFF202020FF97B0AAFF98C4BAFF99C9
      BEFF99CBC0FF96AFA9FF4C4C4CFF505050FF97ABA7FF99D2C6FF9AD7C9FF9AD9
      CAFF9AD6C8FF99CFC3FF98C5BBFF767D7CFF101010FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093E0FFFF4CCBFFFFADE8FFFFA8E7
      FFFFA1E7FFFF97E4FFFF88E0FFFF78DBFFFF68D6FFFF57D1FFFF43CBFFFF1FC1
      FFFF0FBCFFFF09B9FFFF03B7FFFF68D2FFFF0000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFF1F6F1FFCCE5D1FFDBECDEFFF9FAF9FFFCFCFCFFFCFCFCFFFBFB
      FBFFEEEEEEFFA9A9A9FFD8D8D8FFFAFAFAFFFAFAFAFFE5E5E5FFB1B1B1FFEDED
      EDFFFBFBFBFFFCFCFCFFFCFCFCFFFDFDFDFFFCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      00000000000000000000E3DDC1FFF2B271FFFECB94FFFFDAB0FFFFE4C4FFFFEB
      D1FFFFEED7FFFFEED5FFFFEBD1FFFFE6C6FFFFDEB5FFFED19EFFFCC183FFF1AB
      67FFDC9747FFB5973AFFAC6527FFAE4A37FFECE1DAFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BDBDBDFF0B0B0BFF98AAA6FF9CC0B8FF9DC3
      BAFF9CBEB6FF535555FF212121FF121212FF6D7372FF9DCAC0FF9ED0C4FF9ED2
      C6FF9ED1C5FF9DCBC1FF9CC0B8FF515352FF3B3B3BFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5E7FFFF3CC6FFFF96E1
      FFFFABE8FFFFA2E6FFFF95E2FFFF85DEFFFF74D9FFFF4CCDFFFF1DC0FFFF0EBB
      FFFF08B9FFFF04B6FFFF85D9FFFFFEFEFFFF0000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFF9FBFAFFFCFDFCFFFCFCFCFFFCFCFCFFFDFDFDFFFBFB
      FBFFFAFAFAFFCECECEFFB1B1B1FFEFEFEFFFF4F4F4FFC3C3C3FFCECECEFFFAFA
      FAFFFCFCFCFFFDFDFDFFFCFCFCFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000FAE5DCFFF5AF7DFFFCBF80FFFECC96FFFFD4
      A6FFFFD9AFFFFFDAB0FFF6D8A2FFFED09DFFFDC68BFFF7B775FFCEB962FFB6AE
      4DFF8DBB4BFF75C04CFF89BB68FFEAEEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F7FF161616FF4F5151FF9FB4B0FF9FB3
      AEFF636666FF040404FFB7B7B7FF777777FF191919FF96A5A2FFA1C7BEFFA1CA
      C1FFA1C9C0FFA1C4BCFF8D9795FF0D0D0DFF9C9C9CFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8F8FFFF6DD4
      FFFF3CC7FFFF4ECDFFFF50CEFFFF3EC9FFFF1CBFFFFF0DBBFFFF08B9FFFF13BB
      FFFF61D1FFFFDAF4FFFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFFBFBFBFFFDFDFDFFFCFCFCFFFCFCFCFFFDFDFDFFFBFB
      FBFFFBFBFBFFF0F0F0FFB7B7B7FFB5B5B5FFBABABAFFB2B2B2FFEEEEEEFFFBFB
      FBFFFCFCFCFFFDFDFDFFFCFCFCFFFDFDFDFFFCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFDFDFDFFFDFDFDFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      000000000000000000000000000000000000FEFBFAFFF1D6BBFFE3C77AFFECC0
      75FFE6C677FFDAD783FFD1D478FFCFE088FFE3AC5FFFE39344FFC09C3DFFAC92
      3EFFB19962FFC9DDB7FFFDFEFDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B9B9B9FF0C0C0CFF1B1B1BFF1616
      16FF0D0D0DFFA6A6A6FF00000000F6F6F6FF3B3B3BFF181818FF6A6E6DFF98A4
      A1FF95A09EFF636565FF111111FF565656FFFDFDFDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFEFFFFC8EFFFFFA5E5FFFF8DDEFFFF8EDEFFFFA6E5FFFFCAEFFFFFFCFE
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFAFAFAFFECECECFFCECECEFFC7C7C7FFE7E7E7FFFAFAFAFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFFFCFCFCFFFCFCFCFFFDFDFDFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFEFAFFE6FB
      D9FFD2F9BAFFC3F7A5FFBDF294FFBEDF8BFFC6D089FFCFBB82FFC8E4ACFFE2F0
      D7FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E5E5E5FF9E9E9EFFA7A7
      A7FFEDEDEDFF000000000000000000000000F8F8F8FF7D7D7DFF1A1A1AFF0000
      00FF000000FF222222FF8D8D8DFFFCFCFCFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00FDFDFDFFFEFEFEFFFDFD
      FDFFFDFDFDFFFDFDFDFFFCFCFCFFFEFEFEFFFDFDFDFFFDFDFDFFFEFEFEFFFCFC
      FCFFFCFCFCFFFCFCFCFFFBFBFBFFFBFBFBFFFAFAFAFFFCFCFCFFFDFDFDFFFCFC
      FCFFFDFDFDFFFEFEFEFFFDFDFDFFFEFEFEFFFDFDFDFFFDFDFDFFFEFEFEFFFDFD
      FDFFFEFEFEFFFEFEFEFFFDFDFDFFFEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFDFFEBEB
      EBFFEDEDEDFFFEFEFEFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFFFFF83FFFF00000000
      FFC00007FFC00007FF0001FF00000000FF800001FF800001FC00007F00000000
      FF000000FF000000F800003F00000000FE000000FE000000F000001F00000000
      FE000000FE000000C000001F00000000FE000000FE0000008000000700000000
      F0000000F00000000000000300000000F0000000F00000000000000100000000
      F0000000F00000000000000100000000F0000000F0000000C000000100000000
      F0000000F0000000F000000300000000F0000000F0000000F800000700000000
      F0000000F0000000F000000F00000000E0000001E0000001E000000F00000000
      8000000180000001C0000007000000000000000300000003C000000700000000
      000000070000000780000003000000000000000F0000000F8000000000000000
      0000000F0000000F00000000000000000000000F0000000F0000000000000000
      000000070000000780000000000000000000000700000007E000000100000000
      0000000700000007F8000003000000008000000780000007FC00000300000000
      E0E00007E0E00007FC00000700000000FFE0000FFFE0000FFC00000F00000000
      FFE0000FFFE0000FFE00000F00000000FFF0000FFFF0000FFE00001F00000000
      FFF0001FFFF0001FFF00001F00000000FFF8003FFFF8003FFF80103F00000000
      FFFE00FFFFFE00FFFFC07C7F0000000080000000FFF00FFFFFFE0FFF00000000
      80000001FF00007FFFFE0FFF00000000C0000001FC00003FFFFC0FFF00000000
      C0000001FC00001FFFFC0FF800000000E0000000FC00001FF87C07C000000000
      E0000000F800000FF038030100000000F0000000F0000007F000000100000000
      F0000000E0000003F000000100000000F0000000C0000003F000000300000000
      F0000000C0000001F800000300000000F000000080000001FC00000700000000
      E000000080000001FC00000700000000C000000080000000FC00000700000000
      C000000080000000F8000007000000008000000000000000E000000F00000000
      80000000000000000000000F0000000000000000000000000000000F00000000
      00000000000000000000000F0000000000000000000000000000000F00000000
      00000000800000000000000F000000000000000080000000E000000F00000000
      000001FF80000001F800001F00000000000001FF80000001FC00001F00000000
      000001FFC0000001FC00003F00000000000003FFC0000003FC00003F00000000
      800003FFE0000003F800007F00000000800007FFE0000007F00001FF00000000
      C00007FFF000000FF00007FF00000000E0000FFFF800001FF013FFFF00000000
      F0001FFFFE00003FE03FFFFF00000000F8007FFFFF0000FFE0FFFFFF00000000
      FE01FFFFFFE003FFE3FFFFFF0000000000000000FFFFFFFFFFC3FFFFFFE007FF
      00000000FFFE1FFFFF00FFFFFC00003F00000000FFC000FFFE0043FFF0000007
      00000000FF00003FFE0001FFE000000700000000FF00003FFE0000FFF0000007
      00000000FF00003FFE0000FFF800001F00000000FF00003FFE0000FFFFC003FF
      00000000FE00003FFE000007FFE007FF00000000FC00007FF0000003FFE007FF
      00000000F800003FE0000001FFE007FF00000000F000001FC0000001FFE007FF
      00000000E000000FC0000001FFC003FF00000000E000000FC0000001FF0001FF
      00000000E000000FE0000001FE0000FF00000000C0000007E0000001FE00007F
      00000000C0000007C0000003FC00003F00000000C000000780000007FC00003F
      00000000C000000780000003FC00003F00000000C000000780000003FC00003F
      00000000C000000780000001FC00003F00000000C000000780000001FC00003F
      00000000C000000780000001FC00003F00000000E000000FC0000003FC00003F
      00000000E000000FE0000003FC00003F00000000E000001FFE00001FFC00003F
      00000000F000001FFE00007FFE00007F00000000F800003FFE00007FFF0000FF
      00000000FC00007FFE00007FFF8000FF00000000FE0000FFFE00007FFFC003FF
      00000000FF0001FFFF02007FFFF00FFF00000000FFC00FFFFF8700FFFFFFFFFF
      00000000FFFFFFFFFFFFC3FFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object JabberTimer: TTimer
    Enabled = False
    Interval = 15000
    OnTimer = JabberTimerTimer
    Left = 16
    Top = 56
  end
  object ICQTimer: TTimer
    Enabled = False
    Interval = 15000
    OnTimer = ICQTimerTimer
    Left = 16
    Top = 88
  end
  object dlgOpen: TOpenDialog
    Filter = 'DLL (*.dll)|*.DLL'
    Left = 16
    Top = 120
  end
  object Tray: TTrayIcon
    Hint = '[Atomic Calculator] - "Bot version"'
    OnDblClick = TrayDblClick
    Left = 16
    Top = 152
  end
  object mnuMain: TMainMenu
    Left = 16
    Top = 184
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
end
