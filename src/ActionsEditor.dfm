object Form28: TForm28
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Dialogue Code Editor'
  ClientHeight = 540
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object HeaderLabel: TLabel
    Left = 12
    Top = 8
    Width = 600
    Height = 16
    Caption = 'Dialogue Code Editor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CodeList: TListView
    Left = 12
    Top = 32
    Width = 360
    Height = 380
    HideSelection = False
    TabOrder = 0
    OnClick = CodeListClick
    OnDblClick = CodeListDblClick
  end
  object DetailLabel: TLabel
    Left = 384
    Top = 32
    Width = 80
    Height = 13
    Caption = 'Code details:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DetailMemo: TMemo
    Left = 384
    Top = 48
    Width = 360
    Height = 200
    Color = clInfoBk
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Num1Label: TLabel
    Left = 384
    Top = 256
    Width = 28
    Height = 13
    Caption = 'num1:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Num1Edit: TJvSpinEdit
    Left = 420
    Top = 252
    Width = 100
    Height = 21
    MaxValue = 99999.000000000000000000
    MinValue = -99999.000000000000000000
    TabOrder = 2
    OnChange = Num1EditChange
  end
  object Num2Label: TLabel
    Left = 532
    Top = 256
    Width = 28
    Height = 13
    Caption = 'num2:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Num2Edit: TJvSpinEdit
    Left = 568
    Top = 252
    Width = 100
    Height = 21
    MaxValue = 99999.000000000000000000
    MinValue = -99999.000000000000000000
    TabOrder = 3
    OnChange = Num2EditChange
  end
  object CurrentFieldLabel: TLabel
    Left = 12
    Top = 420
    Width = 240
    Height = 13
    Caption = 'Current field contents (editable):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CurrentFieldMemo: TMemo
    Left = 12
    Top = 436
    Width = 732
    Height = 50
    Color = clWindow
    ScrollBars = ssHorizontal
    TabOrder = 4
    OnChange = CurrentFieldMemoChange
  end
  object PreviewLabel: TLabel
    Left = 12
    Top = 494
    Width = 200
    Height = 13
    Caption = 'Selected code preview:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PreviewValue: TLabel
    Left = 140
    Top = 494
    Width = 460
    Height = 16
    AutoSize = False
    Caption = '(select a code from the list)'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Name = 'Consolas'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object InsertButton: TButton
    Left = 12
    Top = 510
    Width = 150
    Height = 25
    Hint = 'Append the selected code to the current field contents (Insert)'
    Caption = 'Insert (append)'
    TabOrder = 5
    OnClick = InsertButtonClick
  end
  object ReplaceButton: TButton
    Left = 168
    Top = 510
    Width = 150
    Height = 25
    Hint = 'Replace the entire field with just this code'
    Caption = 'Replace'
    TabOrder = 6
    OnClick = ReplaceButtonClick
  end
  object CancelButton: TButton
    Left = 676
    Top = 510
    Width = 70
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
    OnClick = CancelButtonClick
  end
  object HelpButton: TButton
    Left = 320
    Top = 510
    Width = 200
    Height = 25
    Hint = 'Insert syntax: code num1 [num2]. Multiple codes are joined with commas in the test/result field.'
    Caption = 'Syntax help'
    TabOrder = 8
    OnClick = HelpButtonClick
  end
end
