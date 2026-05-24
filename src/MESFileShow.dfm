object Form7: TForm7
  Left = 979
  Top = 217
  Caption = 'MES file data'
  ClientHeight = 649
  ClientWidth = 685
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
    Left = 16
    Top = 328
    Width = 75
    Height = 13
    Caption = 'MES Entry ID:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 448
    Width = 29
    Height = 13
    Caption = 'Text:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 352
    Width = 64
    Height = 13
    Caption = 'Comments:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 248
    Top = 600
    Width = 113
    Height = 33
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object ListView1: TListView
    Left = 8
    Top = 16
    Width = 665
    Height = 265
    Columns = <
      item
        Caption = 'ID'
      end
      item
        Caption = 'Text'
        Width = 611
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = ListView1Click
    OnKeyUp = ListView1KeyUp
  end
  object index: TEdit
    Left = 104
    Top = 320
    Width = 105
    Height = 21
    TabOrder = 2
    OnKeyUp = indexKeyUp
  end
  object mesdata: TMemo
    Left = 104
    Top = 448
    Width = 569
    Height = 145
    ScrollBars = ssVertical
    TabOrder = 3
    WantTabs = True
    OnKeyUp = mesdataKeyUp
  end
  object addbutton: TButton
    Left = 8
    Top = 288
    Width = 81
    Height = 25
    Caption = 'Add'
    TabOrder = 4
    OnClick = addbuttonClick
  end
  object deletebutton: TButton
    Left = 184
    Top = 288
    Width = 81
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = deletebuttonClick
  end
  object insertbutton: TButton
    Left = 96
    Top = 288
    Width = 81
    Height = 25
    Caption = 'Insert'
    TabOrder = 6
    OnClick = insertbuttonClick
  end
  object comments: TMemo
    Left = 104
    Top = 352
    Width = 569
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 7
    OnKeyUp = commentsKeyUp
  end
  object Button2: TButton
    Left = 368
    Top = 600
    Width = 113
    Height = 33
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object CheckBox1: TCheckBox
    Left = 280
    Top = 328
    Width = 297
    Height = 17
    Caption = 'Add linebreak after this entry'
    TabOrder = 9
    OnClick = CheckBox1Click
  end
  object Button3: TButton
    Left = 552
    Top = 287
    Width = 121
    Height = 35
    Caption = 'Edit MES file header'
    TabOrder = 10
    OnClick = Button3Click
  end
end
