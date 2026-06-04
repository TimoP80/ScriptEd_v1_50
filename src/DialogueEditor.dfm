object Form3: TForm3
  Left = 267
  Top = 112
  Caption = 'Dialogue Editor'
  ClientHeight = 694
  ClientWidth = 1238
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 45
    Height = 13
    Caption = 'Node list:'
  end
  object Label7: TLabel
    Left = 528
    Top = 66
    Width = 58
    Height = 13
    Caption = 'Node name:'
  end
  object Label8: TLabel
    Left = 680
    Top = 66
    Width = 88
    Height = 13
    Caption = 'Line number start:'
  end
  object Button1: TButton
    Left = 1040
    Top = 666
    Width = 73
    Height = 25
    Hint = 'Save the current dialogue file'
    Caption = 'Save'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 664
    Width = 81
    Height = 25
    Hint = 
      'This button adds a new node to the node list and'#13#10'increments the' +
      ' line number based on the last node in the list.'#13#10#13#10'The default ' +
      'increment is 20, but you can change this'#13#10'setting in the prefere' +
      'nces.'
    Caption = 'Add'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 184
    Top = 664
    Width = 81
    Height = 25
    Hint = 'Delete a dialogue node'
    Caption = 'Delete'
    TabOrder = 2
    OnClick = Button3Click
  end
  object nodename: TEdit
    Left = 592
    Top = 58
    Width = 73
    Height = 21
    Hint = 'Name for the node (Default: Node<num> for example Node001)'
    TabOrder = 3
    OnKeyUp = nodenameKeyUp
  end
  object Button4: TButton
    Left = 1120
    Top = 666
    Width = 73
    Height = 25
    Hint = 'Cancel the dialogue editing and do not save changes'
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object Button5: TButton
    Left = 96
    Top = 664
    Width = 81
    Height = 25
    Hint = 'Insert a new node at the selected position.'
    Caption = 'Insert'
    TabOrder = 5
    OnClick = Button5Click
  end
  object linenumstart: TEdit
    Left = 776
    Top = 58
    Width = 73
    Height = 21
    Hint = 
      'Line number start for the node, player option numbers are calcul' +
      'ated automatically based on this number + player option index'
    TabOrder = 6
    OnKeyUp = linenumstartKeyUp
  end
  object Button6: TButton
    Left = 528
    Top = 666
    Width = 113
    Height = 25
    Hint = 
      'Remap line numbers (for example to make more space for player op' +
      'tions)'
    Caption = 'Remap Line numbers'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button11: TButton
    Left = 648
    Top = 666
    Width = 129
    Height = 25
    Hint =
      'Edit the dialogue header to provide more information about the d' +
      'ialogue file'
    Caption = 'Edit dialogue header'
    TabOrder = 8
    OnClick = Button11Click
  end
  object RemoveBlankNodesBtn: TButton
    Left = 780
    Top = 666
    Width = 145
    Height = 25
    Hint =
      'Remove nodes that have no NPC text and no player options (blank' +
      ' lines in the dialogue file, e.g. {N}{}{}{}{}{}{})'
    Caption = 'Remove blank nodes'
    TabOrder = 30
    OnClick = RemoveBlankNodesBtnClick
  end
  object fltflag: TCheckBox
    Left = 855
    Top = 58
    Width = 337
    Height = 17
    Caption = 'This is a float message'
    TabOrder = 9
    OnMouseUp = fltflagMouseUp
  end
  object fltgrpstart: TCheckBox
    Left = 855
    Top = 75
    Width = 337
    Height = 17
    Caption = 'Starting entry of a float message group'
    TabOrder = 10
    OnMouseUp = fltgrpstartMouseUp
  end
  object JvPageList1: TJvPageList
    Left = 520
    Top = 98
    Width = 705
    Height = 561
    ActivePage = DialogueEditorPage
    PropagateEnable = False
    object DialogueEditorPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 705
      Height = 561
      Caption = '9'
      object Label1: TLabel
        Left = 13
        Top = 94
        Width = 76
        Height = 13
        Caption = 'NPC text [Male]'
      end
      object Label2: TLabel
        Left = 13
        Top = 197
        Width = 88
        Height = 13
        Caption = 'NPC text [Female]'
      end
      object Label4: TLabel
        Left = 16
        Top = 312
        Width = 93
        Height = 13
        Caption = 'Actions to perform:'
      end
      object Label5: TLabel
        Left = 24
        Top = 344
        Width = 80
        Height = 13
        Caption = 'Sound file index:'
      end
      object Label6: TLabel
        Left = 16
        Top = 376
        Width = 72
        Height = 13
        Caption = 'Player options:'
      end
      object Label9: TLabel
        Left = 17
        Top = 5
        Width = 84
        Height = 13
        Caption = 'Node description:'
      end
      object npctextmale: TMemo
        Left = 13
        Top = 113
        Width = 689
        Height = 73
        TabOrder = 0
        OnKeyUp = npctextmaleKeyUp
      end
      object npctextfemale: TMemo
        Left = 13
        Top = 216
        Width = 689
        Height = 81
        TabOrder = 1
        OnKeyUp = npctextfemaleKeyUp
      end
      object nodeactions: TEdit
        Left = 128
        Top = 304
        Width = 433
        Height = 21
        Hint = 'Node actions to perfrorm'
        TabOrder = 2
        OnKeyUp = nodeactionsKeyUp
      end
      object nogenderspecific: TCheckBox
        Left = 136
        Top = 192
        Width = 233
        Height = 17
        Caption = 'Use text from male npc line'
        TabOrder = 3
        OnClick = nogenderspecificClick
      end
      object useVO: TCheckBox
        Left = 207
        Top = 340
        Width = 209
        Height = 17
        Caption = 'Use voice over for this line'
        TabOrder = 4
        OnClick = useVOClick
      end
      object vofield: TEdit
        Left = 128
        Top = 331
        Width = 73
        Height = 21
        Hint = 'Sound file index for this node (example 1, 2, 3, 4, ... etc)'
        Enabled = False
        TabOrder = 5
        OnKeyUp = vofieldKeyUp
      end
      object ListView1: TListView
        Left = 8
        Top = 400
        Width = 689
        Height = 153
        Columns = <
          item
            Caption = 'id'
          end
          item
            Caption = 'Player Text'
            Width = 333
          end
          item
            Caption = 'Gender'
          end
          item
            Caption = 'Conditions'
            Width = 76
          end
          item
            Caption = 'IQ'
          end
          item
            Caption = 'Link'
          end
          item
            Caption = 'Actions'
          end
          item
            Caption = 'Comments'
            Width = 120
          end>
        MultiSelect = True
        RowSelect = True
        PopupMenu = PopupMenu1
        TabOrder = 6
        ViewStyle = vsReport
        OnClick = ListView1Click
        OnDblClick = ListView1DblClick
        OnMouseDown = ListView1MouseDown
      end
      object Button7: TButton
        Left = 472
        Top = 368
        Width = 65
        Height = 25
        Hint = 'Add a new player option'
        Caption = 'Add'
        TabOrder = 7
        OnClick = Button7Click
      end
      object insbutton: TButton
        Left = 544
        Top = 368
        Width = 73
        Height = 25
        Hint = 'Insert a player option'
        Caption = 'Insert'
        Enabled = False
        TabOrder = 8
        OnClick = insbuttonClick
      end
      object delbutton: TButton
        Left = 624
        Top = 368
        Width = 73
        Height = 25
        Hint = 'Delete a player option'
        Caption = 'Delete'
        TabOrder = 9
        OnClick = delbuttonClick
      end
      object Button10: TButton
        Left = 568
        Top = 304
        Width = 81
        Height = 25
        Caption = 'Edit'
        TabOrder = 10
        Visible = False
      end
      object nodedesc: TMemo
        Left = 13
        Top = 24
        Width = 689
        Height = 57
        Hint = 'Description for the selected node'
        TabOrder = 11
        OnKeyUp = nodedescKeyUp
      end
      object mvdownbtn: TButton
        Left = 320
        Top = 368
        Width = 65
        Height = 25
        Hint = 'Move the player option down'
        Caption = 'Move Down'
        Enabled = False
        TabOrder = 12
        OnClick = mvdownbtnClick
      end
      object mvupbtn: TButton
        Left = 392
        Top = 368
        Width = 65
        Height = 25
        Hint = 'Move the player option up'
        Caption = 'Move Up'
        Enabled = False
        TabOrder = 13
        OnClick = mvupbtnClick
      end
      object Button8: TButton
        Left = 360
        Top = 336
        Width = 121
        Height = 25
        Hint = 
          'Automatically creates the required folder for the dialogue'#39's voi' +
          'ceover. (in Sound\Speech\<scriptnum>)'
        Caption = 'Create speech folder'
        Enabled = False
        TabOrder = 14
        OnClick = Button8Click
      end
      object clonebutton: TButton
        Left = 208
        Top = 368
        Width = 41
        Height = 25
        Hint = 
          'Clone the selected player option. NOTE: Only works on one select' +
          'ed player option!'
        Caption = 'Clone'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = clonebuttonClick
      end
      object copybtn: TButton
        Left = 128
        Top = 368
        Width = 33
        Height = 25
        Hint = 'Copy selected player options to the buffer'
        Caption = 'Copy'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnClick = copybtnClick
      end
      object pastebtn: TButton
        Left = 168
        Top = 368
        Width = 33
        Height = 25
        Hint = 'Paste player option from the buffer'
        Caption = 'Paste'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = pastebtnClick
      end
      object SyncNPCLines: TCheckBox
        Left = 368
        Top = 192
        Width = 297
        Height = 17
        Hint = 
          'Automatically replace various gender specific words such as sir,' +
          ' man, boy etc with a female equivalent.'
        Caption = 'Synchronize NPC lines with gender-specific strings'
        TabOrder = 18
      end
      object GenSpeech: TButton
        Left = 488
        Top = 336
        Width = 121
        Height = 25
        Hint = 'Generates speech using the SAPI5 plugin.'
        Caption = 'Generate Speech'
        TabOrder = 19
        Visible = False
        OnClick = GenSpeechClick
      end
      object PlaySpeech: TButton
        Left = 616
        Top = 336
        Width = 75
        Height = 25
        Hint = 'Plays the speech file if present.'
        Caption = 'Play speech'
        Enabled = False
        TabOrder = 20
        OnClick = PlaySpeechClick
      end
    end
    object FloatMessageEditorPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 705
      Height = 561
      Caption = 'FloatMessageEditorPage'
    end
    object OllamaGenerate: TButton
      Left = 592
      Top = 87
      Width = 110
      Height = 25
      Caption = 'Generate with Ollama'
      TabOrder = 2
      OnClick = Button16Click
    end
  end
  object Button9: TButton
    Left = 783
    Top = 665
    Width = 106
    Height = 24
    Hint = 
      'Automatically number each node with a voiceover number (e.g.  1,' +
      ' 2, 3, 4, ... etc.)'
    Caption = 'Auto VO numbers'
    TabOrder = 12
    OnClick = Button9Click
  end
  object Button12: TButton
    Left = 520
    Top = 27
    Width = 161
    Height = 25
    Hint = 
      'This button adds float messages from a list of strings. Each lin' +
      'e represents one float message.'
    Caption = 'Add float messages from list'
    TabOrder = 13
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 695
    Top = 27
    Width = 106
    Height = 25
    Hint = 
      'This button clears all nodes, confirmation is asked so you are a' +
      'ble to cancel it if you don'#39't want to do it.'
    Caption = 'Clear all nodes'
    TabOrder = 14
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 807
    Top = 27
    Width = 154
    Height = 25
    Hint = 
      'This invokes a window for selecting a dialogue file to call and ' +
      'inserts the global variables to the node action field'
    Caption = 'Add inter-NPC dialogue call'
    TabOrder = 15
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 967
    Top = 27
    Width = 170
    Height = 25
    Hint = 
      'Adds local variable conditions and actions to each player line. ' +
      'This makes it easier to emove player options that have already b' +
      'een selected, for example in a questions nodee.'
    Caption = 'Add local vars to player options'
    TabOrder = 16
    OnClick = Button15Click
  end
  object TreeView1: THTMLTreeview
    Left = 8
    Top = 27
    Width = 509
    Height = 631
    ItemHeight = 45
    SelectionNFColor = clSilver
    SelectionNFFontColor = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    Indent = 19
    ParentFont = False
    TabOrder = 17
    WordWrap = True
    OnClick = TreeView1Click
    Version = '1.5.1.0'
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 752
    Top = 546
    object Editplayeroptionregularmode1: TMenuItem
      Caption = 'Edit selected player option (regular mode)'
      OnClick = Editplayeroptionregularmode1Click
    end
    object Editallplayeroptionslistmode1: TMenuItem
      Caption = 'Edit all player options (list mode) ** NOT IMPLEMENTED ** '
      Enabled = False
    end
  end
end
