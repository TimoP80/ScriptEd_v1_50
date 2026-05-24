object Form27: TForm27
  Left = 0
  Top = 0
  Caption = 'Add condition + statement'
  ClientHeight = 138
  ClientWidth = 583
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
    Left = 16
    Top = 24
    Width = 33
    Height = 13
    Caption = 'IF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 51
    Width = 28
    Height = 13
    Caption = 'THEN'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 78
    Width = 25
    Height = 13
    Caption = 'ELSE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object condlist: TComboBox
    Left = 58
    Top = 21
    Width = 514
    Height = 21
    TabOrder = 0
  end
  object thenlist: TComboBox
    Left = 58
    Top = 48
    Width = 514
    Height = 21
    TabOrder = 1
  end
  object elselist: TComboBox
    Left = 58
    Top = 75
    Width = 514
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 416
    Top = 102
    Width = 75
    Height = 25
    Caption = 'Add'
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 497
    Top = 102
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
