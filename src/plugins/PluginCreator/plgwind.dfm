object plgwnd: Tplgwnd
  Left = 326
  Top = 143
  Width = 530
  Height = 435
  Caption = 'Plugin helper'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 522
    Height = 401
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 117
      Height = 14
      Caption = 'Name for new plugin:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Description: TLabel
      Left = 15
      Top = 42
      Width = 159
      Height = 28
      Caption = 'Description'#13#10'(for source code comments)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 18
      Top = 179
      Width = 86
      Height = 28
      Caption = 'Description'#13#10'(for application)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 18
      Top = 212
      Width = 38
      Height = 14
      Caption = 'Author'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 336
      Width = 99
      Height = 14
      Caption = 'Output project file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 296
      Width = 47
      Height = 14
      Caption = 'Shortcut'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object plgName: TEdit
      Left = 176
      Top = 16
      Width = 330
      Height = 22
      TabOrder = 0
    end
    object plgdesc: TMemo
      Left = 176
      Top = 40
      Width = 331
      Height = 129
      TabOrder = 1
    end
    object appdesc: TEdit
      Left = 176
      Top = 176
      Width = 334
      Height = 22
      TabOrder = 2
    end
    object auth: TEdit
      Left = 176
      Top = 200
      Width = 334
      Height = 22
      TabOrder = 3
    end
    object Button1: TButton
      Left = 392
      Top = 368
      Width = 49
      Height = 27
      Caption = 'OK'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 446
      Top = 368
      Width = 53
      Height = 27
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 5
    end
    object CheckBox1: TCheckBox
      Left = 176
      Top = 318
      Width = 270
      Height = 14
      Caption = 'Plugin can be added to the Plugins-menu'
      TabOrder = 6
    end
    object JvHotKey1: TJvHotKey
      Left = 176
      Top = 296
      Width = 153
      Height = 17
      HotKey = 0
      InvalidKeys = [hcShift]
      Modifiers = []
      TabOrder = 7
      ParentColor = False
    end
    object CheckBox2: TCheckBox
      Left = 176
      Top = 224
      Width = 225
      Height = 17
      Caption = 'Allow plugin to refresh data'
      TabOrder = 8
    end
    object CheckBox3: TCheckBox
      Left = 176
      Top = 240
      Width = 257
      Height = 17
      Caption = 'Allow plugin to close its windows'
      TabOrder = 9
    end
    object CheckBox4: TCheckBox
      Left = 176
      Top = 256
      Width = 305
      Height = 17
      Caption = 'Allow plugin to receive debug messages from the host application'
      TabOrder = 11
    end
    object CheckBox5: TCheckBox
      Left = 176
      Top = 272
      Width = 297
      Height = 17
      Caption = 'Allow plugin to be configured'
      TabOrder = 10
    end
    object output: TJvFilenameEdit
      Left = 176
      Top = 336
      Width = 337
      Height = 22
      DefaultExt = 'dpr'
      Filter = 'Delphi project files (*.dpr)|*.dpr'
      TabOrder = 12
    end
  end
end
