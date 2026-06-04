  object SplashForm: TSplashForm
    Left = 0
    Top = 0
    BorderStyle = bsNone
    ClientHeight = 480
    ClientWidth = 640
    Color = clBlack
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    FormStyle = fsStayOnTop
    OldCreateOrder = False
    Position = poScreenCenter
    Visible = True
    OnCreate = FormCreate
    OnDestroy = FormDestroy
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
      Picture.Data = {
        0B546478706E676F0A010001010000D43EA0000000000010003800340000000
        0000000000004E00560089005B00000000008F009F00007C0000000000000000
        000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000000
        00000000000000000043C6592100000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000}
      ExplicitTop = -6
    end
    object StatusLabel: TLabel
      Left = 0
      Top = 446
      Width = 640
      Height = 17
      Align = alBottom
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
      ExplicitTop = 436
      ExplicitWidth = 552
    end
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 463
      Width = 640
      Height = 17
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 453
      ExplicitWidth = 552
    end
  end
