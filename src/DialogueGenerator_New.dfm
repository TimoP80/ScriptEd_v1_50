object FormDialogueGen: TFormDialogueGen
  Left = 400
  Top = 200
  Caption = 'Dialogue Generator'
  ClientHeight = 520
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 604
    Height = 464
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'NPC Response'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 580
        Height = 420
        Caption = 'Generate NPC reply'
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 24
          Width = 107
          Height = 13
          Caption = 'NPC description / role:'
        end
        object Label2: TLabel
          Left = 16
          Top = 72
          Width = 59
          Height = 13
          Caption = 'Player says:'
        end
        object LabelExistingNPC: TLabel
          Left = 16
          Top = 204
          Width = 66
          Height = 13
          Caption = 'NPC last said:'
          Enabled = False
        end
        object LabelExistingPlayer: TLabel
          Left = 296
          Top = 204
          Width = 76
          Height = 13
          Caption = 'Player last said:'
          Enabled = False
        end
        object EditNodeDesc: TEdit
          Left = 16
          Top = 40
          Width = 545
          Height = 21
          TabOrder = 0
        end
        object MemoPlayerText: TMemo
          Left = 16
          Top = 88
          Width = 545
          Height = 89
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object CheckBoxContinue: TCheckBox
          Left = 16
          Top = 183
          Width = 200
          Height = 17
          Caption = 'Continue from existing dialogue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          OnClick = CheckBoxContinueClick
        end
        object MemoExistingNPC: TMemo
          Left = 16
          Top = 220
          Width = 265
          Height = 49
          Enabled = False
          ScrollBars = ssVertical
          TabOrder = 2
        end
        object MemoExistingPlayer: TMemo
          Left = 296
          Top = 220
          Width = 265
          Height = 49
          Enabled = False
          ScrollBars = ssVertical
          TabOrder = 3
        end
        object ButtonGenNPC: TButton
          Left = 16
          Top = 278
          Width = 105
          Height = 25
          Caption = 'Generate Reply'
          TabOrder = 4
          OnClick = ButtonGenNPCClick
        end
        object MemoNPCResult: TMemo
          Left = 16
          Top = 310
          Width = 545
          Height = 89
          ScrollBars = ssVertical
          TabOrder = 6
        end
        object ButtonCopyNPC: TButton
          Left = 128
          Top = 278
          Width = 97
          Height = 25
          Caption = 'Copy to Clipboard'
          TabOrder = 5
          OnClick = ButtonCopyNPCClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Player Options'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 580
        Height = 380
        Caption = 'Generate player dialogue options'
        TabOrder = 0
        object Label3: TLabel
          Left = 16
          Top = 24
          Width = 43
          Height = 13
          Caption = 'Context:'
        end
        object EditContext: TEdit
          Left = 16
          Top = 40
          Width = 545
          Height = 21
          TabOrder = 0
        end
        object ButtonGenOptions: TButton
          Left = 16
          Top = 72
          Width = 105
          Height = 25
          Caption = 'Generate Options'
          TabOrder = 1
          OnClick = ButtonGenOptionsClick
        end
        object MemoOptionsResult: TMemo
          Left = 16
          Top = 104
          Width = 545
          Height = 257
          ScrollBars = ssVertical
          TabOrder = 2
        end
        object ButtonCopyOptions: TButton
          Left = 128
          Top = 72
          Width = 97
          Height = 25
          Caption = 'Copy to Clipboard'
          TabOrder = 3
          OnClick = ButtonCopyOptionsClick
        end
        object ButtonCreateNodes: TButton
          Left = 232
          Top = 72
          Width = 113
          Height = 25
          Caption = 'Create Nodes &Options'
          TabOrder = 4
          OnClick = ButtonCreateNodesClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Journal Entry'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 580
        Height = 380
        Caption = 'Generate journal entry'
        TabOrder = 0
        object Label4: TLabel
          Left = 16
          Top = 24
          Width = 64
          Height = 13
          Caption = 'Topic or clue:'
        end
        object EditJournalTopic: TEdit
          Left = 16
          Top = 40
          Width = 545
          Height = 21
          TabOrder = 0
        end
        object CheckBoxSmart: TCheckBox
          Left = 16
          Top = 72
          Width = 150
          Height = 17
          Caption = 'Detailed / sophisticated'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object ButtonGenJournal: TButton
          Left = 200
          Top = 68
          Width = 105
          Height = 25
          Caption = 'Generate Entry'
          TabOrder = 2
          OnClick = ButtonGenJournalClick
        end
        object MemoJournalResult: TMemo
          Left = 16
          Top = 104
          Width = 545
          Height = 257
          ScrollBars = ssVertical
          TabOrder = 3
        end
        object ButtonCopyJournal: TButton
          Left = 312
          Top = 68
          Width = 97
          Height = 25
          Caption = 'Copy to Clipboard'
          TabOrder = 4
          OnClick = ButtonCopyJournalClick
        end
      end
    end
  end
end
