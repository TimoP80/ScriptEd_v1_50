object Form13: TForm13
  Left = 402
  Top = 216
  Caption = 'Edit dialogue header'
  ClientHeight = 429
  ClientWidth = 606
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
    Width = 122
    Height = 13
    Caption = 'Dialogue header text:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dlgheadertext: TMemo
    Left = 8
    Top = 24
    Width = 593
    Height = 361
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 232
    Top = 392
    Width = 89
    Height = 33
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 328
    Top = 392
    Width = 81
    Height = 33
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 8
    Top = 392
    Width = 121
    Height = 33
    Caption = 'Insert variable info'
    TabOrder = 3
    OnClick = Button3Click
  end
end
