object SplashForm: TSplashForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 480
  ClientWidth = 640
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 640
    Height = 440
    Align = alClient
    Center = True
    Proportional = True
    Stretch = True
    ExplicitTop = -6
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 440
    Width = 640
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    object StatusLabel: TLabel
      Left = 0
      Top = 0
      Width = 640
      Height = 20
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      ExplicitWidth = 552
      ExplicitHeight = 17
    end
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 20
      Width = 640
      Height = 20
      Align = alClient
      TabOrder = 0
    end
  end
end
