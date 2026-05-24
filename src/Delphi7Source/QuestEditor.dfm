object Form8: TForm8
  Left = 300
  Top = 282
  Width = 724
  Height = 452
  Caption = 'Quest Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 52
    Height = 13
    Caption = 'Quest List:'
  end
  object Label2: TLabel
    Left = 360
    Top = 56
    Width = 78
    Height = 13
    Caption = 'Quest Log Text:'
  end
  object Label3: TLabel
    Left = 360
    Top = 168
    Width = 149
    Height = 13
    Caption = 'Quest Log Text (Dumb player):'
  end
  object Label4: TLabel
    Left = 360
    Top = 304
    Width = 73
    Height = 13
    Caption = 'Quest XP level:'
  end
  object Label5: TLabel
    Left = 360
    Top = 336
    Width = 106
    Height = 13
    Caption = 'Quest alignment shift:'
  end
  object Label6: TLabel
    Left = 360
    Top = 16
    Width = 47
    Height = 13
    Caption = 'Quest ID:'
  end
  object Label7: TLabel
    Left = 584
    Top = 296
    Width = 121
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Quest Level XP:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object xprewarddata: TLabel
    Left = 584
    Top = 312
    Width = 121
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object questlogsmart: TMemo
    Left = 360
    Top = 72
    Width = 345
    Height = 97
    TabOrder = 0
    OnKeyUp = questlogsmartKeyUp
  end
  object questlogdumb: TMemo
    Left = 360
    Top = 184
    Width = 345
    Height = 105
    TabOrder = 1
    OnKeyUp = questlogdumbKeyUp
  end
  object questxpr: TEdit
    Left = 480
    Top = 296
    Width = 97
    Height = 21
    TabOrder = 2
    OnKeyUp = questxprKeyUp
  end
  object questaligns: TEdit
    Left = 480
    Top = 328
    Width = 97
    Height = 21
    TabOrder = 3
    OnKeyUp = questalignsKeyUp
  end
  object Button1: TButton
    Left = 520
    Top = 376
    Width = 89
    Height = 33
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 616
    Top = 376
    Width = 89
    Height = 33
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object questid: TJvSpinEdit
    Left = 360
    Top = 32
    Width = 113
    Height = 21
    MaxValue = 9999.000000000000000000
    MinValue = 1000.000000000000000000
    Value = 1000.000000000000000000
    TabOrder = 6
  end
  object Button3: TButton
    Left = 8
    Top = 376
    Width = 89
    Height = 33
    Caption = 'Add quest'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 104
    Top = 376
    Width = 89
    Height = 33
    Caption = 'Delete quest'
    TabOrder = 8
    OnClick = Button4Click
  end
  object questlist: TJvHTListBox
    Left = 8
    Top = 32
    Width = 337
    Height = 329
    HideSel = False
    ColorHighlight = clHighlight
    ColorHighlightText = clHighlightText
    ColorDisabledText = clGrayText
    TabOrder = 9
    OnClick = questlistClick
    OnMouseDown = questlistMouseDown
  end
end
