object Form26: TForm26
  Left = 0
  Top = 0
  Caption = 'Select Condition'
  ClientHeight = 338
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 232
    Top = 295
    Width = 89
    Height = 33
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object CMDList: TListView
    Left = 8
    Top = 8
    Width = 619
    Height = 281
    Columns = <
      item
        Caption = 'Condition'
        Width = 450
      end
      item
        Caption = '# of params'
        Width = 150
      end>
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = CMDListClick
    OnDblClick = CMDListDblClick
  end
  object Button2: TButton
    Left = 335
    Top = 295
    Width = 90
    Height = 33
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
