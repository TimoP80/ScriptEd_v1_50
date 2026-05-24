object Form10: TForm10
  Left = 506
  Top = 308
  Caption = 'Load module script'
  ClientHeight = 504
  ClientWidth = 778
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
    Top = 16
    Width = 71
    Height = 13
    Caption = 'Search scripts:'
  end
  object ListView1: TListView
    Left = 8
    Top = 39
    Width = 765
    Height = 394
    Columns = <
      item
        Caption = 'Script ID'
        Width = 90
      end
      item
        Caption = 'Filename'
        Width = 190
      end
      item
        Caption = 'Description'
        Width = 150
      end
      item
        Caption = 'Last modified'
        Width = 105
      end
      item
        Caption = 'File created on'
        Width = 126
      end
      item
        Caption = 'Voiceover?'
        Width = 80
      end>
    GridLines = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = ListView1Click
    OnDblClick = ListView1DblClick
  end
  object Button1: TButton
    Left = 314
    Top = 439
    Width = 89
    Height = 25
    Caption = 'Load Script'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 401
    Top = 439
    Width = 89
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object ScriptFilter: TEdit
    Left = 109
    Top = 8
    Width = 444
    Height = 21
    TabOrder = 3
    OnKeyPress = ScriptFilterKeyPress
  end
  object Button3: TButton
    Left = 559
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = Button3Click
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = MainForm.JvAppIniFileStorage1
    AppStoragePath = 'Form10\'
    StoredProps.Strings = (
      'ListView1.Columns')
    StoredValues = <>
    Left = 145
    Top = 216
  end
  object PopupMenu1: TPopupMenu
    Left = 233
    Top = 168
    object DeleteScript1: TMenuItem
      Caption = 'Delete Script'
      OnClick = DeleteScript1Click
    end
  end
end
