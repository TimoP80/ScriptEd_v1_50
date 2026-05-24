object Form14: TForm14
  Left = 535
  Top = 332
  Width = 584
  Height = 261
  Caption = 'Set up generated dialog line'
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 76
    Height = 13
    Caption = 'Response type:'
  end
  object Label2: TLabel
    Left = 312
    Top = 152
    Width = 86
    Height = 13
    Caption = 'Resulting code:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 312
    Top = 168
    Width = 249
    Height = 17
    AutoSize = False
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 297
    Height = 161
    ItemHeight = 13
    Items.Strings = (
      'Appreciate'
      'Barter/Gamble'
      'Check story state'
      'Directions'
      'Exit'
      'Forget it'
      'Ask questions'
      'Load worldmap'
      'No'
      'Paper'
      'Quest'
      'Sorry'
      'Training'
      'Use skill'
      'Who are you?'
      'X Marks the spot'
      'Yes'
      'Zap Spell'
      'Insult'
      'Rumor')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 408
    Top = 192
    Width = 73
    Height = 25
    Caption = 'OK'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 488
    Top = 192
    Width = 73
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
  end
end
