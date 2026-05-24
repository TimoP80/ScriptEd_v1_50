object Form20: TForm20
  Left = 831
  Top = 276
  Caption = 'Uncompressing module'
  ClientHeight = 374
  ClientWidth = 572
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
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Progress:'
  end
  object Label2: TLabel
    Left = 8
    Top = 96
    Width = 21
    Height = 13
    Caption = 'Log:'
  end
  object progressphase: TLabel
    Left = 8
    Top = 24
    Width = 561
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object progress: TProgressBar
    Left = 8
    Top = 72
    Width = 561
    Height = 17
    TabOrder = 0
  end
  object uncompresslog: TMemo
    Left = 8
    Top = 112
    Width = 561
    Height = 257
    TabOrder = 1
  end
end
