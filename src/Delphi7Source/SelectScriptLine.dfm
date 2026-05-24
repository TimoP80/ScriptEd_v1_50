object Form19: TForm19
  Left = 508
  Top = 283
  Width = 516
  Height = 451
  Caption = 'Choose script line from another script'
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
    Left = 160
    Top = 8
    Width = 114
    Height = 13
    Caption = 'List of lines in script:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 280
    Top = 8
    Width = 56
    Height = 13
    Caption = '<filename>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object JvHTListBox1: TJvHTListBox
    Left = 8
    Top = 32
    Width = 489
    Height = 337
    HideSel = False
    ColorHighlight = clHighlight
    ColorHighlightText = clHighlightText
    ColorDisabledText = clGrayText
    TabOrder = 0
    OnClick = JvHTListBox1Click
  end
  object Button1: TButton
    Left = 160
    Top = 376
    Width = 97
    Height = 33
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 264
    Top = 376
    Width = 97
    Height = 33
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
