object MainForm: TMainForm
  Left = 390
  Top = 0
  Caption = 'ScriptEd 1.50 - []'
  ClientHeight = 702
  ClientWidth = 1133
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    1133
    702)
  PixelsPerInch = 96
  TextHeight = 13
  object ScriptEditor: TSynEdit
    Left = 8
    Top = 47
    Width = 1112
    Height = 481
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'DejaVu Sans Mono'
    Font.Pitch = fpFixed
    Font.Style = []
    TabOrder = 0
    OnKeyDown = ScriptEditorKeyDown
    OnKeyUp = ScriptEditorKeyUp
    OnMouseDown = ScriptEditorMouseDown
    CodeFolding.GutterShapeSize = 11
    CodeFolding.CollapsedLineColor = clGrayText
    CodeFolding.FolderBarLinesColor = clGrayText
    CodeFolding.IndentGuidesColor = clGray
    CodeFolding.IndentGuides = True
    CodeFolding.ShowCollapsedLine = False
    CodeFolding.ShowHintMark = True
    UseCodeFolding = False
    Gutter.Color = clActiveBorder
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.ZeroStart = True
    Gutter.GradientStartColor = clHotLight
    Gutter.GradientSteps = 78
    Highlighter = SynGeneralSyn1
    Options = [eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
    SearchEngine = SynEditSearch1
    FontSmoothing = fsmNone
  end
  object CompilerLog: TMemo
    Left = 8
    Top = 534
    Width = 1115
    Height = 147
    Anchors = [akLeft, akRight, akBottom]
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 677
    Width = 1133
    Height = 25
    Panels = <>
    SimplePanel = True
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1133
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 103
    Caption = 'ToolBar1'
    Images = ImageList1
    ShowCaptions = True
    TabOrder = 3
    Transparent = True
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'Compile script'
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 103
      Top = 0
      Caption = 'Edit Dialogue'
      ImageIndex = 1
      OnClick = ToolButton2Click
    end
    object ToolButton5: TToolButton
      Left = 206
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 214
      Top = 0
      Caption = 'Edit Global Flags'
      ImageIndex = 2
      OnClick = ToolButton3Click
    end
    object ToolButton4: TToolButton
      Left = 317
      Top = 0
      Caption = 'Edit Global Variables'
      ImageIndex = 2
      OnClick = ToolButton4Click
    end
    object ToolButton6: TToolButton
      Left = 420
      Top = 0
      Caption = 'Edit Internal Names'
      ImageIndex = 2
      OnClick = ToolButton6Click
    end
    object ToolButton7: TToolButton
      Left = 523
      Top = 0
      Caption = 'Edit Descriptions'
      ImageIndex = 2
      OnClick = ToolButton7Click
    end
  end
  object XPManifest1: TXPManifest
    Left = 616
    Top = 72
  end
  object SynGeneralSyn1: TSynGeneralSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    CommentAttri.Foreground = clGreen
    Comments = [csAnsiStyle, csPasStyle, csCStyle, csCPPStyle]
    DetectPreprocessor = False
    IdentifierChars = 
      '!"#$%&'#39'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`' +
      'abcdefghijklmnopqrstuvwxyz{|}~'#8364#129#8218#402#8222#8230#8224#8225#710#8240#352#8249#338#141#381#143#144#8216#8217#8220#8221#8226#8211#8212#732#8482#353#8250#339#157#382#376#160 +
      #161#162#163#164#165#166#167#168#169#170#171#172#173#174#175#176#177#178#179#180#181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197#198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214#215#216#217#218#219#220#221#222#223#224 +
      #225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#240#241#242#243#244#245#246#247#248#249#250#251#252#253#254#255
    KeyAttri.Foreground = clNavy
    KeyWords.Strings = (
      'DESCRIPTION'
      'ELSE'
      'FLAGS'
      'IF'
      'MAX_LINES_ALLOCATED'
      'THEN')
    NumberAttri.Foreground = clBlue
    StringAttri.Foreground = clBlue
    StringDelim = sdDoubleQuote
    StringMultiLine = False
    Left = 664
    Top = 120
  end
  object MainMenu1: TMainMenu
    Left = 664
    Top = 72
    object File1: TMenuItem
      Caption = 'File'
      object Newscript1: TMenuItem
        Caption = 'New script'
        OnClick = Newscript1Click
      end
      object Loadscript1: TMenuItem
        Caption = 'Load script'
        OnClick = Loadscript1Click
      end
      object Loadofficialscript1: TMenuItem
        Caption = 'Load "official" script'
        OnClick = Loadofficialscript1Click
      end
      object Savescript1: TMenuItem
        Caption = 'Save script'
        OnClick = Savescript1Click
      end
      object Savescriptas1: TMenuItem
        Caption = 'Save script as...'
        OnClick = Savescriptas1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Selectmodule1: TMenuItem
        Caption = 'Select module'
        OnClick = Selectmodule1Click
      end
      object Preferences1: TMenuItem
        Caption = 'Preferences...'
        OnClick = Preferences1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Quit1: TMenuItem
        Caption = 'Quit'
        OnClick = Quit1Click
      end
    end
    object Script1: TMenuItem
      Caption = 'Script'
      object Compile1: TMenuItem
        Caption = 'Compile'
        ShortCut = 16504
        OnClick = Compile1Click
      end
      object SetscriptID1: TMenuItem
        Caption = 'Set script ID'
        OnClick = SetscriptID1Click
      end
      object Properties1: TMenuItem
        Caption = 'Properties'
        OnClick = Properties1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Action1: TMenuItem
        Caption = 'Action'
        ShortCut = 32833
        OnClick = Action1Click
      end
      object Condition1: TMenuItem
        Caption = 'Condition'
        ShortCut = 32835
        OnClick = Condition1Click
      end
      object ConditionStatement1: TMenuItem
        Caption = 'Condition + Actions'
        OnClick = ConditionStatement1Click
      end
      object Undocompile1: TMenuItem
        Caption = 'Undo compile'
        Enabled = False
        ShortCut = 16474
        OnClick = Undocompile1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Createdialogue1: TMenuItem
        Caption = 'Create dialogue'
        OnClick = Createdialogue1Click
      end
      object Removedialogue1: TMenuItem
        Caption = 'Remove dialogue'
        Enabled = False
      end
      object DialogueEditor1: TMenuItem
        Caption = 'Dialogue Editor'
        Enabled = False
        ShortCut = 16452
        OnClick = DialogueEditor1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Generatedialogue1: TMenuItem
        Caption = 'Dialogue Generator...'
        OnClick = Generatedialogue1Click
      end
    end
    object Module1: TMenuItem
      Caption = 'Module:'
      Visible = False
      object LoadScript2: TMenuItem
        Caption = 'Load Script'
        OnClick = LoadScript2Click
      end
      object Recentlyeditedscripts1: TMenuItem
        Caption = 'Recently edited scripts:'
        Enabled = False
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object InternalData1: TMenuItem
        Caption = 'Internal Data'
        object EditGlobalFlags1: TMenuItem
          Caption = 'Edit Global Flags'
          OnClick = EditGlobalFlags1Click
        end
        object EditGlobalVariables1: TMenuItem
          Caption = 'Edit Global Variables'
          OnClick = EditGlobalVariables1Click
        end
        object EditPCFlags1: TMenuItem
          Caption = 'Edit PC Flags'
          OnClick = EditPCFlags1Click
        end
        object EditPCVariables1: TMenuItem
          Caption = 'Edit PC Variables'
          OnClick = EditPCVariables1Click
        end
        object EditInternalNames1: TMenuItem
          Caption = 'Edit Internal Names'
          OnClick = EditInternalNames1Click
        end
        object EditFactions1: TMenuItem
          Caption = 'Edit Factions'
          OnClick = EditFactions1Click
        end
      end
      object GameText1: TMenuItem
        Caption = 'Game Text'
        object Quests1: TMenuItem
          Caption = 'Quests'
          object QuestEntries1: TMenuItem
            Caption = 'Edit Quest Entries'
            OnClick = QuestEntries1Click
          end
        end
        object Rumors1: TMenuItem
          Caption = 'Rumors'
          object Editjournalentries1: TMenuItem
            Caption = 'Edit journal entries'
            OnClick = Editjournalentries1Click
          end
          object Editreputations1: TMenuItem
            Caption = 'Edit reputations'
            OnClick = Editreputations1Click
          end
          object Editreputationlog1: TMenuItem
            Caption = 'Edit reputation log'
            OnClick = Editreputationlog1Click
          end
        end
        object Written1: TMenuItem
          Caption = 'Written'
          object Books1: TMenuItem
            Caption = 'Books'
            OnClick = Books1Click
          end
          object Notes1: TMenuItem
            Caption = 'Notes'
            OnClick = Notes1Click
          end
          object elegrams1: TMenuItem
            Caption = 'Telegrams'
            OnClick = elegrams1Click
          end
          object Newspapers1: TMenuItem
            Caption = 'Newspapers'
            OnClick = Newspapers1Click
          end
        end
        object WorldEdData1: TMenuItem
          Caption = 'WorldEd Data'
          object StoryState1: TMenuItem
            Caption = 'Story State'
            OnClick = StoryState1Click
          end
          object Description1: TMenuItem
            Caption = 'Descriptions'
            OnClick = Description1Click
          end
          object Keys1: TMenuItem
            Caption = 'Keys'
            OnClick = Keys1Click
          end
        end
      end
      object Selectmessagefiletoedit1: TMenuItem
        Caption = 'Edit other MES file'
        OnClick = Selectmessagefiletoedit1Click
      end
    end
    object HelperScripts1: TMenuItem
      Caption = 'Helper Scripts'
    end
    object Plugins1: TMenuItem
      Caption = 'Plugins'
    end
    object DeveloperTools1: TMenuItem
      Caption = 'Developer Tools'
      object Dumpscriptingfunctionstoatextfile1: TMenuItem
        Caption = 'Dump scripting functions to a text file'
        OnClick = Dumpscriptingfunctionstoatextfile1Click
      end
      object EditscriptattachmentpointMESdata1: TMenuItem
        Caption = 'Edit script attachment point MES data'
        OnClick = EditscriptattachmentpointMESdata1Click
      end
      object EditAttachmentPointdescriptions1: TMenuItem
        Caption = 'Edit Attachment Point descriptions'
        OnClick = EditAttachmentPointdescriptions1Click
      end
      object CreatenewMESfile1: TMenuItem
        Caption = 'Create new MES file'
        OnClick = CreatenewMESfile1Click
      end
      object Editmesfile1: TMenuItem
        Caption = 'Edit mes file'
        OnClick = Editmesfile1Click
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
  object OpenDialog1: TOpenDialog
    DefaultExt = 'scr'
    Filter = 
      'Arcanum Script files (*.scr)|*.scr|Text files (*.txt)|*.txt|All ' +
      'files (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 728
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'scr'
    Filter = 
      'Arcanum Script files (*.scr)|*.scr|Text files (*.txt)|*.txt|All ' +
      'files (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 760
    Top = 16
  end
  object SynEditSearch1: TSynEditSearch
    Left = 552
    Top = 120
  end
  object DelphiWebScriptII1: TDelphiWebScript
    Config.CompilerOptions = []
    Left = 536
    Top = 72
  end
  object dws2Unit1: TdwsUnit
    Script = DelphiWebScriptII1
    Constants = <
      item
        Name = 'SC_DAYTIME'
        DataType = 'Integer'
        Value = 1
      end
      item
        Name = 'SC_OBJ_HAS_GOLD_NUM'
        DataType = 'Integer'
        Value = 2
      end
      item
        Name = 'SC_LOCAL_FLAG_IS_SET'
        DataType = 'Integer'
        Value = 3
      end
      item
        Name = 'SC_NUM_EQUALS_NUM'
        DataType = 'Integer'
        Value = 4
      end
      item
        Name = 'SC_NUM_LESS_OR_EQUAL_NUM'
        DataType = 'Integer'
        Value = 5
      end
      item
        Name = 'SC_PC_HAS_QUEST_IN_STATE'
        DataType = 'Integer'
        Value = 6
      end
      item
        Name = 'SC_QUEST_IN_GLOBAL_STATE'
        DataType = 'Integer'
        Value = 7
      end
      item
        Name = 'SC_OBJ_HAS_BLESS'
        DataType = 'Integer'
        Value = 8
      end
      item
        Name = 'SC_OBJ_HAS_CURSE'
        DataType = 'Integer'
        Value = 9
      end
      item
        Name = 'SC_NPC_OBJ_HAS_MET_PC_OBJ_BEFORE'
        DataType = 'Integer'
        Value = 10
      end
      item
        Name = 'SC_OBJ_HAS_BAD_ASSOCIATES'
        DataType = 'Integer'
        Value = 11
      end
      item
        Name = 'SC_OBJ_IS_POLYMORPHED'
        DataType = 'Integer'
        Value = 12
      end
      item
        Name = 'SC_OBJ_IS_SHRUNK'
        DataType = 'Integer'
        Value = 13
      end
      item
        Name = 'SC_OBJ_HAS_BODY_SPELL'
        DataType = 'Integer'
        Value = 14
      end
      item
        Name = 'SC_OBJ_IS_INVISIBLE'
        DataType = 'Integer'
        Value = 15
      end
      item
        Name = 'SC_OBJ_HAS_MIRROR_IMAGE'
        DataType = 'Integer'
        Value = 16
      end
      item
        Name = 'SC_OBJ_HAS_ITEM_NAMED_OBJ'
        DataType = 'Integer'
        Value = 17
      end
      item
        Name = 'SC_NPC_IS_A_FOLLOWER_OF_PC'
        DataType = 'Integer'
        Value = 18
      end
      item
        Name = 'SC_NPC_OBJ_IS_A_MONSTER_OF_SPECIES'
        DataType = 'Integer'
        Value = 19
      end
      item
        Name = 'SC_OBJ_IS_NAMED_NUM'
        DataType = 'Integer'
        Value = 20
      end
      item
        Name = 'SC_OBJ_IS_WIELDING_ITEM'
        DataType = 'Integer'
        Value = 21
      end
      item
        Name = 'SC_OBJ_IS_DEAD'
        DataType = 'Integer'
        Value = 22
      end
      item
        Name = 'SC_OBJ_HAS_MAXIMUM_FOLLOWERS'
        DataType = 'Integer'
        Value = 23
      end
      item
        Name = 'SC_OBJ_CAN_OPEN_THE_CONTAINER_OBJ'
        DataType = 'Integer'
        Value = 24
      end
      item
        Name = 'SC_OBJ_HAS_SURRENDERED'
        DataType = 'Integer'
        Value = 25
      end
      item
        Name = 'SC_OBJ_IS_IN_DIALOG'
        DataType = 'Integer'
        Value = 26
      end
      item
        Name = 'SC_OBJ_IS_SWITCHED_OFF'
        DataType = 'Integer'
        Value = 27
      end
      item
        Name = 'SC_OBJ_CAN_SEE_OBJ'
        DataType = 'Integer'
        Value = 28
      end
      item
        Name = 'SC_OBJ_CAN_HEAR_OBJ'
        DataType = 'Integer'
        Value = 29
      end
      item
        Name = 'SC_OBJ_IS_INVULNERABLE'
        DataType = 'Integer'
        Value = 30
      end
      item
        Name = 'SC_OBJ_IS_IN_COMBAT'
        DataType = 'Integer'
        Value = 31
      end
      item
        Name = 'SC_OBJ_IS_AT_LOCATION_XY'
        DataType = 'Integer'
        Value = 32
      end
      item
        Name = 'SC_OBJ_HAS_REPUTATION_NUM'
        DataType = 'Integer'
        Value = 33
      end
      item
        Name = 'SC_OBJ_IS_WITHIN_NUM_TILES_OF_LOCATION_XY'
        DataType = 'Integer'
        Value = 34
      end
      item
        Name = 'SC_OBJ_IS_UNDER_THE_INFLUENCE_OF_SPELL_NUM'
        DataType = 'Integer'
        Value = 35
      end
      item
        Name = 'SC_OBJ_IS_OPEN'
        DataType = 'Integer'
        Value = 36
      end
      item
        Name = 'SC_OBJ_IS_AN_ANIMAL'
        DataType = 'Integer'
        Value = 37
      end
      item
        Name = 'SC_OBJ_IS_UNDEAD'
        DataType = 'Integer'
        Value = 38
      end
      item
        Name = 'SC_OBJ_WAS_JILTED_BY_A_PC'
        DataType = 'Integer'
        Value = 39
      end
      item
        Name = 'SC_PC_OBJ_KNOWS_RUMOR_NUM'
        DataType = 'Integer'
        Value = 40
      end
      item
        Name = 'SC_RUMOR_HAS_BEEN_QUELLED'
        DataType = 'Integer'
        Value = 41
      end
      item
        Name = 'SC_OBJ_IS_BUSTED'
        DataType = 'Integer'
        Value = 42
      end
      item
        Name = 'SC_GLOBAL_FLAG_NUM_IS_SET'
        DataType = 'Integer'
        Value = 43
      end
      item
        Name = 'SC_OBJ_CAN_OPEN_THE_PORTAL_OBJ_IN_DIRECTION_NUM'
        DataType = 'Integer'
        Value = 44
      end
      item
        Name = 'SC_SECTOR_AT_LOCATION_IS_BLOCKED'
        DataType = 'Integer'
        Value = 45
      end
      item
        Name = 'SC_MONSTER_GENERATOR_IS_DISABLED'
        DataType = 'Integer'
        Value = 46
      end
      item
        Name = 'SC_OBJ_IS_IDENTIFIED'
        DataType = 'Integer'
        Value = 47
      end
      item
        Name = 'SC_OBJ_KNOWS_SPELL_NUM'
        DataType = 'Integer'
        Value = 48
      end
      item
        Name = 'SC_OBJ_HAS_MASTERED_SPELL_COLLEGE_NUM'
        DataType = 'Integer'
        Value = 49
      end
      item
        Name = 'SC_ITEMS_ARE_BEING_REWIELDED'
        DataType = 'Integer'
        Value = 50
      end
      item
        Name = 'SC_OBJ_IS_PROWLING'
        DataType = 'Integer'
        Value = 51
      end
      item
        Name = 'SC_OBJ_IS_WAITING_FOR_LEADERS_RETURN'
        DataType = 'Integer'
        Value = 52
      end
      item
        Name = 'SA_DO_NOTHING'
        DataType = 'Integer'
        Value = 0
      end
      item
        Name = 'SA_RETURN_SKIP'
        DataType = 'Integer'
        Value = 1
      end
      item
        Name = 'SA_RETURN_RUN'
        DataType = 'Integer'
        Value = 2
      end
      item
        Name = 'SA_GO_TO_LINE'
        DataType = 'Integer'
        Value = 3
      end
      item
        Name = 'SA_DIALOG'
        DataType = 'Integer'
        Value = 4
      end
      item
        Name = 'SA_REMOVE_SCRIPT'
        DataType = 'Integer'
        Value = 5
      end
      item
        Name = 'SA_CHANGE_SCRIPT'
        DataType = 'Integer'
        Value = 6
      end
      item
        Name = 'SA_CALL_SCRIPT'
        DataType = 'Integer'
        Value = 7
      end
      item
        Name = 'SA_SET_LOCAL_FLAG'
        DataType = 'Integer'
        Value = 8
      end
      item
        Name = 'SA_CLEAR_LOCAL_FLAG'
        DataType = 'Integer'
        Value = 9
      end
      item
        Name = 'SA_NUM_ASSIGN'
        DataType = 'Integer'
        Value = 10
      end
      item
        Name = 'SA_NUM_ADD'
        DataType = 'Integer'
        Value = 11
      end
      item
        Name = 'SA_NUM_SUBTRACT'
        DataType = 'Integer'
        Value = 12
      end
      item
        Name = 'SA_NUM_MULTIPLY'
        DataType = 'Integer'
        Value = 13
      end
      item
        Name = 'SA_NUM_DIVIDE'
        DataType = 'Integer'
        Value = 14
      end
      item
        Name = 'SA_OBJ_ASSIGN'
        DataType = 'Integer'
        Value = 15
      end
      item
        Name = 'SA_SET_PC_QUEST_STATE'
        DataType = 'Integer'
        Value = 16
      end
      item
        Name = 'SA_SET_GLOBAL_QUEST_STATE'
        DataType = 'Integer'
        Value = 17
      end
      item
        Name = 'SA_LOOP_FOR'
        DataType = 'Integer'
        Value = 18
      end
      item
        Name = 'SA_LOOP_END'
        DataType = 'Integer'
        Value = 19
      end
      item
        Name = 'SA_LOOP_BREAK'
        DataType = 'Integer'
        Value = 20
      end
      item
        Name = 'SA_CRITTER_PARTY_ADD'
        DataType = 'Integer'
        Value = 21
      end
      item
        Name = 'SA_CRITTER_PARTY_REMOVE'
        DataType = 'Integer'
        Value = 22
      end
      item
        Name = 'SA_FLOAT_LINE'
        DataType = 'Integer'
        Value = 23
      end
      item
        Name = 'SA_PRINT_LINE'
        DataType = 'Integer'
        Value = 24
      end
      item
        Name = 'SA_BLESSING_ADD'
        DataType = 'Integer'
        Value = 25
      end
      item
        Name = 'SA_BLESSING_REMOVE'
        DataType = 'Integer'
        Value = 26
      end
      item
        Name = 'SA_CURSE_ADD'
        DataType = 'Integer'
        Value = 27
      end
      item
        Name = 'SA_CURSE_REMOVE'
        DataType = 'Integer'
        Value = 28
      end
      item
        Name = 'SA_STORE_REACTION'
        DataType = 'Integer'
        Value = 29
      end
      item
        Name = 'SA_SET_REACTION'
        DataType = 'Integer'
        Value = 30
      end
      item
        Name = 'SA_ADJUST_REACTION'
        DataType = 'Integer'
        Value = 31
      end
      item
        Name = 'SA_STORE_ARMOR'
        DataType = 'Integer'
        Value = 32
      end
      item
        Name = 'SA_STORE_STAT'
        DataType = 'Integer'
        Value = 33
      end
      item
        Name = 'SA_STORE_OBJECT_TYPE'
        DataType = 'Integer'
        Value = 34
      end
      item
        Name = 'SA_ADJUST_GOLD'
        DataType = 'Integer'
        Value = 35
      end
      item
        Name = 'SA_CRITTER_ATTACK'
        DataType = 'Integer'
        Value = 36
      end
      item
        Name = 'SA_RANDOM_NUMBER'
        DataType = 'Integer'
        Value = 37
      end
      item
        Name = 'SA_SOCIAL_CLASS'
        DataType = 'Integer'
        Value = 38
      end
      item
        Name = 'SA_NPC_ORIGIN_STORE'
        DataType = 'Integer'
        Value = 39
      end
      item
        Name = 'SA_TRANSFORM_TO_BASIC_PROTO'
        DataType = 'Integer'
        Value = 40
      end
      item
        Name = 'SA_TRANSFER_NAMED_ITEM'
        DataType = 'Integer'
        Value = 41
      end
      item
        Name = 'SA_STORY_STATE_STORE'
        DataType = 'Integer'
        Value = 42
      end
      item
        Name = 'SA_STORY_STATE_SET'
        DataType = 'Integer'
        Value = 43
      end
      item
        Name = 'SA_TELEPORT_OBJECT'
        DataType = 'Integer'
        Value = 44
      end
      item
        Name = 'SA_DAY_STAND_POINT_SET_CURRENT_MAP'
        DataType = 'Integer'
        Value = 45
      end
      item
        Name = 'SA_NIGHT_STAND_POINT_SET_CURRENT_MAP'
        DataType = 'Integer'
        Value = 46
      end
      item
        Name = 'SA_SKILL_STORE'
        DataType = 'Integer'
        Value = 47
      end
      item
        Name = 'SA_CAST_SPELL'
        DataType = 'Integer'
        Value = 48
      end
      item
        Name = 'SA_MARK_LOCATION'
        DataType = 'Integer'
        Value = 49
      end
      item
        Name = 'SA_SET_RUMOR'
        DataType = 'Integer'
        Value = 50
      end
      item
        Name = 'SA_QUELL_RUMOR'
        DataType = 'Integer'
        Value = 51
      end
      item
        Name = 'SA_OBJ_CREATE'
        DataType = 'Integer'
        Value = 52
      end
      item
        Name = 'SA_LOCK_STATE_SET'
        DataType = 'Integer'
        Value = 53
      end
      item
        Name = 'SA_CALL_SCRIPT_IN_SECONDS'
        DataType = 'Integer'
        Value = 54
      end
      item
        Name = 'SA_CALL_SCRIPT_AT_SECOND'
        DataType = 'Integer'
        Value = 55
      end
      item
        Name = 'SA_OBJ_STATE_TOGGLE'
        DataType = 'Integer'
        Value = 56
      end
      item
        Name = 'SA_OBJ_INVULNERABLE_TOGGLE'
        DataType = 'Integer'
        Value = 57
      end
      item
        Name = 'SA_OBJ_KILL'
        DataType = 'Integer'
        Value = 58
      end
      item
        Name = 'SA_ART_CHANGE'
        DataType = 'Integer'
        Value = 59
      end
      item
        Name = 'SA_OBJ_DAMAGE'
        DataType = 'Integer'
        Value = 60
      end
      item
        Name = 'SA_CAST_SPELL_GLOBAL'
        DataType = 'Integer'
        Value = 61
      end
      item
        Name = 'SA_OBJ_ANIMATE'
        DataType = 'Integer'
        Value = 62
      end
      item
        Name = 'SA_GIVE_XP_QUEST_LEVEL'
        DataType = 'Integer'
        Value = 63
      end
      item
        Name = 'SA_WRITTEN_UI_START_BOOK'
        DataType = 'Integer'
        Value = 64
      end
      item
        Name = 'SA_WRITTEN_UI_START_IMAGE'
        DataType = 'Integer'
        Value = 65
      end
      item
        Name = 'SA_CREATE_ITEM_INSIDE_OBJ'
        DataType = 'Integer'
        Value = 66
      end
      item
        Name = 'SA_CRITTEr_WAIT_LEADER'
        DataType = 'Integer'
        Value = 67
      end
      item
        Name = 'SA_OBJ_DESTROY'
        DataType = 'Integer'
        Value = 68
      end
      item
        Name = 'SA_CRITTER_WALk'
        DataType = 'Integer'
        Value = 69
      end
      item
        Name = 'SA_STORE_WEAPON'
        DataType = 'Integer'
        Value = 70
      end
      item
        Name = 'SA_OBJ_DISTANCE_GET'
        DataType = 'Integer'
        Value = 71
      end
      item
        Name = 'SA_OBJ_GIVE_REP'
        DataType = 'Integer'
        Value = 72
      end
      item
        Name = 'SA_OBJ_REMOVE_REP'
        DataType = 'Integer'
        Value = 73
      end
      item
        Name = 'SA_CRITTER_RUN'
        DataType = 'Integer'
        Value = 74
      end
      item
        Name = 'SA_HEAL_POINTS'
        DataType = 'Integer'
        Value = 75
      end
      item
        Name = 'SA_HEAL_FATIGUE'
        DataType = 'Integer'
        Value = 76
      end
      item
        Name = 'SA_OBJ_EFFECT_GIVE'
        DataType = 'Integer'
        Value = 77
      end
      item
        Name = 'SA_OBJ_EFFECT_REMOVE'
        DataType = 'Integer'
        Value = 78
      end
      item
        Name = 'SA_USE_OBJ_ON_OBJ_WITH_SKILL_MOD'
        DataType = 'Integer'
        Value = 79
      end
      item
        Name = 'SA_ADJUST_MAGIC_TECH'
        DataType = 'Integer'
        Value = 80
      end
      item
        Name = 'SA_CALL_SCRIPT_ATTACHED_TO'
        DataType = 'Integer'
        Value = 81
      end
      item
        Name = 'SA_PLAY_SOUND'
        DataType = 'Integer'
        Value = 82
      end
      item
        Name = 'SA_PLAY_SOUND_AT'
        DataType = 'Integer'
        Value = 83
      end
      item
        Name = 'SA_OBJ_AREA_STORE'
        DataType = 'Integer'
        Value = 84
      end
      item
        Name = 'SA_QUEUE_NEWSPAPER'
        DataType = 'Integer'
        Value = 85
      end
      item
        Name = 'SA_FLOAT_NEWSPAPER_HEADLINE'
        DataType = 'Integer'
        Value = 86
      end
      item
        Name = 'SA_PLAY_SOUND_SCHEME'
        DataType = 'Integer'
        Value = 87
      end
      item
        Name = 'SA_OBJ_TOGGLE_OPEN_CLOSED'
        DataType = 'Integer'
        Value = 88
      end
      item
        Name = 'SA_STORE_FACTION'
        DataType = 'Integer'
        Value = 89
      end
      item
        Name = 'SA_SCROLL_DISTANCE_STORE'
        DataType = 'Integer'
        Value = 90
      end
      item
        Name = 'SA_MAGIC_TECH_ADJUST'
        DataType = 'Integer'
        Value = 91
      end
      item
        Name = 'SA_OBJ_RENAME'
        DataType = 'Integer'
        Value = 92
      end
      item
        Name = 'SA_OBJ_PRONE'
        DataType = 'Integer'
        Value = 93
      end
      item
        Name = 'SA_WRITTEN_START_IN_OBJ_SET'
        DataType = 'Integer'
        Value = 94
      end
      item
        Name = 'SA_OBJ_LOCATION_STORE'
        DataType = 'Integer'
        Value = 95
      end
      item
        Name = 'SA_STORE_DAYS_SINCE_STARTUP'
        DataType = 'Integer'
        Value = 96
      end
      item
        Name = 'SA_STORE_GAME_HOUR'
        DataType = 'Integer'
        Value = 97
      end
      item
        Name = 'SA_STORE_GAME_MINUTE'
        DataType = 'Integer'
        Value = 98
      end
      item
        Name = 'SA_OBJ_CHANGE_SCRIPT_AT_POINT'
        DataType = 'Integer'
        Value = 99
      end
      item
        Name = 'SA_SET_GLOBAL_FLAG'
        DataType = 'Integer'
        Value = 100
      end
      item
        Name = 'SA_CLEAR_GLOBAL_FLAG'
        DataType = 'Integer'
        Value = 101
      end
      item
        Name = 'SA_FADE_TELEPORT_MOVE'
        DataType = 'Integer'
        Value = 102
      end
      item
        Name = 'SA_FADE_WAIT_PLAY_SFX_MOVIE'
        DataType = 'Integer'
        Value = 103
      end
      item
        Name = 'SA_SPELL_EYECANDY_PLAY'
        DataType = 'Integer'
        Value = 104
      end
      item
        Name = 'SA_STORE_HOURS_SINCE_STARTUP'
        DataType = 'Integer'
        Value = 105
      end
      item
        Name = 'SA_BLOCKED_STATE_TOGGLE'
        DataType = 'Integer'
        Value = 106
      end
      item
        Name = 'SA_HITPOINTS_STORE_CURRENT_MAX'
        DataType = 'Integer'
        Value = 107
      end
      item
        Name = 'SA_FATIGUE_STORE_CURRENT_MAX'
        DataType = 'Integer'
        Value = 108
      end
      item
        Name = 'SA_COMBAT_OBJ_FORCE_STOP'
        DataType = 'Integer'
        Value = 109
      end
      item
        Name = 'SA_MONSTERGEN_TOGGLE'
        DataType = 'Integer'
        Value = 110
      end
      item
        Name = 'SA_ARMOR_COVERAGE_STORE'
        DataType = 'Integer'
        Value = 111
      end
      item
        Name = 'SA_OBJ_SPELL_MASTERY_GIVE'
        DataType = 'Integer'
        Value = 112
      end
      item
        Name = 'SA_TOWNMAP_UNFOG'
        DataType = 'Integer'
        Value = 113
      end
      item
        Name = 'SA_WRITTEN_UI_PLAQUE_START'
        DataType = 'Integer'
        Value = 114
      end
      item
        Name = 'SA_OBJ_STEAL_100_COINS'
        DataType = 'Integer'
        Value = 115
      end
      item
        Name = 'SA_STOP_SPELL_EYECANDY'
        DataType = 'Integer'
        Value = 116
      end
      item
        Name = 'SA_GIVE_FATE_POINT'
        DataType = 'Integer'
        Value = 117
      end
      item
        Name = 'SA_OBJ_FREE_SPELL_CAST'
        DataType = 'Integer'
        Value = 118
      end
      item
        Name = 'SA_PC_QUEST_UNBOTCHED'
        DataType = 'Integer'
        Value = 119
      end
      item
        Name = 'SA_PLAY_SCRIPT_EYECANDY'
        DataType = 'Integer'
        Value = 120
      end
      item
        Name = 'SA_OBJ_UNRESISTABLE_SPELL_CAST'
        DataType = 'Integer'
        Value = 121
      end
      item
        Name = 'SA_OBJ_FREE_UNRESISTABLE_SPELL_CAST'
        DataType = 'Integer'
        Value = 122
      end
      item
        Name = 'SA_TOUCH_ART'
        DataType = 'Integer'
        Value = 123
      end
      item
        Name = 'SA_STOP_SCRIPT_EYECANDY'
        DataType = 'Integer'
        Value = 124
      end
      item
        Name = 'SA_REMOVE_SCRIPT_CALL_FROM_QUEUE'
        DataType = 'Integer'
        Value = 125
      end
      item
        Name = 'SA_DESTROY_ITEM'
        DataType = 'Integer'
        Value = 126
      end
      item
        Name = 'SA_OBJ_INVENTORY_TOGGLE'
        DataType = 'Integer'
        Value = 127
      end
      item
        Name = 'SA_OBJ_POISON_HEAL'
        DataType = 'Integer'
        Value = 128
      end
      item
        Name = 'SA_DISPlAY_SCHEMATIC_UI'
        DataType = 'Integer'
        Value = 129
      end
      item
        Name = 'SA_STOP_SPELL'
        DataType = 'Integer'
        Value = 130
      end
      item
        Name = 'SA_QUEUE_SLIDE'
        DataType = 'Integer'
        Value = 131
      end
      item
        Name = 'SA_END_GAME_PLAY_SLIDES'
        DataType = 'Integer'
        Value = 132
      end
      item
        Name = 'SA_OBJ_SET_ROTATION'
        DataType = 'Integer'
        Value = 133
      end
      item
        Name = 'SA_SET_OBJ_FACTION'
        DataType = 'Integer'
        Value = 134
      end
      item
        Name = 'SA_DRAIN_CHARGES'
        DataType = 'Integer'
        Value = 135
      end
      item
        Name = 'SA_GLOBAL_CAST_UNRESISTABLE_SPELL'
        DataType = 'Integer'
        Value = 136
      end
      item
        Name = 'SA_OBJ_ADJUST_STAT'
        DataType = 'Integer'
        Value = 137
      end
      item
        Name = 'SA_DAMAGE_OBJ_UNRESISTABLE'
        DataType = 'Integer'
        Value = 138
      end
      item
        Name = 'SA_CHANGE_AUTOLEVEL_SCHEME'
        DataType = 'Integer'
        Value = 139
      end
      item
        Name = 'SA_OBJ_SET_DAY_STANDPOINT_ON_MAP'
        DataType = 'Integer'
        Value = 140
      end
      item
        Name = 'SA_OBJ_SET_NIGHT_STANDPOINT_ON_MAP'
        DataType = 'Integer'
        Value = 141
      end>
    Functions = <
      item
        Name = 'EditorAddLine'
        Parameters = <
          item
            Name = 'linedata'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = dws2Unit1FunctionsEditorAddLineEval
      end
      item
        Name = 'CompileScript'
        OnEval = dws2Unit1FunctionsCompileScriptEval
      end
      item
        Name = 'DebugMessage'
        Parameters = <
          item
            Name = 'data'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = dws2Unit1FunctionsDebugMessageEval
      end
      item
        Name = 'AddHelperScript'
        Parameters = <
          item
            Name = 'Filename'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Description'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Category'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = dws2Unit1FunctionsAddHelperScriptEval
      end
      item
        Name = 'AddScriptCommand'
        Parameters = <
          item
            Name = 'opcode'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'param1'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'param2'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'param3'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'param4'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'param5'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'param6'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'param7'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'param8'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = 0
          end
          item
            Name = 'pos'
            DataType = 'Integer'
            HasDefaultValue = True
            DefaultValue = -1
          end>
        OnEval = dws2Unit1FunctionsAddScriptCommandEval
      end
      item
        Name = 'SelectGlobalFlag'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectGlobalFlagEval
      end
      item
        Name = 'SelectGlobalVar'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectGlobalVarEval
      end
      item
        Name = 'SelectPCFlag'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectPCFlagEval
      end
      item
        Name = 'SelectPCVar'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectPCVarEval
      end
      item
        Name = 'SelectQuest'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectQuestEval
      end
      item
        Name = 'SelectRumor'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectRumorEval
      end
      item
        Name = 'SelectInternalName'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectInternalNameEval
      end
      item
        Name = 'ChooseScript'
        Parameters = <
          item
            Name = 'FilenameStorage'
            DataType = 'String'
            IsVarParam = True
            DefaultValue = ''
          end>
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsChooseScriptEval
      end
      item
        Name = 'ChooseFocus'
        ResultType = 'String'
        OnEval = dws2Unit1FunctionsChooseFocusEval
      end
      item
        Name = 'ChooseValue'
        ResultType = 'String'
        OnEval = dws2Unit1FunctionsChooseValueEval
      end
      item
        Name = 'SelectScriptLine'
        Parameters = <
          item
            Name = 'srcfile'
            DataType = 'String'
          end>
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectScriptLineEval
      end
      item
        Name = 'SelectLineFromCurrentScript'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectLineFromCurrentScriptEval
      end
      item
        Name = 'SelectBasicPrototype'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectBasicPrototypeEval
      end
      item
        Name = 'InitializeHelperScriptMenu'
        OnEval = dws2Unit1FunctionsInitializeHelperScriptMenuEval
      end
      item
        Name = 'GetEditorCursorPosition'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsGetEditorCursorPositionEval
      end
      item
        Name = 'InsertScriptLine'
        Parameters = <
          item
            Name = 'pos'
            DataType = 'Integer'
          end
          item
            Name = 'line'
            DataType = 'String'
          end>
        OnEval = dws2Unit1FunctionsInsertScriptLineEval
      end
      item
        Name = 'SelectScriptCallType'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectScriptCallTypeEval
      end
      item
        Name = 'ShowScriptInfo'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
          end
          item
            Name = 'description'
            DataType = 'String'
          end
          item
            Name = 'author'
            DataType = 'String'
          end
          item
            Name = 'infotext'
            DataType = 'String'
          end>
        OnEval = dws2Unit1FunctionsShowScriptInfoEval
      end
      item
        Name = 'ChooseFocus_Integer'
        Parameters = <
          item
            Name = 'Caption'
            DataType = 'String'
            HasDefaultValue = True
            DefaultValue = 'Choose focus type'
          end>
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsChooseFocus_IntegerEval
      end
      item
        Name = 'SelectAttachmentPoint'
        ResultType = 'Integer'
        OnEval = dws2Unit1FunctionsSelectAttachmentPointEval
      end
      item
        Name = 'QuestionDlg'
        Parameters = <
          item
            Name = 'Question'
            DataType = 'String'
          end>
        ResultType = 'Boolean'
        OnEval = dws2Unit1FunctionsQuestionDlgEval
      end>
    UnitName = 'ScriptEdUnit'
    Variables = <
      item
        Name = 'ModuleFolder'
        DataType = 'String'
        OnReadVar = dws2Unit1VariablesModuleFolderReadVar
        OnWriteVar = dws2Unit1VariablesModuleFolderWriteVar
      end
      item
        Name = 'ArcanumPath'
        DataType = 'String'
        OnReadVar = dws2Unit1VariablesArcanumPathReadVar
        OnWriteVar = dws2Unit1VariablesArcanumPathWriteVar
      end
      item
        Name = 'EditorYPosition'
        DataType = 'Integer'
        OnReadVar = dws2Unit1VariablesEditorYPositionReadVar
        OnWriteVar = dws2Unit1VariablesEditorYPositionWriteVar
      end>
    StaticSymbols = False
    Left = 696
    Top = 16
  end
  object dws2GUIFunctions1: TdwsGUIFunctions
    Left = 584
    Top = 120
  end
  object SynAutoCorrect1: TSynAutoCorrect
    Editor = ScriptEditor
    Options = []
    Left = 504
    Top = 48
  end
  object SynCompletionProposal1: TSynCompletionProposal
    Options = [scoLimitToMatchedText, scoUsePrettyText, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter]
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <>
    ShortCut = 16416
    Editor = ScriptEditor
    OnCodeCompletion = SynCompletionProposal1CodeCompletion
    Left = 440
    Top = 144
  end
  object JvMRUManager1: TJvMRUManager
    Duplicates = dupAccept
    IniStorage = JvFormStorage1
    RecentMenu = Recentlyeditedscripts1
    OnClick = JvMRUManager1Click
    Left = 368
    Top = 112
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = JvAppIniFileStorage1
    AppStoragePath = 'MainForm\'
    StoredValues = <>
    Left = 440
    Top = 96
  end
  object JvAppIniFileStorage1: TJvAppIniFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    AutoReload = True
    FileName = 'ScriptEdFormData.ini'
    SubStorages = <>
    Left = 200
    Top = 72
  end
  object ImageList1: TImageList
    Left = 176
    Top = 136
    Bitmap = {
      494C010103000C00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00F3F3F300EEEEEE00EEEEEF00F3F3F300FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DCB79600DCB79600DCB79600DCB7
      9600DCB79600DCB79600DCB79600DCB79600DCB79600DCB79600DCB79600DCB7
      9600DCB79600DCB79600DCB79600E0BC9D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F6F6
      F600FCFCFC00F0EEEB00DCD8D100D8D3CB00D8D3CB00E5E1DC00FCFCFB00ECEC
      ED00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F5F4F2000000000000000000000000000000
      000000000000000000000000000000000000EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00DCB48F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0F0F100F4F2
      F000D9D3CB00DBD6CE00DDD8D000DED9D100DDD8D100DCD7CF00DAD5CC00DBD6
      CF00FBFBFB00FCFCFC0000000000000000000000000000000000000000000000
      00000000000000000000D4CEC600FCFBFB000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00ACAFB300AAC9F000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DCB38A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1F1F100EDEBE700DAD5
      CC00DED9D100E0DCD500E2DED700E3DFD800E3DED800E1DDD600DFDAD300DCD7
      CF00D6D0C800FBFBFB0000000000000000000000000000000000000000000000
      000000000000E1DDD700F8F7F700000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0089B6EC006AA0ED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DBB183000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FCFBFB00DAD4CB00DED9
      D200E2DDD700E5E1DC00E7E3DE00E8E5E000E8E4DF00E6E2DD00E3DFD900E0DB
      D400DCD6CE00D9D3CB00E7E7E800000000000000000000000000000000000000
      000000000000F2F0EE00FBFBFB00000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7F9FC0089B6ED0069A0ED00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DAAF7C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1F1F100D7D1C800DDD8D000E1DD
      D600E6E1DC00D5D1CC00ACA8A100EEECE800EEEBE700EBE8E400E7E3DE00E3DF
      D900DFDAD300DAD4CB00FCFBFB00FEFEFE000000000000000000000000000000
      0000EFEDEA00FBFBFB00FDFDFD00E7E4E000EBE8E500E6E2DE00D5D0C800DBD6
      CF00FCFCFC00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F8FC008AB7ED00689FED00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D9AC75000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00DAD5CC00DFDAD300E4E0
      DA00E9E5E100D9D6D1006D675D006D675D00CFCCC600EFEDE900EBE7E300E6E1
      DC00E1DCD600E1DDD600E2DDD700EEEEEF000000000000000000E2DED900F3F2
      F100FBFBFB00FDFDFD00FDFDFD00FEFEFE00FDFDFD00FDFDFD00FBFBFB00FAFA
      FA00FAFAFA00BEB7AA000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F5F7FB008AB7ED00689F
      ED00FFFFFF00FFFFFF00FFFFFF00D8AB6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00E0DBD400E6E2DD00E5E1
      DC00DBD6CF00C4BFB6006D675D007A736700867D6F007E766A00CDC8BF00E5E1
      DB00E3DFD800E4E0DA00D3CCC200E4E4E40000000000C2BDB100F9F9F900FAFA
      FA00FBFBFB00FDFDFD00FDFDFD00FAFAFA00FEFEFE00FDFDFD00FCFCFC00FBFB
      FB00FAFAFA00F7F7F700B7AFA20000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F7FB008BB8
      ED00679EED00FFFFFF00FFFFFF00D8A965000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAF9F900E0DCD500E7E3DE00DBD6
      CF00D4CEC400C3BEB5006D675D007E7669008C83740080776B00756E6500D3CD
      C400E3DFD900E4E0DA00CCC4BA00E3E3E300C2BCB100F1F1F100F9F9F900FAFA
      FA00FBFBFB00FCFCFC00FDFDFD00C9D2DD00A4C8F100EFF3F900FBFBFB00FAFA
      FA00FAFAFA00F6F6F600EEEEEF00D9D5CE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F6
      FB008CB8ED00C9BEAD00FFFFFF00D6A65D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00DDD8D000DBD6CF00DCD7
      CF00DCD7D000C7C2B9006D675D00726B610079726600C7C2B800DCD7CF00DCD7
      CF00DCD7CF00E2DED800C7C0B600E8E8E800D7D4D000F0F0F000F5F6F600EBEB
      EC00ECECEC00ECECEC00EEEEEE00EEEEEE0072A6EB0082B1EE00E0E4E900EBEB
      EC00EBEBEC00F3F4F400ECEDED00B5AC9F00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F4F4F400DED7CF002228A400D5A452000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700C3BAAF00D1CAC000D8D3
      CB00DCD7CF00CAC4BC006D675D00B1ACA300DCD7CF00DCD7CF00DCD7CF00DAD5
      CD00D4CEC500CAC3B800E5E1DD00F7F7F700DAD9D700ECECED00F1F2F200E9E9
      EA00EAEAEA00EAEAEA00EAEAEB00EAEAEB00EAEAEB0073A7EB0082B0EE00E0E3
      E900E8E8E800F0F0F000E9EAEA00C8C1B800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00EAEAF600FEFEFE00D5A241000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1F1F100D7D2CB00C4BCB100CCC5
      BB00D2CCC300D0CAC200D9D4CC00DAD5CD00DAD4CD00D8D2CB00D4CEC500CFC8
      BE00C8C0B600B1A89900F5F5F60000000000AEA69800E8E9E900EFEFEF00F4F5
      F500F9F9F900FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA0073A7EB0081B0
      EE00E9ECF000ECECED00B6AFA300FDFDFD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D4A031000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F8F8F800A79D8E00BFB8
      AC00C5BEB300CAC2B800CCC4BB00CDC6BC00CCC5BB00CAC3B900C7BFB500C2BA
      AF00B1A89B00E9E6E300EFEFEF0000000000F6F5F400C6C2BB00E9EAEA00EFEF
      EF00F3F3F300F7F8F800F9F9F900FAFAFA00F9F9F900F9F9F900F6F6F60074A7
      EB0080AFEE00BFBDB900DFDEDA0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D29D31000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00FCFCFC009E95
      8500B3AB9F00BAB2A600BDB5A900BEB7AB00BDB6AA00BBB3A700B7AFA300A59C
      8D00D8D4CE00DFDFE000000000000000000000000000F9F9F800A9A09100E8E8
      E800ECEDED00F0F0F000F2F2F200F3F3F300F3F3F300F1F1F100EFEFEF00E0DF
      DD0074A8EB007FAFEE00F9FAFC0000000000EDEEEE00EDEEEE00EDEEEE00EDEE
      EE00EDEEEE00EDEEEE00EDEEEE00EDEEEE00EDEEEE00EDEEEE00EDEEEE00EDEE
      EE00EDEEEE00EDEEEE00EDEEEE00CF9A30000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD00F6F6
      F600CBC6BE00968C7C00A2998B00A89F9200A69D8F009C9283009C938400F9F9
      F800E2E2E200000000000000000000000000000000000000000000000000EDEB
      E900B1A99C00AEA59800BFB9AF00C2BCB300B7B0A400A0968600C3BDB300F7F7
      F6000000000080A9DE00D2C6B500FAFAFB00CB9C3F00CB9C3F00CB9C3F00CB9C
      3F00CB9C3F00CB9C3F00CB9C3F00CB9C3F00CB9C3F00CB9C3F00CB9C3F00CB9C
      3F00CB9C3F00CB9C3F00CB9C3F00CC9224000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEEEEE00F1F1F100FDFDFD00F8F7F600FDFDFD00F8F8F800E2E2E200FDFD
      FD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008D8DB8006166C400C37F0000C37F0000C37F0000C37F
      0000C37F0000C37F0000C37F0000C37F0000C37F0000C37F0000C37F0000C37F
      0000C37F0000C37F0000C37F0000CA8F20000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F81FFFFF00000000E00FFEFF00000000
      C003FCFF000000008003F9FF000000000001F9FF000000000000F00700000000
      0000C00300000000000080010000000000000000000000000000000000000000
      0000000000000000000100000000000080010001000000008003800100000000
      C007E00800000000F00FFFFC0000000000000000000000000000000000000000
      000000000000}
  end
end
end
