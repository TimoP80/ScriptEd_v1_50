object Form29: TForm29
  Left = 0
  Top = 0
  Caption = 'Inter NPC dialogue call'
  ClientHeight = 313
  ClientWidth = 431
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
    Left = 24
    Top = 71
    Width = 177
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label2: TLabel
    Left = 207
    Top = 71
    Width = 202
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label3: TLabel
    Left = 24
    Top = 121
    Width = 177
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label4: TLabel
    Left = 24
    Top = 176
    Width = 177
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label5: TLabel
    Left = 207
    Top = 176
    Width = 202
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label6: TLabel
    Left = 216
    Top = 120
    Width = 193
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label7: TLabel
    Left = 216
    Top = 101
    Width = 120
    Height = 13
    Caption = 'Corresponding script file:'
  end
  object Button1: TButton
    Left = 24
    Top = 32
    Width = 177
    Height = 33
    Caption = 'Select dialogue line global var'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 207
    Top = 32
    Width = 202
    Height = 33
    Caption = 'Select script line global var'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 90
    Width = 177
    Height = 25
    Caption = 'Select dialogue file'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 96
    Top = 240
    Width = 105
    Height = 43
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object Button5: TButton
    Left = 223
    Top = 240
    Width = 122
    Height = 43
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object Button6: TButton
    Left = 24
    Top = 140
    Width = 177
    Height = 29
    Caption = 'Select dialogue line'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 207
    Top = 140
    Width = 202
    Height = 25
    Caption = 'Select script line'
    TabOrder = 6
    OnClick = Button7Click
  end
end
