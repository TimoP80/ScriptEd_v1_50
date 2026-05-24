object Form25: TForm25
  Left = 0
  Top = 0
  Caption = 'Select Action'
  ClientHeight = 336
  ClientWidth = 635
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
    Left = 240
    Top = 295
    Width = 89
    Height = 33
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object CMDList: TListView
    Left = 8
    Top = 8
    Width = 619
    Height = 281
    Columns = <
      item
        Caption = 'Command'
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
